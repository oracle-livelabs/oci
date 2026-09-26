# Provision of the necessary resources

## Introduction

In this lab, we will provision the required resources: an OKE cluster along with Falco and Falco Sidekick.  
We’ll use a pre-built Terraform configuration that automates the entire setup — creating the OKE environment, configuring network and access policies, and deploying Falco via Helm with Sidekick and its web UI enabled.

Estimated Time: 30 minutes

### **Objectives**

* Provision the infrastructure using OCI Resource Manager.  
* Create a new VCN, OKE cluster, and supporting hosts (bastion and operator).  
* Prepare the environment for Falco deployment.

### **Prerequisites**

This lab assumes you have:

* An Oracle Cloud account.
* Administrator privileges or sufficient access rights to create and manage OKE resources.
* Basic understanding of Kubernetes concepts (pods, Helm charts, namespaces).
* Access to a command-line environment such as **OCI Cloud Shell** (or a local setup) with:
  - `kubectl`
  - `helm`
  - `oci` CLI configured for your tenancy.

## Task 1: Provision resources

1. Download the provided archive of the code: [labfiles_falco-on-oke-main.zip](https://c4u04.objectstorage.us-ashburn-1.oci.customer-oci.com/p/EcTjWk2IuZPZeNnD_fYMcgUhdNDIDA6rt9gaFj_WZMiL7VvxPBNMY60837hu5hga/n/c4u04/b/livelabsfiles/o/labfiles%2Ffalco-on-oke-main.zip)

2. In your OCI tenancy go to **Developer Services → Resource Manager → Stacks → Create Stack**.  

3. Select **My configuration**, upload the downloaded code as *.Zip file* or *Folder*, and click **Next**.

    ![Resource Manager](images/resource_manager.png)

4. On the next screen provide the following information: 

- **Deployment compartment target**: Choose the appropriate compartment for the OKE cluster.
- **Cluster Name**: Enter a descriptive name for the OKE cluster.
- **SSH public key**: You have the option to input here your own SSH public key.
- **VCN Name**: Enter a descriptive name for the new VCN where the resources will be placed.

5. Once all of the variables are configured click **Next**, review the *Stack information*, check the **Run apply** box and click **Apply**.

    ![Apply Stack](images/run_apply.png)

4. Wait for the job to complete, which may take 15-20 minutes before the infrastructure is fully provisioned.

You may now **proceed to the next lab**.

## Acknowledgements

**Authors**

* **Adina Nicolescu**, Principal Cloud Architect, NACIE
* Last Updated - Adina Nicolescu, November 2025
