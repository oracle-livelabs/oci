# Manage OCI infrastructure using OCI Crossplane provider

## Introduction

* This lab walks you through the steps to deploy OCI infrastructure from kubernetes environment using OCI Crossplane provider.

Estimated Lab Time: 30 minutes

### Objectives

In this lab, you will:
* How to deploy an OCI Bucket using OCI Crossplane provider
* How to delete a resource using OCI Crossplane provider
* Troubleshouting tips for OCI Crossplane provider

### Prerequisites

This lab assumes you have:
* All previous labs successfully completed

## Task 1: How to deploy an OCI Bucket using OCI Crossplane provider

1. You need to connect to the operator instance, as we did in [Lab 2 Task 2 Step 15](./../provision/provision.md#task-2-provision-resources).

	![Image alt text](images/sample1.png)

2. Go to [examples of resources for OCI Crossplane provider](https://github.com/oracle-samples/crossplane-provider-oci/tree/main/examples) and copy the [bucket deployment](https://github.com/oracle-samples/crossplane-provider-oci/blob/main/examples/objectstorage/bucket.yaml)

  ![Image alt text](images/sample1.png)

4. Create a yaml file called bucket.yaml on your operator instance and paste the content in there:


5. Change the with compartmentId and give the ocid of the compartment where you want the bucket to be created:
  ```
  compartmentId: "ocid1.compartment.oc1.."
  ```

6. Change the namespace with your tenanacy object namespace. See [Task 1 Step 1](./../provision/provision.md#task-1-gathering-data-to-complete-variables-in-resource-manager) in the previous Lab.
  ```
  namespace: tenanacy_namespace
  ```

7. Run the **bucket.yaml** file using kubectl:
  ```
  kubectl apply -f bucket.yaml
  ```

8. After the kubectl command runned succesfully the bucket will be created and you can check it in the OCI console.

9. Now you can reference the bucket in your kubernetes resources by using the metadata name you gave to the bucket:
  ```
  metadata:
    name: bucket-via-crossplane4
  ```

10. You can check details about the created resources with OCI Crossplane provider in the **make_run.log** located in the home directory of the operator instance.


## Task 2: Delete an OCI resource using OCI Crossplane provider

1. To delete the previosly created bucket, simply run the kubectl delete command:
  ```
  kubectl delete -f bucket.yaml
  ```

2. You can check details about the status of deleting  resources with OCI Crossplane provider in the **make_run.log** located in the home directory of the operator instance.


## Task 3: Troubleshouting tips

1. Allways check the status of the resources in the **make_run.log** file.

2. In the log you will see if there is an authentication problem for the provider if you are seeing 404 Not Authorized errors. To solve this check the **~/crossplane_yamls/secret.yaml** and make sure the information about login to OCI are correct. Also, you can check if the secret is created and contains the correct information.

## Acknowledgements

**Authors**

* **Ionut Sturzu**, Principal Cloud Architect, NACIE
