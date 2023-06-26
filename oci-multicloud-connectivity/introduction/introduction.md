# Introduction

## About this Workshop

Oracle Cloud Infrastructure (OCI) Networking is a core tenet of a MultiCloud architecture. This lab will deploy the required networking resources to connect with other cloud providers. The high level constructs of this lab include a VCN, DRG and FastConnect to connect to another other cloud providers. Be aware that this lab is used to deploy a simple configuration and additional network and security considerations will need to be made to deploy these services in a production environment.

Be sure to review [Overview of Networking](https://docs.cloud.oracle.com/iaas/Content/Network/Concepts/overview.htm) to gain a full understanding of the network components and their relationships.

NOTE: This lab will connect to Azure as the 3rd party cloud platform. The steps to connect other cloud providers such as AWS and GCP will follow a very similar process.

![Reference Diagram](images/multicloud-topology.jpg)

Estimated Workshop Time: 1 hour

  [](youtube:zNKxJjkq0Pw)

### Prerequisites

This lab assumes you have:

* Administrative Access to an Oracle Cloud Tenancy

* (Option 1)  [A FastConnect Partner](https://www.oracle.com/cloud/networking/fastconnect/providers/) that is available in your OCI region and your preferred 3rd party cloud service provider.

* (Option 2) A supported OCI and Azure region. [Supported regions are documented here](https://learn.microsoft.com/en-us/azure/virtual-machines/workloads/oracle/oracle-oci-overview#region-availability).

### Objectives

In this workshop, you will learn how to:

* Deploy a Virtual Cloud Network (VCN)
* Deploy a Dynamic Routing Gateway (DRG)
* Setup a FastConnect Connection
* Verify MultiCloud Connectivity

## OCI Reference Acronym List

**DRG** - Dynamic Routing Gateway

**VCN** - Virtual Cloud Network

**OCI** - Oracle Cloud Infrastructure