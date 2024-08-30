![Deployment Diagram](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/topology_gcp_interconnect.png)

# Oracle Interconnect for Google Cloud

## Introduction

Estimated Time: 30 minutes

### About FastConnect

FastConnect allows customers to connect directly external environments such as 3rd party cloud providers and on-premise data centers to their Oracle Cloud Infrastructure (OCI) virtual cloud network via dedicated, private, high-bandwidth connections. [Visit our documentation](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/Overview_of_VCNs_and_Subnets.htm) for more information on FastConnects.

### Objectives

In this lab, you will:

* Use the Google Cloud Console to deploy the required network resources to connect to Oracle Cloud.
* Use the Oracle Cloud Console to create a FastConnect to directly connect to Google Cloud.
* Verify routes are exchanged between GCP and OCI.

### Prerequisites

This lab assumes you have:

* Tasks from the previous labs are completed.
* Google Cloud Console with the ability to create a private connection and a virtual machine for testing.

### Video Walkthrough

[GCP Interconnect Quickstart Video](youtube:jKnB3nMlyr8:large)

## Task 1: Create a GCP Project

1. Select the **Projects** drop down menu in GCP.
   ![Projects Dropdown](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/gcp-project-1.png)
2. Create a new project.
   ![Create new project](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/gcp-project-2.png)
3. Select a memorable name for the project and click **Create**.
   ![Create project](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/gcp-project-3.png)
4. When the project is finished being created, click **Select Project** in the notifications menu.
   ![Select new project](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/gcp-project-4.png)

## Task 2: Create a GCP Virtual Machine

1. On the GCP home page, select **Create a VM**.
   ![Create a VM](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/gcp-vm-1.png)
2. If the Compute Engine API is not enabled, go ahead an enable it now. Otherwise you can skip this step.
   ![Enable compute API](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/gcp-vm-2.png)
3. Select **Create an instance**.
   ![Create an instance](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/gcp-vm-3.png)
4. Give the instance a **Name** and select the region you want to deploy the VM to.
   ![Set VM Parameters](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/gcp-vm-4.png)
5. If you intend to log into this machine, add your public SSH key under the security menu titled **Add manually generated SSH keys**.
   ![Set VM Parameters](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/gcp-vm-5.png)
6. Click **Create**.
   ![Create VM](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/gcp-vm-6.png)

## Task 3: Create a GCP Interconnect

1. Search for **Cloud Routers** in the GCP search bar.
   ![Cloud Router](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/gcp-interconnect-1.png)
2. Select **Interconnect** in the Network Connectivity menu.
   ![Interconnect](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/gcp-interconnect-2.png)
3. Select **Create a VLAN Attachment**.
   ![VLAN Attachment](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/gcp-interconnect-3.png)
4. Select **Partner Interconnect connection**.
   ![Partner Interconnect connection](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/gcp-interconnect-4.png)
5. Select **I Already Have A Service Provider**.
   ![Already have a service provider](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/gcp-interconnect-5.png)
6. Select **Create a single VLAN (no redundancy)**.
   ![Create a single VLAN](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/gcp-interconnect-6.png)
7. The connection will not be redundant for this lab build out. Click **Continue** to accept the SLA agreement for single circuit deployments.
   ![Accept SLA agreement](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/gcp-interconnect-7.png)
8. Under the **Cloud Router** drop down menu, select **Create A Cloud Router**.
   ![Create A Cloud Router](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/gcp-cr-1.png)
9. Give the router a name and use the default parameters. Select **Create**.
    ![Create A Cloud Router](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/gcp-cr-2.png)
10. Select the VPC name **default** and the region you would like to connect.
   ![Default VPC](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/gcp-interconnect-8.png)
11. Select the Cloud Router that was created under the **Cloud Router** drop down menu. Provide a **VLAN attachment name**. Set the **Maximum Transmission unit** to 1500 MTU. Click **Create**.
    ![MTU 1500](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/gcp-interconnect-9.png)
12. Copy the **Pairing key** to pair the OCI FastConnect with the GCP Interconnect.
    ![Copy Pairing Key](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/gcp-interconnect-10.png)
13. Select **Enable** to pre-activate the VLAN attachments.
    ![Pre-activate VLAN attachment](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/gcp-interconnect-11.png)
14. Select **OK** to move to the next step.
    ![Move to Next Step](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/gcp-interconnect-12.png)

## Task 4: Create an Oracle Cloud FastConnect

1. Within the OCI Console, move to the Navigation Menu.
   ![OCI Nav Menu](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/fc-1.png)
2. Select **Networking**.
   ![Select Networking](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/fc-2.png)
3. Under **Customer Connectivity** select **FastConnect**.
   ![Select FastConnect](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/fc-3.png)
4. Select **Create FastConnect**.
   ![Create FastConnect](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/fc-4.png)
5. Under the **Partner** dropdown, select **Google Cloud: OCI Interconnect**.
   ![GCP Interconnect](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/fc-5.png)
6. Give a **Name** to the connection. Select the Dynamic Routing Gateway. Select the **Provisioned bandwidth** for the connection. Paste the Pairing Key from the GCP Interconnect into **Partner Service Key**. Select **Create**.
   ![Interconnect Parameters](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/fc-6.png)

## Task 5: Modify Google Cloud BGP Parameters

1. Navigate back to the GCP console. Click on the name of the **GCP Interconnect**.
   ![GCP Interconnect](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/gcp-bgp-1.png)
2. Select **Edit BGP Session**.
   ![BGP Session](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/gcp-bgp-2.png)
3. Verify the Peer ASN is **31898** and change it if it is not already. Click **Save and Continue**.
   ![Verify Parameters](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/gcp-bgp-3.png)
4. Verify the **Status** is **Up**.
   ![Verify UP Status](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/gcp-bgp-4.png)

## Task 6: Verify Deployment

1. Move to the navigation menu within the OCI Console.
   ![OCI Navigation Menu](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/oci-verify-1.png)
2. Select **Networking**.
   ![Networking](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/oci-verify-2.png)
3. Under **Customer Connectivity**, select **Dynamic Routing Gateway**.
   ![Dynamic Routing Gateway](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/oci-verify-3.png)
4. Select the Dynamic Routing Gateway.
   ![Dynamic Routing Gateway](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/oci-verify-4.png)
5. Navigate to **DRG route tables** and select **Autogenerated Drg Route Table for VCN attachments**.
   ![Autogenerated DRG Route Table](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/oci-verify-5.png)
6. Select **Get all route rules**.
   ![Get All Routes](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/oci-verify-6.png)
7. Verify the GPC VPC CIDR Prefix is seen by the DRG route table.
   ![Verify GCP CIDRs](../oci-multicloud-connectivity/fastconnect/images/gcp_interconnect/oci-verify-7.png)

## Acknowledgements

* **Author** - Jake Bloom, Principal Solution Architect, OCI Networking
* **Last Updated By/Date** - Jake Bloom, Jul 2024
