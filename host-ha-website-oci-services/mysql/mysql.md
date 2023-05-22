# Configure a MySQL Database

## Introduction

This lab will walk you through creating and configuring an Oracle MySQL Database Service instance.

Estimated Time: 10 minutes

### Objectives

In this lab, you will:
* Create and configure a Standalone MySQL Database System

### Prerequisites

This lab assumes you have:
* An Oracle Cloud account
* All previous labs successfully completed

## Task 1: Create a Standalone MySQL Database Service instance

1. Click Navigation



  Select Databases



  Select MySQL or 'DB Systems'

	![Navigation MySQL](images/databases-mysql.png)

2. Click 'Create DB system'

  ![Create MySQL DB System](images/mysql-create.png)

3. Fill out the Instance Information:
    - Production
    - Compartment: *Select Your Compartment*
    - Name: WordPress-MySQL-SA
    - Description: MySQL Database Stand Alone for WordPress
    - Standalone

    ![MySQL Instance Information](images/mysql-db-info.png)

4. Create Administrator Credentials
    - Username: admin
    - Password: ???
    - Confirm Password: ???

    ![MySQL Admin Details](images/mysql-admin.png)

5. Configure Networking
    - VCN: Select **WordPress-VCN**
    - Subnet: Select the **private subnet**

    ![MySQL Networking](images/mysql-networking.png)

6. Configure Placement
    - Availability Domain: *Leave as default*

    ![MySQL Placement](images/mysql-placement.png)

7. Configure Hardware
    - Change shape to: **MySQL.VM.Standard.E3.1.8GB**
    - Data Storage Size: 50 GB

    ![MySQL Hardware](images/mysql-hardware.png)

8. Configure Backup Plan



    - Keep on 'Enable Automatic Backup'

    ![MySQL Backup](images/mysql-backup.png)

9. Click 'Create'

    ![MySQL Provisioning](images/mysql-provisioning.png)



    The MySQL instance can take 10+ minutes to be ready. Once the state turns to 'Active' and the icon turns to green, the DB system is ready for use.

    ![MySQL Active](images/mysql-active.png)

10. On the MySQL page, check the Endpoint (Private IP) and Save It For Later

    ![MySQL IP Address](images/mysql-ip-address.png)

You may now **proceed to the next lab.**

## Acknowledgements
* **Author** - Bernie Castro, Cloud Engineer
* **Last Updated By/Date** - Bernie Castro, May 2023
