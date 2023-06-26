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

## Task 1: Build a Virtual Cross Connect (VXC) in the MegaPort Portal

Do your thing here on the MegaPort portal

(optional) Task 1 opening paragraph.

1. From the Navigation Menu, navigate to **Networking -> Customer Connectivity -> FastConnect**. Click on **Create FastConnect**.

	![Image alt text](images/sample1.png)

  To create a link to local file you want the reader to download, use the following formats. _The filename must be in lowercase letters and CANNOT include any spaces._

	Download the [starter file](files/starter-file.sql) SQL code.

	When the file type is recognized by the browser, it will attempt to render it. So you can use the following format to force the download dialog box.

	Download the [sample JSON code](files/sample.json?download=1).

  > Note: do not include zip files, CSV, PDF, PSD, JAR, WAR, EAR, bin, or exe files - you must have those objects stored somewhere else. We highly recommend using Oracle Cloud Object Store and creating a PAR URL instead. See [Using Pre-Authenticated Requests](https://docs.cloud.oracle.com/en-us/iaas/Content/Object/Tasks/usingpreauthenticatedrequests.htm)

2. Make sure **FastConnect Partner** is selected, and the click on the **Partner** Dropdown menu. Select **Microsoft Azure: ExpressRoute** and click **Next**.

  ![Image alt text](images/sample1.png)

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

## Task 2: Configure Oracle Cloud FastConnect to MegaPort

Show the MegaPort OCI steps here.

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)