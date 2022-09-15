# Provision the Infrastructure using Resource Manager

## Introduction

In this lab exercise, you will provision all the Infrastructure resources used by your applications through Infrastructure As Code (IaC) using [Terraform](https://www.terraform.io) on [Oracle Cloud Infrastructure Resource Manager service (ORM)](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Concepts/resourcemanager.htm).  

#### Terraform
Terraform is an open-source tool that allow you to write infrastructure as code using declarative configuration files that will represent the state of your infrastructure. 

The Landing Zone is written entirely in Terraform and can be extended by modifying the stack or writing additional Terraform that builds upon the base configuration.

#### Resource Manager
OCI Resource Manager allows you to share and manage Terraform configurations and state files across multiple teams and platforms. 

You will use it in this lab to deploy terraform stacks without needing to install any tools locally.

Estimated time: 30 minutes

### Objectives

In this lab, you will:

* Create an ORM Stack and configuration from the baseline landing zone template
* Provision Infrastructure: Network, IAM, Security

### Prerequisites

* An Oracle Free Tier(Trial), Paid or LiveLabs Cloud Account
* User that belongs to the Administrator group or has granted privileges to manage multiple OCI resources (IAM, ORM, Network, etc).


## Task 1: Create ORM Stack

The first step is to create a OCI Resource Manager Stack. The Stack is a collection of Oracle Cloud Infrastructure resources corresponding to a given Terraform configuration. Each stack resides in the compartment you specify, in a single region; however, resources on a given stack can be deployed across multiple regions. An OCID (unique identifier) is assigned to each stack.

1. Open up Resource Manager service. You can click directly on Resource Manager in the navigation path menu, otherwise, Go back to the main Navigation Menu -> Developer Services -> Resource Manager.

2. In the stack section, click create stack and choose template as the origin of the Terraform configuration.
    ![Create Stack](./images/create-stack.png)

3. Click select template and click on the Enterprise scale baseline landing zone under the architecture tab.
    ![Select Orm Template](./images/browse-orm-templates.png)

4. In the Stack Information section, enter:

    |Varibale Name|Value|
    |--|--|
    |Parent compartment name|`LZ_Parent_Demo`|
    |Create in Compartment| tenancy (root)|
    |Terraform Version| leave the default option if you have the option to select it|

5. Click on Next in the bottom of the page to go to the `2. Configure variables` page.

## Task 2: Configure Variables

* Sample Variable Values   
    |Variable|Value|
    |--|--|
    |Tag cost center|`Example_tag_cost_center`|
    |Tag geo location|`Example_tag_geo_location`|
    |Parent compartment name|`LZ_Parent_Demo`|
    |Global Resources Control|Check the Box|
    |Break glass user email list|example@test.com|
    |VCN CIDR block|10.0.0.0/16|
    |VCN DNS label|vcn|
    |Shared service subnet CIDR block|10.0.6.0/24|
    |Shared service subnet DNS label|shared|
    |Bastion client CIDR block allow list|10.0.0.0/16, 10.0.0.0/24|
    |Bastion subnet CIDR block|10.0.7.0/24|
    |Use FastConnect?|Check the Box|
    |FastConnect provider|Microsoft Azure|
    |FastConnect routing policy|GLOBAL|
    |Virtual circuit cross connect mappings - customer BGP peering IP|10.0.0.22/30|
    |Virtual circuit cross connect mappings - Oracle BPG peering IP|10.0.0.21/30|
    |Virtual circuit cross connect mappings - customer secondary BGP peering IP|10.0.0.26/30|
    |Virtual circuit cross connect mappings - Oracle secondary BGP peering IP|10.0.0.25/30|
    |Provider service key name|aaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee|
    |Security Admin Email Endpoints|example@test.com|
    |Budget Admin Email Endpoints|example@test.com|
    |Network Admin Email Endpoints|example@test.com|
    
* Enter Tagging and Compartment Variables

    * The tag fields correspond to freeform tags that are applied to resources created within the template. These can be used to identify the cost center and location of the resources. Each resource created is also given a default assigned value for the Description tag.
    * The parent compartment and other compartment name variables are used to rename the compartment structure. This includes the parent level compartment, security, network, and workload-specific compartments.

    ![Tagging and Compartment Vars](./images/variables-tagging-compartment.png)

2. Enter IAM Vars including break glass user email list. Group name variables can be left as default.

    * The break glass user is an IAM user created with full administrator permissions. Entering a valid email here will create the user and send an email allowing access.
    * IAM lets you control who has access to specific cloud resources and what type of access a group of users can have. The Baseline Landing Zone provisions IAM groups with established roles and access levels. The group names listed are the default names but can be overridden by updating using the Terraform variables. 

    ![IAM Vars](./images/variables-iam.png)

3. Enter Networking variables for the VCN and subnet configuration

    * The landing zone provisions a VCN, nat gateway, internet gateway, and shared services subnets. You will need to input cidr blocks and dns labels.
    * The landing zone also provides options for connectivity using an Ipsec tunnel or a Fastconnect connection. In this lab however, it can remain disabled.

    ![VCN Vars 2](./images/LZ_Stack_Variable_2.png)

4. Enter Security variables for Cloud Guard, Vulnerability Scanning Service, VCN Flow Logging, and Audit Logs.

    * Cloud Guard is an OCI resource that detects misconfigured resources and insecure activity across tenants. It enables security administrators to triage and resolve cloud security issues. Security inconsistencies can be automatically resolved with out-of-the-box security recipes.
    * VCN Flow Logs for the provisioned VCN subnets can be viewed in the Logging Analytics Dashboard. You can also enter subnet ocids to log traffic for externally created subnets. Audit Logging can also be enabled using the same variable which enables logging and stores them in an archive bucket.
    * The bastion provides restricted and time-limited access to cloud resources without public-facing endpoints. There are two types of bastion sessions, managed SSH and port forwarding, which depends on the type of target resource. Input the cidr of the bastion subnet as well as the cidr blocks the bastion can connect to.

    ![VCN Vars 3](./images/LZ_Stack_Variable_3.png)

5. Enter the sample variables for creation of Bastions, Dynamic Routing Gateway(DRG) and Monitoring. 

    ![VCN Vars 4](./images/LZ_Stack_Variable_4.png)
    ![VCN Vars 5](./images/LZ_Stack_Variable_5.png)
    ![VCN Vars 6](./images/LZ_Stack_Variable_6.png)
    

6. Create the Stack.
    ![VCN Vars 7](./images/LZ_Stack_Variable_7.png)
    

## Task 3: Provisioning the Infrastructure

1. After creating the Stack, you can perform some Terraform operations that are also known as `Jobs` in OCI. By clicking on `Plan` button and defining a name for your plan, e.g. `deploy1` Resource Manager will parse your Terraform configuration and creates an execution plan for the associated stack. The execution plan lists the sequence of specific actions planned to provision your Oracle Cloud Infrastructure resources. The execution plan is handed off to the apply job, which then executes the instructions.
    ![ORM Stack - jobs menu](./images/oci-orm-jobs-menu.png)
    ![ORM Stack - plan - deploy1](./images/oci-orm-plan-deploy1.png)


2. Once the job state is `Succeeded`, click on `Stack Details` navigation menu on the top of the page to go back to the previous page. 
    ![ORM Stack - plan - deploy1 succeed](./images/oci-orm-plan-deploy1-succeed.png)


3. Then, click `Apply` and enter a name (e.g `deploy1`), select the Apply Job Plan resolution that was previously created (`deploy1`). This will apply the execution plan to create (or modify) your Oracle Cloud Infrastructure resources. This operation will take some time to complete (15-20 minutes) as it is going to provision all infrastructure resources needed by this lab (IAM, Network, Logging, OKE).

4. After that, if you want to make any change to the variables, you can go back to the Stack details page, click on `Edit` button to change them. Then, you need to run Plan and Apply jobs to make these changes into the infrastructure. Always review the execution plan as some resources are immutable and they can be completely destroyed and recreated by Terraform/ORM after hitting `Apply`.

Note: in case of quota/service limit/permission issues, Apply job will fail and partial resources will be provisioned. Click on Destroy button will trigger the job to remove provisioned resources. 

You may now proceed to the next lab.

<!-- ## Acknowledgements -->

<!-- * **Author** - Lucas Gomes
* **Contributors** -  Jonathan Schreiber, Rishi Johari, Tim Graves
* **Last Updated By/Date** - Lucas Gomes, July 2021 -->
