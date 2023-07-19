# Create a Private Connection via Azure Interconnect

## Introduction

In this lab, we will setup the Oracle Cloud Infrastructure FastConnect service to privately extend connectivity outside of Oracle Cloud Infrastructure.

Estimated Time: 30 minutes

![Deployment Diagram](../fastconnect_azure_interconnect/images/multicloud-topology.png)

### About FastConnect

FastConnect allows customers to connect directly external environments such as 3rd party cloud providers and on-premise data centers to their Oracle Cloud Infrastructure (OCI) virtual cloud network via dedicated, private, high-bandwidth connections.

### Objectives

In this lab, you will:

* Use the Microsoft Azure Console to deploy the required network resources for the Azure Interconnect.
* Use the Microsoft Azure Console to deploy a virtual machine to test and verify connectivity with Oracle Cloud.
* Use the Oracle Cloud Console to create a FastConnect to directly connect to Azure ExpressRoute.

### Prerequisites

This lab assumes you have:

* Unrestricted lab access to your Microsoft Azure tenancy
* The OCI and Azure region you are connecting are [supported Azure InterConnect regions](https://learn.microsoft.com/en-us/azure/virtual-machines/workloads/oracle/oracle-oci-overview#region-availability).

## Video Walkthrough

[Azure Quickstart Video](youtube:97dyUveTasQ:large)

## Task 1: Deploy an Azure VNet and Virtual Network Gateway

1. Log into the Azure portal and click **Create Resource**.
    ![Create resource](images/vnet-gw-1.png)
2. Under the Create Resource menu, navigate to **Networking -> Virtual Network Gateway** and click **Create**.
    ![Create resource](images/vnet-gw-2.png)
3. For the new Virtual Network Gateway, give it a **Name**. Set the Gateway Type to **ExpressRoute**. Under **Virtual Network** select **Create Virtual Network**. Complete the following fields.

    |                  **Field**              |    **Vaue**  |
    |----------------------------------------|:------------:|
    |Name |    Azure_VNET    |
    |Resource Group |  _ChooseExistingORCreateANewOne_    |
    |Address Range|    10.100.0.0/16    |
    |Subnet Name|  azure_subnet  |
    |Address Range|  10.100.0.0/24  |

    Verify the configuration, and then select **OK**.
    ![Verify Configuration](images/vnet-gw-3.png)
4. Optionally, add Public IP address, Select **Create New**. Give the public IP address a **Name** and select the **SKU**. Then select **Review + create**.
    ![Public IP](images/vnet-gw-4.png)
5. Verify the configuration, and then click **Create**.
    ![Verify Config](images/vnet-gw-5.png)
6. When your deployment says **Your deployment is complete**, move to the next task. **The Azure Virtual Network Gateway can take anywhere from 15-45 minutes to deploy.**
    ![Verify Deployment Complete](images/vnet-gw-6.png)

## Task 2: Deploy an Azure VM

1. From the Azure Portal main page, select **Create a Resource**.
    ![Create VM](images/azure-vm-1.png)
2. Under Virtual Machine, select **Create**.
    ![Create VM](images/azure-vm-2.png)
3. Under Create a virtual machine, select your **Resource Group**. Set the **Virtual Machine Name** and **Region**. Verify the image is **Ubuntu Server 20.04 LTS**
    ![Deploy Ubuntu Server](images/azure-vm-3.png)
4. Optionally add the public key from Oracle Cloud Cloud Shell, and then click **Review + create**.
    ![Add public key from cloud shell](images/azure-vm-4.png)
5. Verify the configuration, and then click **Create**.
    ![Verify VM config](images/azure-vm-5.png)
6. While the Virtual Machine is deploying, modify the Network Security Group by clicking **Ubuntu-nsg**.
    ![Modify NSG](images/azure-vm-6.png)
7. Select **Inbound Security Rules**.
    ![Allow traffic inbound](images/azure-vm-7.png)
8. Set Source and Destination to **Any**. Set the Source and Destination port ranges to "*". Set the Protocol to **ICMP**. Set the Action to **Allow**. Select **Add** to add the inbound security rule to the Network Security Group.
    ![All all ICMP traffic](images/azure-vm-8.png)
9. Go back to the Virtual Machine status by selecting the parent level object in the UI.
    ![Navigate back one menu](images/azure-vm-9.png)
10. When the Virtual Machine status changes to "Complete", select **Go to Resource**.
    ![Wait for VM to deploy](images/azure-vm-10.png)
11. Under Networking, notate the **Private IP Address** of the virtual machine. This will be our target to verify that connectivity works between Oracle Cloud and Azure later in the lab.
    ![Notate private IP address](images/azure-vm-11.png)

## Task 3: Deploy Azure ExpressRoute

1. From the Azure Portal homepage, click on **Create a Resource**.
    ![Create Resource](images/expressroute-1.png)
2. In the search box, search for **ExpressRoute**.
    ![Create ExpressRoute](images/expressroute-2.png)
3. Find the ExpressRoute resource, and click **Create**.
    ![Create ExpressRoute](images/expressroute-3.png)
4. Under the **Basics** tab, select the proper **Resource Group** and give the ExpressRoute a **Name**. Click **Next: Configuration**.
    ![Give ExpressRoute a name](images/expressroute-4.png)
5. Under the Configuration tab, select **Oracle Cloud FastConnect** as the Provider. Select your Oracle Cloud region in Peering Location (this example uses the OCI Ashburn Region). Select the bandwidth you want the ExpressRoute circuit to have. Select **Standard** for the SKU. Click **Review + create**.
    ![Add options to ExpressRoute and create](images/expressroute-5.png)
6. Review the configuration, and then click **Create**.
    ![Review the configuration](images/expressroute-6.png)
7. Wait for the deployment to complete. Afterwards, click **Go to resource**.
    ![Wait for deployment completion](images/expressroute-7.png)
8. Find the Service Key for the ExpressRoute circuit and copy it to your clipboard. You will use this in Task 4 to connect ExpressRoute to FastConnect.
    ![Collect the service key from ExpressRoute](images/expressroute-8.png)

## Task 4: Configure Oracle Cloud FastConnect

1. From the Oracle Cloud Home Page, navigate to **Networking -> Customer Connectivity -> FastConnect**.
    ![FastConnect](images/fastconnect-1.png)
2. Click on **Create FastConnect**.
    ![Create FastConnect](images/fastconnect-2.png)
3. Select **FastConnect Partner** for the connection type. Under the Partner dropdown menu, select **Microsoft Azure: ExpressRoute**. Click **Next**.
    ![FastConnect Partner Azure](images/fastconnect-3.png)
4. Complete the following fields:

    |                  **Field**              |    **Vaue**  |
    |----------------------------------------|:------------:|
    |NAME |    OCI Azure Interconnect    |
    |COMPARTMENT |  *Choose your lab compartment*    |
    |Virtual Circuit Type|    Private Virtual Circuit    |
    |Dynamic Routing Gateway|  DynamicRoutingGateway  |
    |Provisioned Bandwidth|    1 Gbps    |
    |Partner Service Key|    *service_key_from_Azure*    |
    |Customer Primary BGP IPv4 Address|    169.254.0.2/30    |
    |Oracle Primary BGP IPv4 Address|    169.254.0.1/30    |
    |Customer Secondary BGP IPv4 Address|    169.254.1.2/30    |
    |Oracle Secondary BGP IPv4 Address|    169.254.1.1/30   |

5. Verify your configuration looks similar to the following, and then click **Create**:
    ![Create FastConnect 1](images/fastconnect-4.png)
    ![Create FastConnect 2](images/fastconnect-5.png)
6. When the FastConnect status is "Provisioned" proceed to the next task.
    ![FastConnect Complete](images/fastconnect-6.png)

## Task 5: Associate Azure ExpressRoute to Azure Virtual Network Gateway

1. Go back to the ExpressRoute in the Azure Portal. Go to **Connections -> Add**.
    ![Add Connection to ExpressRoute](images/expressroute-9.png)
2. Under the **Basics** tab, add the **Resource Group**. Set the Connection type to **ExpressRoute**. Set the Name to **OCI\_Azure_Connection**. Set the region to **East US**. Click **Next: Settings**.
    ![Set ExpressRoute settings](images/expressroute-10.png)
3. Under the **Settings** tab, select the Virtual Network created earlier in the lab. Select the ExpressRoute circuit created earlier in the lab. Click **Review + create**.
    ![Select Virtual Network](images/expressroute-11.png)
4. Verify the configuration, and click **Create**.
    ![Verify the config](images/expressroute-12.png)

## Task 6: Verify FastConnect Routing

1. Go back to the Oracle Cloud Console. On the FastConnect, click on the **Dynamic Routing Gateway** resource.
    ![Dynamic Routing Gateway Select](images/fastconnect-7.png)
2. Click on **DRG route tables**, and select **Autogenerated Drg Route Table for VCN attachments**.
    ![Go to the VCN attachment route table](images/fastconnect-8.png)
3. Click **Get all route rules**.
    ![Get the routes from the route table](images/fastconnect-9.png)
4. Verify the 10.100.0.0/16 route is populated. Seeing this route in the route table confirms that OCI is able to see the Azure network over the FastConnect connection.
    ![Verify routes received from Azure](images/fastconnect-10.png)
5. Congratulations! This is major mile stone. In the next lab we will deploy a virtual machine and verify traffic traverses the private connection between Oracle Cloud and Azure.
