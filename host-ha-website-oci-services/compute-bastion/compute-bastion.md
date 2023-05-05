# Provisioning a Compute Instance and Using a Bastion Host

## Introduction

This lab will walk you through how to create Compute instances. More specifically, it will show you how to create a Bastion host in a public subnet that will used to connect to resources in a private subnet.

Estimated Lab Time: -- minutes

### Objectives

In this lab, you will:
* Learn how to provision Compute instances
* Connect to a Bastion host in a public subnet

### Prerequisites

This lab assumes you have:
* An Oracle Cloud account
* All previous labs successfully completed

## Task 1: Creating a Compute Instance for the Bastion Host

1. Click Navigation



  Select Compute



  Select Instances

	![Image alt text](images/compute-instances.png)

2. Click 'Create Instance'

3. Fill out the Instance Name, Compartment, and Availability Domain
    - Name: BastionHost-WordPress
    - Compartment: *Select Your Compartment*
    - Availability Domain: *Leave as AD1*

   ![Image alt text](images/compute-name-ad.png)

4. Edit the Image and Shape as Needed
    - For Image: Select **Oracle Linux 8**

    ![Image alt text](images/compute-image-shape.png)



    - For Shape: Select **VM.Standard.E4.Flex**

    ![Image alt text](images/compute-pick-shape.png)

5. Review the Networking Settings
    - VCN: Select **WordPress-VCN**
    - Subnet: Select the **public subnet**
    - Public IPv4 Address: Select **Assign a public IPv4 address**

    ![Image alt text](images/compute-networking.png)

6. Add SSH Keys
   - Here, select 'Generate a key pair for me' and save both the public and private SSH keys to your computer.
   - Optionally, you can upload or paste your own public SSH key if you already have your own key pair.

  ![Image alt text](images/compute-ssh.png)

7. Click 'Create'

    ![Image alt text](images/compute-provisioning.png)



    Wait for the instance to finish Provisioning. When it is done, the orange block will turn green.

    ![Image alt text](images/compute-running.png)



## Task 2: Connecting to the Bastion Host

1. Open up a Terminal
    > **Note:** This lab's tutorial will be using Mac Terminal, but you can use other tools such as PuTTY for Windows or even Cloud Shell on the OCI Console.



  ![Image alt text](images/sample1.png)

2. Take note of your Bastion instance's public IP address

  ![Image alt text](images/compute-public-ip.png)

3. In your Terminal, SSH into the Bastion host using the following format

  ```
  <copy>ssh -i <ssh-key-file> opc@<bastion_host_public_ip></copy>
  ```

  ![Image alt text](images/sample1.png)

    > **Note:** Make sure to specify the SSH private key file location or change your directories as needed

4. Verify you have connected to the Bastion host

  ![Image alt text](images/sample1.png)

## Acknowledgements
* **Author** - Bernie Castro, Cloud Engineer
* **Last Updated By/Date** - Bernie Castro, May 2023
