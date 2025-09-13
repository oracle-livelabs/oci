# Pre-requisites
You have to have an existing OpenSearch cluster and have to be able to connect to the Dashboard, to perform all of the steps.

## Introduction

In this lab, you will be creating a Data Prepper pipeline to automate data ingestion into you opensearch index. You can create index from scratch on re-use the KNN index created in the previous lab. You will be creating 2 pipelines. One for processing your app knowledge base, and another for streaming your app live logs. The Goal here is to be able to leverage Agentic framework to perform Root Cause Analysis (RCA) seemlessly without writing. The RCA part will be demonstrated in the next labs

Estimated Time: 30 minutes

### Objectives

In this lab, you will:

1. Create a Data Prepper pipeline to continously stream and ingest data into your cluster
2. Create an object Storage bucket to dump your logs or other data.
3. Verify that Data is getting ingested properly

<br/><br/>

## Task 1: Create Policies:
This lab assumes that you already created the opensearch index in which you will like to dump your logs.
To use the Data Prepper pipeline creation feature, you need to setup some required policies.

If you're a non-administrator in your tenancy, contact your tenancy administrators to grant these permissions to you. The administrator must update the following users permission to allow non-administrator users to manage and CRUD operations the pipelines

1. The following policy allows the administrator to grant permission for a group in a compartment (recommended)
```bash
Allow group <group> to manage opensearch-cluster-pipeline in compartment <compartment>
```
where <group> is all the users inside that group can access the resource.

2. The following policy allows OpenSearch pipelines to read the secrets from the Oracle Cloud Infrastructure Vault.

```bash
Allow group <group> to read secret-bundles in compartment <compartment> WHERE ALL {request.principal.type='opensearchpipeline', target.secret.id = '<target-secret-ocid>' }' }
Allow group <group> to read secrets in compartment <compartment> WHERE ALL {request.principal.type='opensearchpipeline', target.secret.id = '<target-secret-ocid>' }
```

3. The following policy allows OpenSearch pipelines to use a bucket from Object Storage as the source coordination persistence:

```bash
Allow group <group> to manage objects in compartment <compartment> WHERE ALL {request.principal.type='opensearchpipeline', target.bucket.name='<source-coordination-bucket-name>'}
```

> Note: Visit Our Documentation for more information about [data prepper policy configuration](https://docs.oracle.com/en-us/iaas/Content/search-opensearch/Concepts/ociopensearchpipelines.htm#required-policies)




<br/><br/>

## Task 2:  Create Object Storage buckets

Data prepper supports both the **Pull** and the **Push** functionalities to pull/stream data from various sources into the opensearch cluster, and stream data from opensearch to other sinks.  For the **Pull** we currently support multiple data sources including  Object Storage Bucket, and Kafka. Whereas for the Push we support HTTP, and OpenTelemetry.

In this Lab, we will focus the **Pull** from Object Storage bucket to stream data into our Opensearch cluster.

You need to create 2 buckets, 1 for dumping your application data, and another which the pipeline will use to track unassigned, assigned, and completed tasks.

1. Navigate to OCI Console, Click on the main menu and type **bucket**, then click on **Bucket** This should open the Object Storage bucket page.
![Create Bucket](images/create-bucket-1.png)
<br/>

2. Click on **Create Bucket** button to open the Bucket Creation wizard

<br/>

3. Enter your bucket name, in the Wizard, leave everything else default, then click **Create Bucket**. This should create the Object Storage bucket.

![Create Bucket](images/create-bucket-2.png)

<br/>

4. Open the Bucket you just created and navigate to the **Details** tab to view the bucket namespace and OCID
![Create Bucket](images/create-bucket-3.png)

<br/>

5. Create 2 folders to the 2 pipelines we are going to be creating in the next task.

    - Navigate to your first object storage bucket
    - Click on **Actions** and click on **Create Folder**
    - Type a name for your folder but make sure it matches the folder name you used in the pipeline.

    > For this Lab you should create a folder called **knowledge_base** and another called **app-logs**. Make sure to use these names in your pipeline yaml file above.
    ![Data Preper](images/create-bukect-folders.png)




<br/><br/>

## Task 3:  Create Vault and Vault Secrets
The data prepper needs to access your cluster to stream data into your indices. When creating the pipeline, you must supply the Opensearch Credentials i.e Username and password.
These credentials need to be encrypted for security purposes. This is where the OCI Vault comes in! A vault allows your to create master encryption key to encrypt and store all your credentials which can be used by several consuming applications without compromising on security.
A vault can contain several secrets.

1. Create a Vault to store your secret credentials
    - Login to OCI console and navigate to **Vault** under **Key Management & Secret Management** service.
    ![Navigate to Vault](images/vault-1.png)
    - Click on **Create Vault**
    - Enter a Vault name and Choose the compartment and Click **Create Vault**. Make sure to choose the same compartment the compartment where the resource you want to access lives.
    ![Navigate to Vault](images/vault-2.png)

2. Create a master encryption Key to be used to encrypt your secret credentials
    - Open the Vault you just created and navigate to the  **Master Encryption Key File** and then click on **Create Key**
    ![Navigate to Vault](images/vault-3.png)

    - Enter the a name for your master encryption key and click **Create Key**
    ![Navigate to Vault](images/vault-4.png)

3. Create a username secret for your opensearch username name
    - Open the Vault you create and navigate to the **Seceret** Tab
    - Click on **Create Secret** to open the Wizard
    ![Navigate to Vault](images/secret-1.png)
    - Enter a name for your secret e.g: *opensearch_username*.
    - Select **Manual Secret Generation**
    - Type the actual username (e.g: admin1) in the **Secret Content** field. do not surround it content with any quotes.
    - Click **Create**
    ![Navigate to Vault](images/secret-2.png)

4. Create a passwrod secret for your opensearch password
Repeat step 3 above to create a secret for your opensearch password.


<br/><br/>

## Task 4:  Create A KKN index to Stream data from the Data Prepper Pipeline into your cluster
The Data Prepper requires you to specify an index into which data will be ingested. If you do not create an index, the pipeline will be default create an index with the name provided in the yaml config file. For this Lab and for our use case, we will be creating 2 pipelines, one to stream knowledge base for a given app, and another to stream logs generate by said app so we can perform Root Cause Analysis in the subsequent Labs.

1. Create KNN index using the *chunking-pipeline* created in the previous lab. The index should be structured with automatic chunking to enable granular search.

```bash
PUT app_knowledge_base
{
  "settings": {
    "index.knn": true,
    "default_pipeline": "chunking-pipeline"
  },
  "mappings": {
    "properties": {
      "text": {
        "type": "text"
      },
      "chunk_embedding": {
        "type": "nested",
        "properties": {
          "knn": {
            "type": "knn_vector",
            "dimension": 384
          }
        }
      }
    }
  }
}
```

Feel free to change the  index name . You also need to be sure that the *dimension* parameter matches that of the embedding model you deployed and used in the ingestion pipeline creation.
For this Lab, we will be using the pre-trained **mini-L12** model deployed in the cluster.


<br/><br/>

## Task 5:  Create The Data Prepper Pipeline

1. Navigate to your opensearch cluster, scroll down and click on **pipelines** in the left side bar
2. Click on Create Pipeline

![Data Prepper](images/data-pepper-1.png)

<br/>

3. Choose a name for your pipeline

![Data Prepper](images/data-prepper-2.png)
![Data Prepper](images/data-prepper-3.png)


4. Scroll down and Select **Pull**, then select **Object Storage**
5. Copy & paste the following yaml config into the  **Pipeline YaML**
    field. Be sure to edit the config with the values for your object storage bucket name, namespace, opensearch_password secret OCID, opensearch_usernane OCID etc. Use the Object storage bucket where you will be uploading the documents to ingest.

<br/>

```bash
version: 2
pipeline_configurations:
  oci:
    secrets:
      opensearch-username:
        secret_id: <YOUR-OPENSERACH-USERNAME-SECRET-OCID>
      opensearch-password:
        secret_id: <YOUR-OPENSEARCH-PASSWORD-SECRET-OCID>
simple-sample-pipeline:
  source:
    oci-object:
      codec:
        newline:
      acknowledgments: true
      compression: none
      scan:
        scheduling:
          interval: "PT30S"
        buckets:
          - bucket:
              namespace: <YOUR-FIRST-BUCKET-NAMESPACE>
              name: <YOUR-FIRST-BUCKET-NAME>
              region: <REGION-KEY>
              filter:
                include_prefix: ["knowledge_base"]
  processor:
    - rename_keys:
        entries:
        - from_key: "message"
          to_key: "text"
          overwrite_if_to_key_exists: true
  sink:
    - opensearch:
        hosts: [ <YOUR-OPENSEARCH-OCID> ]
        username: ${{oci_secrets:opensearch-username}}
        password: ${{oci_secrets:opensearch-password}}
        insecure: false
        index: app_knowledge_base
```

> Note: If you used a different index name in the previous step, make sure you use the same index name in the yaml config. 

5.  Scroll down to the **Source Coordination YAML** section and copy paste the yaml config below. Be sure to edit values for bucket-name and namespace . Note that this should be for the second bucket.

```bash
source_coordination:
  store:
    oci-object-bucket:
      name: <YOUR-SECOND-BUCKET-NAME>
      namespace: <YOUR-SECOND-BUCKET-NAMESPACE>
```


6. Create a second pipeline with the same yaml config as above. Only change the index name and the folder name. You can use first folder e.g **knowledge_base** for folder name in the Knolwdege_base pipeline and **app-logs** in the app-logs pipeline

```bash
version: 2
pipeline_configurations:
  oci:
    secrets:
      opensearch-username:
        secret_id: <YOUR-OPENSERACH-USERNAME-SECRET-OCID>
      opensearch-password:
        secret_id: <YOUR-OPENSEARCH-PASSWORD-SECRET-OCID>
simple-sample-pipeline:
  source:
    oci-object:
      codec:
        newline:
      acknowledgments: true
      compression: none
      scan:
        scheduling:
          interval: "PT30S"
        buckets:
          - bucket:
              namespace: <YOUR-FIRST-BUCKET-NAMESPACE>
              name: <YOUR-FIRST-BUCKET-NAME>
              region: <REGION-KEY>
              filter:
                include_prefix: ["app-logs"]
  processor:
    - rename_keys:
        entries:
        - from_key: "message"
          to_key: "text"
          overwrite_if_to_key_exists: true
  sink:
    - opensearch:
        hosts: [ <YOUR-OPENSEARCH-OCID> ]
        username: ${{oci_secrets:opensearch-username}}
        password: ${{oci_secrets:opensearch-password}}
        insecure: false
        index: app_live_logs
```


<br/>

```bash
source_coordination:
  store:
    oci-object-bucket:
      name: <YOUR-SECOND-OBJECT-STORAGE-BUCKET>
      namespace: <YOUR-BUCKET-NAMESPACE>
```

 <br/> <br/>

 The pipeline will take about 20min to get provisioned. Once it is completed you can upload documents into your index to trigger the pipeline.

## Task 5: Add data into your Object Storage Bucket.

1. Navigate to your first object storage bucket

![Data Preper](images/bucket-folder-1.png)

4. Download the [ai_app_error_kb.json](files/ai_app_error_kb.json) and the [ai-app-live-logs.json](files/ai-app-live-logs.json)

5. Navigate to the **knowledge_base** folder, Click on **Upload Objects**  then drag and drop the *ai_app_error_kb.json*. Click **Next** to upload the json file in the folder. Then Click **Close** to return to the Folder.

6. Navigate to the **app-logs** folder, Click on **Upload Objects**  then drag and drop the *ai-app-live-logs.json*. Click **Next** to upload the json file in the folder.

7. Uploading these documents into the should trigger data ingestion into the index configured with respective pipelines.



<br/><br/>

## Task 6:  Verify that the pipeline is automatically pulling data from your bucket and Ingesting it into opensearch

1. Login to your Opensearch cluster dashboard
2. Navigate to the **Dev Tools**
3. Run command below

```bash
GET app_knowledge_base/_search
{ "_source": {"excludes": ["chunk_embedding.knn","embedding"]},
  "size": 1000,
  "query": {
    "match_all": {}
  }
}
```

You should a response like the following

![data-prepper index search response](images/index-response.png)


If data is not getting pulled into your index, verify that the Data Prepper is done getting provisioned. You can also try deleting and re-uploading the documents into the respective folders to trigger the pipeline.
Ideally the pipeline should be pulling the data at the frequency specified in the yaml config file. The command below indicates that the pipeline is scheduled to run every 30 Seconds.

```bash
scan:
        scheduling:
          interval: "PT30S"
```


## Acknowledgements

* **Author** - Landry Kezebou
* **Last Updated By/Date** - Landry Kezebou, September 2025
