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

## Prerequisite:
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

Data prepper support both the **Pull** and the **Push** functionalities to pull/stream data from various sources into the opensearch cluster, and stream data from opensearch to other sinks.  For the **Pull** we currently support mutiple data sources including  Object Storage Bucket, and Kafka. Whereas for the Push we support HTTP, and OpenTelemetry.

In this Lab, we will focus the **Pull** from Object Storage bucket to stream data into our Opensearch cluster.

You need to create 2 buckets, 1 for dumping your application data, and another which the pipeline will use to track unassigned, assigned, and completed tasks.

1. Navigate to OCI Console, Click on the main menu and type **bucket**, then click on **Bucket** This should open the Object Storage bucket page.
![Create Bucket](images/create-bucket-1.png)
<br/>

2. Click on **Create Bucket** button to open the Bucket Creation wizard

<br/>

3. Enter your bucket name, in the Wizard, leave everthing else default, then click **Create Bucket**. This should create the Object Storage bucket.

![Create Bucket](images/create-bucket-2.png)

<br/>

4. Open the Bucket you just created and navigate to the **Details** tab to view the bucket namespace and OCID
![Create Bucket](images/create-bucket-3.png)



## Acknowledgements

* **Author** - Landry Kezebou
* **Last Updated By/Date** - Landry Kezebou, September 2025
