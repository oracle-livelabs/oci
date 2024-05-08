![Deployment Diagram](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/topology-equinix-fcr.png)

# Equinix (Fabric Cloud Router) Deployment

## Introduction

Estimated Time: 30 minutes

### About FastConnect

FastConnect allows customers to connect directly external environments such as 3rd party cloud providers and on-premise data centers to their Oracle Cloud Infrastructure (OCI) virtual cloud network via dedicated, private, high-bandwidth connections. [Visit our documentation](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/Overview_of_VCNs_and_Subnets.htm) for more information on FastConnects.

### Objectives

In this lab, you will:

* Use the Equinix Fabric Console to deploy the required network resources to connect Oracle Cloud to Equinix.
* Use the Oracle Cloud Console to create a FastConnect to directly connect to Equinix Fabric.
* Configure the Equinix Fabric Cloud Router to establish connectivity between cloud providers.

### Prerequisites

This lab assumes you have:

* Tasks from the previous labs are completed.
* Access to the Equinix Fabric portal with permissions to create new connections and deploy a Fabric Cloud Router.

### Video Walkthrough

[Equinix Fabric Cloud Router Quickstart Video](youtube:2A5jZrqhK9I:large) @@UPDATE LINK

## Task 1: Deploy an Equinix Fabric Cloud Router

1. Log into the Equinix portal. Navigate to **Cloud Routers** under the **Fabric and Network Edge** menu, click **Create a Fabric Cloud Router**.
    ![Create Fabric Cloud Router](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/task1-step1-click-create-fabric-cloud-router.png)
2. Under **Select Location**, Select the Equinix data center location to deploy the Fabric Cloud Router. Under the **Billing Account** drop-down, pick the appropriate account. Click **Next: Fabric Cloud Router Details**.
    ![Select Location](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/task1-step2-select-fcr-location.png)
3. Under **Fabric Cloud Router Name**, enter in a name for your Fabric Cloud Router. Select the **Lab** package under **Select Package**. Click **Next: Review**
    ![Fabric Cloud Router Details](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/task1-step3-fcr-details.png)
4. Review **Fabric Cloud Router Details**, **Pricing Overview** and optionally setup email notifications under **Notifications**. Once finished scroll down and select **Submit Order**. **Note:** Copy the Autonomous System Number (ASN) provided. This will be added to the FastConnect Parameters in OCI.
    ![Review Fabric Cloud Router Details](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/task1-step4-fcr-review.png)

## Task 2: Create a FastConnect Connection

1. From the Oracle Cloud Console, go to the navigation menu and click on **Networking -> Customer Connectivity -> FastConnect**.
    ![Navigate to FastConnect](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/eq_fastconnect-1.png)
2. Under **FastConnect Connections**, verify you are in the correct compartment for this lab and click **Create FastConnect**.
    ![Create FastConnect](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/task2-step1-create-fc.png)
3. Under **Connection Type**, select **FastConnect Partner**. Under **Partner**, select **Equinix: Fabric**.
    ![Partner Equinix](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/task2-step2-fc-partner.png)
4. Set the FastConnect Parameters as seen below. **Note:** The Customer BGP ASN should be set the ASN provided by Equinix
    ![FastConnect Parameters](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/task2-step3-1-fc-config.png)
    ![FastConnect Parameters2](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/task2-step3-2-fc-config.png)
5. Copy the OCID of the Virtual Circuit and move to the next task.
    ![Virtual Circuit OCID](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/task2-step4-copy-fc-ocid.png)

## Task 3: Create a Connection to the Equinix Fabric Cloud Router

1. Go back to the **Fabric and Network Edge** menu in the Equinix console. Under **Connections** click **Create Connection** to establish a private connection from Oracle Cloud to the Fabric Cloud Router. 
    ![Private Connection](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/task3-step1-click-create-connection.png)
2. Scroll down to **Oracle Cloud** and click **Select Service**. Scroll down again and click **Quick Connect**.
    ![Select Service](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/task3-step2-select-oci-service.png)
    ![Quick COnnect](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/task3-step3-oci-quick-connect.png)
3. Under **Oracle Configuration -> Redundancy** select **Single Connection**. Enter in the Virtual Circuit Oracle Cloud ID (OCID) copied from the OCI console. Select the OCI Region location for the FastConnect in the **Oracle Destination** drop-down, then click **Next**.
    ![Oracle Configuration](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/task3-step4-oci-configuration.png)
4. Under **Equinix Information -> Origin Asset Type** select Cloud Router. In the **Cloud Router** drop-down select the Fabric Cloud Router created in Task 1. Select Primary for the **Connection**, add a description of the connection under the **Connection Name** section. Click **Next**. 
    ![Equinix Information](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/task3-step5-equinix-configuration.png)
5. In the **Contact Information** section, enter in any necessary email notification receipients, Purchase Order Number, or Purchase Reference IDs. Click **Create Connection** once finished.
    ![Submit Order](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/task3-step6-contact-information.png)
6. Select **View this Connection in your Fabric Inventory** and then proceed to the next task.
    ![Go to My Inventory](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/task3-step7-connection-submitted.png)

## Task 4: Configure Routing Details

1. In the **Connections -> Routing Details** section select **Configure Routing**.
    ![Configure Routing](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/task4-step1-fcr-configure-routing.png)
2. Under **Configure Routing Details**, Set the FastConnect Parameters as seen below. Once finished click **Apply Changes**. You will then be redirected back to the **Routing Details** page.
    ![Configure Routing Details](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/task4-step2-fcr-configure-routing-details.png)
3.  **Configure Routing Details**, After a few minutes, confirm that both the **Direct Status** and **BGP Status** displays a green **Provisioned** status.
    ![Configure Routing Details](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/task4-step3-fcr-routing-details.png)

## Task 5: Verify Active Routes on the Fabric Cloud Router

1. Navigate to **Cloud Routers** under the **Fabric and Network Edge** menu, click **Fabric Cloud Router Inventory**.
    ![Fabric Router Inventory](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/task5-step1-fcr-inventory.pngg)
2. Under the **Fabric Cloud Router Name** section find and click the Fabric Cloud Router created for this lab.
    ![Fabric Cloud Router Name](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/task5-step2-click-fcr-name.png)
3. Select the **Active Routes** menu and then click the **Load Active Routes** button.
    ![Load Active Routes](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/task5-step3-fcr-click-active-routes.png)
4. Scroll down to the **Active Routes** section and confirm that you're receiving expected network routes from both cloud providers. The **Next Hop** and the **Connection Name** should match up with the appropriate cloud provider.
    ![Active Routes](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/task5-step4-fcr-active-routes.png)

5. If you've gone this far, congratulations! This is a major mile stone in this lab. Go ahead and proceed to the next lab.

## Acknowledgements

* **Author** - Shawn Moore, Principal Solution Architect, OCI Networking
* **Last Updated By/Date** - Shawn Moore, May 2024