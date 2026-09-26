# Provision an OCI Autonomous Database

## Introduction

This lab describes the steps to create a new OCI Autonomous Database instance.

Estimated Lab Time: 10 minutes

### Objectives

In this lab, you will:

* Create an Autonomous Database instance

## Task 1: Create an Autonomous Database instance

1. From the Oracle Cloud Console, open the navigation menu, click **Oracle Database** and then click **Autonomous Database**.

   ![Oracle Database menu](https://oracle-livelabs.github.io/common/images/console/database-adb.png)

2. Select your workshop compartment from the **Compartment** drop down list. Click **Create Autonomous Database**. <if type="desktop">To find the compartment name, return to the **Login Details** screen, then copy the value of the **Compartment Name**, paste it in the **Compartment** drop down list in the Oracle Cloud Console and select the filtered compartment. 

</if>

   ![Autonomous Database Landing Page](images/adb-landing-page.jpg#input)

3. You will see the **Create Autonomous Database Serverless** screen with default values.

    ![Create ADB Basic Info](images/create-adb-basic-info.png#input)

4. Select the workload type as **Transaction Processing**.

    ![Create ADB Workload Type](images/create-adb-workload-type.jpg#input)


5. Under the **Configure the database** section, enable the **Developer mode**. In the **Choose database version** dropdown, select 19c.

    ![Create ADB Configure DB](images/create-adb-configure-db.png)

6. Under the **Create administrator credentials** section, enter a password of your choice (must be at least 12 characters and contain a number and an uppercase letter).

    ![Create ADB Admin Credentials](images/create-adb-admin-creds.jpg#input)

7. Select the network access type as **Secure access from everywhere**.

    ![Create ADB Network Access](images/create-adb-network-access.jpg#input)

8. Leave the contact email blank, and click **Create**.

    ![Create Autonomous Database](images/create-adb-contact-create.jpg#input)

   It takes about 2-3 minutes to provision an OCI Autonomous Database instance. Meanwhile, proceed to the next step.

Congratulations! In this lab, you created a new OCI Autonomous Database instance in your workshop compartment.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
