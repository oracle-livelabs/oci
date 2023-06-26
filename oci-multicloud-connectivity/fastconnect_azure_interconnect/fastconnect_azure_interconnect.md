# Create a Private Connection with MegaPort

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


## Task 1: Configure Azure ExpressRoute

Show the Azure ExpressRoute tasks here.

1. Create an ExpressRoute Circuit

2. Create a Virtual WAN

3. Connect ExpressRoute to Hub Gateway

4. Connect VNet to Hub Gateway

## Task 2: Configure Oracle Cloud FastConnect

1. From the Navigation Menu, navigate to **Networking -> Customer Connectivity -> FastConnect**. Click on **Create FastConnect**.

2. Make sure **FastConnect Partner** is selected, and the click on the **Partner** Dropdown menu. Select **Microsoft Azure: ExpressRoute** and click **Next**.

3. Complete the following fields:

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

## Learn More

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)