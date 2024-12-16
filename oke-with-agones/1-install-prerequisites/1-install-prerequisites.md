# Install Prerequisites

In this lab you will install the necessary components for this workshop.

## Introduction

In order to complete this workshop you will need to have the necessary tooling to connect to and deploy OCI resources.

You will be using Terraform to deploy OCI and will also need the OCI CLI.

Estimated Time: 15 minutes

Objectives
In this lab, you will:
 - Install the OCI CLI
 - Install Terraform
 - Download the Terraform files
 - Initialize Terraform

Prerequisites
 - An OCI Tenancy
 - A user in a group with Tenancy Admin
 - An API key for that user

## **Task 1**: Install the OCI CLI

1. Make sure you have the policy for Tenancy admin. This is required because the Terraform OKE module creates a dynamic group policy, other than that everything gets created in a OCI Compartment you specific in the `terraform.tfvars` file.

1. Follow the [install steps from Oracle](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm)

2. Make sure you followed the steps above and are fully setup with API Keys (this will be the case if you did `oci setup config`) for the user of the above mentioned Tenancy admin.

## **Task 2**: Install Terraform

1.  Follow the [install steps form Hashicorp](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## **Task 3**: Download the Terraform Files

1. Create a directory called `infrastructure` in your system
2. Download all the files in [files](files/) to `infrastructure`.
3. Initialize the Terraform

       cd infrastructure
       terraform init

## **Summary**

You have now initialized the dependencies for this Workshop.

## **Acknowledgements**

 - **Author** - Marcellus Miles, Master Cloud Architect
 - **Last Updated By/Date** - Marcellus Miles, Dec 2024