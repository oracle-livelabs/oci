# Prepare Setup

## Introduction

This lab will show you how to download the Oracle Resource Manager (ORM) stack zip file needed to set up the resources needed to run this workshop.

*Estimated Lab Time:* 5 minutes

### Objectives

* Download ORM stack
* Select a Compartment for the workshop

### Prerequisites

This lab assumes you have:

* An Oracle Cloud account

## Task 1: Download Oracle Resource Manager (ORM) stack zip file

1. Click on the link below to download the Resource Manager zip file you need to build your environment:

    * [gdk-oci-adb-ll-orm.zip](https://c4u04.objectstorage.us-ashburn-1.oci.customer-oci.com/p/EcTjWk2IuZPZeNnD_fYMcgUhdNDIDA6rt9gaFj_WZMiL7VvxPBNMY60837hu5hga/n/c4u04/b/livelabsfiles/o/oci-library/gdk-oci-adb-ll-orm.zip)

2. Save it in your downloads folder.

## Task 2: Select a Compartment for the Workshop

We recommend you use a single compartment for the workshop. We will refer to this as your workshop compartment. This is the compartment where you will provision all the resources - Oracle Resource Manager (ORM) Stack, Compute Instance, VCN/Subnet, Instance Principals, Policies, Autonomous Database, Vault - needed for the workshop.

1. From the Oracle Cloud Console navigation menu, go to **Identity & Security >> Identity >> Compartments**.
2. Go to your workshop compartment.
3. Make a note of the compartment name and OCID. You will need this information in subsequent labs.

## Task 3: Setup Compute

With the details from the above tasks, proceed to the **Environment Setup** lab > **Create Stack: Compute + Networking** task to set up your workshop environment using Oracle Resource Manager (ORM).

The ORM stack will provision a new self-contained/dedicated VCN along with a new compute instance with 4 OCPUs, 64 GB RAM and a Remote Desktop environment.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
