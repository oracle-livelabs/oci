# Introduction

## About this Workshop

This workshop guides through the steps to setup the PeopleSoft PICASO Chatbot configuration with Oracle Digital Assistant.

After completing this workshop you will have a better understanding of OCI Digital Assistant and the ability to configure and integrate a PeopleSoft environment whether it exists on OCI or on-premises.

Watch the video below for an Introduction To PeopleSoft PICASO Digital Assistant.
[Lab overview](youtube:HCF482DDcrM)

A high-level overview of PeopleSoft Chatbot Integration with Oracle Digital Assistant is depicted in the below figure.

   ![High-level overview of PeopleSoft Chatbot Integration with Oracle Digital Assistant](./images/architecture.png" ")

Estimated Time: 2 hours

Notes:

* The workshop is quite detailed and technical. PLEASE take your time and DO NOT skip any steps.
* IP addresses and URLs in the screenshots in this workbook may differ from what you use in the labs as these are dynamically generated.
* For security purposes, some sensitive text (such as IP addresses) may be redacted in the screenshots in this workbook.
* The user interface for the Oracle Cloud Infrastructure is constantly evolving. As a result, the screens depicted in this tutorial may not exactly coincide with the current release. This tutorial is routinely updated for functional changes to Oracle Cloud Infrastructure, at which time any differences in the user interface will be reconciled.




### Objectives

In this lab, you will:

* Setup Oracle Digital Assistant from OCI services
* Deploy PeopleSoft PICASO from Oracle Digital Store
* Clone and create a new digital assistant
* Configure skills for PeopleSoft
* Create the channel for the skills
* Configure PeopleSoft for Oracle Digital Assistant
* Test the PeopleSoft PICASO chatbot


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
* **Last Updated By/Date** - Deepak Kumar M, Principal Cloud Architect, October 2022

