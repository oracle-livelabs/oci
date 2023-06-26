# Verify MultiCloud Connectivity

## Introduction

In this lab we will deploy the a Virtual Machine and then use it to test and verify connectivity over the FastConnect. Be aware that this lab will connect to Azure as the 3rd party cloud provider. The steps to connect other cloud providers such as AWS and GCP will follow a similar process.

Estimated Lab Time: 20 minutes

### Objectives

In this lab, you will:

* Prepare Cloud Shell
* Launch a Virtual Machine within the VCN created in Lab 1
* Connect to the Virtual Machine
* Test Connectivity

Virtual Machine QuickStart:[Quickstart Video](youtube:8WWpGHxvhw4:large)

## Task 1: Prepare CloudShell

1. Go to the top right hand corner of the UI and click on **Developer Tools -> Cloud Shell**

2. Generate a new SSH key by running the **ssh-keygen** command. Leave all of the values as their default (empty).

3. Run the command **cat ~/.ssh/id_rsa** and copy the contents to your clipboard or a note space. This will be used in the next step when creating a virtual machine.

## Task 2: Launch a Virtual Machine

1. On the Home Page under **Launch Resources**, click on **Create a VM Instance**.

2. On the **Create Compute Instance** page, most of the options will be left as default except for the following.

    |                  **Field**              |    **Vaue**  |
    |----------------------------------------|:------------:|
    |Name |    Connectivity_Test_Instance    |
    |Create in Compartment |  *lab compartment*    |

    Verify the Network Configuration:

    1. Under **Networking: Virtual Cloud Network** - Verify the correct compartment and select the VCN created earlier in the lab.
    2. Under **Networking: Subnet** - Select the Public Subnet of the VCN.
    3. Under **Public IPv4 Address** - Select "Assign a Public IPv4 Address".

    Add the Public SSH Key:

    1. Under **Add SSH Configuration**, select "Paste Public Keys" and add the public key you created from the CloudShell instance.

    Click **Create** and wait for the instance state to be "Running". Make note of the Public IPv4 Address of the instance under **Primary VNIC**.

## Task 3: Log into the Virtual Machine with CloudShell

1. Go back to the CloudShell instance by navigating to the top right of the OCI Console and going UI and click on **Developer Tools -> Cloud Shell**

2. Run the following command **ssh opc@*public_ip***, where public_ip is the public IP address of your Virtual Machine. Now you are logged in via SSH to the virtual machine. In the next step we will run a series of tests to verify connectivity with the 3rd party cloud provider.

## Learn More

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)