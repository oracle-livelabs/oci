# Provisioning Oracle Container Engine for Kubernetes (OKE) with Virtual Nodes

## Introduction

On this lab, you will provision the infrastructure needed to run the Oracle Managed Kubernetes Cluster, including the Virtual Nodes Pool.

Estimated Time: 5 minutes

### About OKE Virtual Nodes

Virtual nodes provide a serverless Kubernetes experience, enabling you to run containerized applications at scale without the operational overhead of managing, scaling, upgrading, and troubleshooting the node infrastructure. Virtual nodes provide granular pod-level elasticity and pay-per-use pricing. As a result, you can scale deployments without taking into consideration the cluster's capacity, simplifying the execution of scalable workloads such as high-traffic web applications and data-processing jobs. You create virtual nodes by creating virtual node pools in enhanced clusters.

Virtual nodes provide you with the flexibility to satisfy application requirements. You can control the Kubernetes pod placement based on an availability needs, selecting the Compute processor shape, CPU, and memory most suited for an application. Hypervisor-level isolation for pods enables you to run any type of application on virtual nodes, including untrusted workloads.

Container Engine for Kubernetes with virtual nodes delivers seamless upgrades of Kubernetes clusters. The Kubernetes software is upgraded and security patches are applied while respecting application availability requirements.

Virtual nodes enable you to optimize the cost of running Kubernetes workloads. You pay for the exact compute resources consumed by each Kubernetes pod instead of paying for whole servers that might have unused capacity.

### Objectives

In this lab, you will:

* Use the Quick Create workflow to provision an OKE cluster with Virtual Nodes
* Execute the pre-requisite steps (IAM Policies and Security Rules)
* Wait for the cluster to be ready
* Check for Security Rules

## Task 1: Create Kubernetes Cluster

1. From the OCI Services menu, click **Developer Services** > **Kubernetes Clusters (OKE)**.

  ![Click Kubernetes Clusters (OKE)](images/sample1.png)

1. Under **List Scope**, select the compartment in which you would like to create a cluster. Click **Create Cluster**.

  ![Click Create Cluster](images/sample1.png)

1. Choose **Quick Create** and click **Submit**.

  ![Submit](images/sample1.png)

1. Fill out the form.

    * Name: Provide a name (oke-cluster in this example)
    * Compartment: Choose your compartment
    * Kubernetes Version: Choose the most recent version (Minimum 1.25.4 for OKE Virtual Nodes)
    * Kubernetes API Endpoint: Public Endpoint
    * Node type: **Virtual**
    * Node count: 3
    * Pod shape: Pod.Standard.E4.Flex

  Click **Next**

  ![Quick Create form](images/sample1.png)

1. Click ![Create Cluster](images/sample2.png) button.

    **We now have a OKE cluster with 3 node Virtual node pool and Virtual Cloud Network with all the necessary resources and configuration needed**

    ![Create Cluster Summary](images/sample2.png)

## Task 2: Check that the OKE Cluster started the provisioning

1. From the OCI Services menu, click **Developer Services** > **Kubernetes Clusters (OKE)**.

  ![Click Kubernetes Clusters (OKE)](images/sample1.png)

  > **Note:** This is the same step as the previous task, you may already be on that page.

1. Check the status of the just created OKE Cluster.

  ![Click Kubernetes Clusters (OKE)](images/sample1.png)

1. Click the just created OKE Cluster.

  ![Click Kubernetes Clusters (OKE)](images/sample1.png)

## Learn More

* [Comparing Virtual Nodes with Managed Nodes](https://docs.oracle.com/en-us/iaas/Content/ContEng/Tasks/contengcomparingvirtualwithmanagednodes_topic.htm#contengusingvirtualormanagednodes_topic)
* [Required IAM Policies for Using Virtual Nodes](https://docs.oracle.com/en-us/iaas/Content/ContEng/Tasks/contengvirtualnodes-Required_IAM_Policies.htm)

## Acknowledgements

* **Author** - Adao Oliveira Junior, Solutions Architect
* **Contributors** -  Adao Oliveira Junior, Solutions Architect
* **Last Updated By/Date** - Adao Oliveira Junior, May 2023
