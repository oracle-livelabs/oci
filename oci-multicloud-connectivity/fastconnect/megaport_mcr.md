![Megaport Architecture](../oci-multicloud-connectivity/fastconnect/images/megaport_mcr/topology-megaport-mcr.png)

# Megaport (MCR) Deployment

## Introduction

Estimated Time: 30 minutes

### About FastConnect

FastConnect allows customers to connect directly external environments such as 3rd party cloud providers and on-premise data centers to their Oracle Cloud Infrastructure (OCI) virtual cloud network via dedicated, private, high-bandwidth connections. [Visit our documentation](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/Overview_of_VCNs_and_Subnets.htm) for more information on FastConnects.

### Objectives

In this lab, you will:

* Use the Megaport portal to build a private connection.
* Use the Oracle Cloud Console to create a FastConnect Connection to Megaport

### Prerequisites

This lab has the following prerequisites:

* Tasks from the previous labs are completed.
* Access to the Megaport portal.
* A 3rd party cloud provider with the following:
  * Properly connected and configured 3rd party cloud to the Megaport Cloud Router after completing Task 2 in this lab. [MCR documentation](https://docs.megaport.com/cloud/mcr/)
  * Non-overlapping Private IP space between clouds.
  * A virtual machine deployed in the private network with ICMP (Ping) and SSH accessibility.

> **Note:** This lab does not walk through the steps to connect additional cloud providers to Megaport. It is recommended to go through Megaport's [MCR documentation](https://docs.megaport.com/cloud/mcr/) for your additional cloud provider of choice and attach the cloud provider to MCR.

### Video Walkthrough

[Megaport Quickstart Video](youtube:G0CySk4mlqs:large)

## Task 1: Configure Oracle Cloud FastConnect

1. From the Navigation Menu, navigate to **Networking -> Customer Connectivity -> FastConnect**. Click on **Create FastConnect**.
  ![Create FastConnect](../oci-multicloud-connectivity/fastconnect/images/megaport_mcr/mp_fc_1.png)
2. Select **Create FastConnect**.
  ![Create FastConnect](../oci-multicloud-connectivity/fastconnect/images/megaport_mcr/mp_fc_2.png)
3. Make sure **FastConnect Partner** is selected, and the click on the **Partner** Dropdown menu. Select **Megaport: Service** and click **Next**.
  ![Select Megaport FastConnect partner](../oci-multicloud-connectivity/fastconnect/images/megaport_mcr/mp_fc_3.png)
4. Complete the following fields:

    |                  **Field**              |    **Value**  |
    |----------------------------------------|:------------:|
    |NAME |    Megaport_1   |
    |COMPARTMENT |  _Choose your lab compartment_    |
    |Virtual Circuit Type|    Private Virtual Circuit    |
    |Dynamic Routing Gateway|  DynamicRoutingGateway  |
    |Provisioned Bandwidth|    1 Gbps    |
    |Customer Primary BGP IPv4 Address|    169.254.0.2/30    |
    |Oracle Primary BGP IPv4 Address|    169.254.0.1/30    |
    |Customer BGP ASN|    133937    |

5. Verify your configuration matches the following, and then click **Create**.
  ![Verify configuration](../oci-multicloud-connectivity/fastconnect/images/megaport_mcr/mp_fc_4.png)

## Task 2: Add Oracle Cloud FastConnect to Megaport MCR

1. Under **Next Steps**, click **Complete connection**
  ![Complete Connection](../oci-multicloud-connectivity/fastconnect/images/megaport_mcr/mp_mcr_1.png)
2. Use your Megaport credentials to authenticate with Megaport within the Oracle Cloud console. Click **Login to Megaport**.
  ![Authenticate with Megaport](../oci-multicloud-connectivity/fastconnect/images/megaport_mcr/mp_mcr_2.png)
3. Under **Configure connection** and select **Megaport Cloud Router**. Your configuration should look similar to the example below.
  ![Megaport Cloud Router Selection](../oci-multicloud-connectivity/fastconnect/images/megaport_mcr/mp_mcr_3.png)
4. Under **Oracle virtual cross connect details** set a name, location and rate limit for the connection similar to the configuration below.
  ![Oracle VXC](../oci-multicloud-connectivity/fastconnect/images/megaport_mcr/mp_mcr_4.png)
5. Review the configuration, accept the agreement and then click **Complete connection**.
  ![Accept Agreement and continue](../oci-multicloud-connectivity/fastconnect/images/megaport_mcr/mp_mcr_5.png)
6. When the provisioning process is complete, the BGP state will be UP. **This process takes ~15 minutes.**
  ![Wait for BGP status UP](../oci-multicloud-connectivity/fastconnect/images/megaport_mcr/mp_mcr_6.png)

## Task 3: Establish Connectivity with Additional Cloud Providers

1. Navigate to <https://portal.megaport.com> and login.
  ![Navigate to Megaport](../oci-multicloud-connectivity/fastconnect/images/megaport_mcr/mp_portal_1.png)
2. Under **Services**, find the new Cloud Router that was provisioned in the previous task. Verify that the status of the CloudRouter and VXC to Oracle Cloud are in a healthy status as indicated by the green icons. Afterwards, click **Connection** to add an additional cloud provider to the CloudRouter.
  ![Verify health of the CloudRouter](../oci-multicloud-connectivity/fastconnect/images/megaport_mcr/mp_portal_2.png)
3. Under **Chose Destination Type** select **Cloud**.
  ![Add another cloud](../oci-multicloud-connectivity/fastconnect/images/megaport_mcr/mp_portal_3.png)
4. Under **Select Provider**, search for the additional cloud provider you would like to establish connectivity with. Follow the steps on the screen to set up the additional cloud provider. (The example below is looking to connect with Azure). It is also recommended to follow the steps in the [MCR documentation](https://docs.megaport.com/cloud/mcr/) to properly set up the other cloud provider.
  ![Select Provider](../oci-multicloud-connectivity/fastconnect/images/megaport_mcr/mp_portal_4.png).
5. Verify the 3rd party cloud is properly connected to the Megaport Cloud Router.
6. You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - Jake Bloom, Principal Solution Architect, OCI Networking
* **Last Updated By/Date** - Jake Bloom, August 2023