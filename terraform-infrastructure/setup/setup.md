# Set up Highly Available and Secure Infrastructure with Terraform on OCI

## Set up your Tenancy

### Introduction

This lab walks you through how to set up Infrastructure as code using Terraform on OCI. 

Estimated Time: 30 minutes

### Prerequisites

This lab assumes you have:
* An Oracle account
* Familiarity with Networking is desirable, but not required
* Some understanding of cloud, networking, and Terraform
* Familiarity with Oracle Cloud Infrastructure (OCI) is helpful

### Objectives

In this lab, you will:
* Generate and Access SSH public and private Keys
* Generate an API Key on the OCI Console
* Create Compartments
* Gather OCIDS


## Task 1: Generate SSH Key

The SSH (Secure Shell) protocol is a method for secure remote login from one computer to another. SSH enables secure system administration and file transfers over insecure networks using encryption to secure the connections between endpoints. SSH keys are an important part of securely accessing Oracle Cloud Infrastructure compute instances in the cloud.

If you already have an SSH key pair, you may use that to connect to your environment.

### **On Mac**

1. On Mac, start up the terminal by using cmd + space and typing terminal or cmd + shift + U and click on terminal

  Once in the terminal type ssh-keygen or copy and paste the command into the terminal, press enter. You will prompted to enter file to save your key. pressing enter will select default in your .ssh folder. Press enter twice for no passphrase. Remember where it is saved as we will reference this later when creating instances.

	![ssh-keygen](images/ssh-keygen.png)

    ```
    <copy>
    ssh-keygen
    </copy>
    ```

### **On Windows 10**

1. Open a Powershell command window on your Windows 10 system by clicking it’s icon/tile or by typing ‘powershell’ in the search field in the Start bar.

  ![ssh-keygen-windows](images/ssh-keygen-windows.png)

2. Once in the terminal type ssh-keygen or copy and paste the command into the terminal, press enter. You will prompted to enter file to save your key. pressing enter will select default in your .ssh folder. Press enter twice for no passphrase. Remember where it is saved as we will reference this later when creating instances.

    ```
    <copy>
    ssh-keygen
    </copy>
    ```

  ![verify-keygen-windows](images/verify-keygen-windows.png)

3. Verify that your keys exist, You can use these commands to verify.

    ```
    <copy>
    cd .ssh
    </copy>
    ```

    ```
    <copy>
    ls
    </copy>
    ```

    ```
    <copy>
    cat id_rsa.pub
    </copy>
    ```

  ![confirm-keygen-windows](images/confirm-keygen-windows.png)

## Task 2: Generate an API Key on the OCI Console

**Profile**

1. Once logged in to your tenancy click on your profile on the top right corner and click on profile.

  ![profile](images/profile.png)


**API keys**

2. On the lower left side you will see resources, click on API keys.

3. Next, click on Add API key.

  ![api](images/api.png)

**Add API key**

4. An API key is an RSA key pair in PEM format used for signing API requests. You can generate the key pair here and download the private key. If you already have a key pair, you can choose to upload or paste your public key file instead.

5. Make sure to click on generate API key pair. 
  
6. Click on Download private key and save it. 
    
7. Click on Add.

  ![api-gen](images/api-gen.png)

This will add the new API Key. Copy the configuration as we will be referencing this later.

Make sure to keep your API Key secure as this key allows you to access OCI resources.

  ![api-config](images/api-config.png)


## Task 3: Create Compartment

A compartment is a logical folder where you can organize your resources. For this Lab we will create a compartment to hold our resources like compute and networking services. 

**Navigation Menu**

1. Click on the Navigation menu on the top left of the console.

  ![navigation-menu](images/navigation-menu.png)

**Compartments**

2. Click on Identity & Security and then compartments under Identity

  ![navigation-compartment](images/navigation-compartment.png)

**Create Compartment**

3. Click on create compartment, Give it a name like terraform and a description (optional). 

4. Select parent compartment as the root compartment.

5. Click Create Compartment.

  ![compartment](images/compartment.png)

  ![create-compartment](images/create-compartment.png)

**Compartment OCID**

Most types of Oracle Cloud Infrastructure resources have an Oracle-assigned unique ID called an Oracle Cloud Identifier (OCID). It's included as part of the resource's information in both the Console and API.

The last piece of information needed from the compartment is the OCID.

6. Click on your newly created compartment and copy the OCID.

We will be referencing the OCID on the next Task. 

  ![compartment-ocid](images/compartment-ocid.png)

## Task 4: Setting up Terraform

Terraform is used to automate the process of provisioning and managing resources. We will install Terraform on to our local machine in this step. 

**Terraform**
    
1. Download [Terraform](https://www.terraform.io/downloads.html/)

    For macOS follow these steps:

    Follow the installation guide on how to install [Homebrew](https://brew.sh/)

    Then run these commands, 

    ```
    <copy>
    brew tap hashicorp/tap
    </copy>
    ```
    ```
    <copy>
    brew install hashicorp/tap/terraform
    </copy>
    ```
  
2. Download the [Terraform template](files/skeleton.zip). We will be using this for the rest of the lab. 

You may now **proceed to the next lab** 

## Learn More

* [Required Keys and OCIDs](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm#Required_Keys_and_OCIDs)
* [Compartments](https://docs.oracle.com/en/cloud/foundation/cloud_architecture/governance/compartments.html#what-is-a-compartment)
* [OCIDs](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/identifiers.htm)
* [OCI Provider](https://registry.terraform.io/providers/oracle/oci/latest/docs)
* [Terraform + OCI](https://developer.hashicorp.com/terraform/tutorials/oci-get-started)

## Acknowledgements
* **Author** - Germain Vargas, Cloud Engineer
* **Contributors** -  David Ortega, Cloud Engineer
* **Last Updated By/Date** - Germain Vargas, August 2023
