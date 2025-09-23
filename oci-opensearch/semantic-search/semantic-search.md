# Pre-requisites
You have to have an existing OpenSearch cluster and have to be able to connect to the Dashboard, to perform all of the steps.
## Introduction

In this lab, you will perform semantic search
Estimated Time: 20 minutes

### Objectives

In this lab, you will:
Use an existing Cluster.
Use the steps in this walkthrough to set up semantic search (without RAG), using an OCI Generative AI connector.
The connector uses the Cohere embed model hosted by Generative AI.

## Step 1: Prerequisites

Confirm that the OpenSearch cluster is version 2.11. To use an OCI Generative AI connector with OCI Search with OpenSearch, you need a cluster configured to use OpenSearch version 2.11. By default, new clusters are configured to use version 2.11. To create a cluster, see Creating an OpenSearch Cluster.

You will also need a subscription to the Chicago or Frankfurt regions, which host the OCI GenAI infrastructure.

Please refer to **LAB2** **Task3** on how to connect to the OpenSearch Dashboard.

First connect to the OpenSearch Dashboard (you have to provide the username/password) and go to **Management** and click on **Dev Tools**. You will be able to type the commands in the Console.

1. Create a policy to grant access to Generative AI resources. The following policy example includes the required permission:
 ```html
   <copy>ALLOW ANY-USER to manage generative-ai-family in tenancy WHERE ALL {request.principal.type='opensearchcluster', request.resource.compartment.id='<cluster_compartment_id>'}</copy>
   ```
If you're new to policies, see Getting Started with Policies and Common Policies.

2. Update the cluster settings to create and use a connector. The following example command updates the applicable settings:
```html
   <copy>PUT _cluster/settings
{
  "persistent": {
    "plugins": {
      "ml_commons": {
        "only_run_on_ml_node": "false",
        "model_access_control_enabled": "true",
        "native_memory_threshold": "99",
        "rag_pipeline_feature_enabled": "true",
        "memory_feature_enabled": "true",
        "allow_registering_model_via_local_file": "true",
        "allow_registering_model_via_url": "true",
        "model_auto_redeploy.enable":"true",
        "model_auto_redeploy.lifetime_retry_times": 10
      }
    }
  }
}</copy>
   ```

## Step 2: Register Model Group

Register a model group using the register operation in the Model Group APIs, as shown in the following example:
```html
   <copy>POST /_plugins/_ml/model_groups/_register
{
   "name": "public OCI GenAI model group",
   "description": "OCI GenAI group for remote models"
}</copy>
```
Make note of the model_group_id returned in the response:
```html
   {
  "model_group_id": "<model_group_ID>",
  "status": "CREATED"
}
```

## Step 3: Create the Connector

Create the Generative AI connector as shown in the following example.
To use the Frankfurt region, simply change "endpoint": **"inference.generativeai.us-chicago-1.oci.oraclecloud.com"** to 
**"endpoint": "inference.generativeai.eu-frankfurt-1.oci.oraclecloud.com"** in the payload below.

Cohere model:
 ```html
<copy>POST /_plugins/_ml/connectors/_create
{
  "name": "OCI GenAI Chat Connector cohere-embed-v5",
  "description": "The connector to public Cohere model service for embed",
  "version": "2",
  "protocol": "oci_sigv1",
 
    "parameters": {
      "endpoint": "inference.generativeai.us-chicago-1.oci.oraclecloud.com",
      "auth_type": "resource_principal", 
      "model": "cohere.embed-english-v3.0",
      "input_type":"search_document",
      "truncate": "END"
    },
 
     "credential": {
     },
     "actions": [
         {
             "action_type": "predict",
             "method":"POST",
             "url": "https://${parameters.endpoint}/20231130/actions/embedText",
             "request_body": "{ \"inputs\":[\"${parameters.passage_text}\"], \"truncate\": \"${parameters.truncate}\" ,\"compartmentId\": \"ocid1.compartment.oc1..aaaaaaaa7yyrmroctukjrejues34onvauhswq7z7j7si2yqnomgkwzou2hoq\", \"servingMode\": { \"modelId\": \"${parameters.model}\", \"servingType\": \"ON_DEMAND\" } }",
             "pre_process_function": """
                StringBuilder builder = new StringBuilder();
                builder.append("\"");
                String first = params.text_docs[0];
                if (first.contains("\"")) {
                  first = first.replace("\"", "\\\"");
                }
                if (first.contains("\\t")) {
                  first = first.replace("\\t", "\\\\\\t");
                }
                if (first.contains('
            ')) {
                  first = first.replace('
            ', '\\n');
                }
                builder.append(first);
                builder.append("\"");
                def parameters = "{" +"\"passage_text\":" + builder + "}";
                return "{" +"\"parameters\":" + parameters + "}";
                """,
              "post_process_function": "connector.post_process.cohere.embedding"
         }
     ]
 }</copy>
   ```


Authentication is done using a resource principal. Specify the cluster's compartment ID in request_body.

Make note of the connector_id returned in the response:
```html
{
  "connector_id": "<connector_ID>",
}
```


## Step 4: Register the Model

Register the remote model using the Generative AI connector with the connector ID and model group ID from the previous steps, as shown in the following example:

```html
   <copy>POST /_plugins/_ml/models/_register
{
   "name": "oci-genai-conversation",
   "function_name": "remote",
   "model_group_id": "<model_group_ID>",
   "description": "test semantic",
   "connector_id": "<connector_ID>"
 }</copy>
   ```
Make note of the model_id returned in the response:
```html
{
  "task_id": "<task_ID>",
  "status": "CREATED",
  "model_id": "<model_ID>"
}
```
## Step 5: Deploy the Model
Use the model ID from the previous step to deploy the model to the cluster so it can be used in any pipeline, as shown in the following example:
```html
   <copy>POST /_plugins/_ml/models/<model_ID>/_deploy</copy>
```
A response similar to the following is returned:
```html
{
  "task_id": "<task_ID>",
  "task_type": "DEPLOY_MODEL",
  "status": "COMPLETED"
}
```
## Step 6: Create Search Index

- Create Search Index with KNN plugin

To leverage hybrid search instead of BM25 to enrich the retriever part of the RAG pipeline, you need to setup an ingestion pipeline and use an imported pretrained model so that documents embeddings are created at ingestion time.

1. For the purposes of this walkthrough, import, register and deploy an OpenSearch pretrained model using the steps described in Custom Models. This includes uploading the model file to an Object Storage bucket, and then specifying the model file's Object Storage URL when you register the model.

Make note of the model ID returned when you register and deploy the model.

2. Create an ingestion pipeline using the model id from the previous step, as shown in the following example:
```html
   <copy>PUT _ingest/pipeline/minil12-test-pipeline
{
  "description": "pipeline for RAG demo index",
  "processors" : [
    {
      "text_embedding": {
        "model_id": "<model_ID>",
        "field_map": {
           "text": "passage_embedding"
        }
      }
    }
  ]
}</copy>
```

3. Create a search index with an ingestion pipeline, as shown in the following example
```html
   <copy>PUT /conversation-demo-index-knn
{
    "settings": {
        "index.knn": true,
        "default_pipeline": "minil12-test-pipeline"
    },
    "mappings": {
        "properties": {
            "passage_embedding": {
                "type": "knn_vector",
                "dimension": 1024,
                "method": {
                    "name":"hnsw",
                    "engine":"lucene",
                    "space_type": "l2",
                    "parameters":{
                        "m":512,
                        "ef_construction": 245
                    }
                }
            },
            "text": {
                "type": "text"
            }
        }
    }
}</copy>
```

4. Ingest the data using the ingestion pipeline from the previous step, as shown in the following example
```html
   <copy>PUT /conversation-demo-index-knn/_doc/1
{
    "text": "The emergence of resistance of bacteria to antibiotics is a common phenomenon. Emergence of resistance often reflects evolutionary processes that take place during antibiotic therapy. The antibiotic treatment may select for bacterial strains with physiologically or genetically enhanced capacity to survive high doses of antibiotics. Under certain conditions, it may result in preferential growth of resistant bacteria, while growth of susceptible bacteria is inhibited by the drug. For example, antibacterial selection for strains having previously acquired antibacterial-resistance genes was demonstrated in 1943 by the Luria–Delbrück experiment. Antibiotics such as penicillin and erythromycin, which used to have a high efficacy against many bacterial species and strains, have become less effective, due to the increased resistance of many bacterial strains."
   
}
GET /conversation-demo-index-knn/_doc/1
PUT /conversation-demo-index-knn/_doc/2
{
  "text": "The successful outcome of antimicrobial therapy with antibacterial compounds depends on several factors. These include host defense mechanisms, the location of infection, and the pharmacokinetic and pharmacodynamic properties of the antibacterial. A bactericidal activity of antibacterials may depend on the bacterial growth phase, and it often requires ongoing metabolic activity and division of bacterial cells. These findings are based on laboratory studies, and in clinical settings have also been shown to eliminate bacterial infection. Since the activity of antibacterials depends frequently on its concentration, in vitro characterization of antibacterial activity commonly includes the determination of the minimum inhibitory concentration and minimum bactericidal concentration of an antibacterial. To predict clinical outcome, the antimicrobial activity of an antibacterial is usually combined with its pharmacokinetic profile, and several pharmacological parameters are used as markers of drug efficacy."
}
 
PUT /conversation-demo-index-knn/_doc/3
{
  "text": "Antibacterial antibiotics are commonly classified based on their mechanism of action, chemical structure, or spectrum of activity. Most target bacterial functions or growth processes. Those that target the bacterial cell wall (penicillins and cephalosporins) or the cell membrane (polymyxins), or interfere with essential bacterial enzymes (rifamycins, lipiarmycins, quinolones, and sulfonamides) have bactericidal activities. Those that target protein synthesis (macrolides, lincosamides and tetracyclines) are usually bacteriostatic (with the exception of bactericidal aminoglycosides). Further categorization is based on their target specificity. Narrow-spectrum antibacterial antibiotics target specific types of bacteria, such as Gram-negative or Gram-positive bacteria, whereas broad-spectrum antibiotics affect a wide range of bacteria. Following a 40-year hiatus in discovering new classes of antibacterial compounds, four new classes of antibacterial antibiotics have been brought into clinical use in the late 2000s and early 2010s: cyclic lipopeptides (such as daptomycin), glycylcyclines (such as tigecycline), oxazolidinones (such as linezolid), and lipiarmycins (such as fidaxomicin)"
}
 
 
PUT /conversation-demo-index-knn/_doc/4
{
  "text": "The Desert Land Act of 1877 was passed to allow settlement of arid lands in the west and allotted 640 acres (2.6 km2) to settlers for a fee of $.25 per acre and a promise to irrigate the land. After three years, a fee of one dollar per acre would be paid and the land would be owned by the settler. This act brought mostly cattle and sheep ranchers into Montana, many of whom grazed their herds on the Montana prairie for three years, did little to irrigate the land and then abandoned it without paying the final fees. Some farmers came with the arrival of the Great Northern and Northern Pacific Railroads throughout the 1880s and 1890s, though in relatively small numbers"
}
 
PUT /conversation-demo-index-knn/_doc/5
{
  "text": "In the early 1900s, James J. Hill of the Great Northern began promoting settlement in the Montana prairie to fill his trains with settlers and goods. Other railroads followed suit. In 1902, the Reclamation Act was passed, allowing irrigation projects to be built in Montana's eastern river valleys. In 1909, Congress passed the Enlarged Homestead Act that expanded the amount of free land from 160 to 320 acres (0.6 to 1.3 km2) per family and in 1912 reduced the time to prove up on a claim to three years. In 1916, the Stock-Raising Homestead Act allowed homesteads of 640 acres in areas unsuitable for irrigation.  This combination of advertising and changes in the Homestead Act drew tens of thousands of homesteaders, lured by free land, with World War I bringing particularly high wheat prices. In addition, Montana was going through a temporary period of higher-than-average precipitation. Homesteaders arriving in this period were known as Honyockers, or scissorbills. Though the word honyocker, possibly derived from the ethnic slur hunyak, was applied in a derisive manner at homesteaders as being greenhorns, new at his business or unprepared, the reality was that a majority of these new settlers had previous farming experience, though there were also many who did not"
}
 
PUT /conversation-demo-index-knn/_doc/6
{
  "text": "In June 1917, the U.S. Congress passed the Espionage Act of 1917 which was later extended by the Sedition Act of 1918, enacted in May 1918. In February 1918, the Montana legislature had passed the Montana Sedition Act, which was a model for the federal version. In combination, these laws criminalized criticism of the U.S. government, military, or symbols through speech or other means. The Montana Act led to the arrest of over 200 individuals and the conviction of 78, mostly of German or Austrian descent. Over 40 spent time in prison. In May 2006, then-Governor Brian Schweitzer posthumously issued full pardons for all those convicted of violating the Montana Sedition Act."
}
 
PUT /conversation-demo-index-knn/_doc/7
{
  "text": "When the U.S. entered World War II on December 8, 1941, many Montanans already had enlisted in the military to escape the poor national economy of the previous decade. Another 40,000-plus Montanans entered the armed forces in the first year following the declaration of war, and over 57,000 joined up before the war ended. These numbers constituted about 10 percent of the state's total population, and Montana again contributed one of the highest numbers of soldiers per capita of any state. Many Native Americans were among those who served, including soldiers from the Crow Nation who became Code Talkers. At least 1500 Montanans died in the war. Montana also was the training ground for the First Special Service Force or Devil's Brigade a joint U.S-Canadian commando-style force that trained at Fort William Henry Harrison for experience in mountainous and winter conditions before deployment. Air bases were built in Great Falls, Lewistown, Cut Bank and Glasgow, some of which were used as staging areas to prepare planes to be sent to allied forces in the Soviet Union. During the war, about 30 Japanese balloon bombs were documented to have landed in Montana, though no casualties nor major forest fires were attributed to them"
}</copy>
```
After creating the search index with the k-NN plugin, when you run the following command to check an indexed document, the response includes embeddings, as follows:

Request:
```html
   <copy>GET /conversation-demo-index-knn/_doc/1</copy>
```
Response:
```html
   {
  "_index": "conversation-demo-index-knn",
  "_id": "1",
  "_version": 1,
  "_seq_no": 0,
  "_primary_term": 1,
  "found": true,
  "_source": {
    "passage_embedding": [
      -0.02929831,
      -0.04421867,
      -0.10647401,
      0.07105031,
      0.004921746,
      -0.04529944,
      -0.092778176,
      0.14189903,
      -0.0016610072,
      0.08001712,
      0.053442925,
      -0.022703059,
      0.039608333,
      0.042299673,
      ..............
```
## Step 7: Perform Semantic search
To perform vector search on your index, use the neural query clause either in the k-NN plugin API or Query DSL queries. You can refine the results by using a k-NN search filter.

The following example request uses a Boolean query to combine a filter clause and two query clauses—a neural query and a match query. The script_score query assigns custom weights to the query clauses:

```html
   <copy>GET /conversation-demo-index-knn/_search
{
  "query": {
    "bool" : {
      "should" : [
        {
          "script_score": {
            "query": {
              "neural": {
                "passage_embedding": {
                  "query_text": "Espionage Act",
                  "model_id": "Model_id",
                  "k": 2
                }
              }
            },
            "script": {
              "source": "_score * 1.5"
            }
          }
        }
      ]
    }
  },
  "fields": [
    "text"
  ],
  "_source": false
}</copy>
```



## Step 8: How to use a custom model
You can upload custom models to a cluster with the Bring Your Own Model (BYOM) process.
To use custom models, you need a cluster configured to use OpenSearch version 2.11. By default, new clusters use version 2.11. To create a cluster, see Creating an OpenSearch Cluster.

The BYOM process to import custom models includes the following steps:

1.Complete the following prerequisites:

  -Configure required IAM policy.

  -Configure recommended cluster settings.

  -Upload a custom model to an Object Storage bucket.

2.Register the model

3.Deploy the model

4.(Optional) Test the model

1: Prerequisites

The best is to perform these steps in the OpenSearch Dashboard API
-IAM Policy

You need to create a policy to grant OCI Search with OpenSearch access to the Object Storage bucket you upload the custom model to. The following policy example includes the required permissions:
```html
   <copy>ALLOW ANY-USER to manage object-family in tenancy WHERE ALL {request.principal.type='opensearchcluster', request.resource.compartment.id='<cluster_compartment_id>'}</copy>
```
If you're new to policies, see Getting Started with Policies and Common Policies.
-Configure Cluster Settings
Use the settings operation of the Cluster APIs to configure the recommended cluster settings for semantic search. The following example includes the recommended settings:

```html
   <copy>PUT _cluster/settings
{
  "persistent": {
    "plugins": {
      "ml_commons": {
        "only_run_on_ml_node": "false",
        "model_access_control_enabled": "true",
        "native_memory_threshold": "99",
        "rag_pipeline_feature_enabled": "true",
        "memory_feature_enabled": "true",
        "allow_registering_model_via_local_file": "true",
        "allow_registering_model_via_url": "true",
        "model_auto_redeploy.enable":"true",
        "model_auto_redeploy.lifetime_retry_times": 10
      }
    }
  }
}</copy>
```
-Upload Model to Object Storage Bucket

To make a custom model available to register for a cluster, you need to upload the model to an Object Storage bucket in the tenancy. If you don't have an existing Object Storage bucket, you need to create the bucket. For a tutorial that walks you through how to create a bucket, see Creating a Bucket.

Next, you need to upload the custom model to the bucket, see Uploading Files to a Bucket for a tutorial that walks you through how to upload files to a bucket. For the purposes of this walkthrough, you can download any supported hugging face model to upload.

2.Register the model

Use the register operation to register the custom model. In the following example, the custom model uploaded to the Object Storage bucket is the huggingface/sentence-transformers/all-MiniLM-L12-v2 model. The values specified in model_config for this example are from the model's config file. Ensure that you're using the applicable model configuration values for the custom model you're registering.

Specify the Object Storage URL in the actions section, this is an OCI Search with OpenSearch API added to support the BYOM scenario.

```html
   <copy>POST /_plugins/_ml/models/_register 
{
  "model_group_id": "Te1qPY0BxVYhYdT6TVCt",
    "name": "sentence-transformers/all-MiniLM-L12-v2",
    "version": "1.0.1",
    "description": "This is a sentence-transformers model: It maps sentences & paragraphs to a 384 dimensional dense vector space and can be used for tasks like clustering or semantic search.",
    "model_task_type": "TEXT_EMBEDDING",
    "model_format": "TORCH_SCRIPT",
    "model_content_size_in_bytes": 134568911,
    "model_content_hash_value": "f8012a4e6b5da1f556221a12160d080157039f077ab85a5f6b467a47247aad49",
    "model_config": {
        "model_type": "bert",
        "embedding_dimension": 384,
        "framework_type": "sentence_transformers",
        "all_config": "{\"_name_or_path\":\"microsoft/MiniLM-L12-H384-uncased\",\"attention_probs_dropout_prob\":0.1,\"gradient_checkpointing\":false,\"hidden_act\":\"gelu\",\"hidden_dropout_prob\":0.1,\"hidden_size\":384,\"initializer_range\":0.02,\"intermediate_size\":1536,\"layer_norm_eps\":1e-12,\"max_position_embeddings\":512,\"model_type\":\"bert\",\"num_attention_heads\":12,\"num_hidden_layers\":12,\"pad_token_id\":0,\"position_embedding_type\":\"absolute\",\"transformers_version\":\"4.8.2\",\"type_vocab_size\":2,\"use_cache\":true,\"vocab_size\":30522
    },
    "url_connector": {
        "protocol": "oci_sigv1",
        "parameters": {
            "auth_type": "resource_principal"
        },
        "actions": [
            {
                "method": "GET",
                "action_type": "DOWNLOAD",
                "url": "<Object_Storage_URL_Path>"
            }
        ]
    }
}
</copy>
```
Replace <Object_Storage_URL_Path> with a valid Object Storage URL, for example:
```html
   <copy>https://<tenancy_name>.objectstorage.us-ashburn-1.oraclecloud.com/n/<tenancy_name>/b/<bucket_name>/o/sentence-transformers_all-distilroberta-v1-1.0.1-torch_script.zip</copy>
```
Make note of the <task_id> returned in the response, you can use the <task_id> to check the status of the operation.

For example, from the following response:

```html
{
  "task_id": "<task_ID>",
  "status": "CREATED"
}
```
Track the register task and get the model ID

To check the status of the register operation, use the task_id with the Get operation of the Tasks APIs, as shown in the following example:
```html
   <copy>GET /_plugins/_ml/tasks/<task_ID></copy>
```
When the register operation is complete, the status value in the response to the Get operation is COMPLETED, as shown the following example:
```html
   {
  "model_id": "<model_ID>",
  "task_type": "REGISTER_MODEL",
  "function_name": "TEXT_EMBEDDING",
  "state": "COMPLETED",
  "worker_node": [
    "3qSqVfK2RvGJv1URKfS1bw"
  ],
  "create_time": 1706829732915,
  "last_update_time": 1706829780094,
  "is_async": true
}
```
Make note of the model_id value returned in the response to use when you deploy the model.

3.Deploy the model

After the register operation is completed for the model, you can deploy the model to the cluster using the deploy operation of the Model APIs, passing the model_id from the Get operation response in the previous step, as shown in the following example:
```html
   <copy>POST /_plugins/_ml/models/<model_ID>/_deploy</copy>
```
Make note of the <task_id> returned in the response, you can use the <task_id> to check the status of the operation.

For example, from the following response:
```html
{
  "task_id": "<task_ID>",
  "task_type": "DEPLOY_MODEL",
  "status": "CREATED"
}
```
to check the status of the register operation, use the task_id with the Get operation of the Tasks APIs, as shown in the following example:
```html
   <copy>GET /_plugins/_ml/tasks/<task_ID></copy>
```
When the deploy operation is complete, the status value in the response to the Get operation is COMPLETED.

4.(Optional) Test the model

After the model is successfully deployed, you can test the model by using the text_embedding endpoint, as shown in the following example:
```html
   <copy>POST /_plugins/_ml/_predict/text_embedding/ZANGOI0B9HkHUYmG79QF
{
  "text_docs":["hellow world", "new message", "this too"]
}
</copy>
```
Alternatively, you can use the _predict endpoint, as shown in the following example:
```html
   <copy>POST /_plugins/_ml/models/ZANGOI0B9HkHUYmG79QF/_predict
{
 "parameters":{
    "passage_text": "Testing the cohere embedding model"
}
}
</copy>
```


## Acknowledgements

* **Author** - Landry Kezebou Yankam
* **Last Updated By/Date** - Landry Kezebou, September 2025
