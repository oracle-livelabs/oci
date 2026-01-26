# Introduction

## About this Workshop

![OCI Core Landing Zone Logo](images/landing-zone-icon.png "OCI Core Landing Zone Logo of helicopter approaching Oracle shaped landing pad")

This set of labs will walk you through deploying a secure cloud architecture, compliant with the [CIS OCI Foundations Benchmark v3.0](https://www.cisecurity.org/benchmark/oracle_cloud/). Upon completion of the labs, a full set of OCI resources will be created as a base to build a secure enterprise workload.

Estimated Workshop Time: 1 Hour 30 Minutes

### Objectives

- Upload Terraform files to OCI Resource Manager
- Configure variables to customize Landing Zone
- Produce and Inspect Terraform Plan
- Apply Plan to OCI tenancy
- Modify Landing Zone via Terraform
- Terraform Destroy to reset

### Prerequisites

This lab has the following pre-requisites:

- A [free tier](https://www.oracle.com/cloud/free/) or paid OCI tenancy
- An account in the Administrators group in OCI

## The OCI Core Landing Zone Architecture

### Overview

The OCI Core Landing Zone is an architecture and related Terraform files [publicly hosted on GitHub](https://github.com/oci-landing-zones/terraform-oci-core-landingzone). The output can be modified by changing configurations in a [variables.tfvars](https://github.com/oci-landing-zones/terraform-oci-core-landingzone/blob/main/VARIABLES.md) file, or as we will do, entering the Terraform code into the [OCI Resource Manager](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Concepts/resourcemanager.htm) and entering configurations in the provided GUI. This will provision a full set of resources as a secure baseline for development or production workloads in OCI.

### Cost

All resources deployed by the Landing Zone are included services, meaning they are provided at no cost, with one exception which will not be used for this lab.

### Architecture Components

The Landing Zone will deploy a full set of resources suitable for a production cloud, including:

- Identity and Access Management (IAM) Controls
- One or More Virtual Cloud Networks (VCNs)
- Logging Services
- OCI Bastion Service
- Cloud Events Rules
- Alarms
- OCI Notifications
- OCI Object Storage
- Budget Controls

The resulting architecture will look similar to this diagram: ![Simple Architecture](images/arch-simple.svg "Simple Landing Zone architecture")

### IAM Components

One of the best features of the Landing Zone is a pre-defined set of groups, policies, and compartments are created for you. These resources have been created to fit most use cases and provide a solid base for enacting [separation of duties](#OnSeparationofDuties).

#### Compartments

[Compartments](https://www.ateam-oracle.com/post/oracle-cloud-infrastructure-compartments) are flexible, logical containers that hold different resources. In the Core Landing Zone, compartments are used to enable segregation of duties by separating resources based on administrative roles. Different groups will be granted permissions to these compartments based on their duties. An optional (but recommended) enclosing compartment is configurable so multiple Landing Zones can be deployed in a single cloud tenancy. A common use case for this is using enclosing compartments for environment type (Development, Testing, Production) with a different Landing Zone in each environment's enclosing compartment.

Compartments include:

- Network
- Security
- Application Development
- Database
- _Exadata (optional)_

#### Groups

Groups are the IAM objects on which permissions are granted. Groups contain one or more members. A user's membership will allow them to perform different functions in OCI. Without being a member of at least one group with permissions assigned, users will have no permissions within OCI.

Groups provisioned by the Landing Zone are:

- Network Admins
- Security Admins
- AppDev (Application Development) Admins
- Database Admins
- IAM Admins
- Cost Admins
- Auditors
- Cred Admins
- Announcement Readers
- Access Gov Admins
- Storage Admins
- _Exadata Admins (optional)_

#### Policies

The connector between groups, compartments, and permissions in OCI are called [_Policies_](https://docs.oracle.com/en-us/iaas/Content/Identity/policieshow/how-policies-work.htm#how_policies_work). Policies are human-readable statements that combine a group, a location (compartment), a resource (or set of resources), and a verb defining the level of access. The policy defining tenant-level Administrator access looks like this:

```Allow Administrators to manage all-resources in tenancy```

This policy uses __tenancy__ as the location as it encompasses all compartments in the tenant. If we want to give the group _SampleAdmins_ full control of all resources in the Sample compartment, it would look like this:

```Allow ExampleAdmins to manage all-resources in compartment Example```

These are a few simple examples. A more detailed explanation of policies in OCI can be found in [the OCI Documentation for IAM Policies](https://docs.oracle.com/en-us/iaas/Content/Identity/policieshow/how-policies-work.htm).

## On Separation of Duties

A quick note on the principal of separation of duties as it pertains to the Landing Zone. Administrators with full access to all resources should be kept to the bare minimum to maintain security. Responsibility should be spread across multiple people and roles to prevent misuse. Administrators should be granted the barest set of permissions as required to perform their duties as per the principal of least privilege. The Landing Zone is designed around this concept, which is the driving idea behind the design of compartments and IAM objects (groups, users, policies).

An effort has been made to provide a default set of useful groups to carry out common roles across organizations. However, it is unlikely that this or any application will fit all possible configurations without any customization. The policies dictating permissions for these groups should be modified to suit organizational needs. What should _not_ be done is assigning all roles to any individuals, granting them elevated access.

## A Note About Terraform

The OCI Core Landing Zone uses [Terraform](https://developer.hashicorp.com/terraform/intro) to deploy all resources into a tenancy. Terraform is an Infrastructure as Code tool used for provisioning cloud objects via automation. This simplifies the setup of the Landing Zone and shortens the time to production in OCI.

Terraform can be used with a variety of clients to fit different deployment methods. For this lab, we will leverage [OCI Resource Manager](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Concepts/resourcemanager.htm) to simplify the use of Terraform in OCI. The OCI Resource Manager is an Oracle-managed Terraform service that uses configuration files to automate deployment and operations for resources using Terraform. It reduces the complexity of using Terraform in OCI as well as storing state in the cloud instead of on a developer laptop.

Most things in OCI can be provisioned with Terraform. While beyond the scope of this lab, more information on [using Terraform in OCI](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraform.htm).

## Acknowledgements

- __Author__ - KC Flynn
- __Contributors__ - Andre Correa, Johannes Murmann, Josh Hammer, Olaf Heimburger
- __Last Updated By/Date__ - KC Flynn September 2025
