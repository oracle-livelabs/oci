# Introduction

## About this Workshop

Oracle Cloud Infrastructure (OCI) Networking is a core tenet of a MultiCloud architecture. This Hands On Lab will walk through the steps required to connect to 3rd party cloud infrastructure such as Azure, GCP and AWS. The Oracle Cloud networking resources deployed in this lab will include a VCN, DRG and FastConnect. Be aware that this lab is used to deploy a simple configuration and additional network and security considerations are needed for a production environment. Make sure to review [Overview of Networking](https://docs.cloud.oracle.com/iaas/Content/Network/Concepts/overview.htm) to gain a full understanding of Oracle Cloud's network components and their relationships.

# Prerequisites

This lab assumes you have:

* Administrative Access to an Oracle Cloud Tenancy

* **Option 1 -**  Access to a [FastConnect Partner](https://www.oracle.com/cloud/networking/fastconnect/providers/) that is available for your Oracle Cloud region and 3rd party cloud service provider.

* **Option 2 -** Access to an Azure subscription with a supported Azure Interconnect region [Supported regions are documented here](https://learn.microsoft.com/en-us/azure/virtual-machines/workloads/oracle/oracle-oci-overview#region-availability).

    > **Note:** If your OCI or Azure region does not support Azure Interconnect use **Option 1** to connect to Azure.

# Architecture Diagram

![Deployment Diagram](images/multicloud-topology.png)

  > **Note:** This architecture diagram shows Azure as the 3rd party cloud. Connecting clouds other than Azure will follow a similar connectivity strategy.


# Objectives

In this workshop, you will learn how to:

* Deploy a Virtual Cloud Network (VCN)
* Deploy a Dynamic Routing Gateway (DRG)
* Setup a FastConnect Connection
* Deploy a Virtual Machine
* Verify MultiCloud Connectivity