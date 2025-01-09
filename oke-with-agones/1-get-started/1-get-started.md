# Get Started

In this lab you will install the necessary components for this workshop.

## Introduction

In order to complete this workshop you will need to have the necessary tooling to connect to and deploy OCI resources.

You will be using Terraform to deploy to OCI and will also need the OCI CLI.

Estimated Time: 15 minutes

### Objectives

In this lab, you will:
 - Install the OCI CLI
 - Install Terraform
 - Download the Terraform files
 - Initialize Terraform

### Prerequisites

Please ensure you have the following before continuing

 - An OCI Tenancy
 - A Shell ([OCI Cloud Shell](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cloudshellintro.htm), Linux, MacOS, Windows with WSL)
 - A user in a group with Tenancy Admin and downloaded API Key

## Task 1: Install the OCI CLI

Install the OCI CLI

1. Make sure you have the policy for Tenancy admin. This is required because the Terraform OKE module creates a dynamic group policy, other than that everything gets created in a OCI Compartment you specify in the `terraform.tfvars` file.

1. Follow the [install steps from Oracle](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm)

2. Make sure you followed the steps above and are fully setup with API Keys (this will be the case if you did `oci setup config`) for the user of the above mentioned Tenancy admin.

## Task 2: Install Terraform

Complete the [install steps form Hashicorp](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## Task 3: Download the Terraform Files

Download the Terraform files

1. Create a directory called `infrastructure` in your system

    ````shell
    <copy>
    mkdir infrastructure
    cd infrastructure
    </copy>
    ````

2. Download the terraform files from [terraform.tar.gz](./files/terraform.tar.gz) to `infrastructure`.

3. Untar the downloaded file

    ````shell
    <copy>
    tar -xvzf terraform.tar.gz
    </copy>
    ````

3. From within the infrastructure folder, initialize the Terraform

    ````shell
    <copy>
    terraform init
    </copy>
    ````

You may now **proceed to the next lab**

## Learn More - *Useful Links*

- [Kubernetes](https://kubernetes.io/)
- [OKE](https://www.oracle.com/cloud/cloud-native/kubernetes-engine/)
- [OKE Terraform Module](https://oracle-terraform-modules.github.io/terraform-oci-oke/)

## **Summary**

You have now initialized the dependencies for this Workshop.

## **Acknowledgements**

 - **Author** - Marcellus Miles, Master Cloud Architect
 - **Last Updated By/Date** - Marcellus Miles, Dec 2024