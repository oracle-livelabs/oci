# Create a Private Connection with FastConnect

## Introduction

In this section, we will deploy the Oracle Cloud Infrastructure FastConnect service to extend private connectivity outside of Oracle Cloud Infrastructure.

Estimated Time: 20 minutes

### About FastConnect

FastConnect allows customers to connect directly external environments such as 3rd party cloud providers and on-premise data centers to their Oracle Cloud Infrastructure (OCI) virtual cloud network via dedicated, private, high-bandwidth connections.

### Objectives

In this lab, you will:

* Use the MegaPort portal to build a private connection.
* Use the Oracle Cloud Console to create a FastConnect Connection to MegaPort

### Prerequisites

This lab assumes you have:

* Access to the MegaPort portal.

## Task 1: Configure Oracle Cloud FastConnect to MegaPort

Show the MegaPort OCI steps here.

1. From the Navigation Menu, navigate to **Networking -> Customer Connectivity -> FastConnect**. Click on **Create FastConnect**.

2. Make sure **FastConnect Partner** is selected, and the click on the **Partner** Dropdown menu. Select **Microsoft Azure: ExpressRoute** and click **Next**.

  ![Image alt text](images/sample1.png)

3. Complete the following fields:

    |                  **Field**              |    **Vaue**  |
    |----------------------------------------|:------------:|
    |NAME |    _ConnectionToMegaPort_   |
    |COMPARTMENT |  *Choose your lab compartment*    |
    |Virtual Circuit Type|    Private Virtual Circuit    |
    |Dynamic Routing Gateway|  *DRG from previous step*  |
    |Provisioned Bandwidth|    1 Gbps    |
    |Partner Service Key|    *service_key_from_Azure*    |
    |Customer Primary BGP IPv4 Address|    169.254.0.2/30    |
    |Oracle Primary BGP IPv4 Address|    169.254.0.1/30    |
    |Customer Secondary BGP IPv4 Address|    169.254.1.2/30    |
    |Oracle Secondary BGP IPv4 Address|    169.254.1.1/30   |

## Task 2: Build a Virtual Cross Connect (VXC) in the MegaPort Portal

Do your thing here on the MegaPort portal

1. In the Megaport Portal, go to the Services page and select the Port you want to use.
If you haven’t already created a Port, see Creating a Port.

2. Add an VXC connection for the Port.
If this is the first connection for the Port, click the Oracle tile. The tile is a shortcut to the configuration page. Alternatively, click +Connection, click Cloud, and click Oracle.

3. Enter your Oracle Cloud ID (OCID).
The Portal verifies the OCID and displays the available port locations based on the FastConnect region. (For example, if your FastConnect service is deployed in Ashburn, you only see the Ashburn FastConnect targets).

4. Select a target location for your first connection and click Next.

5. Complete the following fields:

    |                  **Field**              |    **Vaue**  |
    |----------------------------------------|:------------:|
    |Connection Name |    _nameofVXC_   |
    |Rate Limit|    Private Virtual Circuit    |
    |Preferred A-End VLAN|  Untag  |

6. Click Next

The MegaPort connection has been configured.

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)