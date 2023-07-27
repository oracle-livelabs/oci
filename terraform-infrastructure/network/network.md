# Setting up Highly Available and Secure Infrastructure with Terraform

## Working with Networking on Terraform

### Introduction

This lab walks you through how to set up Networking Infrastruce as code using Terraform on OCI. 

Estimated Time: 30 minutes

### About <Product/Technology> 
We will be using OCI's Virtual Cloud Network, Compute instances, and Load Balancers along side Terraform. 

### Objectives

*List objectives for this lab using the format below*

In this lab, you will:
* Learn about 
* Learn how to provision OCI resources through Terraform
* Objective 3

### Prerequisites (Optional)

*List the prerequisites for this lab using the format below. Fill in whatever knowledge, accounts, etc. is needed to complete the lab. Do NOT list each previous lab as a prerequisite.*

This lab assumes you have:
* An Oracle Cloud account
* Familiarity with Networking is desirable, but not required
* Some understanding of cloud, networking, Terraform terms is helpful
* Familiarity with Oracle Cloud Infrastructure (OCI) is helpful


*Below, is the "fold"--where items are collapsed by default.*

<<<<<<< Updated upstream
## Task 1: Terraform .tf files for Networking
In Terrafrom, there are mulitple files that are created to define input variables for infrastructure deployment. It is one of several ways to provide values to the variables used in a Terrafrom configuration. In this section we will be using the ".tf" extension which stands for Terrafrom.

### 1. Terraform .tf files in the Terrafrom Environment
In the terraform environment provided for this lab, you can see that there are mulitple files with the .tf extension. These files contain the infrastructure-as-code (IAC) instructions that define and describe the resources and services you want to provision and manage in OCI.

We will be going throught the main.tf and variables.tf files in the terraform environment. 

 ![ssh-keygen-windows](images/ssh-keygen-windows.png)

### 2. Terrafrom defining the OCI Provider in the Terraform
The Terrafrom main.tf file is the main entry point for the Terraform configuration. It contains the core infrastructure definitions for the Terraform environment. 

The first definition in this files is the provider. In Terraform, a "provider" is a plugin that allows Terraform to interact with a specific cloud or infrastructure platform to create, manage, and delete resources. The provider is an essential component as it enables Terraform to abstract the underlying APIs of various cloud providers. In this lab we will be defining the provider using the main.tf and provider.auto.tfvars files. 

1. Step 1
Open the provider.auto.tfvars file. In the file you will see a Terraform configuration block that defines the necessary configurations to authenticate and interact with the Oracle Cloud Infrastructure APIs

![Image alt text](images/sample1.png)

In the file replace the tenancy, and userid with the corresponding ocids 



## Task 2: Terrafrom .tfvars file for Networking 

In Terrafrom, there are mulitple files that are created to define input variables for infrastructure deployment. It is one of several ways to provide values to the variables used in a Terrafrom configuration. In this secrtion we will be using the ".tfvars" extension which stands for Terraform Variables. The "terrafrom.tfvars" file allows you to define variables in a seperate file rather than hardcoding them directly into the configuration of a resource. This seperation helps keep sensitive infromation out of the main configuration files, making it easier to manage and share the codebase. 

### 1. Terraform terrafrom.tfvars file
=======
## Task 1: Terrafrom Variables for Networking

The SSH (Secure Shell) protocol is a method for secure remote login from one computer to another. SSH enables secure system administration and file transfers over insecure networks using encryption to secure the connections between endpoints. SSH keys are an important part of securely accessing Oracle Cloud Infrastructure compute instances in the cloud.

### 1. Terraform variables.tf




## Task 2: Concise Task Description

1. Step 1 - tables sample

  Use tables sparingly:

  | Column 1 | Column 2 | Column 3 |
  | --- | --- | --- |
  | 1 | Some text or a link | More text  |
  | 2 |Some text or a link | More text |
  | 3 | Some text or a link | More text |

2. You can also include bulleted lists - make sure to indent 4 spaces:

    - List item 1
    - List item 2

3. Code examples

    ```
    Adding code examples
  	Indentation is important for the code example to appear inside the step
    Multiple lines of code
  	<copy>Enclose the text you want to copy in <copy></copy>.</copy>
    ```

4. Code examples that include variables

	```
  <copy>ssh -i <ssh-key-file></copy>
  ```
>>>>>>> Stashed changes

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Month Year>
