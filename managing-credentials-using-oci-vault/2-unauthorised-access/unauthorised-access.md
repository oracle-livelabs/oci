# Attacker Persona and Public Bucket Access

## Introduction

Step into Lab 2, adopting the perspective of an attacker granted unauthorized access to a public OCI bucket. Explore the inherent risks and potential exploits associated with managing keys in publicly accessible storage.

Estimated Time: 15 minutes

### Objectives

In this lab, you will:

- Comprehend the risks associated with publicly accessible buckets in OCI.
- Explore the perspective of an attacker gaining unauthorized access to a public bucket.
- Analyze the potential exploits and risks involved when managing keys in publicly accessible storage.

### Prerequisites

This lab assumes you have:

- Some understanding of cloud terms
- Familiarity with Oracle Cloud Infrastructure (OCI) would be helpful

## Task 1: Attacker persona and public bucket access

<!--- TODO: add Lab-2 video -->
   [
      ![Watch the video](https://i.stack.imgur.com/Vp2cE.png)
   ](https://youtu.be/vt5fpE0bzSY)

## Task 2: Unauthorized access to a public OCI bucket (Script)

Given the public accessibility of the bucket, an unauthorized individual could potentially exploit the situation by employing the same link as the DevOps persona to access and retrieve the `api-credentials.yml` file from the bucket.

- Update the below URL parameters:
  - `{region_endpoint}` represents the API endpoint for the OCI Object Storage service in the region where the bucket is located.
  - `{namespace_name}` is the namespace of your OCI account.
  - `{bucket_name}` is the name of the bucket.

``` bash
https://objectstorage.{region_endpoint}.oraclecloud.com/n/{namespace_name}/b/{bucket_name}/o/api-credentials.yml
```

- Open a terminal or command prompt.
- Use the curl command to retrieve the object using the URL:

``` bash
curl -X GET https://objectstorage.{region_endpoint}.oraclecloud.com/n/{namespace_name}/b/{bucket_name}/o/api-credentials.yml
```

## Learn More

- [OCI Bucket](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/managingbuckets.htm)
- [OCI DevOps](https://www.oracle.com/devops/devops-service/)

## Acknowledgements

- **Author**
  - Andrea Romano, Senior Research Manager, Oracle Labs
- **Contributors**
  - Rhicheek Patra, Research Director, Oracle Labs
  - El Houcine Es Sanhaji, Member of Technical Staff, Oracle Labs
  - Robin Vaaler, Senior Member of Technical Staff,  Oracle Labs
- **Last Updated By/Date**
  - El Houcine Es Sanhaji, 11 2023
