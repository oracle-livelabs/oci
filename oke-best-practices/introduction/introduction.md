# Deploy OKE with Simple and Advanced Terraform Modules with Best Practices

## About this Workshop

This workshop deploys Oracle Cloud Infrastructure Kubernetes Engine (OKE) through two independent delivery paths: Terraform CLI and OCI Resource Manager (ORM). Lab 1 uses the simple module source; Lab 2 uses the advanced module source. Lab 3 applies production-oriented practices and an optional Karpenter Provider for OCI (KPO) use case.

Estimated Time: 2 hours 30 minutes

> **Important:** OKE, compute, networking, and load-balancer resources can incur charges. Complete the destroy procedure for the path you used when you finish.

### Objectives

* Prepare OCI credentials, Terraform inputs, and a safe preflight plan.
* Deploy an OKE cluster with either Terraform CLI or OCI Resource Manager.
* Verify the cluster and safely remove test resources.
* Apply reusable-module, compartment, availability, node-pool, and KPO practices.

### Prerequisites

* An OCI tenancy, supported region, and compartment permissions for networking, OKE, compute, and Resource Manager.
* Terraform and OCI CLI, or OCI Cloud Shell, for the CLI paths.
* An SSH key pair; never upload a private key or commit it to the Terraform source archive.
* Available service limits and node-shape capacity in the selected region.

## Architecture

Terraform creates or references a VCN, subnets, OKE cluster, node pools, and an optional bastion. The advanced source separates VCN, OKE, and bastion concerns into reusable modules. KPO runs in a baseline OKE node pool and creates worker capacity through the flow `OCINodeClass` → `NodePool` → `NodeClaim` → KPO-launched worker node.

![OKE architecture](../lab1/images/1-OKEArchitecture.jpg "OKE architecture")

## Source Packages

* [Lab 1 CLI source](https://docs.oracle.com/en/learn/oke-clstr-trfm/files/oke_terraform_for_beginners.zip)
* [Lab 1 ORM source](https://docs.oracle.com/en/learn/oke-cluster-automation/files/oke_advanced_module_orm.zip)
* [Lab 2 CLI source](https://docs.oracle.com/en/learn/oke-cluster-automation/files/oke_advanced_module.zip)
* [Lab 2 ORM source](https://docs.oracle.com/en/learn/oke-cluster-automation/files/oke_advanced_module_orm.zip)

## Learn More

* [OKE advanced Terraform modules](https://docs.oracle.com/en/learn/oke-cluster-automation/index.html)
* [OCI Resource Manager documentation](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/home.htm)
* [Karpenter Provider for OCI documentation](https://docs.oracle.com/en-us/iaas/Content/ContEng/Tasks/contengkarpenter.htm)

## Acknowledgements

* **Authors** - Mahamat H. Guiagoussou, Payal Sharma, Matthew McDaniel, and John Adewumi
* **Last Updated** - July 2026
