# Developer persona and credentials misuse

## Introduction

Embark on Lab 1 as a developer persona navigating the challenges of DevOps in OCI. Witness the consequences of storing credentials in an OCI bucket for automation, as we delve into the risks and security implications of key misuse.

Estimated Time: 15 minutes

### Objectives

In this lab, you will:

* Understand the challenges associated with storing credentials in OCI buckets for DevOps automation.
* Recognize the potential risks and security implications of mishandling keys within an OCI setup.
* Experience the consequences of unauthorized access resulting from the misuse of keys.

### Prerequisites

This lab assumes you have:

* Some understanding of cloud terms
* Familiarity with Oracle Cloud Infrastructure (OCI) would be helpful

## Task 1: Developer persona and credentials misuse

<!--- TODO: add Lab-1 video -->
   [
      ![Watch the video](https://i.stack.imgur.com/Vp2cE.png)
   ](https://youtu.be/vt5fpE0bzSY)

## Task 2: Retrieve the credentials from the OCI bucket using REST API  

### 1- Construct the URL of the Object

The URL of an object in an OCI bucket follows a specific pattern:

``` bash
https://{api_endpoint}/n/{namespace_name}/b/{bucket_name}/o/{object_name}
```

* `{api_endpoint}` represents the API endpoint for the OCI Object Storage service in the region where the bucket is located. You can find the API endpoint for your region in the [OCI documentation](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm).
* `{namespace_name}` is the namespace of your OCI account.
* `{bucket_name}` is the name of the bucket.
* `{object_name}` is the name of the object (file) you want to retrieve.

For example, if you want to retrieve the `api-credentials.yml` file from a bucket named `my-bucket` in the `us-phoenix-1` region, and your namespace is `my-namespace`, the URL of the object would be:

``` bash
https://objectstorage.us-phoenix-1.oraclecloud.com/n/my-namespace/b/my-bucket/o/api-credentials.yml
```

### 2- Retrieve the Object Using the URL

* Open a terminal or command prompt.
* Use the curl command to retrieve the object using the URL:

``` bash
curl -X GET https://objectstorage.us-phoenix-1.oraclecloud.com/n/my-namespace/b/my-bucket/o/api-credentials.yml
```

The command will output the content of the `api-credentials.yml` file to your terminal.

### 3- Verify the Retrieved Data

Here is the `api-credentials.yml` file original content:

``` yml
api-key: some-token
```

Compare the content of the file with the output from the curl command to verify that you have retrieved the correct data.

That's it! You have successfully retrieved a file from an OCI public bucket using REST API.

## Learn More

* [OCI Bucket](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/managingbuckets.htm)
* [OCI DevOps](https://www.oracle.com/devops/devops-service/)

## Acknowledgements

* **Author**
  * Andrea Romano, Senior Research Manager, Oracle Labs
* **Contributors**
  * Rhicheek Patra, Research Director, Oracle Labs
  * El Houcine Es Sanhaji, Member of Technical Staff, Oracle Labs
  * Robin Vaaler, Senior Member of Technical Staff,  Oracle Labs
* **Last Updated By/Date**
  * El Houcine Es Sanhaji, 11 2023
