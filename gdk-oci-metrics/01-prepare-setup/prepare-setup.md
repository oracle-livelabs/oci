# Prepare Setup

## Introduction

This lab will show you how to download the Oracle Resource Manager (ORM) stack zip file needed to set up the resources needed to run this workshop.

*Estimated Lab Time:* 5 minutes

### Objectives

* Download ORM stack
* (*Optional*) Configure an existing Virtual Cloud Network (VCN)
* Select a Compartment for the workshop

### Prerequisites

This lab assumes you have:

* An Oracle Cloud account

## Task 1: Download Oracle Resource Manager (ORM) stack zip file

1. Click on the link below to download the Resource Manager zip file you need to build your environment:

    * [gdk-oci-metrics-ll-orm.zip](https://c4u04.objectstorage.us-ashburn-1.oci.customer-oci.com/p/EcTjWk2IuZPZeNnD_fYMcgUhdNDIDA6rt9gaFj_WZMiL7VvxPBNMY60837hu5hga/n/c4u04/b/livelabsfiles/o/oci-library/gdk-oci-metrics-ll-orm.zip)

2. Save it in your downloads folder.

3. (*Recommended*) We strongly recommend using this stack to create a new self-contained/dedicated VCN along with your instance. Skip to **Task 3** to follow the recommendation.

4. Alternatively, if you would rather use an existing VCN then proceed to the next task to update your existing VCN with the required network security rules.

## Task 2: Add Network Security Rules to an Existing VCN

This workshop requires a certain number of ports to be available, a requirement that is automatically met by using the default ORM stack execution that creates a new dedicated VCN.

However, if you would rather use an existing VCN/subnet, follow these steps to add the following rules to the network security list.

1. From the Oracle Cloud Console navigation menu, go to **Networking >> Virtual Cloud Networks**.
2. Choose your network.
3. Under **Resources**, select **Security Lists**.
4. Click on **Default Security Lists** under the **Create Security List** button.
5. Click **Add Ingress Rules** button.
6. Create a rule for each row in the *Ingress* table below:

    | Stateless      | Source Type | Source CIDR | IP Protocol | Source Port Range | Destination Port Range | Description                |
    | :------------- | :---------: | :---------: | :---------: | :---------------: | :--------------------: | :------------------------- |
    | No (unchecked) |    CIDR     |  0.0.0.0/0  |     TCP     |        All        |           80           | Remote Desktop using noVNC |
    | No (unchecked) |    CIDR     |  0.0.0.0/0  |     TCP     |        All        |          6080          | Remote Desktop using noVNC |
    {: title="Network Ingress Security Rules"}

7. Select **Egress Rule** from the left panel.
8. Click **Add Egress Rule** button
9. Create a rule for each row in the *Egress* table below:

    | Stateless      | Source Type | Destination CIDR | IP Protocol | Source Port Range | Destination Port Range | Description           |
    | :------------- | :---------: | :--------------: | :---------: | :---------------: | :--------------------: | :-------------------- |
    | No (unchecked) |    CIDR     |    0.0.0.0/0     |     TCP     |        All        |           80           | Outbound HTTP access  |
    | No (unchecked) |    CIDR     |    0.0.0.0/0     |     TCP     |        All        |          443           | Outbound HTTPS access |
    {: title="Network Egress Security Rules"}

## Task 3: Select a Compartment for the Workshop

We recommend you use a single compartment for the workshop. We will refer to this as your workshop compartment. This is the compartment where you will provision all the resources - Oracle Resource Manager (ORM) Stack, Compute Instance, VCN/Subnet - needed for the workshop.

1. From the Oracle Cloud Console navigation menu, go to **Identity & Security >> Identity >> Compartments**.
2. Go to your workshop compartment.
3. Make a note of the compartment name and OCID. You will need this information in subsequent labs.

## Task 4: Setup Compute

Using the details from the above Tasks, proceed to the **Environment Setup** lab to set up your workshop environment using Oracle Resource Manager (ORM) with one of the following options:

* (*Recommended*) Create Stack: **Compute + Networking**
* Create Stack: **Compute only** with an existing VCN where security lists have been updated as per **Task 2** above

The ORM stack will provision a compute instance with 4 OCPUs, 64 GB RAM and a Remote Desktop environment.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
