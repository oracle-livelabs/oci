# Setup the Environment

## Introduction

On this lab, you will create the required IAM Policies for Using Virtual Nodes, Update Network Security Lists and wait for full provisioning of the OKE cluster and the Virtual Node Pool.

Estimated Lab Time: 25 minutes

### Objectives

In this lab, you will:

* Enter the IAM polices required for the service OKE Virtual Nodes
* Navigate to the Virtual Cloud Network(VCN) and update the LoadBalancer Security list
* Configure the Kubernetes Cluster access on the OCI Cloud Shell
* Wait for the provisioning of the OKE cluster and the Virtual Node Pool

### Prerequisites

This lab assumes you have:

* Admin Access to the Tenancy or rights to create policies on the root compartment

> **Note:** If you do not have necessary rights, you need to have that steps previously setup by the tenancy admin, or the demo application may not deploy correctly

## Task 1: Enter the Required IAM Policies for Using Virtual Nodes

To create and use clusters with virtual nodes and virtual node pools, you must endorse the Container Engine for Kubernetes service to allow virtual nodes to create container instances in the Container Engine for Kubernetes service tenancy with a VNIC connected to a subnet of a VCN in your tenancy.

1. From the OCI Services menu, click **Identity & Security** > **Policies**.

  ![Click Policies](images/sample1.png)

1. Under **List Scope**, select the (root) compartment. Click ![Create Policy](images/sample2.png) button.

  ![Click Policy](images/sample1.png)

1. Fill out the form.

    * Name: Provide a name (oke-virtual-node-policy in this example)
    * Description: Policies for the OKE Virtual Nodes Service
    * Compartment: Choose the (root) compartment
    * On the Policy Builder, switch to **Show manual editor**

  Click **Next**

  ![Create Policy form](images/sample1.png)

1. On the **Policy Builder** box, enter the exactly policies as shown below:

    ```text
    define tenancy ske as ocid1.tenancy.oc1..aaaaaaaacrvwsphodcje6wfbc3xsixhzcan5zihki6bvc7xkwqds4tqhzbaq

    define compartment ske_compartment as ocid1.compartment.oc1..aaaaaaaa2bou6r766wmrh5zt3vhu2rwdya7ahn4dfdtwzowb662cmtdc5fea

    endorse any-user to associate compute-container-instances in compartment ske_compartment of tenancy ske with subnets in tenancy where ALL {request.principal.type='virtualnode',request.operation='CreateContainerInstance',request.principal.subnet=2.subnet.id}

    endorse any-user to associate compute-container-instances in compartment ske_compartment of tenancy ske with vnics in tenancy where ALL {request.principal.type='virtualnode',request.operation='CreateContainerInstance',request.principal.subnet=2.subnet.id}

    endorse any-user to associate compute-container-instances in compartment ske_compartment of tenancy ske with network-security-group in tenancy where ALL {request.principal.type='virtualnode',request.operation='CreateContainerInstance'}
    ```

  > **Note:** Do not change any of the OCIDs, copy as is

  ![Policy Builder](images/sample1.png)

## Task 2: Update Network Security List for LoadBalancer

1. From the OCI Services menu, click **Networking** > **Virtual cloud networks**.

  ![Click Policies](images/sample1.png)

1. Under **List Scope**, select the same compartment used to create a cluster. Click on the vcn created for the OKE Cluster

  ![VCN List](images/sample1.png)

1. Click on the Security Lists and select the **oke-svclbseclist-quick-xxxx-yyyy**.

  ![Sec List](images/sample1.png)

1. Click on the Egress Rules and click **Add Egress Rules** button.

  ![Egress Rules](images/sample1.png)

1. Enter the **Egress Rule 1**.

    * Destination Type: CIDR
    * Destination CIDR:
    * IP Protocol: TCP
    * Source Port Range:
    * Destination Port Range:
    * Description:

    Click **Add Egress Rules** button

  ![Add Egress Rules](images/sample1.png)

1. Your Egress Rules should looks like this:

  ![Egress Rules Completed](images/sample1.png)

## Task 3: Configure the Kubernetes Cluster access on the OCI Cloud Shell

1. On OCI Console, Top-Right, click the ![Cloud Shell Icon](images/sample1.png) icon and select **Cloud Shell**.

  ![Cloud Shell Access](images/sample1.png)

## Task 4: Check OKE Cluster and Virtual Node pool completion

1. From the OCI Services menu, click **Developer Services** > **Kubernetes Clusters (OKE)**.

  ![Click Kubernetes Clusters (OKE)](images/sample1.png)

  > **Note:** This is the same step as the previous task, you may already be on that page.

1. Check the status of the just created OKE Cluster.

  ![Click Kubernetes Clusters (OKE)](images/sample1.png)

1. Click the just created OKE Cluster.

  ![Click Kubernetes Clusters (OKE)](images/sample1.png)

## Learn More

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements

* **Author** - Adao Oliveira Junior, Solutions Architect
* **Contributors** -  Adao Oliveira Junior, Solutions Architect
* **Last Updated By/Date** - Adao Oliveira Junior, May 2023
