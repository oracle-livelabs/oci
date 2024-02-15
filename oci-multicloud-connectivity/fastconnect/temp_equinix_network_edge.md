![Deployment Diagram](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/topology-equinix-network-edge.png)

# Equinix (Network Edge) Deployment

## Introduction

Estimated Time: 30 minutes

### About FastConnect

FastConnect allows customers to connect directly external environments such as 3rd party cloud providers and on-premise data centers to their Oracle Cloud Infrastructure (OCI) virtual cloud network via dedicated, private, high-bandwidth connections. [Visit our documentation](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/Overview_of_VCNs_and_Subnets.htm) for more information on FastConnects.

### Objectives

In this lab, you will:

* Use the Equinix Fabric Console to deploy the required network resources to connect Oracle Cloud to Equinix.
* Use the Oracle Cloud Console to create a FastConnect to directly connect to Equinix Fabric.
* SSH to the VyOS Virtual Router establish connectivity between cloud providers.

### Prerequisites

This lab assumes you have:

* Tasks from the previous labs are completed.
* Access to the Equinix Fabric portal with permissions to create new connections and deploy a Network Edge.
* A [Public SSH RSA Key](https://deploy.equinix.com/developers/docs/metal/accounts/ssh-keys/) uploaded to the Equinix console. The SSH Keypair from the previous lab can be used.
* An [Access Control List Template](https://docs.equinix.com/en-us/MicroContent/Interconnection/NE/microcontent/NE-access-control-list/how-to-create-access-control-list.htm) allowing your public IP address and allows SSH (TCP port 22) in the Equinix Console.

### Video Walkthrough

[Equinix Network Edge Quickstart Video](youtube:2A5jZrqhK9I:large)

## Task 1: Deploy an Equinix Network Edge

1. Log into the Equinix portal. Navigate to **Network Edge** and click **Create Virtual Device**.
    ![Create Virtual Device](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/network-edge-1.png)
2. Under **Add New Edge Device**, scroll to the bottom of the page to find the **VyOS** virtual router. Click **Select and Continue**.
    ![Add New Edge Device](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/network-edge-2.png)
3. Under **Select Device Type**, select **Single Device** and click **Begin Creating Edge Devices**.
    ![Select Device Type](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/network-edge-3.png)
4. Under **Select Edge Device Location**, select **Ashburn**. Scroll down to **Select Billing Account** and verify the correct billing account is used. Afterwards, click **Next: Device Details**.
    ![Select Edge Location](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/network-edge-4.png)
5. Under **Device Details**, fill in a **Device Name** and **Host Name Prefix**. Afterwards, click **Next: Additional Services Details**.
    ![Device Details](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/network-edge-5.png)
6. Under **Add Users**, create a memorable username under **Username** and add your public SSH RSA key under **SSH RSA Public Keys**. Under **Access Control List Templates** select your existing template. Make sure that your public IP address is allowed on the Access Control Template, and that TCP port 22 is allowed. Click **Next: Review**.
    ![Add Users](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/network-edge-6.png)
7. Review the device configuration. Review and Access the Order Terms, and then click **Create Virtual Device**.
    ![Create Virtual Device](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/network-edge-7.png)
8. Under **See your device in your dashboard**, click **Go to the device**.
    ![Go To Device](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/network-edge-8.png)
9. Continue to the next task when the green indicator is on the VyOS Virtual Router.
    ![Wait for Provisioning to Finish](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/network-edge-9.png)

## Task 2: Create a FastConnect Connection

1. From the Oracle Cloud Console, go to the navigation menu and click on **Networking -> Customer Connectivity -> FastConnect**.
    ![Navigate to FastConnect](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/eq_fastconnect-1.png)
2. Under **FastConnect Connections**, verify you are in the correct compartment for this lab and click **Create FastConnect**.
    ![Create FastConnect](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/eq_fastconnect-2.png)
3. Under **Connection Type**, select **FastConnect Partner**. Under **Partner**, select **Equinix: Fabric**.
    ![Partner Equinix](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/eq_fastconnect-3.png)
4. Set the FastConnect Parameters as seen below.
    ![FastConnect Parameters](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/eq_fastconnect-4.png)
5. Copy the OCID of the Virtual Circuit and move to the next task.
    ![Virtual Circuit OCID](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/eq_fastconnect-5.png)

## Task 3: Create a Connection to the Equinix Network Edge

1. Go back to the Network Edge in the Equinix console. Under **Virtual Device Details -> Connections** the **Virtual Connections** list should be empty. Click **Create Connection** to establish a private connection from Oracle Cloud to VyOS. 
    ![Private Connection](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/connections-1.png)
2. Scroll down to **Oracle Cloud** and click **Select Service**. Scroll down again and click **Create Connection**.
    ![Select Service](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/connections-2.png)
    ![Create Connection](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/connections-3.png)
3. Select the parameters indicated below and move to the next step.
    ![Private Connection Parameters](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/connections-4.png)
4. Under **Connection Information -> Virtual Circuit Name** create a unique name for this connection to OCI. Under **Virtual Circuit OCID**, add the OCID of the Virtual Circuit you created in Task 2. 
    ![FastConnect OCID](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/connections-5.png)
5. Click **Submit Order** on the next page.
    ![Submit Order](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/connections-6.png)
6. Navigate to **See this Connection in your Inventory -> Go to My Inventory**!
    ![Go to My Inventory](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/connections-7.png)
7. Verify the connection has been added to the Equinix portal and then proceed to the next task.
    ![OCI Config Complete](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/connections-8.png)

## Task 4: Establish Connectivity with Additional Cloud Providers

1. An additional private connection will need to be made between your Network Edge and additional cloud provider that you choose. For most cloud providers, you will be able to click **Create Connection** and follow the steps within the Equinix portal to connect to your additional cloud provider. You can also follow the [Equinix Network Edge Documentation](https://docs.equinix.com/en-us/Content/Interconnection/NE/landing-pages/NE-landing-main.htm) for further guidance on this connectivity.

    The lab assumes you made the following setup on the additional cloud provider. See the **Azure Interconnect** section if you need an example how to do this configuration on the other cloud providers.

    * A BGP interface with the IP address of 169.254.1.1/30.
    * The BGP ASN number is 64512.
    * The private IP address space is 10.100.0.0/16
    * A virtual machine is deployed in the private IP space, and ICMP (ping) is allowed.
    * Proper routing is configured to get traffic from the virtual machine to the private connection service.

## Task 5: Configure VyOS Virtual Router (Network Edge)

1. Navigate to your Network Edge and verify there is a connection for OCI and for your additional cloud provider.
    ![Multiple Cloud Providers](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/vyos-setup-1.png)
2. Navigate to **Details**, and then scroll down to **IP Address** to get the public IP address of the network edge.
    ![Navigation - Details](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/vyos-setup-2.png)
    ![Public IP address](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/vyos-setup-3.png)
3. Navigate back to the Oracle Cloud console and go back to the Cloud Shell instance.
    ![CloudShell](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/cloudshell-1.png)
4. With the username created in Task 1 of the lab, ssh into the VyOS Network Edge. The command will look something like this. **ssh username@vyos\_public\_ip**. The SSH RSA keypair is used to authenticate the session, so no password will be needed to connect to the appliance.
    ![VyOS SSH](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/vyos-setup-4.png)
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

    ![VyOS Configuration](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/vyos-setup-5.png)
6. Run the command **show ip bgp sum** in the VyOS router. You can confirm the configuration is working if the **Up/Down** status of each neighbor has a timer indicating it's uptime, and **PrxRcd** has a number greater than zero.
    ![Verify Route Exchange](../oci-multicloud-connectivity/fastconnect/images/equinix_network_edge/vyos-setup-6.png)

7. If you've gone this far, congratulations! This is a major mile stone in this lab. Go ahead and proceed to the next lab.

## Acknowledgements

* **Author** - Jake Bloom, Principal Solution Architect, OCI Networking
* **Last Updated By/Date** - Jake Bloom, August 2023