# Introduction

## About this Workshop

This workshop showcases the deployment of a new Siebel CRM environment on Oracle Cloud Infrastructure (OCI) using the Siebel Cloud Manager.

The Siebel Cloud Manager is a new REST-based continuous deployment tool used for automating the deployment of Siebel CRM on Oracle Cloud Infrastructure, whether you start from the existing on-premises deployment of Siebel CRM or create a new deployment of Siebel CRM on OCI. The Siebel CRM runs as Docker Containers in Oracle Kubernetes Engine (OKE).

For the complete documentation on Siebel Cloud Manager, visit the support article **Using Siebel Cloud Manager to Deploy Siebel CRM on OCI (Doc ID 2828904.1)** and download the attached pdf document. 

Estimated Time: 2 hours 20 minutes

Notes:

* The workshop is quite detailed and technical. PLEASE take your time and DO NOT skip any steps.
* IP addresses and URLs in the screenshots in this workbook may differ from what you use in the labs, as these are dynamically generated.
* For security purposes, some sensitive text (such as IP addresses) may be redacted in the screenshots in this workbook.
* Replace **{}** characters and the string inside them with the relevant values wherever applicable as they are placeholders; for example, **{Application_Name}** will be **Siebel**


UNIX commands (usually executed in an SSH session using PuTTY) are displayed in a monospace font within a box, as follows:

```
$ <copy>sudo yum install wget -y $ wget -O bitnami-mean-linux-installer.run https://bitnami.com/stack/mean/download_latest/linux-x64</copy>
```

### Workshop Overview

This workshop uses the following components:

* Trial accounts (one per attendee)

  - Virtual Cloud Network and related resources
    - User-generated using Resource Manager and provided Terraform script

  - GitLab Instance
    - Deployed through Architecture Center's GitLab stack

  - Siebel Cloud Manager instance
    - Provisioned from OCI Marketplace Image

  - Oracle Kubernetes Engine (OKE) and related resources
    - Created by Siebel Cloud Manager

  - Siebel CRM Application


### Objectives

In this lab, you will:
* Provision the Siebel Cloud Manager instance
* Deploy, configure, and upgrade GitLab instance
* Prepare and execute a JSON payload to create a new Siebel CRM environment
* Validate the Siebel Application
* Access the Siebel Kubernetes Cluster


### Prerequisites

You will need the following to complete this workshop:

* A secure remote login (Secure Shell, or SSH) utility
        - Such as PuTTY - downloaded from [here](https://www.ssh.com/ssh/putty/download)
* Basic understanding of Dockers & Kubernetes, and Unix commands.

## Appendix
### Terminology

The following terms are commonly employed in Oracle Siebel cloud operations and used throughout our documentation:

**Availability Domain** – One or more data centers located within a region.

**Bucket** – A logical container used by Object Storage for storing your data and files. A bucket can contain an unlimited number of objects.

**Compartments** – Allows you to organize and control access to your cloud resources. A compartment is a collection of related resources (such as instances, virtual cloud networks, block volumes etc) that can be accessed only by certain groups.

**Oracle Cloud Infrastructure (OCI)** – Combines the elasticity and utility of public cloud with the granular control, security, and predictability of on-premises infrastructure to deliver high-performance, high availability, and cost-effective infrastructure services.

**Region** – Oracle Cloud Infrastructure is hosted in regions, which are located in different metropolitan areas. Regions are completely independent of other regions and can be separated by vast distances – across countries or even continents. Generally, you would deploy an application in the region where it is most heavily used since using nearby resources is faster than using distant resources.

**Tenancy** – When you sign up for Oracle Cloud Infrastructure, Oracle creates a tenancy for your company, which is a secure and isolated partition within Oracle Cloud Infrastructure where you can create, organize, and administer your cloud resources.

**Virtual Cloud Network (VCN)** – A virtual version of a traditional network – including subnets, route tables, and gateways – on which your instances run. A cloud network resides within a single region, but can cross multiple availability domains.

**Oracle Kubernetes Engine (OKE)** – Oracle Cloud Infrastructure Container Engine for Kubernetes is a fully-managed, scalable, and highly available service that you can use to deploy your containerized applications to the cloud.

**GitLab** – GitLab is a web-based DevOps platform that provides a Git-based repository management service, issue-tracking, and continuous integration and deployment (CI/CD) pipeline features

**Oracle Cloud Infrastructure Marketplace** – Oracle Cloud Infrastructure Marketplace is an online store that offers solutions specifically for customers of Oracle Cloud Infrastructure. In the Oracle Cloud Infrastructure Marketplace catalog, you can find listings for two types of solutions from Oracle and trusted partners: images and stacks. These listing types include different categories of applications

## Acknowledgements

* **Author:** Shyam Mohandas, Principal Cloud Architect; Sampath Nandha, Principal Cloud Architect
* **Contributors** - Vinodh Kolluri, Raj Aggarwal, Mark Farrier, Sandeep Kumar
* **Last Updated By/Date** - Sampath Nandha, Principal Cloud Architect, March 2023
