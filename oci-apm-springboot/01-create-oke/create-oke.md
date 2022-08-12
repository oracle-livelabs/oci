# Create a Kubernetes cluster

## Introduction

This workshop uses a Spring Boot based Java microservices as a target application to trace against. In this lab, you will create an Oracle container engine for Kubernetes (OKE) cluster in your tenancy. In the Lab 3, you will deploy the application to the OKE.

Estimated time: 20 minutes

### Objectives

* Build a microservices application for monitoring

### Prerequisites

* Completion of the preceding labs in this workshop

## **Task 1**: Create an OKE

1. Open the navigation menu from the top left corner (aka. hamburger menu) in the Oracle Cloud console, select **Developer Services** > **Kubernetes Clusters (OKE)**.

   ![Oracle Cloud console, Navigation Menu](images/1-1-menu.png " ")

2. Make sure the **apmworkshop** is selected in the Compartment field, then click **Create cluster**

   ![Oracle Cloud console, Navigation Menu](images/1-2-OKE.png " ")

3. Quick Create pane is pre-selected. Keep the default selection and click **Submit**.

   ![Oracle Cloud console, Navigation Menu](images/1-3-OKE.png " ")

4. Name the cluster as **apmlab-cluser1**. Accept the default setting for other fields and click **Next**.

   ![Oracle Cloud console, Navigation Menu](images/1-4-OKE.png " ")
   ![Oracle Cloud console, Navigation Menu](images/1-5-OKE.png " ")

5. Review the configuration, and click **Create cluster**.

   ![Oracle Cloud console, Navigation Menu](images/1-6-OKE.png " ")

6. Make sure all verification steps are cleared. Click **Close**.

   ![Oracle Cloud console, Navigation Menu](images/1-7-OKE.png " ")

7.  This will start to create a cluster, and takes 7 to 10 minutes to complete. While waiting for the creation of the cluster, you can proceed to the next lab to create an APM domain. In the lab 3, we will resume the steps to build the application.

   ![Oracle Cloud console, Navigation Menu](images/1-8-OKE.png " ")




You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - Yutaka Takatsu, Product Manager, Enterprise and Cloud Manageability
- **Contributors** - Steven Lemme, Senior Principal Product Manager,  
Avi Huber, Senior Director, Product Management
* **Last Updated By/Date** - Yutaka Takatsu, August 2022
