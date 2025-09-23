# Provision an OCI MySQL HeatWave Database

## Introduction

This lab describes the steps to create a new OCI MySQL HeatWave Database instance.

Estimated Lab Time: 10 minutes

### Objectives

In this lab, you will:

* Create MySQL HeatWave Database instance

## Task 1: Create MySQL HeatWave Database instance

1. From the Oracle Cloud Console, open the navigation menu, click **Databases**. Under **HeatWave MySQL**, click **DB Systems**

   ![Oracle Databases menu](https://oracle-livelabs.github.io/common/images/console/database-mysql.png)

2. Select your workshop compartment from the **Compartment** drop down list on the left

   ![HeatWave MySQL Landing Page](images/heatwave-mysql-landing-page.jpg#input)

3. Click **Create DB System**.

    ![Create DB System Button](images/create-db-system.jpg#input)

4. You will see the **Create DB System** screen. Select **Development or testing**.

    ![Create DB System Screen](images/mysql-db-system-form.png#input)

5. Under the **Create administrator credentials** section, enter the username as "mysqladmin" and a password of your choice.

    ![Create MySQL Admin User](images/mysql-admin-user.jpg#input)

6. Ensure **Standalone** is selected.

    ![MySQL Standalone or HA](images/mysql-standalone-ha.jpg#input)

7. Select from the dropdown list *llw-net-* for **VCN** and *LLW Public Subnet(Regional)* for **Subnet**.

    ![MySQL Network and Placement](images/mysql-network-placement.png#input)

8. Under the **Configure hardware** section, deselect **Enable HeatWave cluster**. Leave the other default values unchanged.

    ![MySQL Configure Hardware](images/mysql-configure-hw.jpg#input)

9. Under the **Configure backup plan** section, deselect **Enable automatic backups**. Click **Create**.

    ![Disable MySQL Automatic Backup and Create](images/mysql-backup-create.png)

    It takes about 10 minutes to provision an OCI MySQL DB System instance. Meanwhile, proceed to the next step.

Congratulations! In this lab, you created a new OCI MySQL HeatWave Database instance in your workshop compartment.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
