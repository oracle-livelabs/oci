![Deployment Diagram](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/topology-interconnect.png)

# Azure Interconnect Deployment

## Introduction

Estimated Time: 30 minutes

### About FastConnect

FastConnect allows customers to connect directly external environments such as 3rd party cloud providers and on-premise data centers to their Oracle Cloud Infrastructure (OCI) virtual cloud network via dedicated, private, high-bandwidth connections. [Visit our documentation](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/Overview_of_VCNs_and_Subnets.htm) for more information on FastConnects.

### Objectives

In this lab, you will:

* Use the Microsoft Azure Console to deploy the required network resources for the Azure Interconnect.
* Use the Microsoft Azure Console to deploy a virtual machine to test and verify connectivity with Oracle Cloud.
* Use the Oracle Cloud Console to create a FastConnect and connect directly to Azure ExpressRoute.

### Prerequisites

This lab assumes you have:

* Tasks from the previous labs are completed.
* Administrative Azure Cloud access to provision networking and compute resources.
* The OCI and Azure region you are connecting are [supported Azure InterConnect regions](https://learn.microsoft.com/en-us/azure/virtual-machines/workloads/oracle/oracle-oci-overview#region-availability).

### Video Walkthrough

[Azure Quickstart Video](youtube:97dyUveTasQ:large)

## Task 1: Deploy an Azure VNet and Virtual Network Gateway

1. Log into the Azure portal and click **Create Resource**.
    ![Create resource](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/vnet-gw-1.png)
2. Under the Create Resource menu, navigate to **Networking -> Virtual Network Gateway** and click **Create**.
    ![Create resource](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/vnet-gw-2.png)
3. For the new Virtual Network Gateway, give it a **Name**. Set the Gateway Type to **ExpressRoute**. Under **Virtual Network** select **Create Virtual Network**. Complete the following fields.

    |                  **Field**              |    **Value**  |
    |----------------------------------------|:------------:|
    |Name |    Azure_VNET    |
    |Resource Group |  _ChooseExistingORCreateANewOne_    |
    |Address Range|    10.100.0.0/16    |
    |Subnet Name|  azure_subnet  |
    |Address Range|  10.100.0.0/24  |

    Verify the configuration, and then select **OK**.
    ![Verify Configuration](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/vnet-gw-3.png)
4. Select **Create New**. Give the public IP address a **Name** and select the **SKU**. Then select **Review + create**.
    ![Public IP](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/vnet-gw-4.png)
5. Verify the configuration, and then click **Create**.
    ![Verify Config](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/vnet-gw-5.png)
6. When your deployment says **Your deployment is complete**, move to the next task. **The Azure Virtual Network Gateway can take anywhere from 15-45 minutes to deploy.**
    ![Verify Deployment Complete](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/vnet-gw-6.png)

## Task 2: Deploy an Azure Virtual Machine

1. From the Azure Portal main page, select **Create a Resource**.
    ![Create VM](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/azure-vm-1.png)
2. Under Virtual Machine, select **Create**.
    ![Create VM](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/azure-vm-2.png)
3. Under Create a virtual machine, select your **Resource Group**. Set the **Virtual Machine Name** and **Region**. Verify the image is **Ubuntu Server 20.04 LTS**
    ![Deploy Ubuntu Server](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/azure-vm-3.png)
4. Add your public key from Oracle Cloud Cloud Shell, and then click **Review + create**.
    ![Add public key from cloud shell](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/azure-vm-4.png)
5. Verify the configuration, and then click **Create**.
    ![Verify VM config](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/azure-vm-5.png)
6. While the Virtual Machine is deploying, modify the Network Security Group by clicking **Ubuntu-nsg**.
    ![Modify NSG](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/azure-vm-6.png)
7. Select **Inbound Security Rules**.
    ![Allow traffic inbound](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/azure-vm-7.png)
8. Set Source and Destination to **Any**. Set the Source and Destination port ranges to "*". Set the Protocol to **ICMP**. Set the Action to **Allow**. Select **Add** to add the inbound security rule to the Network Security Group.
    ![All all ICMP traffic](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/azure-vm-8.png)
9. Go back to the Virtual Machine status by selecting the parent level object in the UI.
    ![Navigate back one menu](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/azure-vm-9.png)
10. When the Virtual Machine status changes to "Complete", select **Go to Resource**.
    ![Wait for VM to deploy](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/azure-vm-10.png)
11. Under Networking, notate the **Private IP Address** of the virtual machine. This will be our target to verify that connectivity works between Oracle Cloud and Azure later in the lab.
    ![Notate private IP address](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/azure-vm-11.png)

## Task 3: Deploy an Azure ExpressRoute

1. From the Azure Portal homepage, click on **Create a Resource**.
    ![Create Resource](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/expressroute-1.png)
2. In the search box, search for **ExpressRoute**.
    ![Create ExpressRoute](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/expressroute-2.png)
3. Find the ExpressRoute resource, and click **Create**.
    ![Create ExpressRoute](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/expressroute-3.png)
4. Under the **Basics** tab, select the proper **Resource Group** and give the ExpressRoute a **Name**. Click **Next: Configuration**.
    ![Give ExpressRoute a name](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/expressroute-4.png)
5. Under the Configuration tab, select **Oracle Cloud FastConnect** as the Provider. Select your Oracle Cloud region in Peering Location (this example uses the OCI Ashburn Region). Select the bandwidth you want the ExpressRoute circuit to have. Select **Standard** for the SKU. Click **Review + create**.
    ![Add options to ExpressRoute and create](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/expressroute-5.png)
6. Review the configuration, and then click **Create**.
    ![Review the configuration](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/expressroute-6.png)
7. Wait for the deployment to complete. Afterwards, click **Go to resource**.
    ![Wait for deployment completion](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/expressroute-7.png)
8. Find the Service Key for the ExpressRoute circuit and copy it to your clipboard. You will use this in Task 4 to connect ExpressRoute to FastConnect.
    ![Collect the service key from ExpressRoute](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/expressroute-8.png)

## Task 4: Configure an Oracle Cloud FastConnect

1. From the Oracle Cloud Home Page, navigate to **Networking -> Customer Connectivity -> FastConnect**.
    ![FastConnect](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/fastconnect-1.png)
2. Click on **Create FastConnect**.
    ![Create FastConnect](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/fastconnect-2.png)
3. Select **FastConnect Partner** for the connection type. Under the Partner dropdown menu, select **Microsoft Azure: ExpressRoute**. Click **Next**.
    ![FastConnect Partner Azure](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/fastconnect-3.png)
4. Complete the following fields:

    |                  **Field**              |    **Value**  |
    |----------------------------------------|:------------:|
    |NAME |    OCI Azure Interconnect    |
    |COMPARTMENT |  _OCILabCompartment_    |
    |Virtual Circuit Type|    Private Virtual Circuit    |
    |Dynamic Routing Gateway|  DynamicRoutingGateway  |
    |Provisioned Bandwidth|    1 Gbps    |
    |Partner Service Key|    _servicekeyfromAzure_    |
    |Customer Primary BGP IPv4 Address|    169.254.0.2/30    |
    |Oracle Primary BGP IPv4 Address|    169.254.0.1/30    |
    |Customer Secondary BGP IPv4 Address|    169.254.1.2/30    |
    |Oracle Secondary BGP IPv4 Address|    169.254.1.1/30   |

5. Verify your configuration looks similar to the following, and then click **Create**:
    ![Create FastConnect 1](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/fastconnect-4.png)
    ![Create FastConnect 2](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/fastconnect-5.png)
6. When the FastConnect status is "Provisioned" proceed to the next task.
    ![FastConnect Complete](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/fastconnect-6.png)

## Task 5: Associate Azure ExpressRoute to Azure Virtual Network Gateway

1. Go back to the ExpressRoute in the Azure Portal. Go to **Connections -> Add**.
    ![Add Connection to ExpressRoute](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/expressroute-9.png)
2. Under the **Basics** tab, add the **Resource Group**. Set the Connection type to **ExpressRoute**. Set the Name to **OCI\_Azure_Connection**. Set the region to **East US**. Click **Next: Settings**.
    ![Set ExpressRoute settings](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/expressroute-10.png)
3. Under the **Settings** tab, select the Virtual Network created earlier in the lab. Select the ExpressRoute circuit created earlier in the lab. Click **Review + create**.
    ![Select Virtual Network](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/expressroute-11.png)
4. Verify the configuration, and click **Create**.
    ![Verify the config](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/expressroute-12.png)

## Task 6: Verify FastConnect Routing

1. Go back to the Oracle Cloud Console. On the FastConnect, click on the **Dynamic Routing Gateway** resource.
    ![Dynamic Routing Gateway Select](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/fastconnect-7.png)
2. Click on **DRG route tables**, and select **Autogenerated Drg Route Table for VCN attachments**.
    ![Go to the VCN attachment route table](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/fastconnect-8.png)
3. Click **Get all route rules**.
    ![Get the routes from the route table](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/fastconnect-9.png)
4. Verify the 10.100.0.0/16 route is populated. Seeing this route in the route table confirms that OCI is able to see the Azure network over the FastConnect connection.
    ![Verify routes received from Azure](../oci-multicloud-connectivity/fastconnect/images/azure_interconnect/fastconnect-10.png)
5. Congratulations! This is a major milestone. In the next lab we will deploy a virtual machine and verify traffic traverses the private connection between Oracle Cloud and Azure.

## Acknowledgements

* **Author** - Jake Bloom, Principal Solution Architect, OCI Networking
* **Last Updated By/Date** - Jake Bloom, August 2023