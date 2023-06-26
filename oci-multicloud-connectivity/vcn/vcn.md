# Deploy a Virtual Cloud Network

## Introduction

In this lab you will build a Virtual Cloud Network (VCN) to create a private network for workload connectivity using the VCN Wizard.

Estimated Time: 10 minutes

VCN QuickStart: [Quickstart Video](youtube:svGxVEifOe0:large)

### About Virtual Cloud Networks (VCNs)
Oracle Cloud Infrastructure (OCI) Virtual Cloud Networks (VCNs) provide customizable and private cloud networks in Oracle Cloud Infrastructure (OCI). Just like a traditional data center network, the VCN provides customers with complete control over their cloud networking environment. This includes assigning private IP address spaces, creating subnets and route tables, and configuring stateful firewalls. 

### Objectives

In this lab, you will:

* Setup a VCN using the VCN Wizard

### Prerequisites

This lab assumes you have:

* A paid Oracle Cloud account
* Access to a connectivity provider such as Equinix or Megaport OR a region that supports the OCI Azure Interconnect.

## Task 1: VCN Wizard

1. On the Oracle Cloud Infrastructure Console Home page, under the Quick Actions header, click on Set up a network with a wizard.

  ![Quick Actions Wizard](images/setupVCN1.png)

	> **Note:** Use this format for notes, hints, and tips. Only use one "Note" at a time in a step.

2. Select **VCN with Internet Connectivity**, and then click **Start VCN Wizard**.

  ![VCN with Internet Connectivity](images/setupVCN2.png)

3. Complete the following fields:

       |                  **Field**              |    **Vaue**  |
    |----------------------------------------|:------------:|
    |VCN NAME |OCI_HOL_VCN|
    |COMPARTMENT |  Choose the ***Demo*** compartment you created in the [Identity Lab](../Identity_Access_Management/IAM_HOL.md)
    |VCN CIDR BLOCK|10.0.0.0/16|
    |PUBLIC SUNBET CIDR BLOCK|10.0.2.0/24|
    |PRIVATE SUBNET CIDR BLOCK|10.0.1.0/24
    |USE DNS HOSTNAMES IN THIS VCN| Checked|

  Your configuration should look similar to the following:
  ![Create a VCN Configuration](images/setupVCN3.png)

4. Press the **Next** button at the bottom of the screen.
    ![Review CV Configuration](images/setupVCN4.png)

5. Review your settings to be sure they are correct.
    ![Workflow](images/workflow.png)

  
6. Press the **Create** button to create the VCN. I will take a moment to create the VCN and a progress screen will keep you apprised of the workflow.

7. Once you see that the creation is complete (see previous screenshot), click on the **View Virtual Cloud Network** button and verify that the VCN is in a "Provisioned" state.