# Provision of the necessary resources

## Introduction

In this lab, we will provision the requiredv resources: an OKE cluster and all necessary add-ons. We’ll use a pre-built repository that automates the setup.

Estimated Time: 30 minutes

### **Objectives**

Provisioning of the infrastructure using OCI Resource Manager.

### **Prerequisites**

This lab assumes you have:

* An Oracle Cloud account
* Administrator privileges or access rights to the OCI tenancy
* Basic Kubernetes knowledge (kubectl, Helm, manifests).
* Local setup with:
    - kubectl
    - helm
    - oci CLI configured

## Task 1: Provision resources

1. Download the  
Go to Resource manager -> Stacks -> Create Stack. Choose My configuration and upload the provided folder and click Next: [openkruise-on-oke.zip](https://github.com/dranicu/openkruise-on-oke/archive/refs/heads/main.zip)

    ![Resource Manager](images/resource_manager.png)

    Or you could use the single click deployment button shown below

    [![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/dranicu/openkruise-on-oke/archive/refs/heads/main.zip)

2. Provide the following information: 

**Select Compartment**: Choose the appropriate compartment for the Kubernetes cluster.
**Cluster Name**: Enter a descriptive name for the cluster.
**Create New VCN**: Check the option to create a new VCN and leave other networking details as default.
**SSH Public key**: Choose the ssh public key file or paste the key in the section

3. Once all of the variables are configured click **Next** and after that click apply.

![Apply Stack](images/run_apply.png)

4. Wait for the job to complete, which may take 15-20 minutes before the infrastructure is fully provisioned.

You may now proceed to the next lab.

## Acknowledgements

**Authors**

* **Dragos Nicu**, Senior Cloud Engineer, NACIE
* **Last Updated By/Date** - Dragos Nicu, September 2025
