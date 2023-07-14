# Setting up Highly Available and Secure Infrastructure with Terraform

## Setting up your Tenancy

### Introduction

This lab walks you through how to set up Infrastruce as code using Terraform on OCI. 

Estimated Time: 20 minutes

### Objectives

In this lab, you will:
* Generate and Access SSH public and private Keys
* Generate an API Key on the OCI Console
* Create Compartments
* Gather OCIDS

### Prerequisites

This lab assumes you have:
* An Oracle Cloud account



## Task 1: Generate SSH Key

The SSH (Secure Shell) protocol is a method for secure remote login from one computer to another. SSH enables secure system administration and file transfers over insecure networks using encryption to secure the connections between endpoints. SSH keys are an important part of securely accessing Oracle Cloud Infrastructure compute instances in the cloud.

If you already have an SSH key pair, you may use that to connect to your environment.

### 1. **On Mac**

	![ssh-keygen](images/ssh-keygen.png)

  ```
  ssh-keygen <copy></copy>
  ```

  On Mac, start up the terminal by using cmd + space and typing terminal or cmd + shift + U and click on terminal

  Once in the terminal type ssh-key or copy and paste the command into the terminal, press enter. You will prompted to enter file to save your key. pressing enter will select default in your .ssh folder. Press enter twice for no passphrase. Remember where it is saved as we will reference this later when creating instances.




### 2. **On Windows 10**

  Open a Powershell command window on your Windows 10 system by clicking it’s icon/tile or by typing ‘powershell’ in the search field in the Start bar.

  ![ssh-keygen-windows](images/ssh-keygen-windows.png)

  Once in the terminal type ssh-key or copy and paste the command into the terminal, press enter. You will prompted to enter file to save your key. pressing enter will select default in your .ssh folder. Press enter twice for no passphrase. Remember where it is saved as we will reference this later when creating instances.

  ```
  ssh-keygen <copy> </copy>
  ```

  ![verify-keygen-windows](images/verify-keygen-windows.png)

  Verify that your keys exist

  ```
  cd .ssh <copy></copy>
  ```
  ```
  ls <copy></copy>
  ```
  ```
  cat id_rsa.pub <copy></copy>
  ```

  ![confirm-keygen-windows](images/confirm-keygen-windows.png)


## Task 2: Generate an API Key on the OCI Console

1. Step 1 - 

  ![profile](images/profile.png)

    Once logged in to your tenancy click on your profile on the top right corner and click on profile.

2. Step 2

  ![api](images/api.png)

    On the lower left side you will see resources, click on API keys.

    Next, click on Add API key.

3. Step 3

  ![api-gen](images/api-gen.png)

    An API key is an RSA key pair in PEM format used for signing API requests. You can generate the key pair here and download the private key. If you already have a key pair, you can choose to upload or paste your public key file instead.

    Make sure to click on generate API key pair. 
    
    Click on Download private key and save it. 
    
    Click on Add.

    This will add the new API Key. We will be referencing this later along with the Fingerprint.

## Task 3: Create Compartment

## Task 4: Gather OCIDS

## Task 5: Setting up Terraform

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [Required Keys and OCIDs](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm#Required_Keys_and_OCIDs)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Month Year>
