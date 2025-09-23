
<!-- Updated July 30, 2025 by Madhusudhan Rao -->
<!-- Updated April 12, 2021 -->
<!-- Updated May 21, 2024 by Madhusudhan Rao -->
# Provision Autonomous Database and Connect Using SQL Worksheet

## Introduction

This lab walks you through the steps to quickly provision an Oracle Autonomous Database on Oracle Cloud. You will use this database in subsequent labs of this workshop. In this lab, you will then connect to the database using SQL Worksheet, a browser-based tool that is easily accessible from the Autonomous Data Warehouse.

<!-- [](youtube:a6Jm7lYaCWI) -->

Estimated lab time: 15 minutes

### Objectives

-   Provision a new Autonomous Data Warehouse
-   Learn how to connect to your new autonomous database using SQL Worksheet


### Prerequisites

-   This lab requires completion of the **Get Started** section in the Contents menu on the left.  


## Task 1: Choose ADW from the Services Menu

1. Log in to the Oracle Cloud.
2. Once you are logged in, you are taken to the cloud services dashboard where you can see all the services available to you. Click the navigation menu in the upper left to show top level navigation choices. 

3. Click on **Oracle Database** > **Autonomous Data Warehouse**.

    ![navigation](./images/redwood-navigation.png " ")

    Select the compartment where you have access to create or use an Oracle Autonomous Database Instance. 

    Click on **Create Autonomous Database** button

    ![locate compartment](./images/autonomous-databases-page.png " ")


    > Note: Avoid the use of the **ManagedCompartmentforPaaS** compartment as this is an Oracle default used for Oracle Platform Services.
 
    
## Task 2: Create the Autonomous Database Instance
 
1.  This brings up the __Create Autonomous Database__ screen where you will specify the configuration of the instance.
2. Provide basic information for the autonomous database:
  
    - __Display Name__ - Enter a memorable name for the database for display purposes. For this lab, use __FirstName LastName__ example (John Smith).
    - __Database Name__ - Use letters and numbers only, starting with a letter. Maximum length is 14 characters. (Underscores not initially supported.) For this lab, use __YOURNAME__ example (JOHNSMITH). 
    - __Choose a compartment__ - Select a compartment for the database from the drop-down list.

    ![example database name](./images/adb-create-screen-names.png " ")

3. Choose a workload type. Select the workload type for your database from the choices:

    - __Data Warehouse__ - For this lab, choose __Data Warehouse__ as the workload type.
    - __Transaction Processing__ - Alternately, you could have chosen Transaction Processing as the workload type. 
    - __Deployment Type__ - For this lab, choose __Serverless__ as the deployment type.
    - __Dedicated Infrastructure__ - Alternately, you could have chosen Dedicated Infrastructure as the workload type.

    ![Create Workload](./images/adb-create-screen-workload.png " ")

    <b>Choose the Data Warehouse as workload type for this course.  Do not choose one of the others. Each student is only allowed 2 ECPU instance for ADW (depending upon the resources available for this lab).</b>
 
  
    <if type="freetier">
    Choose database version: Select **19c** for the database version from this drop-down list.

    ![choose workload type](./images/create-19c.png " ")
    </if>
    <if type="freetier23ai">   
    Choose database version: Select **23ai** for the database version from this drop-down list.

    ![choose workload type](./images/adb-create-database-configuration.png " ")
    </if>
  
- __ECPU count (2)__ - Leave default.
- __Storage (TB)__ - Leave default.
- __Storage auto scaling__ (off) - Leave default. 

## Task 3: Advanced Options

1. Under the **Advanced Options** select **Edit License selection** 

    ![choose workload type](./images/byol.png " ")

    Under Advanced Options choose a license type. For this lab, choose **Bring Your Own License** (BYOL) enabled.
  
2. Create administrator credentials: 
 
    ![create administrator credentials](./images/adb-create-screen-password.png " ") 

    > Note: __Password and Confirm Password__ - Specify the password for ADMIN user of the service instance.
    - The password must meet the following requirements:
    - The password must be between 12 and 30 characters long and must include at least one uppercase letter, one lowercase letter, and one numeric character.
    - The password cannot contain the username.
    - The password cannot contain the double quote (") character.
    - The password must be different from the last 4 passwords used.
    - The password must not be the same password that is set less than 24 hours ago.
    - Re-enter the password to confirm it. Make a note of this password.

3. Backup

    - __Backup retention__ - Leave default. 
  
    ![create administrator credentials](./images/choose-backup-retention.png " ")

    
4. Choose network access:
    - For this lab, accept the default, **Secure access from everywhere**.
   
    ![choose network access](./images/adb-create-network-access.png " ")

5. In the Contacts for operational notifications and announcements section, provide a contact email address. The Contact email field allows you to list contacts to receive operational notices and announcements as well as unplanned maintenance notifications.

    ![choose network access](./images/adb-create-contact-email.png " ")

6.  Click **Create**.
 
7.    Your instance will begin provisioning. In a few minutes the state will turn from Provisioning to Available. At this point, your Autonomous Data Warehouse database is ready to use! Have a look at your instance's details here including its name, database version, CPU count and storage size.
   
    ![23ai information](./images/adb-create-provisioning-message-new.png " ")

8. A Check database lifecycle state informational box is displayed. You can navigate through this tour or choose to skip it. Click Skip tour. A Skip guided tour dialog box is displayed. Click Skip.

    In a few minutes, the instance status changes to Available. At this point, your Autonomous Data Warehouse database instance is ready to use! Review your instance's details including its name, database version, ECPU count, and storage size.

    ![23ai information](./images/adb-created.png " ")

> Note: In the following screen sample, the database display name is Training-Database and the database name is TrainingDatabase. In your example, your database display name and database name might be different.

## Task 4: Navigate to Database Actions

1. Navigate to the **Autonomous Database details** page of the Autonomous Database instance that you provisioned earlier. Click the **Database actions** drop-down list, and then select **View all database actions** or **SQL**.

    ![Database Actions](./images/click-data-load-drop-down.png " ")

## Task 5: Connect with SQL Worksheet

Although you can connect to your autonomous database from local PC desktop tools like Oracle SQL Developer, you can conveniently access the browser-based SQL Worksheet directly from your Autonomous Data Warehouse or Autonomous Transaction Processing console.

1. From the **Database Actions** tool, navigate to the SQL Worksheet. Click the **Selector** menu. In the **Development** section, click **SQL**.

    ![Click the Database Actions button](./images/goto-sql.png " ")

    The SQL Worksheet is displayed. The first time you access the SQL Worksheet, informational boxes are displayed. Click the X icons to close those boxes. You can also click the **Collapse** icon to increase the worksheet area.

    ![Click the Database Actions button](./images/sql-worksheet.png " ")
 
2. Learn more about the SQL Worksheet features using the tooltips when you hover over an icon. You will run queries by entering your commands in the worksheet. Click the **Run Statement** icon to run the command and view the output in the Query Result tab in tabular format. Click the Run Script icon to run a script and display the output in the Script Output tab in text format. You can clear your worksheet by clicking the trash icon.

    ![Click on SQL.](./images/run-query.png " ")

3. The first time you open SQL Worksheet, a series of pop-up informational boxes introduce you to the main features. Click **Next** to take a tour through the informational boxes.
 

## Task 6: Run scripts in SQL Worksheet

Run a query on a sample Oracle Autonomous Database data set.

1. Copy and paste the code snippet below to your SQL Worksheet. One of the two ADW sample data sets that you can access from any ADW instance. Take a moment to examine the script. Make sure you click the Run Statement button to run it in SQL Worksheet so that all the rows display on the screen.
  
        <copy>
        select sysdate from dual; 
        </copy>

    ![Query Low Results SQL Worksheet](./images/run2.png " ")

        <copy>
        select /* low */ c_city,c_region,count(*)
        from ssb.customer c_low
        group by c_region, c_city
        order by count(*);
        </copy>

    ![Query Low Results SQL Worksheet](./images/run1.png " ")

2. Take a look at the output response from your Autonomous Data Warehouse.

3. When possible, ADW also caches the results of a query for you.  If you run identical queries more than once, you will notice a much shorter response time when your results have been cached.

4. You can find more sample queries to run in the <a href="https://www.oracle.com/autonomous-database/autonomous-data-warehouse/">ADW documentation.</a>
  
## Troubleshoot Tips

If you are having problems with any of the labs, please visit the Need Help? tab.

## Acknowledgements

* **Author** - Madhusudhan Rao, Principal Product Manager Oracle Database 
<!-- * **Author** - Marion Smith, Senior Technical Program Manager,Eugenio Galiano
* **Contributors** - Kay Malcolm, Paige Hanssen, Beda Hammerschmidt, Patrick Wheeler, Jayant  Mahto, Russ Lowenthal, Marcos Arancibia Coddou, Jayant Sharma, David Lapp, Madhusudhan Rao -->
* **Last Updated By/Date** - Madhusudhan Rao, 30th July, 2025
