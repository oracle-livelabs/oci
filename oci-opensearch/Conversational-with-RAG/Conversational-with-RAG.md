# Pre-requisites
You have to have an existing OpenSearch cluster and be able to connect to the Dashboard, to perform all of the steps.
## Introduction

In this lab, you will perform semantic search and conversational search utilizing a RAG pipeline.
Estimated Time: 30 minutes

### Objectives

In this lab, you will:
-Use an existing Cluster

Use the steps in this walkthrough to set up and use an end-to-end Retrieval-Augmented Generation (RAG) pipeline in OCI Search with OpenSearch, using an OCI Generative AI connector.
The connector uses the Cohere embed model hosted by Generative AI. 
## Step1: Prerequisites

Confirm that the OpenSearch cluster is version 2.11. To use an OCI Generative AI connector with OCI Search with OpenSearch, you need a cluster configured to use OpenSearch version 2.11. By default, new clusters are configured to use version 2.11. To create a cluster, see Creating an OpenSearch Cluster.
Please refer to **LAB2** **Task3** on how to connect to the OpenSearch Dashboard.

You will also need a subscription to the Chicago or Frankfurt regions, which host the OCI GenAI infrastructure.

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



## Step 2: Register Model Group for RAG
Steps 2-6 will guide you to create a RAG pipeline.

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

## Step 3: Create the Connector for RAG

Create the Generative AI connector as shown in one of the following examples.
To use the Frankfurt region, simply change "endpoint": **"inference.generativeai.us-chicago-1.oci.oraclecloud.com"** to 
**"endpoint": "inference.generativeai.eu-frankfurt-1.oci.oraclecloud.com"** in the payload below.

Cohere model:
 ```html
   <copy>POST _plugins/_ml/connectors/_create
{
     "name": "OpenAI Chat Connector",
     "description": "when did us pass espio",
     "version": 2,
     "protocol": "oci_sigv1",
     "parameters": {
         "endpoint": "inference.generativeai.us-chicago-1.oci.oraclecloud.com",
         "auth_type": "resource_principal"
     },
     "credential": {
     },
     "actions": [
         {
             "action_type": "predict",
             "method": "POST",
             "url": "https://${parameters.endpoint}/20231130/actions/generateText",
             "request_body": "{\"compartmentId\":\"<cluster_compartment_id>\",\"servingMode\":{\"modelId\":\"cohere.command\",\"servingType\":\"ON_DEMAND\"},\"inferenceRequest\":{\"prompt\":\"${parameters.prompt}\",\"maxTokens\":600,\"temperature\":1,\"frequencyPenalty\":0,\"presencePenalty\":0,\"topP\":0.75,\"topK\":0,\"returnLikelihoods\":\"GENERATION\",\"isStream\":false ,\"stopSequences\":[],\"runtimeType\":\"COHERE\"}}"
         }
     ]
 }</copy>
   ```



cohere.command-r-16k  payload

(The API end-point is actions/chat) 
 ```html
   <copy>POST _plugins/_ml/connectors/_create
{
     "name": "Cohere Chat Connector",
     "description": "Check errors in logs",
     "version": 2,
     "protocol": "oci_sigv1",
     "parameters": {
         "endpoint": "inference.generativeai.us-chicago-1.oci.oraclecloud.com",
         "auth_type": "resource_principal"
     },
     "credential": {
     },
     "actions": [
         {
             "action_type": "predict",
             "method": "POST",
             "url": "https://${parameters.endpoint}/20231130/actions/chat",
             "request_body": "{\"compartmentId\":\"<YOUR_COMPARTMENT_OCID>\",\"servingMode\":{\"modelId\":\"cohere.command-r-16k\",\"servingType\":\"ON_DEMAND\"},\"chatRequest\":{\"message\":\"${parameters.prompt}\",\"apiFormat\":\"COHERE\"}}",
             "post_process_function": "def text = params['chatResponse']['text'].replace('\n', '\\\\n');\n return '{\"name\":\"response\",\"dataAsMap\":{\"inferenceResponse\":{\"generatedTexts\":[{\"text\":\"' + text + '\"}]}}}'"
 
         }
     ]
 }</copy>
  ```



Llama model:
```html
  <copy>POST _plugins/_ml/connectors/_create
{
     "name": "OpenAI Chat Connector",
     "description": "testing genAI connector",
     "version": 2,
     "protocol": "oci_sigv1",
     "parameters": {
         "endpoint": "inference.generativeai.us-chicago-1.oci.oraclecloud.com",
         "auth_type": "resource_principal"
     },
     "credential": {
     },
     "actions": [
         {
             "action_type": "predict",
             "method": "POST",
             "url": "https://${parameters.endpoint}/20231130/actions/generateText",
             "request_body": "{\"compartmentId\":\"<cluster_compartment_id>\",\"servingMode\":{\"modelId\":\"meta.llama-2-70b-chat\",\"servingType\":\"ON_DEMAND\"},\"inferenceRequest\":{\"prompt\":\"${parameters.prompt}\",\"maxTokens\":600,\"temperature\":1,\"frequencyPenalty\":0,\"presencePenalty\":0,\"topP\":0.75,\"topK\":-1,\"isStream\":false,\"numGenerations\":1,\"stop\":[],\"runtimeType\":\"LLAMA\"}}",
            "post_process_function": "def text = params['inferenceResponse']['choices'][0]['text'].replace('\n', '\\\\n');\n return '{\"name\":\"response\",\"dataAsMap\":{\"inferenceResponse\":{\"generatedTexts\":[{\"text\":\"' + text + '\"}]}}}'"
                          
               }
     ]
 }</copy>
  ```



meta.llama-3-70b-instruct  payload

(The API end-point is actions/chat)  
```html
  <copy>POST _plugins/_ml/connectors/_create
{
     "name": "Llama3 Chat Connector",
     "description": "Check errors in logs",
     "version": 2,
     "protocol": "oci_sigv1",
     "parameters": {
         "endpoint": "inference.generativeai.us-chicago-1.oci.oraclecloud.com",
         "auth_type": "resource_principal"
     },
     "credential": {
     },
     "actions": [
         {
             "action_type": "predict",
             "method": "POST",
             "url": "https://${parameters.endpoint}/20231130/actions/chat",
             "request_body": "{\"compartmentId\":\<YOUR_COMPARTMENT_OCID>\",\"servingMode\":{\"modelId\":\"meta.llama-3-70b-instruct\",\"servingType\":\"ON_DEMAND\"},\"chatRequest\":{\"maxTokens\":600,\"temperature\":1,\"frequencyPenalty\":0,\"presencePenalty\":0,\"topP\":0.75,\"topK\":-1,\"isStream\":false,\"apiFormat\":\"GENERIC\",\"messages\":[{\"role\":\"USER\",\"content\":[{\"type\":\"TEXT\",\"text\":\"${parameters.prompt}\"}]}]}}",
             
              "post_process_function": "def text = params['chatResponse']['choices'][0]['message']['content'][0]['text'].replace('\n', '\\\\n');\n return '{\"name\":\"response\",\"dataAsMap\":{\"inferenceResponse\":{\"generatedTexts\":[{\"text\":\"' + text + '\"}]}}}'"



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


## Step 4: Register the Model for RAG

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
## Step 5: Deploy the Model for RAG
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
## Step 6: Create a RAG Pipeline
Create a RAG pipeline using the model_id from the previous step, as shown in the following example:
```html
   <copy>PUT /_search/pipeline/demo_rag_pipeline
{
  "response_processors": [
    {
      "retrieval_augmented_generation": {
        "tag": "genai_conversational_search_demo",
        "description": "Demo pipeline for conversational search Using Genai Connector",
        "model_id": "<model_ID>",
        "context_field_list": ["text"],
        "system_prompt":"hepfull assistant",
        "user_instructions":"generate concise answer"
      }
    }
  ]
}</copy>
```
## Step 7: Create/Register/Deploy a model for kNN

Confirm that the OpenSearch cluster is version 2.11. To use an OCI Generative AI connector with OCI Search with OpenSearch, you need a cluster configured to use OpenSearch version 2.11. By default, new clusters are configured to use version 2.11. To create a cluster, see Creating an OpenSearch Cluster.


Step 1: Register Model Group

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

Step 2: Create the Connector

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


Step 3: Register the Model

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
Step 4: Deploy the Model

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
## Step 8: Create Search Index
After the RAG pipeline is created, you can perform RAG plus conversational search on any index.

- Create Search Index with KNN plugin (use the modle_id for kNN)

To leverage hybrid search instead of BM25 to enrich the retriever part of the RAG pipeline, you need to setup an ingestion pipeline and use an imported pretrained model so that documents embeddings are created at ingestion time.

1. For the purposes of this walkthrough, import, register and deploy an OpenSearch pretrained model using the steps described in Custom Models. This includes uploading the model file to an Object Storage bucket, and then specifying the model file's Object Storage URL when you register the model.

Make note of the model ID returned when you register and deploy the model.

2. Create an ingestion pipeline using the model id from the step#2, as shown in the following example:
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
                "dimension": 384,
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

## Step 9: Perform RAG with Hybrid Search

You can perform RAG with hybrid search as the retriever. Using hybrid search instead of BM25 can significantly improve the quality of the retriever. This is because the hybrid search retriever uses a deployed model to embed the user query into the same hyperspace as the indexed documents and then performs a pure semantic search to retrieve the most relevant documents to augment the LLM knowledge. If the retriever doesn't do a good job at retrieving and supplying the most relevant context to the LLM, the LLM model response isn't as accurate.

Using the conversation-demo-index-knn index from Create Search Index with KNN plugin,which already uses an ingestion pipeline with a deployed pretrained sentence transformer model, the RAG query uses hybrid search instead of BM5 search, as shown in the following example(use the kNN model_id):
```html
   <copy>GET /conversation-demo-index-knn/_search?search_pipeline=demo_rag_pipeline
{
  "query": {
    "bool" : {
      "should" : [
        {
          "script_score": {
            "query": {
              "neural": {
                "passage_embedding": {
                  "query_text": "when did us pass espionage act?",
                  "model_id": "<model_ID>",
                  "k": 3
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
    "ext": {
        "generative_qa_parameters": {
            "llm_model": "oci_genai/cohere.command",
            "llm_question": "when did us pass espionage act? answer only in two sentences using provided context.",
            "context_size": 2,
            "interaction_size": 1,
            "timeout": 15
        }
    }
}</copy>
```
Response:
```html
{
  "took": 1,
  "timed_out": false,
  "_shards": {
    "total": 1,
    "successful": 1,
    "skipped": 0,
    "failed": 0
  },
  "hits": {
    "total": {
      "value": 3,
      "relation": "eq"
    },
    "max_score": 0.80985546,
    "hits": [
      {
        "_index": "conversation-demo-index-knn",
        "_id": "6",
        "_score": 0.80985546,
        "_source": {
          "passage_embedding": [
            -0.015252565,
            0.023013491,
            -0.023333456,
            -0.088787265,
            0.03142115,
            0.053571254,
            0.067729644,
            -0.018526044,
            -0.02262757,
            0.054774728,
            0.095119946,
           .......
          ],
          "text": "In June 1917, the U.S. Congress passed the Espionage Act of 1917 which was later extended by the Sedition Act of 1918, enacted in May 1918. In February 1918, the Montana legislature had passed the Montana Sedition Act, which was a model for the federal version. In combination, these laws criminalized criticism of the U.S. government, military, or symbols through speech or other means. The Montana Act led to the arrest of over 200 individuals and the conviction of 78, mostly of German or Austrian descent. Over 40 spent time in prison. In May 2006, then-Governor Brian Schweitzer posthumously issued full pardons for all those convicted of violating the Montana Sedition Act."
        }
      },
      {
        "_index": "conversation-demo-index-knn",
        "_id": "7",
        "_score": 0.5822973,
        "_source": {
          "passage_embedding": [
            0.016897075,
            -0.027237555,
            -0.026178025,
            -0.041597113,
            -0.07700658,
            0.02490874,
            0.009785392,
            ........
          ],
          "text": "When the U.S. entered World War II on December 8, 1941, many Montanans already had enlisted in the military to escape the poor national economy of the previous decade. Another 40,000-plus Montanans entered the armed forces in the first year following the declaration of war, and over 57,000 joined up before the war ended. These numbers constituted about 10 percent of the state's total population, and Montana again contributed one of the highest numbers of soldiers per capita of any state. Many Native Americans were among those who served, including soldiers from the Crow Nation who became Code Talkers. At least 1500 Montanans died in the war. Montana also was the training ground for the First Special Service Force or Devil's Brigade a joint U.S-Canadian commando-style force that trained at Fort William Henry Harrison for experience in mountainous and winter conditions before deployment. Air bases were built in Great Falls, Lewistown, Cut Bank and Glasgow, some of which were used as staging areas to prepare planes to be sent to allied forces in the Soviet Union. During the war, about 30 Japanese balloon bombs were documented to have landed in Montana, though no casualties nor major forest fires were attributed to them"
        }
      },
      {
        "_index": "conversation-demo-index-knn",
        "_id": "4",
        "_score": 0.58108574,
        "_source": {
          "passage_embedding": [
            0.017924132,
            0.03570767,
            0.024848921,
            -0.023073182,
            -0.0023820316,
            0.009969,
            0.076653704,
            -0.10182037,
            .......
          ],
          "text": "The Desert Land Act of 1877 was passed to allow settlement of arid lands in the west and allotted 640 acres (2.6 km2) to settlers for a fee of $.25 per acre and a promise to irrigate the land. After three years, a fee of one dollar per acre would be paid and the land would be owned by the settler. This act brought mostly cattle and sheep ranchers into Montana, many of whom grazed their herds on the Montana prairie for three years, did little to irrigate the land and then abandoned it without paying the final fees. Some farmers came with the arrival of the Great Northern and Northern Pacific Railroads throughout the 1880s and 1890s, though in relatively small numbers"
        }
      }
    ]
  },
  "ext": {
    "retrieval_augmented_generation": {
      "answer": """ The United States passed the Espionage Act in 1917, with the Sedition Act being enacted in 1918. This was preceded by the Montana Sedition act in 1918, which served as a model for the federal version, and resulted in the arrest of over 200 people, many of German or Austrian descent.
 
Would you like to know more about the Espionage act or any other events that occurred during that period? """
    }
  }
}
```
## Step 10: Perform Conversational Search with Hybrid Search Retriever

To perform conversational search create a conversation memory and pass the returned conversation ID to the RAG API call.

The following example shows how to create the conversation memory to get the conversation ID:
```html
   <copy>POST /_plugins/_ml/memory/conversation
{
  "name": "rag-conversation"
}</copy>
```
Response:
```html
   {
  "conversation_id": "<conversation_ID>"
}
```

- Conversational Search with Hybrid Search Retriever
Try the following (use the kNN model_id):
```html
   <copy>GET /conversation-demo-index-knn/_search?search_pipeline=demo_rag_pipeline
{
  "query": {
    "bool" : {
      "should" : [
        {
          "script_score": {
            "query": {
              "neural": {
                "passage_embedding": {
                  "query_text": "when did us pass espionage act?",
                  "model_id": "<model_ID>",
                  "k": 3
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
    "ext": {
        "generative_qa_parameters": {
            "llm_model": "oci_genai/cohere.command",
            "llm_question": "when did us pass espionage act? answer only in two sentences using provided context.",
            "conversation_id": "<conversation_ID>",
            "context_size": 2,
            "interaction_size": 1,
            "timeout": 15
        }
    }
}</copy>
```

Specifying the conversation ID prompts OpenSearch to create a memory to track the history of the conversation. The following details are passed to the LLM for conversational search:

The retrieved context documents.
The user's input query and prompt fine-tuning.
The user's previous conversation history based on the specified conversation ID.
You can control how many previous conversation contexts to consider using the interaction_size parameter in the API call. You can also use the context_size to control how many of the retrieved top documents you want to parse to the LLM as context to augment the knowledge.




## Acknowledgements

* **Author** - Landry Kezebou Yankam
* **Last Updated By/Date** - George Csaba, June 2024
