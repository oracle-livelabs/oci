# Create an Oracle Autonomous Database Instance

## Introduction

Learn how to provision an Autonomous Database using the OCI console.

Estimated Time: 10 minutes

### Objectives

In this lab, you will:

- Learn how to provision a new Oracle Autonomous Database
- Learn some of the important Oracle APEX How to's
 
### Prerequisites

* This lab requires completion of the Get Started section in the Contents menu on the left.
* Ensure that the schema associated with the APEX application workspace, where the Graph Visualization plug-in is imported, is a graph-enabled schema. 
* To enable graph for a schema: Access Database Actions as an ADMIN user.

Alternatively, you can also select Edit, turn on the Graph toggle on the Edit User page, and click Apply Changes.

The target application into which you want to import the plug-in exists in your APEX instance.

## Task 1: Create or select a compartment
 
A compartment is a collection of cloud assets, like compute instances, load balancers, databases, and so on. By default, a root compartment was created for you when you created your tenancy (for example, when you registered for the trial account). It is possible to create everything in the root compartment, but Oracle recommends that you create sub-compartments to help manage your resources more efficiently.

If you are using an Oracle LiveLabs-provided sandbox, you don't have privileges to create a compartment and should skip this first task. Oracle LiveLabs has already created a compartment for you and you should use that one. Even though you can't create a compartment, you can review the steps below to see how it is done.

> **Note:**  If you already have a compartment created, you can **optionally skip this Task**.


1. Click the three-line menu on the top left of the console. Scroll down to the bottom of the menu, click **Identity & Security -> Compartments**.

    ![Click Identity & Security then Compartments.](images/oci-navigation-compartments.png " ")

    Then, click the **Create Compartment** button to create a sub-compartment.

    ![Click the Create Compartment button.](images/compartment-create.png " ")

2. Give the compartment a name and description. Be sure your root compartment appears as the parent compartment. Press the blue **Create Compartment** button.

    ![Click the Create Compartment button.](images/compartment-click-create.png " ")

    The compartment is created and you can use it for your cloud services!

## Task 2: Choose Autonomous Database from the services menu

1. Log in to the Oracle Cloud.
2. Once you log in, the cloud services dashboard shows all the services available to you. Click the **navigation menu** in the upper left to show top-level navigation choices.

3. This lab shows the provisioning of an Autonomous Data Warehouse database. Click on **Oracle Database**, then select **Autonomous Data Warehouse**.

    ![Click Autonomous Data Warehouse.](https://oracle-livelabs.github.io/common/images/console/database-adw.png " ")


4. Make sure your Workload Type is __Data Warehouse__ or __All__ to see your Autonomous Data Warehouse instances. Use the __List Scope__ drop-down menu to select a compartment. <if type="livelabs">Enter the first part of your user name, for example `LL185` in the Search Compartments field to quickly locate your compartment.
 
    <if type="freetier">
    ![Check the workload type on the left.](images/compartment-name.png " Check the workload type on the left.")

    > **Note:** Avoid using the `ManagedCompartmentforPaaS` compartment, as this is an Oracle default used for Oracle Platform Services.
   </if>

5. This console shows that no databases yet exist. If there were a long list of databases, you could filter the list by the **State** of the databases (Available, Stopped, Terminated). You can also sort by __Workload Type__. In this example, __Data Warehouse__ is the workload type.

    ![Autonomous Databases console.](./images/no-adb-instances.png "Autonomous Databases console. ")

<if type="freetier">
1. You can see your current default **region** in the top right-hand corner of the page.
    ![Select region on the far upper-right corner of the page.](./images/region-select.png " ")
</if>

## Task 3: Create the Oracle Autonomous Database instance

1. Click **Create Autonomous Database** to start the instance creation process.

    ![Click Create Autonomous Database.](./images/create-autonomous-database.png "Click Create Autonomous Database. ")

2.  This brings up the __Create Autonomous Database__ screen, where you will specify the instance's configuration.

3. Specify basic information for the Autonomous Database:

    - __Compartment__ - Leave the default compartment.
    - __Display Name__ - Enter a memorable name for the database for display purposes. For example, use __DEMO\_ADW__.
    - __Database Name__ - Use letters and numbers only, starting with a letter. The maximum length is 30 characters.  
    <if type="freetier">
        ![Create ADW screen](./images/adb-install-00.png "Create ADW screen ") 
    </if>
    - __Workload Type__ - For this lab, choose __Data Warehouse__ as the workload type.
    - __Deployment Type__ - For this lab, choose __Serverless__ as the deployment type.
    ![Create ADW screen](./images/adb-install-01.png "Create ADW screen ")  
    - __Always Free__ - For this lab, we will leave Always Free **unchecked**.
    - __Choose database version__ - Select a database version **19c** from the available versions.
    - **Choose network access**: For this lab, accept the default, **Secure access from everywhere**.
    ![Create ADW screen](./images/adb-install-04.png "Create ADW screen ")

    <if type="freetier">
    Choose a license type. For this lab, choose __License Included__. The two license types are:
    </if> 

    - __Bring Your Own License (BYOL)__ - Select this type when your organization has existing database licenses. [learn more](https://www.oracle.com/cloud/pricing/)
    - __License Included__ - Select this type when you want to subscribe to new database software licenses and the database cloud service.
    - __Oracle Database Edition__ - Select __Oracle Database Enterprise Edition__. This option is available only if you have selected __Bring Your Own License (BYOL)__

4. Configure the database:
 
    - __ECPU count__ - Number of ECPU for your service. For this lab, specify __2 ECPU__.  
    - __Storage (TB)__ - Select your storage capacity in terabytes. For this lab, specify __1 TB__ of storage.  
    - __Auto Scaling__ - Auto Scaling - For this lab, keep auto-scaling **unchecked**. If autoscaling is enabled, the system will automatically use up to three times more CPU and IO resources to meet workload demand. learn more about [auto scaling](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/autonomous-auto-scale.html)
 
        ![Create workload type](./images/adb-install-02.png "Create ADW screen ")
  
        Backup retention period, default to 60 days.

        Create administrator credentials:

        ![Create deployment type](./images/adb-install-03.png "deployment type ")

    - __Password and Confirm Password__ - Specify the password for the **ADMIN** user of the service instance.  
    - Autonomous Database requires strong passwords.
  
1. The **Contact Email** field allows you to list contacts to receive operational notices and announcements as well as unplanned maintenance notifications. This is optional.

    ![Click Create ADW Button.](images/db-actions-05.png)
 
    Click on __Create Autonomous Database__. button

    

2.   Your instance will begin provisioning. In a few minutes, the State will turn from Provisioning to Available. At this point, your Autonomous Data Warehouse database is ready to use! Have a look at your instance's details here, including its name, database version, OCPU count, and storage size.

    ![Database instance homepage.](./images/adb-install-05.png "Database instance homepage ")

    ![Database instance homepage.](./images/adb-install-06.png "Database instance homepage ")
 

## Task 4: Access Database Actions run SQL queries 

1. From Database Actions menu we can run common tasks such as running SQL queries, Data Modeler, REST API development etc.  

    Click the **Database Actions** button.

    ![database actions](images/db-actions-01.png "database actions")

    ![database actions](images/db-actions-00.png "database actions")

    Select the **SQL** tab to open the **SQL worksheet**.

    ![database actions](images/db-actions-04.png "database actions")
     
## Task 5: How to create an Oracle APEX Workspace

1. Once the Autonomous Database has been fully provisioned, return to the *Autonomous Database* page, locate the instance's display name, and then click on it to view the ADB's details page. Click the *Tools* tab. 
2. Click the *Copy* button to copy the URL to launch the Oracle APEX development environment. Open the link in a new browser window or tab.
![Launch the Oracle APEX App Builder.](./images/launch-oracle-apex-app-builder.png)
3. For new Autonomous Database instances, this should launch the **Administration Services** login screen. Enter the password for the *admin* user and click the **Sign In to Administration** button.
![Login to the Oracle APEX Administration Services.](./images/login-to-oracle-apex-administration-services.png)
4. Again, for new Autonomous Database instances, after a successful login, the browser will redirect to the page shown below. Click the **Create Workspace** button.
![Click the Create Workspace button.](./images/create-a-new-workspace.png)
5. Click and select the **New Schema** option.
![Select to create a workspace using a new schema.](./images/create-workspace-using-a-new-schema.png)
1. Enter the desired **Workspace Name** and **Workspace Username**. The will be used to create an Oracle Database user account. Also, provide a new **Workspace Password** that conforms to the same password policy. Click the **Create Workspace** button to create the workspace.
![Provide the desired workspace name, and the administrator's username and password.](./images/provide-workspace-name-and-admin-credentials.png)
1. After the workspace has been successfully provisioned, click the button on the top-right, and then click the **Sign out** button to return to the App Builder login screen.
![Sign out of the Administration Services.](./images/sign-out-of-administration-services.png)
1. Enter the workspace name, username, and password set earlier when creating the workspace. Click the **Sign In** button to access the newly created workspace.
![Login to the new workspace.](./images/login-to-new-workspace.png)
1. After successful authentication, the browser will redirect to the default App Builder landing page where workspace administrators and developers will have access to various functionalities to develop and manage APEX applications.
![Once signed in, the workspace administrator and developers have access to the App Builder and a few other utilities.](./images/oracle-apex-development-environment-home-page.png)

## Task 6: How to run SQL queries in Oracle APEX

There are several ways to run SQL queries, few most frequently used techniques are listed below.

1. You can run SQL queries in APEX Workspace under **SQL Workshop** in top navigation and select Option **SQL Commands**
2. Copy paste SQL queries in the editor window and click on **Run** button

    ![SQL Commands](./images/apex-run-sql.png)

3. Some times you might need to run SQL queries within an APEX page for example displaying data from a table, such SQL queries can be written in SQL Query Editor, this query executes during the page runtime. 

    ![SQL Commands](./images/apex-collection.png)

## Task 7: APEX Graph Visualization Plug-in

The plug-in mainly allows you to:

- Construct a property graph for visualization from the graph data in your Autonomous Database instance.
- Explore the graph vertices and edges. You can also select and visualize these graph elements individually or in groups.
- Interact with the graph visualization by performing various actions such as changing the graph layouts, grouping or ungrouping selected vertices, removing selected vertices or edges, and so on.
- Style the vertices and edges in the graph by configuring the style settings such as size, color, icon, label values, and so on.
- Visualize and study the evolution of the graph over time.

Download [Graph Visualization Plug-In (Preview)] (https://github.com/oracle/apex/tree/23.2/plugins/region/graph-visualization) and Install in Oracle APEX workspace

Installation Steps

- Download the region\_type\_plugin\_graphviz.sql file in this directory
- Navigate to App Builder -> Import
- Drag and drop the plugin.sql file
- Choose File Type -> Plug-in
- Click Next
- Continue through the remaining steps in the wizard to finish installing the application

Please check [Sample Graph Visualizations](https://github.com/oracle/apex/tree/23.2/sample-apps/sample-graph-visualizations) to test sample Graph queries and installation
  
You may now **proceed to the next lab**.

## Learn more

- See the [Autonomous Database GetStarted Guide](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/getting-started.html)  for using Autonomous Data Warehouse.
- Go to the [Data Warehousing Insider blog](https://blogs.oracle.com/datawarehousing/) for more information on network connectivity options mentioned in this workshop.

## Acknowledgements

- **Author** - Madhusudhan Rao, Oracle Database Product Manager 
* **Last Updated By/Date** - June 12th, 2024
* **Updates** - Database Actions