# Setup required resources for manufacturing application

## Introduction

This workshop help setup resources required for running manufacturing spark applications in OCI Data Flow.

Estimated time: 10 minutes

### Objectives

* Plan and Apply terraform scripts in OCI Resource Manager to provision required resources.
* Verify required resources are created.

### Prerequisites

* This lab requires an [Oracle Cloud account](https://www.oracle.com/cloud/free/). You may use your own cloud account, or a Free tier account, a cloud account that you obtained through a trial.
* This lab requires user with necessary access to CREATE,MODIFY,DELETE below OCI resources at tenancy level.
    * OCI Compartments
    * OCI UserGroup
    * OCI Policies
    * OCI Autonomous Databases
    * OCI Vault
    * OCI Object Storage Buckets & Objects
    * OCI Streampool & Streams
    * OCI Dataflow Application & Runs

## Task1: Create an OCI compartment

1. Open the navigation menu from the top-left corner (aka. hamburger menu) of the Oracle Cloud console and select **Identity & Security** > **Compartments**.
	![Oracle Cloud console Menu](images/1-1-compartments.png " ")
2. Click **Create Compartments**
	![Oracle Cloud console, Create Compartment](images/1-2-compartments.png " ")
3. Enter the following parameters:
*	Compartment name: **apmworkshop**
*	Description: **APM workshop compartment**
*	Accept the default values for the other fields, and click, **Create Compartment**
	![Oracle Cloud console, Create Compartment](images/1-3-compartments.png " ")
*	Verify that your apmworkshop compartment is created in the table
	![Oracle Cloud console, Create Compartment](images/1-4-compartments.png " ")

## Task2: Create an OKE

1. Open the navigation menu from the top left corner (aka. hamburger menu) in the Oracle Cloud console, and select **Developer Services** > **Kubernetes Clusters (OKE)**.

   ![Oracle Cloud console, Navigation Menu](images/1-1-menu.png " ")

2. Make sure the **apmworkshop** is selected in the Compartment field, then click **Create cluster**

   ![Oracle Cloud console, Clusters in Compartment](images/1-2-OKE.png " ")

3. Quick Create pane is pre-selected. Keep the default selection and click **Submit**.

   ![Oracle Cloud console, Create cluster](images/1-3-OKE.png " ")

4. Name the cluster as **apmlab-cluser1**. Accept the default setting for other fields and click **Next**.

   ![Oracle Cloud console, Create cluster](images/1-4-OKE.png " ")
   ![Oracle Cloud console, Create cluster](images/1-5-OKE.png " ")

5. Review the configuration, and click **Create cluster**.

   ![Oracle Cloud console, Create cluster](images/1-6-OKE.png " ")

6. Make sure all verification steps are cleared. Click **Close**.

   ![Oracle Cloud console, Create cluster](images/1-7-OKE.png " ")

7.  This will start to create a cluster, and takes 7 to 10 minutes to complete. While waiting for the creation of the cluster, you can proceed to the next lab to create an APM domain. In Lab 3, we will resume the steps to build the application.

   ![Oracle Cloud console, Create cluster](images/1-8-OKE.png " ")




You may now **proceed to the next lab**.

## Acknowledgements
- **Author** - Sujoy Chowdhury, Senior Principal Product Manager,
- **Contributors** - OCI Data Flow Sivanesh Selvanataraj, Senior Software Engineer, OCI Data Flow
- **Last Updated By/Date** - Sivanesh Selvanataraj, September 2022
