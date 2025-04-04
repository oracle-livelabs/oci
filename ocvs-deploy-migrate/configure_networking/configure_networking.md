# Lab 1: Configure Network and Access Components

## Introduction

In this lab we will be setting up the Virtual cloud network which will contain our two servers. The Bastion host will be used to access the Jump Server securely.

**Estimated Time:** 30 minutes

**About Compute Service**

Oracle Cloud Infrastructure Compute lets you provision and manage compute hosts, known as instances. You can define instances as needed to meet your compute and application requirements.

### Prerequisites

This lab assumes you have:

* An Oracle account
* Familiarity with Networking is desirable, but not required
* Some understanding of cloud, networking
* Familiarity with Oracle Cloud Infrastructure (OCI) is helpful

### Objectives

In this lab, you will:

* Learn how to provision OCI resources.

## Task 1 - Create VCN

To Create a VCN on Oracle Cloud Infrastructure:

1. On the Oracle Cloud Infrastructure Console homepage, on the top left you will find the hamburger menu.

    ![hamburger menu](images/hambuger.png)

2. Select **Networking**, and then **Virtual cloud networks**.

    ![Networking](images/networking.png)

3. In the left hand pane, make sure you are in the right compartment and click on **Start VCN Wizard**.

    ![Compartment](images/compartment.png)

4. Select **Create VCN with Internet Connectivity** and **Start VCN Wizard**.

    ![VCNwizard](images/vcnwizard.png)

5. The VCN Wizard will help provision a VCN, a Public and Private Subnet, an Internet Gateway, NAT Gateway, and a Service Gateway. We will start by giving the VCN a name,

    ```text
    <copy>
    ocvs-livelab
    </copy>
    ```

    next, you will provide the **IPv4 CIDR Blocks**,

    ```text
    <copy>
    172.16.0.0/16
    </copy>
    ```

    ![vcnname](images/vcnname.png)

6. Add the **IPv4 CIDR Blocks** for the Public and Private subnets,

    ```text
    <copy>
    172.16.0.0/24
    </copy>
    ```

    ```text
    <copy>
    172.16.1.0/24
    </copy>
    ```

    ![VCN](images/subnets.png)

7. Click **Next** to review and create.

## Task 2 - Configure Security Rules and Routing

1. After provisioning your VCN. Click **View VCN**.

    ![provisioned](images/provisioned.png)

2. In the left hand pane, under **Resources**, click on **Security Lists** and select **security list for private subnet-ocvs-livelab**.

    ![securitylist](images/securitylist.png)

3. Click on **Security rules** and then **Add Ingress rules**.

    ![ingressrule](images/ingressrule.png)

    Here we will add the **Source CIDR** and **Port** to allow access through TCP for the jump server.

    ```text
    <copy>
    172.16.0.0/16
    </copy>
    ```

    ```text
    <copy>
    3389
    </copy>
    ```

    ![port3389](images/port3389.png)

4. Next we'll verify that our routing rules are correct. Return to the **VCN details** page, under the **Resources** list, Click on **Route Tables** and select **route table for private private subnet-ocvs-livelab**.

    ![routing](images/routing.png)

    Verify the rules for the NAT and Service Gateways. The NAT Gateway will gives cloud resources without public IP addresses access to the internet without exposing those resources to incoming internet connections. A service gateway lets resources in your VCN privately access specific Oracle services, without exposing the data to an internet gateway or NAT.

    ![gateways](images/gateways.png)

5. Finally, verify the rules for the Internet Gateway. Return to the Route tables list and Click on **default route table for ocvs-livelab**

    ![internetgateway](images/internetgateway.png)

    An internet gateway is an optional gateway you can add to your VCN to enable direct connectivity to the internet.

    ![internetrules](images/internetrules.png)

## Task 3: Generate SSH Key

The SSH (Secure Shell) protocol is a method for secure remote login from one computer to another. SSH enables secure system administration and file transfers over insecure networks using encryption to secure the connections between endpoints. SSH keys are an important part of securely accessing Oracle Cloud Infrastructure compute instances in the cloud.

If you already have an SSH key pair, you may use that to connect to your environment.

### **On Mac**

1. On Mac, start up the terminal by using cmd + space and typing terminal or cmd + shift + U and click on terminal

  Once in the terminal type ssh-keygen or copy and paste the command into the terminal, press enter. You will prompted to enter a file to save your key. pressing enter will select default in your .ssh folder. Press enter twice for no passphrase. Remember where it is saved as we will reference this later when creating instances.

    ![ssh-keygen](images/ssh-keygen.png)

    ```text
    <copy>
    ssh-keygen
    </copy>
    ```

### **On Windows 10**

1. Open a Powershell command window on your Windows 10 system by clicking it’s icon/tile or by typing ‘powershell’ in the search field in the Start bar.

  ![ssh-keygen-windows](images/ssh-keygen-windows.png)

2. Once in the terminal type ssh-keygen or copy and paste the command into the terminal, press enter. You will prompted to enter file to save your key. pressing enter will select default in your .ssh folder. Press enter twice for no passphrase. Remember where it is saved as we will reference this later when creating instances.

    ```text
    <copy>
    ssh-keygen
    </copy>
    ```

  ![verify-keygen-windows](images/verify-keygen-windows.png)

### **Verifying the Keys**

To verify that your keys exist, You can use the following commands.

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

## Task 4 - Deploy Bastion and Jump Server Instance

1. We will be deploying a Bastion first, a Bastion instance allows you to access to the private subnet we created in the last task. Lets start by going to the hamburger menu on the top left, click on **compute** and then **instances**.

    ![instance](images/instance.png)

2. Click on **Create Instance**. Fill in the **name** for the bastion host and ensure that your in the correct **compartment**.

    ![bastioninfo](images/bastioninfo.png)

3. Click on **change image**.

    ![changeimage](images/changeimage.png)

    Select **Oracle Linux**,

    ![linux](images/linux.png)

    Select the **Oracle linux 8** image and click **Select image**.

    ![linuximage](images/linuximage.png)

4. Next, we will be selecting the shape for our bastion. Click on **Change shape**.

    ![changeshape](images/changeshape.png)

    Select the following:

    **Instance type**
    - Virtual machine

    **Shape series**
    - AMD

    **Shape name**
    - VM.Standard.E4.Flex

    Click on **Select shape** when finished.

    ![linuxshape](images/linuxshape.png)

5. For **Primary VNIC information**, **Select existing virtual cloud network**. From the drop down select **ocvs-livelab** VCN. In the Subnet section, click **Select existing subnet**, from drop-down select **public subnet-ocvs-livelab**. Under Primary VNIC IP addresses, select **Automatically assign private IPv4 address**. 

    ![bastionsubnet](images/bastionsubnet.png)

6. In the **Add SSH keys** section, select **Upload public key file (.pub)**, drop your key inside the box and click **Create**.

    ![bastionssh](images/bastionssh.png)

7. After creation please take note of the **Public IP address** in the details page of the bastion host instance.

    ![bastionip](images/bastionip.png)

7. We will repeat the process for the jump server, however the difference is we will be using the **Windows Server 2022 Datacenter**

    ![windows](images/windows.png)

    and placing it in our **private subnet** we created.

    ![windowssubnet](images/windowssubnet.png)

**Congratulations! You may proceed to the next lab**

## Learn More

* [VCNs & Subnets](https://docs.public.oneportal.content.oci.oraclecloud.com/en-us/iaas/Content/Network/Tasks/Overview_of_VCNs_and_Subnets.htm)
* [SSH Keys](https://docs.oracle.com/en/learn/generate_ssh_keys/index.html)
* [Compute Service](https://docs.oracle.com/en-us/iaas/Content/Compute/Concepts/computeoverview.htm)
* [Physical Architecture Concepts](https://docs.oracle.com/en-us/iaas/Content/GSG/Concepts/concepts-physical.htm)


## Acknowledgements

* **Author:** Vijay Kumar
, Cloud Engineering OCVS
* **Contributors:**
    - Chris Wegenek, Cloud Engineering
    - Karthik Meenakshi Sundaram, Cloud Engineering
    - Germain Vargas, Cloud Engineering
    - Kelly Montgomery, Cloud Engineering

* **Last Updated By/Date:** Germain Vargas, Cloud Engineering, February 2025
