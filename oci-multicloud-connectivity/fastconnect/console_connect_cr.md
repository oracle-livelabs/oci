![Deployment Diagram](../oci-multicloud-connectivity/fastconnect/images/console_connect_cr/topology_consoleconnect.png)

# Console Connect Cloud Router Deployment

## Introduction

Estimated Time: 30 minutes

### About FastConnect

FastConnect allows customers to connect directly external environments such as 3rd party cloud providers and on-premise data centers to their Oracle Cloud Infrastructure (OCI) virtual cloud network via dedicated, private, high-bandwidth connections. [Visit our documentation](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/Overview_of_VCNs_and_Subnets.htm) for more information on FastConnects.

### Objectives

In this lab, you will:

* Use the Console Connect Cloud Router to route private traffic from Oracle Cloud Infrastructure through Console Connect.
* Use the Oracle Cloud Console to create a FastConnect.

### Prerequisites

This lab assumes you have:

* Tasks from the previous labs are completed.
* Access to the Console Connect portal with access to a Cloud Router and the ability to add a site.

### Video Walkthrough

[Console Connect Cloud Router Quickstart Video](youtube:S-V76CbJxWU:large)

## Task 1: Configure an OCI FastConnect

1. Under the navigation menu, click **Networking**. Navigate to Customer connectivity and then click on **FastConnect**.
   ![Navigate To Networking](../oci-multicloud-connectivity/fastconnect/images/console_connect_cr/cc-fastconnect-1.png)
2. Click **Create FastConnect**.
   ![Create FastConnect](../oci-multicloud-connectivity/fastconnect/images/console_connect_cr/cc-fastconnect-2.png)
3. Under **Partner** search for **PCCW: Console Connect by PCCWG_L3**.
   ![Select FastConnect Partner](../oci-multicloud-connectivity/fastconnect/images/console_connect_cr/cc-fastconnect-3.png)
4. Under the configuration options of the FastConnect, fill in the required parameters as shown in the screenshot. Click **Create**.
   ![Add FastConnect Details](../oci-multicloud-connectivity/fastconnect/images/console_connect_cr/cc-fastconnect-4.png)
5. Copy the OCID from the new FastConnect and proceed to the next step.
   ![Copy OCID from Created FastConnect](../oci-multicloud-connectivity/fastconnect/images/console_connect_cr/cc-fastconnect-5.png)

## Task 2: Create a Console Connect Cloud Router

1. Log in to the Console Connect interface and select **Network**.
   ![Select Network](../oci-multicloud-connectivity/fastconnect/images/console_connect_cr/cc-cloud-router-1.png)
2. Navigate to the Cloud Router icon and select **Add new**.
   ![Add new Cloud Router](../oci-multicloud-connectivity/fastconnect/images/console_connect_cr/cc-cloud-router-2.png)
3. Set the required parameters and then select **Next: Review**.
   ![Configure Cloud Router](../oci-multicloud-connectivity/fastconnect/images/console_connect_cr/cc-cloud-router-3.png)
4. Review the Cloud Router configuration and then select **Next: Payment**.
   ![Verify Configuration](../oci-multicloud-connectivity/fastconnect/images/console_connect_cr/cc-cloud-router-4.png)
5. Agree to the terms and then select **Create CloudRouter**.
   ![Term Agreement](../oci-multicloud-connectivity/fastconnect/images/console_connect_cr/cc-cloud-router-5.png)

## Task 3: Add a new Console Connect Site

1. Within the Cloud Router, add a new site by clicking **Add new site**.
   ![Add New Site](../oci-multicloud-connectivity/fastconnect/images/console_connect_cr/cc-site-1.png)
2. Under **Site Type**, select **Cloud or XaaS**.
   ![Site Type Cloud](../oci-multicloud-connectivity/fastconnect/images/console_connect_cr/cc-site-2.png)
3. Under **Choose your provider**, select **Oracle Cloud**.
   ![Provider Oracle Cloud](../oci-multicloud-connectivity/fastconnect/images/console_connect_cr/cc-site-3.png)
4. Add the FastConnect OCID from the OCI console into the **Oracle Cloud Account ID**. Select the port location for your OCI region.
   ![Add FastConnect OCID and Location](../oci-multicloud-connectivity/fastconnect/images/console_connect_cr/cc-site-4.png)
5. Fill in the details for the service and then click **Next: Review**.
   ![Configure Site](../oci-multicloud-connectivity/fastconnect/images/console_connect_cr/cc-site-5.png)
6. Review the items and then select **Next: Terms**.
   ![Review terms](../oci-multicloud-connectivity/fastconnect/images/console_connect_cr/cc-site-6.png)
7. Accept the terms and then click **Create site**.
   ![Accept terms](../oci-multicloud-connectivity/fastconnect/images/console_connect_cr/cc-site-7.png)
8. The site will be in a **Provisioning** status.
   ![Provisioning status](../oci-multicloud-connectivity/fastconnect/images/console_connect_cr/cc-site-8.png)
9. Once the site is in an **Active** status, proceed to the next step.
    ![Active status](../oci-multicloud-connectivity/fastconnect/images/console_connect_cr/cc-site-9.png)
10. Navigate back to the Oracle Cloud console and verify that the FastConnect is now in a **Provisioned** lifecycle state and the IPv4 BGP State is **Up**.
    ![FastConnect Healthy Status](../oci-multicloud-connectivity/fastconnect/images/console_connect_cr/cc-site-10.png)

## Task 4: Add Additional Sites

1. Navigate back to the Console Connect console and select the Cloud Router.
    ![Navigate to CC Cloud Router](../oci-multicloud-connectivity/fastconnect/images/console_connect_cr/cc-site-11.png)
2. Select **Add new site**.
    ![Add New Site](../oci-multicloud-connectivity/fastconnect/images/console_connect_cr/cc-site-12.png)
3. Create an additional site that you would like to interconnect with OCI.
    ![Create Additional Connection](../oci-multicloud-connectivity/fastconnect/images/console_connect_cr/cc-site-13.png)

## Acknowledgements

* **Author** - Jake Bloom, Principal Solution Architect, OCI Networking
* **Last Updated By/Date** - Jake Bloom, July 2024
