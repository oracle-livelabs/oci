# Introduction

## About this Workshop

Oracle Cloud Infrastructure (OCI) Networking is a core tenet of a MultiCloud architecture. This Hands On Lab will walk through the steps required to connect to Oracle Cloud to 3rd party cloud infrastructure such as Microsoft Azure, Google GCP and Amazon AWS. After the networking dependencies are met, you will deploy a test workload to verify connectivity between cloud providers. The Oracle Cloud networking resources deployed in this lab will include a VCN, DRG and FastConnect. Make sure to review [Oracle Cloud Networking Overview](https://docs.cloud.oracle.com/iaas/Content/Network/Concepts/overview.htm) become more familiar with Oracle Cloud's networking components and their relationships.

## Objectives

In this workshop, you will learn how to:

* Deploy a Virtual Cloud Network (VCN)
* Deploy a Dynamic Routing Gateway (DRG)
* Setup a FastConnect Connection
* Deploy a Virtual Machine
* Verify MultiCloud Connectivity

### Prerequisites

This lab assumes you have:

* Unrestricted lab access to an Oracle Cloud Tenancy
* Unrestricted lab access to your 3rd party cloud provider (Azure, GCP, AWS, etc)
* Access to a private connectivity provider
    * **Option 1 -**  Access to a [FastConnect Partner](https://www.oracle.com/cloud/networking/fastconnect/providers/) that is available for your Oracle Cloud region and 3rd party cloud service provider. This Hands-On Lab currently supports a Megaport MCR deployment with Oracle Cloud.
    * **Option 2 -** Access to an Azure subscription with a [supported Azure Interconnect region](https://learn.microsoft.com/en-us/azure/virtual-machines/workloads/oracle/oracle-oci-overview#region-availability). If your OCI or Azure region does not support Azure Interconnect use **Option 1** to connect to Microsoft Azure.

## Acknowledgements

* **Author** - <Name, Title, Group> Jake Bloom, Principal Solution Architect, OCI Networking
* **Last Updated By/Date** - <Name, Month Year> Jake Bloom, July 2023
