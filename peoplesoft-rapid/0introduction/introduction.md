# Introduction

## About this Workshop

This workshop covers the basics needed to create and provision a PeopleSoft Environment using OCI.

After completing this workshop you should have a better understanding of OCI, the ability to create and access a PeopleSoft environment that you created as well as view all of the components that were created during the lab to make that possible. After the completion of the lab, you will tear down, or destroy, all created components.

Estimated Time: 2 hours

Notes:

* The workshop is quite detailed and technical. PLEASE take your time and DO NOT skip any steps.
* IP addresses and URLs in the screenshots in this workbook may differ from what you use in the labs as these are dynamically generated.
* For security purposes, some sensitive text (such as IP addresses) may be redacted in the screenshots in this workbook.
* The user interface for the Oracle Cloud Infrastructure is constantly evolving. As a result, the screens depicted in this tutorial may not exactly coincide with the current release. This tutorial is routinely updated for functional changes to Oracle Cloud Infrastructure, at which time any differences in the user interface will be reconciled.




### Objectives

In this lab, you will:
* Create a Sub-Compartment
* Create a Virtual Cloud Network (VCN)
* Provision a PeopleSoft Marketplace image
* Establish Security List Rules for PeopleSoft Instance
* Access the PeopleSoft application
* Terminate and tear down all of the resources that you have created

### Prerequisites

You will need the following to complete this workshop:

* A modern browser
* A secure remote login (Secure Shell, or SSH) utility
        - Such as PuTTY - downloaded from [here](https://www.ssh.com/ssh/putty/download)
* Knowledge of basic UNIX commands and the ability to copy and use them
* You must have subscribed to resources in OCI to install and run PeopleSoft.
* Access to OCI Marketplace to deploy PeopleSoft
* Minimum Shape: VMStandard2.1 (1 OCPUs and 15 GB memory).
* Boot Volume Storage of 300 GB.

## Appendix

*Terminology*

The following terms are commonly employed in PeopleSoft cloud operations and are used throughout our documentation:

**Availability Domain** – One or more data centers located within a region.

**Bucket** – A logical container used by Object Storage for storing your data and files. A bucket can contain an unlimited number of objects.

**Compartments** – This allows you to organize and control access to your cloud resources. A compartment is a collection of related resources (such as instances, virtual cloud networks, block volumes) that can be accessed only by certain groups.

**Virtual Cloud Network (VCN)** – Networking and compute resources required to run PSFT on Oracle Cloud Infrastructure. The PSFT VCN includes the recommended networking resources (VCN, subnets routing tables, internet gateway, security lists, and security rules) to run Oracle PeopleSoft on OCI.

**Oracle Cloud Infrastructure (OCI)** – Combines the elasticity and utility of the public cloud with the granular control, security, and predictability of on-premises infrastructure to deliver high-performance, high availability, and cost-effective infrastructure services.

**Region** – Oracle Cloud Infrastructure is hosted in regions, which are located in different metropolitan areas. Regions are completely independent of other regions and can be separated by vast distances – across countries or even continents. Generally, you would deploy an application in the region where it is most heavily used since using nearby resources is faster than using distant resources.

**Subnet, Private** - Instances created in private subnets do not have direct access to the Internet. In this lab, we will be provisioning the Cloud Manager stack in Resource Manager, and creating private subnets. We will then choose to create a "jump host", or bastion host, as part of the installation. The IP address for a private subnet cannot be accessed directly from the Internet. To access our CM instance in a private subnet, we will set up a jump host to enable SSH tunneling and Socket Secure (SOCKS) proxy connection to the Cloud Manager web server (PIA). The jump host is created using an Oracle Linux platform image and will be created inside the VCN.

**Subnet, Public** - Instances that you create in a public subnet have public IP addresses, and can be accessed from the Internet.

**Tenancy** – When you sign up for Oracle Cloud Infrastructure, Oracle creates a tenancy for your company, which is a secure and isolated partition within Oracle Cloud Infrastructure where you can create, organize, and administer your cloud resources.

## Acknowledgements
* **Authors** - Deepak Kumar M, Principal Cloud Architect
* **Contributors** - Deepak Kumar M, Principal Cloud Architect
* **Last Updated By/Date** - Deepak Kumar M, Principal Cloud Architect, April 2022

