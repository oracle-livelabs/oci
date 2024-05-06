![Deployment Diagram](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/topology-equinix-fcr.png) @@UPDATE LINK

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

1. An additional private connection will need to be made between your Fabric Cloud Router and additional cloud provider that you choose. For most cloud providers, you will be able to click **Create Connection** and follow the steps within the Equinix portal to connect to your additional cloud provider. You can also follow the [Equinix Network Edge Documentation](https://docs.equinix.com/en-us/Content/Interconnection/NE/landing-pages/NE-landing-main.htm) for further guidance on this connectivity.

    The lab assumes you made the following setup on the additional cloud provider. See the **Azure Interconnect** section if you need an example how to do this configuration on the other cloud providers.

    * A BGP interface with the IP address of 169.254.1.1/30.
    * The BGP ASN number is 64512.
    * The private IP address space is 10.100.0.0/16
    * A virtual machine is deployed in the private IP space, and ICMP (ping) is allowed.
    * Proper routing is configured to get traffic from the virtual machine to the private connection service.

## Task 5: Confirm BGP Routes are Received and Advertised from both Cloud Providers

1. Navigate to your Network Edge and verify there is a connection for OCI and for your additional cloud provider.
    ![Multiple Cloud Providers](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/vyos-setup-1.png)
2. Navigate to **Details**, and then scroll down to **IP Address** to get the public IP address of the network edge.
    ![Navigation - Details](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/vyos-setup-2.png)
    ![Public IP address](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/vyos-setup-3.png)
3. Navigate back to the Oracle Cloud console and go back to the Cloud Shell instance.
    ![CloudShell](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/cloudshell-1.png)
4. With the username created in Task 1 of the lab, ssh into the VyOS Network Edge. The command will look something like this. **ssh username@vyos\_public\_ip**. The SSH RSA keypair is used to authenticate the session, so no password will be needed to connect to the appliance.
    ![VyOS SSH](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/vyos-setup-4.png)
5. Copy the configuration below to your clipboard, and paste in into the SSH session. This will start the BGP process on the VyOS router and setup connections from the Network Edge to the cloud providers. This configuration assumes the additional cloud provider's AS is 64512 and the remote IP address is 169.254.1.1.
        ```text
        <copy>
        config
        set interfaces ethernet eth2 address 169.254.0.2/30
        set protocols bgp 65001 address-family ipv4-unicast
        set protocols bgp 65001 neighbor 169.254.0.1 address-family ipv4-unicast
        set protocols bgp 65001 neighbor 169.254.0.1 remote-as 31898
        set interfaces ethernet eth3 address 169.254.1.2/30
        set protocols bgp 65001 neighbor 169.254.1.1 address-family ipv4-unicast
        set protocols bgp 65001 neighbor 169.254.1.1 remote-as 64512
        commit;save;exit
        </copy>
        ```

    > **Note:** If your BGP connection requires a password, add this to the BGP neighbor configuration. **set protocols bgp 65001 neighbor 169.254.1.1 password 'passwordgoeshere'**

    ![VyOS Configuration](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/vyos-setup-5.png)
6. Run the command **show ip bgp sum** in the VyOS router. You can confirm the configuration is working if the **Up/Down** status of each neighbor has a timer indicating it's uptime, and **PrxRcd** has a number greater than zero.
    ![Verify Route Exchange](../oci-multicloud-connectivity/fastconnect/images/equinix_fcr/vyos-setup-6.png)

7. If you've gone this far, congratulations! This is a major mile stone in this lab. Go ahead and proceed to the next lab.

## Acknowledgements

* **Author** - Shawn Moore, Principal Solution Architect, OCI Networking
* **Last Updated By/Date** - Shawn Moore, May 2024