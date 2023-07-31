# Create a Virtual Cloud Network

## Introduction

This lab walks you through the steps to create a Virtual Cloud Network (VCN) on the OCI Console that will allow the desired connectivity to your instances.

Estimated Time: 15 minutes

### Objectives

In this lab, you will:
* Create a Virtual Cloud Network using the VCN Wizard
* Edit Security Lists to Allow SSH, HTTP, and MySQL connections

### Prerequisites

* An Oracle Cloud account
* Login to the OCI Dashboard
* A Child Compartment in your OCI Tenancy for this Lab (optional)


![OCI Dashboard](images/oci-dashboard.png)



## Task 1: Create a Virtual Cloud Network using the VCN Wizard

1. Click Navigation



  Select Networking



  Select Virtual Cloud Networks

	![Navigation Virtual Cloud Network](images/networking-vcn.png)

2. Click **Start VCN Wizard**

  ![Start VCN Wizard](images/start-vcn-wizard.png)

3. Select 'Create VCN with Internet Connectivity' then click 'Start Wizard'

  ![VCN with Internet Connectivity](images/vcn-wiz-int-conn.png)

4. Fill out the 'Configuration' page
  * VCN Name: *WordPress-VCN*
  * Compartment: *Select Your Compartment*

  ![VCN Configuration](images/vcn-config.png)



    Click 'Next'

5. Review VCN, Subnets, and Gateways

6. Click 'Create' to create the VCN
	> **Note:** This step should take less than a minute

  ![VCN Creation](images/vcn-creation.png)

7. Click 'View Virtual Cloud Network' to display the created VCN

  ![VCN Details Page](images/vcn-details-page.png)


## Task 2: Configure Security Lists

1. In the WordPress-VCN page, go to 'Security Lists'



  Click the security list for the **private subnet**

  ![Private Subnet Security List](images/security-list-private-subnet.png)

2. Edit the default SSH (port 22) ingress rule

  ![Edit SSH Rule](images/private-sl-ssh-edit.png)



    - CIDR Block: 10.0.0.0/24 (Public Subnet's CIDR Block)
    - Description: Allows SSH Access from the Public Subnet Only

  ![SSH Rule](images/private-sl-ssh.png)

3. Click 'Add Ingress Rules'

  ![Add Ingress Rule](images/private-sl-add-ingress.png)

4. Add the following rules for HTTP connections


    Rule 1
    - Stateless: unchecked
    - Source CIDR: 10.0.0.0/24 (CIDR block for public subnet)
    - IP Protocol: TCP
    - Destination Port: 80
    - Description: Allows HTTP Access from the Public Subnet Only



    Rule 2
    - Stateless: unchecked
    - Source CIDR: 10.0.0.0/24 (CIDR block for public subnet)
    - IP Protocol: TCP
    - Destination Port: 443
    - Description: Allows HTTP Access from the Public Subnet Only

5. Add another rule for MySQL connections



    - Stateless: unchecked
    - Direction: Ingress
    - Source CIDR: 10.0.1.0/24
    - IP Protocol: TCP
    - Destination Port: 3306, 33060
    - Description: Allows MySQL(X) Port Access from Private Subnet Only

  ![Private Subnet MySQL Rule](images/private-sl-mysql.png)


6. Go back to the WordPress-VCN 'Security Lists' page



  Click the security list for the **public subnet**



  ![Public Subnet Security List](images/security-list-public-subnet.png)

7. Click 'Add Ingress Rules' and add the following rules for HTTP connections



    Rule 1
    - Stateless: unchecked
    - Source CIDR: 0.0.0.0/0
    - IP Protocol: TCP
    - Destination Port: 80
    - Description: Allows HTTP Access from the Public Internet



    Rule 2
    - Stateless: unchecked
    - Source CIDR: 0.0.0.0/0
    - IP Protocol: TCP
    - Destination Port: 443
    - Description: Allows HTTP Access from the Public Internet

8. Allow  SSH Access Into Your Public Subnet From a Specific Set of IP Addresses (optional)
    > **Note:** This step is a recommended best practice when implementing an actual architecture you do not want getting hacked or reached by unknown entities. Performing this step will only allow a certain set of IP addresses you define to reach your public subnet's resources.



  In the **public subnet** security list, edit the SSH (port 22) ingress rule:

    ![Public Subnet SSH Rule](images/public-sl-ssh.png)



  Source CIDR: 0.0.0.0/0 -> **your desired public IP Range**



  For example, if you only wanted your local computer to SSH into the public subnet's resources:
   - 10.10.10.10/32

Congratulations! You have successfully set up your VCN! You may now **proceed to the next lab.**

## Acknowledgements
* **Author** - <Bernie Castro, Cloud Engineer>
* **Last Updated By/Date** - <Bernie Castro, May 2023>
