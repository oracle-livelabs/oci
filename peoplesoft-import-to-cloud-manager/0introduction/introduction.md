# Introduction

## About this Workshop

This workshop guides you through the steps to import PeopleSoft environments running on Oracle Cloud Infrastructure to PeopleSoft Cloud Manager.

After completing this workshop, you will have a better insight and understanding of importing PeopleSoft environments into PeopleSoft Cloud Manager for better lifecycle management of PeopleSoft environments.

Watch the video below for an Introduction To PeopleSoft Cloud Manager.
[PeopleSoft Cloud Manager](youtube:msMcUr3fny4&t=4s:medium)

The below image provides a high-level overview of PeopleSoft Chatbot Integration with Oracle Digital Assistant.

   ![High-level overview of PeopleSoft Chatbot Integration with Oracle Digital Assistant](./images/peoplesoft-cloud-manager.png" ")

PeopleSoft Cloud Manager overview

PeopleSoft Cloud Manager is a PeopleSoft application that runs on Oracle Cloud Infrastructure (OCI) to help accelerate adoption as well as to optimize the benefits of running PeopleSoft on Cloud. PeopleSoft Cloud Manager brings an unprecedented extent of automation to migrate your existing environment from on-premises and to rapidly clone and create new environments on the cloud tailored for specific functional use — such as development, customization, user acceptance testing, performance testing or production. PeopleSoft Cloud Manager comes with a built-in automated download manager and provides automated lifecycle operations such as PeopleTools only upgrade, PeopleTools update, setting up of selective adoption environments and automated self-update to the latest Cloud Manager Image. 

Estimated Time: 2 hours

Notes:

* The workshop is quite technical and in-depth. Please go slowly and without skipping any steps.
*  The IP addresses and URLs in this workbook's screenshots are dynamically generated, so they might not match what you use in the labs
* For security purposes, some sensitive text (such as IP addresses) may be redacted in the screenshots in this workbook.
* The user interface for the Oracle Cloud Infrastructure is constantly evolving. As a result, the screens depicted in this tutorial may not exactly coincide with the current release. This tutorial is routinely updated for functional changes to Oracle Cloud Infrastructure, at which time any differences in the user interface will be reconciled.


### Objectives

In this lab, you will:

* Import PeopleSoft Environments to PeopleSoft Cloud Manager
* Check PeopleSoft lifecycle management in PeopleSoft Cloud Manager


### Prerequisites

You will need the following to complete this workshop:

* A modern browser
* You must have subscribed to resources in OCI to install and run Oracle Digital Assistant 
* Access to OCI Marketplace to deploy PeopleSoft if using OCI
* PeopleSoft HCM 9.2 Update Image 43 or PeopleSoft FSCM 9.2 Update Image 45 already available on-premise or on Oracle Cloud Infrastructure.
* In case of new PeopleSoft deployment on OCI using marketplace image, follow the PeopleSoft Rapid Provisioning Livelabs for instructions.Refer to link [here](https://apexapps.oracle.com/pls/apex/r/dbpm/livelabs/view-workshop?wid=3208) 

## Appendix

*Terminology*

The following terms are commonly employed in PeopleSoft cloud operations and are used throughout our documentation:

**Availability Domain** – One or more data centers located within a region.

**Bucket** – A logical container used by Object Storage for storing your data and files. A bucket can contain an unlimited number of objects.

**Compartments** – This allows you to organize and control access to your cloud resources. A compartment is a collection of related resources (such as instances, virtual cloud networks, block volumes) that can be accessed only by certain groups.

**Virtual Cloud Network (VCN)** – Networking and compute resources required to run PSFT on Oracle Cloud Infrastructure. The PSFT VCN includes the recommended networking resources (VCN, subnets routing tables, internet gateway, security lists, and security rules) to run Oracle PeopleSoft on OCI.

**Oracle Cloud Infrastructure (OCI)** – Combines the elasticity and utility of the public cloud with the granular control, security, and predictability of on-premises infrastructure to deliver high-performance, high availability, and cost-effective infrastructure services.

**Region** – Oracle Cloud Infrastructure is hosted in regions, which are located in different metropolitan areas. Regions are completely independent of other regions and can be separated by vast distances – across countries or even continents. Generally, you would deploy an application in the region where it is most heavily used since using nearby resources is faster than using distant resources.

**Subnet, Private** - Instances created in private subnets do not have direct access to the Internet. 

**Subnet, Public** - Instances that you create in a public subnet have public IP addresses, and can be accessed from the Internet.

**Tenancy** – When you sign up for Oracle Cloud Infrastructure, Oracle creates a tenancy for your company, which is a secure and isolated partition within Oracle Cloud Infrastructure where you can create, organize, and administer your cloud resources.

## Acknowledgements
* **Authors** - Deepak Kumar M, Principal Cloud Architect
* **Contributors** - Deepak Kumar M, Principal Cloud Architect
* **Last Updated By/Date** - Deepak Kumar M, Principal Cloud Architect, March 2023

