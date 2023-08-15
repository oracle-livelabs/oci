# Deploy Lab using Oracle Resource Manager

## Introduction

In this lab you will be using Oracle Resource Manager to deploy required virtual cloud networks (VCNs), subnets in each VCN, dynamic routing gateways (DRG), route tables, compute instances and FortiGate instances to support traffic between VCNs.

**PLEASE READ**: If you wish to deploy the configuration manually, please skip **Lab0** and continue from **Lab1** onwards.

Estimated Lab Time: 10 minutes.

### Objectives

   - Create Stack using Oracle Resource Manager
   - Validate Terraform Plan and Apply
   - Connect to Instances

### Prerequisites

- Oracle Cloud Infrastructure paid account credentials (User, Password, Tenant, and Compartment)
- Oracle Marketplace Listings Access
    - **FortiGate** paid listing access required for this **Lab0** 

## Task 1: Login and Create Stack using Resource Manager

You will be using Terraform to create your lab environment.

1.  Click on the link below to download the zip file which you need to build your environment.  

    - Click here: [fortigate-live-labs.zip](https://objectstorage.us-ashburn-1.oraclecloud.com/p/i4Rchb3xOybkcRclsdJgpzKGqA5YgM_12owPKYAmE9XoSYfQENY4C-5NviXuiwvy/n/partners/b/files/o/fortigate-live-labs.zip) 
        - Packaged terraform **FortiGate High Availability** use-case.
        - **PAR URL** is valid until **Dec, 2025**.

    **Please Read**: You can also download this zip folder locally and update required variables to support your required version/listing of Firewall. 

2.  Save in your local machine's downloads folder.

3.  Open up the hamburger menu in the left-hand corner.  Choose **Developer Services > Stacks**. Click on **Stacks**: 

    ![Oracle Resource Manager Home Page](./images/orm-home-page.png " ")

4. Choose the right compartment from left hand side drop-down and appropriate region from top right drop-down and click the **Create Stack** button

    ![Oracle Resource Manager Create Stack Page](./images/create-stack-page.png " ")

5.  Select **My Configuration**, choose the **.ZIP FILE** button, click the **Browse** link and select the zip file (fortigate-live-labs.zip) that you downloaded. Click **Select**.

    ![Oracle Resource Manager Create Stack Workflow with Zip File Upload](./images/myconfiguration-step1.png " ")

    Enter the following information and accept all the defaults

    - **Name**: Enter a user-friendly name for your **stack** 

    - **Compartment**: Select the Compartment where you want to create your stack. 

    - **Terraform Version**: Validated version for this stack is **1.0.x**

6.  Click **Next**.

    **Please Read**: Partner now supports flex shapes so Update shapes as **VM.Standard.E3.Flex** for firewall Compute Shape and **VM.Standard.E4.Flex** for Spoke Compute Shape. 

    ![Oracle Resource Manager Create Stack Workflow with adding variables](./images/myconfiguration-step3.png " ")

    Enter/Select the following minimum information. Some information may already be pre-populated. Do not change the pre-populated info.

    **Compute Compartment**: Select Compute Compartment from drop-down where you would like to create compute instances.  
    
    **Note**: This use-case recommends selecting either your root compartment or your own compartment which is one level below root to support HA failover on FortiGate instances. 

    **Availability Domain:** Select Appropriate AD from drop-down. 

    **Public SSH Key**: Paste the public key string which you would like to use to connect VMs via your private-key.

    **Network Compartment**: Select Network Compartment from drop-down where you would like to create networking components i.e. VCN, subnets, route tables, DRG etc. 

    **Note:** Keep the Network Strategy as **Create New VCN and Subnet** as default value, if you chose to modify the code you can do so to support existing VCN/Subnet values. 

7. Click **Create** to create your stack. Now you can move next steps to create your environment.

    ![Oracle Resource Manager Create Stack Workflow with reviewing variables](./images/final-create-stack.png " ")

## Task 2: Terraform Plan and Apply

When using Resource Manager to deploy an environment, you need to execute a terraform **plan** and **apply**. Let's do that now.

1.  [OPTIONAL] Click **Plan** to validate your configuration. This takes about a minute, please be patient.

    ![Terraform Plan Option](./images/terraform-plan.png " ")

2.  At the top of your page, click on **Stack Details**.  Click the button, **Apply**. This will create your instances and required configuration.

    ![Terraform Apply](./images/terraform-apply.png " ")

3.  Once this job succeeds, your environment is created! Time to login to your instance to finish the configuration.

    ![Terraform Apply Successful Output](./images/terraform-apply-success.png " ")

    **Note**: Stack will deploy **FortiGate Next Gen Firewall (4 cores)** paid listing instances to support this use-case.

## Task 3: Connect to your instances

1. Based on your laptop config, choose the appropriate steps to connect to your instances. 

   ![Created Instances using Terraform](./images/final-instances.png " ")

**NOTE**: It will take few minutes before you can connect to ssh-daemon becomes available. If you are unable to connect then make sure you have a valid key, wait a few minutes, and try again.

***Congratulations! You have successfully completed the lab.***

**PLEASE READ**: You must skip **Lab 1 to Lab2** now and proceed to **Lab 3** i.e. **Configure FortiGate**. 

You may now [proceed to the next lab](#next).

## Learn More
1. [OCI Training](https://cloud.oracle.com/en_US/iaas/training)
2. [Familiarity with OCI console](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm)
3. [Overview of Networking](https://docs.us-phoenix-1.oraclecloud.com/Content/Network/Concepts/overview.htm)
4. [Familiarity with Compartment](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/concepts.htm)
5. [Connecting to a compute instance](https://docs.us-phoenix-1.oraclecloud.com/Content/Compute/Tasks/accessinginstance.htm)
6. [OCI FortiGate Administration Guide](https://docs.fortinet.com/document/fortigate-public-cloud/7.0.0/oci-administration-guide/16658/about-fortigate-vm-for-oci)

## Acknowledgements

- **Author** - Arun Poonia, Principal Solutions Architect
- **Adapted by** -  Fortinet
- **Contributors** - N/A
- **Last Updated By/Date** - Arun Poonia, Aug 2023