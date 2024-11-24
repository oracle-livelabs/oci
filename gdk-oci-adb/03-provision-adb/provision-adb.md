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

2. Select your workshop compartment from the **Compartment** drop down list on the left. <if type="desktop">To find the compartment name, return to the **Login Details** screen, then copy the value of the **Compartment Name**, paste it in the **Compartment** drop down list in the Oracle Cloud Console and select the filtered compartment.

</if>

   ![Autonomous Database Landing Page](images/adb-landing-page.jpg#input)

6. Click **Create Autonomous Database**.

    ![Create Autonomous Database Button](images/create-adb.jpg#input)

7. You will see the **Create Autonomous Database** screen with default values.

    ![Create ADB Basic Info](images/create-adb-basic-info.jpg#input)

8. Select the workload type as **Transaction Processing**.

    ![Create ADB Workload Type](images/create-adb-workload-type.jpg#input)

9. Select the deployment type as **Serverless**.

    ![Create ADB Deployment Type](images/create-adb-deployment-type.jpg#input)

10. Under the **Configure the database** section, leave the default values unchanged.

    ![Create ADB Configure DB](images/create-adb-configure-db.jpg#input)

11. Under the **Backup retention** section, set the automatic backup retention period to 1 day.

    ![Create ADB Backup retention](images/create-adb-backup-retention.jpg#input)

12. Under the **Create administrator credentials** section, enter a password of your choice (must be at least 12 characters and contain a number and an uppercase letter).

    ![Create ADB Admin Credentials](images/create-adb-admin-creds.jpg#input)

13. Select the network access type as **Secure access from everywhere**.

    ![Create ADB Network Access](images/create-adb-network-access.jpg#input)

14. Leave the license type as **License included**.

    ![Create ADB License Type](images/create-adb-license-edition.jpg#input)

15. Leave the contact email blank, and click **Create Autonomous Database**.

    ![Create Autonomous Database](images/create-adb-contact-create.jpg#input)

   It takes about 2-3 minutes to provision an OCI Autonomous Database instance. Meanwhile, proceed to the next step.

Congratulations! In this lab, you created a new OCI Autonomous Database instance in your workshop compartment.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
