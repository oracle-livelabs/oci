# Create a Private Connection via Azure Interconnect

## Introduction

In this section, we will deploy the Oracle Cloud Infrastructure FastConnect service to extend private connectivity outside of Oracle Cloud Infrastructure.

Estimated Time: 20 minutes

### About FastConnect

FastConnect allows customers to connect directly external environments such as 3rd party cloud providers and on-premise data centers to their Oracle Cloud Infrastructure (OCI) virtual cloud network via dedicated, private, high-bandwidth connections.

### Objectives

In this lab, you will:

* Use the Azure console to setup the connectivity requirements for the Azure Interconnect
* Use the Oracle Cloud Console to create a FastConnect Connection to ExpressRoute

### Prerequisites

This lab assumes you have:

* Administrative Access to your Azure tenancy
* The OCI and Azure region you are connecting are [supported Azure InterConnect regions](https://learn.microsoft.com/en-us/azure/virtual-machines/workloads/oracle/oracle-oci-overview#region-availability).

## Video Walkthrough

TODO

## Task 1: Deploy an Azure VNet and Virtual Network Gateway

1. Log into the Azure portal and click **Create Resource**.
    ![Alt text](images/vnet-gw-1.png)
2. Under the Create Resource menu, navigate to **Networking -> Virtual Network Gateway** and click **Create**.
    ![Alt text](images/vnet-gw-2.png)
3. For the new Virtual Network Gateway, give it a **Name**. Set the Gateway Type to **ExpressRoute**. Under **Virtual Network** select **Create Virtual Network**. Complete the following fields.

    |                  **Field**              |    **Vaue**  |
    |----------------------------------------|:------------:|
    |Name |    Azure_VNET    |
    |Resource Group |  _ChooseExistingorCreateANewOneHere_    |
    |Address Range|    10.100.0.0/16    |
    |Subnet Name|  azure_subnet  |
    |Address Range|  10.100.0.0/24  |

    Verify the configuration, and then select **OK**.
    ![Alt text](images/vnet-gw-3.png)
4. Optionally, add Public IP address, Select **Create New**. Give the public IP address a **Name** and select the **SKU**. Then select **Review + create**.
    ![Alt text](images/vnet-gw-4.png)
5. Verify the configuration, and then click **Create**.
    ![Alt text](images/vnet-gw-5.png)
6. When your deployment says **Your deployment is complete**, move to the next task. This step can take anywhere from 15-45 minutes so be patient.
    ![Alt text](images/vnet-gw-6.png)

## Task 2: Deploy an Azure VM

1. From the Azure Portal main page, select **Create a Resource**.
    ![Alt text](images/azure-vm-1.png)
2. Under Virtual Machine, select **Create**.
    ![Alt text](images/azure-vm-2.png)
3. Under Create a virtual machine, select your **Resource Group**. Set the **Virtual Machine Name** and **Region**. Verify the image is **Ubuntu Server 20.04 LTS**
    ![Alt text](images/azure-vm-3.png)
4. Optionally add the public key from Oracle Cloud Cloud Shell, and then click **Review + create**.
    ![Alt text](images/azure-vm-4.png)
5. Verify the configuration, and then click **Create**.
    ![Alt text](images/azure-vm-5.png)
6. While the Virtual Machine is deploying, modify the Network Security Group by clicking **Ubuntu-nsg**.
    ![Alt text](images/azure-vm-6.png)
7. Select **Inbound Security Rules**.
    ![Alt text](images/azure-vm-7.png)
8. Set Source and Destination to **Any**. Set the Source and Destination port ranges to "*". Set the Protocol to **ICMP**. Set the Action to **Allow**. Select **Add** to add the inbound security rule to the Network Security Group.
    ![Alt text](images/azure-vm-8.png)
9. Go back to the Virtual Machine status by selecting the parent level object in the UI.
    ![Alt text](images/azure-vm-9.png)
10. When the Virtual Machine status changes to "Complete", select **Go to Resource**.
    ![Alt text](images/azure-vm-10.png)
11. Under Networking, notate the **Private IP Address** of the virtual machine. This will be our target to verify that connectivity works between Oracle Cloud and Azure later in the lab.
    ![Alt text](images/azure-vm-11.png)

## Task 3: Deploy Azure ExpressRoute

1. From the Azure Portal homepage, click on **Create a Resource**.
    ![Alt text](images/expressroute-1.png)
2. In the search box, search for **ExpressRoute**.
    ![Alt text](images/expressroute-2.png)
3. Find the ExpressRoute resource, and click **Create**.
    ![Alt text](images/expressroute-3.png)
4. Under the **Basics** tab, select the proper **Resource Group** and give the ExpressRoute a **Name**. Click **Next: Configuration**.
    ![Alt text](images/expressroute-4.png)
5. Under the Configuration tab, select **Oracle Cloud FastConnect** as the Provider. Select your Oracle Cloud region in Peering Location (this example uses the OCI Ashburn Region). Select the bandwidth you want the ExpressRoute circuit to have. Select **Standard** for the SKU. Click **Review + create**.
    ![Alt text](images/expressroute-5.png)
6. Review the configuration, and then click **Create**.
    ![Alt text](images/expressroute-6.png)
7. Wait for the deployment to complete. Afterwards, click **Go to resource**.
    ![Alt text](images/expressroute-7.png)
8. Find the Service Key for the ExpressRoute circuit and copy it to your clipboard. You will use this in Task 4 to connect ExpressRoute to FastConnect.
    ![Alt text](images/expressroute-8.png)

## Task 4: Configure Oracle Cloud FastConnect

1. From the Oracle Cloud Home Page, navigate to **Networking -> Customer Connectivity -> FastConnect**. 
    ![Alt text](images/fastconnect-1.png)

2. Click on **Create FastConnect**.
    ![Alt text](images/fastconnect-2.png)

3. Select **FastConnect Partner** for the connection type. Under the Partner dropdown menu, select **Microsoft Azure: ExpressRoute**. Click **Next**.
    ![Alt text](images/fastconnect-3.png)

4. Complete the following fields:

    |                  **Field**              |    **Vaue**  |
    |----------------------------------------|:------------:|
    |NAME |    _ConnectionToAzure    |
    |COMPARTMENT |  *Choose your lab compartment*    |
    |Virtual Circuit Type|    Private Virtual Circuit    |
    |Dynamic Routing Gateway|  *DRG from previous step*  |
    |Provisioned Bandwidth|    1 Gbps    |
    |Partner Service Key|    *service_key_from_Azure*    |
    |Customer Primary BGP IPv4 Address|    169.254.0.2/30    |
    |Oracle Primary BGP IPv4 Address|    169.254.0.1/30    |
    |Customer Secondary BGP IPv4 Address|    169.254.1.2/30    |
    |Oracle Secondary BGP IPv4 Address|    169.254.1.1/30   |

5. Verify your configuration looks similar to the following, and then click **Create**:
    ![Alt text](images/fastconnect-4.png)
    ![Alt text](images/fastconnect-5.png)

6. When the FastConnect status turns to "Provisioned" proceed to the next task.
    ![Alt text](images/fastconnect-6.png)

## Task 5: Associate Azure ExpressRoute to Azure Virtual Network Gateway

1. Go back to the ExpressRoute in the Azure Portal. Go to **Connections -> Add**.
    ![Alt text](images/expressroute-9.png)
2. Under the **Basics** tab, add the **Resource Group**. Set the Connection type to **ExpressRoute**. Set the Name to **OCI_Azure_Connection**. Set the region to **East US**. Click **Next: Settings**.
    ![Alt text](images/expressroute-10.png)
3. Under the **Settings** tab, select the Virtual Network created earlier in the lab. Select the ExpressRoute circuit created earlier in the lab. Click **Review + create**.
    ![Alt text](images/expressroute-11.png)
4. Verify the configuration, and click **Create**.
    ![Alt text](images/expressroute-12.png)

## Task 6: Verify Dynamic Routing Configuration

1. Go back to the Oracle Cloud Console. On the FastConnect, click on the **Dynamic Routing Gateway** resource.
    ![Alt text](images/fastconnect-7.png)
2. Click on **DRG route tables**, and select **Autogenerated Drg Route Table for VCN attachments**.
    ![Alt text](images/fastconnect-8.png)
3. Click **Get all route rules**.
    ![Alt text](images/fastconnect-9.png)
4. Verify the 10.100.0.0/16 route is populated. 
    ![Alt text](images/fastconnect-10.png)

5. Congratulations! This is major mile stone. In the next lab we will deploy a virtual machine and verify traffic traverses the private connection between Oracle Cloud and Azure.