# Prepare your OCI tenant to execute the Unique Security Experience tool

## Introduction

This lab will show you how to set up your OCI tenant in order to have your Unique Security Experience.

Estimated Time: 60 minutes

### Objectives

In this lab, you will:
*  Set up Oracle Cloud Shell
*  Create Object Storage buckets
*  Provision and configure Autonomous Database
*  Install and deploy the Security Center dashboard application


Please see picture below with the components you will create in this lab:

   ![Diagram components](./images/first-lab-diagram.png "Diagram components")


### Prerequisites

This lab assumes you have:
* An Oracle Cloud account


*This is the "fold" - below items are collapsed by default*

## Task 1: Set up Oracle Cloud Shell

You will use the Oracle Cloud Shell to launch the provided Python script that executes the security assessment in your tenant. This Python script leverages the OCI Python SDK. The SDK Python is pre-configured with your credentials and ready to use immediately from within Cloud Shell. For more information on using the SDK for Python from within Cloud Shell, see [SDK for Python Cloud Shell Quick Start](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cloudshellquickstart_python.htm#Cloud_Shell_Quick_Start_SDK_for_Python).

OCI Cloud Shell is a web browser-based terminal accessible from the Oracle Cloud console. Cloud Shell is free to use (within monthly tenancy limits), and provides access to a Linux shell, with a pre-authenticated Oracle Cloud Infrastructure CLI, a pre-authenticated Ansible installation, and other useful tools for following Oracle Cloud Infrastructure service tutorials and labs. Cloud Shell is a feature available to all OCI users. Your Cloud Shell will appear in the Oracle Cloud console as a persistent frame of the console and will stay active as you navigate to different pages of the console.
Cloud Shell provides:
* An ephemeral machine to use as a host for a Linux shell, pre-configured with the latest version of the OCI Command Line Interface (CLI) and a number of useful tools
* 5GB of storage for your home directory
* A persistent frame of the console which stays active as you navigate to different pages of the console

To get started with Cloud Shell, in case your are not OCI Admin, you’ll need to grant user access to Cloud Shell via an IAM policy. Each service in Oracle Cloud Infrastructure integrates with IAM for authentication and authorization, for all interfaces (the console, SDK or CLI, and REST API). The following is an example policy to grant access to Cloud Shell:


```
allow group <GROUP_NAME> to use cloud-shell in tenancy
```


This example policy shows how to allow a group within a domain to use Cloud Shell:

```
allow group <DOMAIN_NAME>/<GROUP_NAME> to use cloud-shell in tenancy
```

Once you have access to Oracle Cloud Shell follow the next steps:

1. Log in to the OCI console.

2. Click the Cloud Shell icon in the Console header. A display menu will prompt, then click Cloud Shell. 
    
    Note that the OCI CLI running in the Cloud Shell will execute commands against the region selected in the Console's Region selection menu when the Cloud Shell was started.

    ![Cloud Shell Icon](./images/cloud-shell-icon.png "Cloud Shell Icon")

    This displays the Cloud Shell in a "drawer" at the bottom of the console:

    ![Cloud Shell running](./images/cloud-shell-panel.png "Cloud Shell running")


## Task 2: Create Object Storage buckets

First you need to create a new compartment for the purpose of this workshop. To do that, follow the next steps:

1. Log in to the OCI console and navigate through the main hamburger menu to *"Identity & Security > Compartments"*

    ![Compartments](./images/compartments.png "Compartments")

2.	Create a new compartment by clicking Create Compartment as bellow:

    ![Create Compartment](./images/create-compartment.png "Create Compartment")

    Name it "USE_Workshop" and click Create Compartment

    ![Create Compartment with info](./images/create-compartment-info.png "Create Compartment with info")


Now that you have a compartment for the workshop, you will create a bucket in Object Storage to store your security assessment report. Optionally, you can create a second bucket if you want to run as well the CIS compliance assessment.

To create the buckets, please follow the next steps:

3. Log in to OCI console and navigate through the main hamburger menu to *"Storage > Object Storage > Buckets"*.
    
    ![Buckets](./images/buckets.png "Buckets")


4. Create a bucket in the previously created compartment USE_Workshop by selecting the compartment and click Create Bucket.
    
    ![Create bucket](./images/create-bucket.png "Create bucket")


5. Name it security_assessment and click Create.
    
    ![Create](./images/click-create.png "Create")


6.	(Optional) Create a second bucket to store the CIS Compliance Assessment, and name it cis_report by following previous steps.

## Task 3: Provision and configure Autonomous Database

Now you need to create an Autonomous Database that will provide you the following functionalities in this workshop:

* Repository for your security assessment reports
* Front-end user interface by using the hosted APEX

To do that, follow the next steps:

1. Navigate through the main hamburger menu to: *"Oracle Database > Autonomous Database"*.

    ![Autonomous Database](./images/autonomous-database.png "Autonomous Database")


2.	Click Create Autonomous Database:

    ![Create Autonomous Database](./images/create-autonomous-database.png "Create Autonomous Database")



3.	Fill the parameters as follows:
    *   Compartment: USE_Workshop
    *	Display Name: SecAssessments
    *	Database Name: SecAssessments
    *	Workload type: Transaction Processing
    *	Deployment type: Serverless
    *	Configure the database: &lt;Leave it as default&gt; 
    *	Administrator credentials: &lt;your ADMIN password&gt; 
    *	Network access: Secure access from everywhere
    *	License type: Bring Your Own License (BYOL)
    *   Oracle Database Edition: Oracle Database Standard Edition (SE)

and click Create Autonomous Database. Then wait until the database status is set to green and ACTIVE.

![Click Create Autonomous Database](./images/click-create-autonomous-db.png "Click Create Autonomous Database")

Once you have created the Autonomous Database, you need to create a new user. This user will manage the APEX application that will act as the OCI Security Center Dashboard. In order to do that, the user needs to be REST enabled, as this will allow that user to store the security and compliance assessment reports in the Autonomous Database by using REST calls.

Since the Autonomous Database ADMIN user is REST Enabled, this allows for REST Services to be published in the ADMIN schemas and allows you to access Database Actions using the ADMIN database user account. Therefore, you can use the web SQL Developer provided in your Autonomous Database to create the new user and to enable it for REST services.

To be able to access the web SQL Developer provided in your Autonomous Database, follow the next steps:


4.	Once the Autonomous Database status is set to green and ACTIVE, click on Database Actions and click SQL in the displayed menu.

    ![Database Actions](./images/database-actions-security.png "Database Actions")

5. Log in with ADMIN user and the password you provided during database creation.

    ![Log in as ADMIN](./images/admin-login.png "Log in as ADMIN")


7.	Web SQL Developer will launch, and you will be able to run SQL queries to create users and tables.

    ![SQL Developer](./images/sql-developer.png "SQL Developer")

8. Create a database user named SECASSESSMENT and grant required permissions, as we will use it in trying out RESTful services. To do that, copy the following SQL code and paste it on the SQL developer. Replace the value between brackets with the password you want to give to that user. Then click the button "Run Script" and you will be able to see the Script Output showing the actions were successfully performed:


    ```
    CREATE USER SECASSESSMENT IDENTIFIED BY <your password>;
    GRANT CONNECT TO SECASSESSMENT;
    GRANT RESOURCE TO SECASSESSMENT;
    GRANT UNLIMITED TABLESPACE TO SECASSESSMENT;
    ```
    ![Create user SECASSESSMENT](./images/create-user.png "Create user SECASSESSMENT")


    **Note:** A new user is granted CONNECT and RESOURCE roles when Web Access is selected.
    Granting UNLIMITED TABLESPACE privilege allows a user to use all the allocated storage space. You cannot selectively revoke tablespace access from a user with the UNLIMITED TABLESPACE privilege. You can grant selective or restricted access only after revoking the privilege.
    For sake of simplicity, you can use same password you used for ADMIN user.

9. Enable REST for the new created schema SECASSESSMENT. To do that, go back to the Autonomous Database dashboard, click again Database Actions as you did previously, but this time click DATABASE USERS under the section Administration.

    ![Database Users](./images/dbusers.png "Database Users")



10. You will be able to see all users in the Autonomous Database. Click in the menu of the recently created user SECASSESSMENT and select Enable REST like in the picture below:

    ![Enable REST](./images/enable-rest.png "Enable REST")



11. A window will prompt, you can leave default values and click REST Enable User:

    ![REST Enable user](./images/rest-enable-user.png "REST Enable user")



12. After you created the user and granted all required permissions to manage APEX, you will create now a table to store security assessments by running the following script in web SQL Developer:
    ```
    CREATE TABLE SECASSESSMENT.OCISECURITYCENTER
    (   STATUS VARCHAR2(50 BYTE) COLLATE "USING_NLS_COMP",
        SERVICE VARCHAR2(255 BYTE) not null,
        EXTRACT_DATE DATE not null
    )   DEFAULT COLLATION "USING_NLS_COMP";
    ```
  ![Create new table](./images/create-table.png "Create new table")  

13. In same way that you enabled your schema SECASSESSMENT for REST, you need to enable the OCISECURITYCENTER table for REST as well. To do that, you have to log in in Web SQL Developer as SECASSESSMENT. You can do it in a quick way by going again to the Database Users view:

    ![SECASSESSMENT user](./images/secassessment-user.png "SECASSESSMENT user")  

    Click Open in new tab, as in the picture above. Then you will have to enter the credentials for SECASSESSMENT schema and click Sign in:

    ![Sign in as SECASSESSMENT user](./images/sign-in.png "Sign in as SECASSESSMENT user")

14. Go to SQL under Development, and now you are signed as SECASSESSMENT in Web SQL Developer. Right click on the OCISECURITYCENTER table and select REST --> Enable…

    ![Enable...](./images/enable.png "Enable...")

15.	Note the curl command location URL (Preview URL) from the new window, and click Enable:

    ![Click Enable](./images/click-enable.png "Click Enable")

16. (Optional) If you decided to run the OCI Compliance assessment as well, you need to create the tables to store the outcome data of OCI CIS Compliance Benchmark:

    ```
    CREATE TABLE "SECASSESSMENT"."OCICISCOMPLIANCECHECK"
        (   "Recommendation #" VARCHAR2(50 BYTE),
            "Section" VARCHAR2(50 BYTE) COLLATE "USING_NLS_COMP",
            "Level" NUMBER,
            "Compliant" VARCHAR2(50 BYTE) COLLATE "USING_NLS_COMP",
            "Findings" VARCHAR2(50 BYTE),
            "Title" VARCHAR2(255 BYTE) not null,
            "CIS v8" VARCHAR2(255 BYTE) not null,
            "CCCS Guard Rail" VARCHAR2(255 BYTE),
            "extract_date" DATE not null
        )   DEFAULT COLLATION "USING_NLS_COMP";
    ```
    You will need to enable for REST this table in same way as you did for the OCISECURITYCENTER table.


## Task 4: Install and deploy the Security Center dashboard application

Proceed to OCI console to perform the next steps:

1. On the Autonomous Database dashboard, click on SecAssessment under Instance Name on APEX Instance section:

    ![APEX](./images/apex.png "APEX")


2. Click launch APEX

    ![Launch APEX](./images/launch-apex.png "Launch APEX")

3.	The log in page for APEX will be prompted and you need to enter the ADMIN password of your Autonomous Database to log in:

    ![ADMIN Password](./images/admin-password.png "ADMIN Password")

4. Create your workspace by clicking Create Workspace:

    ![Create Workspace](./images/create-workspace.png "Create Workspace")

5. You will be prompted with a windows asking you how you would like to create your workspace. For this lab, you will select Existing Schema, as you will associate the new workspace with the database schema that you just created:

    ![Create Workspace with existing schema](./images/existing-schema.png "Create Workspace with existing schema")

6. Create your workspace with following information:

    * Database User: SECASSESSMENT 
    * Workspace Name: SECASSESSMENT
    * Workspace Username: SECASSESSMENT
    * Workspace Password: &lt;your password for SECASSESSMENT&gt; 

    ![Create Workspace for SECASSESSMENT user](./images/secassess-workspace.png "Create Workspace for SECASSESSMENT user")


7. Sign out of Administration Services and sign in to OCISECURITYCENTER to begin building applications. To do that, click on the top right corner admin icon and click Sign out:

    ![Sign Out](./images/sign-out.png "Sign Out")

9. Now, click Return to Sign In Page:

    ![Return to Sign In](./images/return-sign-in.png "Return to Sign In")

    and sign in with the following credentials:

    ![Sign In](./images/sign-in-apex.png "Sign In")


10. Now download the [packaged APEX application OCI Security Center Dashboard.](https://c4u04.objectstorage.us-ashburn-1.oci.customer-oci.com/p/EcTjWk2IuZPZeNnD_fYMcgUhdNDIDA6rt9gaFj_WZMiL7VvxPBNMY60837hu5hga/n/c4u04/b/livelabsfiles/o/oci-library/OCISecurityDashboard.sql)

11. Click App Builder and Import.

    ![App Builder](./images/app-builder.png "App Builder")

    ![Import](./images/import.png "Import")

12. Select the first option: Application, Page or Component Export and drag and drop the provided file: . Click Next.

    ![Drag and drop](./images/drag-and-drop.png "Drag and drop")

13. Click Next.

    ![Next](./images/click-next.png "Next")

14.	Review the details and click Install Application.

    ![Install Application](./images/install-application.png "Install Application")

15.	Once you see the message for Application Installed, click Run Application.

    ![Run Application](./images/run-application.png "Run Application")

16.	You will be redirected to the APEX application log in page, and you will be asked to enter the credentials for SECASSESSMENT user.

    ![SECASSESSMENT credentials](./images/login-apex.png "SECASSESSMENT credentials")

17.	You are now able to see the OCI Security Center Dashboard. Click on the OCI SECURITY ASSESSMENT card:

    ![OCI Security Assessment Dashboard](./images/sec-dashboard.png "OCI Security Assessment Dashboard")

18.	As you still did not run the Security and Compliance Assessment scripts, you do not have any data on it. Let’s continue and start with the Unique Security Experience in the next lab.


**This concludes this lab.**
You may now **proceed to the next lab**.


## Acknowledgements
* **Author** - Sonia Yuste (OCI Security Specialist), Damien Rilliard (OCI Security Senior Director)
* **Last Updated By/Date** - Sonia Yuste, April 2023


## Learn More

* [Introduction to Oracle Cloud Shell](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cloudshellintro.htm)
* [Object Storage Overview](https://docs.oracle.com/en-us/iaas/Content/Object/Concepts/objectstorageoverview.htm)
* [Oracle Autonomous Database Documentation](https://docs.oracle.com/en-us/iaas/autonomous-database-shared/doc/part-using.html)
* [Developing RESTful Services in Autonomous Database](https://docs.oracle.com/en-us/iaas/autonomous-database-shared/doc/ords-autonomous-database.html)

