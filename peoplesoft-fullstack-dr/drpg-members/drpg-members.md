# Add members to the DR Protection groups

## Introduction

In this lab, we will add members to the DR Protection groups created and associated in the previous lab. Ashburn is the primary region and Phoenix is the standby region.

Estimated Time: 20 Minutes

### Objectives

- Add members to Ashburn DRPG (Primary)
- Add members to Phoenix DRPG (Standby)

In Ashburn (Primary) region, members to be added are below. 
 
- PeopleSoft Active Database hosted on Oracle Base DB Services
- PeopleSoft Application Server Compute Instance (Linux)
- PeopleSoft Process Scheduler Server Compute Instance (Linux)
- PeopleSoft Process Scheduler Server Compute Instance (Windows)
- PeopleSoft Web Server Compute Instance (Linux)
- Elastic Search and Kibana Server (Linux)

In Phoenix (Standby), members to be added are below.

- PeopleSoft Standby Database hosted on Oracle Base DB Services
- PeopleSoft Application Server Compute Instance (Linux)
- PeopleSoft Process Scheduler Server Compute Instance (Linux)
- PeopleSoft Process Scheduler Server Compute Instance (Windows)
- PeopleSoft Web Server Compute Instance (Linux)
- Elastic Search and Kibana Server (Linux)

## Task 1: Add members to Ashburn DRPG (Primary)

1. Login into OCI Console. The primary region should be **Ashburn**.

   ![oci console ashburn](./images/ashburn-region1.png)

2. Select **Migration and Disaster Recovery** from the Hamburger menu, then **Disaster Recovery** -> **DR Protection Groups**. Verify the region is **Ashburn**

   ![drpg navigation page](./images/ashburn-drpgpage1.png)

3. You will land on the Disaster Recovery Protection group home page; make sure you have selected *the Ashburn* region. Click on **FSCM92-FSDR-Group-Ashburn** DRPG.

   ![drpg landing page](./images/ashburn-drpg1.png)

  In the Ashburn region DRPG page, add the members required in the **FSCM92-FSDR-Group-Ashburn** DRPG. 

4. Add Primary Oracle Base DB Services. 

  Select **FSCM92-FSDR-Group-Ashburn** DRPG, click on **Members**, click on **Manage Members** and hit **Add Member**

  ![drpg add member](./images/ashburn-add-member.png)

 - Resource Type is **Database (BaseDB, ExaDB-D, ExaCC, ExaXS)**
 - Database Type is **Oracle Base Database**
 - Database System will be PeopleSoft Primary Application Database
 - Select Database Home
 - Select Database from the drop down
 - Database password secret will be the secret created in Lab 1.

 Click on **Add**.

   ![ashburn-add-db](./images/ashburn-add-db.png)

  **FSCM92-FSDR-Group-Ashburn** DRPG status will change to updating; wait for a few seconds. You should see that the database is added as a member. Refresh the DRPG page if required. You can monitor the request's status in the **Work requests**.

  Navigate back to the DR Protection group page; the status of DRPG should be active.

   ![drpg atp added](./images/ashburn-db-added.png)

5. Add PeopleSoft Application Server Compute instance.

  Select **FSCM92-FSDR-Group-Ashburn** DRPG, click on **Members**, click on **Manage Members** and hit **Add Member**

   ![drpg add member](./images/ashburn-add-member.png)

  It will show various resource types and select **Instance**
   ![drpg resource type](./images/ashburn-add-app.png)

- Resource Type is **Instance**
- Instances in Compartment, select PeopleSoft Application Server Compute Instance
- **Check** the checkmark of **Non-moving instance**.
- Click Add

  **FSCM92-FSDR-Group-Ashburn** DRPG status will change to updating; wait for a few seconds. DRPG status will change to active.You should be able to see that PeopleSoft Application Server compute instance has been added as a member. Refresh the DRPG page if required. You can monitor the status in the *Work requests*.

   ![drpg compute added](./images/ashburn-app-added.png)

  Navigate back to the DR Protection group page; the status of DRPG should be active.

7. Add PeopleSoft Process Scheduler Server Compute instance (Linux).

  Select **FSCM92-FSDR-Group-Ashburn** DRPG, click on **Members**, click on **Manage Members** and hit **Add Member**

   ![drpg add member](./images/ashburn-add-member.png)

  It will show various resource types and select **Instance**
   ![drpg resource type](./images/ashburn-add-prcs.png)

- Resource Type is **Instance**
- Instances in Compartment, select PeopleSoft Process Scheduler Server Compute Instance
- **Check** the checkmark of **Non-moving instance**.
- Click Add

  **FSCM92-FSDR-Group-Ashburn** DRPG status will change to updating; wait for a few seconds. DRPG status will change to active.You should be able to see that PeopleSoft Process Scheduler Server compute instance (Linux) has been added as a member. Refresh the DRPG page if required. You can monitor the status in the *Work requests*.

  Navigate back to the DR Protection group page; the status of DRPG should be active.

  ![drpg compute added](./images/ashburn-prcs-added.png)

8. Add PeopleSoft Process Scheduler Server Compute instance (Windows).

  Select **FSCM92-FSDR-Group-Ashburn** DRPG, click on **Members**, click on **Manage Members** and hit **Add Member**

   ![drpg add member](./images/ashburn-add-member.png)

  It will show various resource types and select **Instance**
   ![drpg resource type](./images/ashburn-add-prcs-win.png)

- Resource Type is **Instance**
- Instances in Compartment, select PeopleSoft Process Scheduler Server Compute Instance
- **Check** the checkmark of **Non-moving instance**.
- Click Add

  **FSCM92-FSDR-Group-Ashburn** DRPG status will change to updating; wait for a few seconds. DRPG status will change to active.You should be able to see that PeopleSoft Process Scheduler Server compute instance (Windows) has been added as a member. Refresh the DRPG page if required. You can monitor the status in the *Work requests*.

  Navigate back to the DR Protection group page; the status of DRPG should be active.

  ![drpg compute added](./images/ashburn-prcs-win-added.png)

9. Add PeopleSoft Process Web Server Compute instance.

  Select **FSCM92-FSDR-Group-Ashburn** DRPG, click on **Members**, click on **Manage Members** and hit **Add Member**

   ![drpg add member](./images/ashburn-add-member.png)

  It will show various resource types and select **Instance**
   ![drpg resource type](./images/ashburn-add-web.png)

- Resource Type is **Instance**
- Instances in Compartment, select PeopleSoft Web Server Compute Instance
- **Check** the checkmark of **Non-moving instance**.
- Click Add

  **FSCM92-FSDR-Group-Ashburn** DRPG status will change to updating; wait for a few seconds. DRPG status will change to active.You should be able to see that PeopleSoft Web Server compute instance has been added as a member. Refresh the DRPG page if required. You can monitor the status in the *Work requests*.

  Navigate back to the DR Protection group page; the status of DRPG should be active.

  ![drpg compute added](./images/ashburn-web-added.png)

10. Add Elastic Search and Kibana Services Compute instance.

  Select **FSCM92-FSDR-Group-Ashburn** DRPG, click on **Members**, click on **Manage Members** and hit **Add Member**

   ![drpg add member](./images/ashburn-add-member.png)

  It will show various resource types and select **Instance**
   ![drpg resource type](./images/ashburn-add-elk.png)

- Resource Type is **Instance**
- Instances in Compartment, select PeopleSoft Elastic Search Server Compute Instance
- **Check** the checkmark of **Non-moving instance**.
- Click Add

  **FSCM92-FSDR-Group-Ashburn** DRPG status will change to updating; wait for a few seconds. DRPG status will change to active.You should be able to see that Elastic Search & Kibana Service compute instance has been added as a member. Refresh the DRPG page if required. You can monitor the status in the *Work requests* section under Resources.

  Navigate back to the DR Protection group page; the status of DRPG should be active.

  ![drpg compute added](./images/ashburn-elk-added.png)


## Task 2: Add members to Phoenix DRPG (Standby)

1. Login into OCI Console. The standby region should be **Phoenix**.

   ![oci console phoenix](./images/phoenix-region1.png)

2. Select **Migration and Disaster Recovery** from the Hamburger menu, then **Disaster Recovery** -> **DR Protection Groups**. Verify the region is **Phoenix**.

   ![drpg navigation page](./images/phoenix-drpgpage1.png)

3. You will land on the Disaster Recovery Protection group home page; make sure you have selected the *Phoenix* region. Click on **FSCM92-FSDR-Group-Phoenix** DRPG.

   ![drpg landing page](./images/phoenix-drpg1.png)

  In the Phoenix region DRPG page, add the members required in the **FSCM92-FSDR-Group-Phoenix** DRPG. 

4. Add Standby Oracle Base DB Services. 

  Select **FSCM92-FSDR-Group-Phoenix** DRPG, click on **Members**, click on **Manage Members** and hit **Add Member**

  ![drpg add member](./images/phoenix-add-member.png)

 - Resource Type is **Database (BaseDB, ExaDB-D, ExaCC, ExaXS)**
 - Database Type is **Oracle Base Database**
 - Database System will be PeopleSoft Primary Application Database
 - Select Database Home
 - Select Database from the drop down
 - Database password secret will be the secret created in Lab 1.

 Click on **Add**..

   ![ashburn-add-db](./images/phoenix-add-db.png)

  **FSCM92-FSDR-Group-Phoenix** DRPG status will change to updating; wait for a few seconds. You should see that the database is added as a member. Refresh the DRPG page if required. You can monitor the request's status in the **Work requests**.

  Navigate back to the DR Protection group page; the status of DRPG should be active.

   ![drpg db added](./images/phoenix-db-added.png)

6. Add Standby PeopleSoft Application Server Compute instance.

  Select **FSCM92-FSDR-Group-Phoenix** DRPG, click on **Members**, click on **Manage Members** and hit **Add Member**

   ![drpg add member](./images/phoenix-add-member.png)

  It will show various resource types and select **Instance**
   ![drpg resource type](./images/phoenix-add-app.png)

- Resource Type is **Instance**
- Instances in Compartment, select PeopleSoft Application Server Compute Instance
- **Check** the checkmark of **Non-moving instance**.
- Click Add

  **FSCM92-FSDR-Group-Phoenix** DRPG status will change to updating; wait for a few seconds. DRPG status will change to active.You should be able to see that Standby PeopleSoft Application Server compute instance has been added as a member. Refresh the DRPG page if required. You can monitor the status in the *Work requests*.

   ![drpg compute added](./images/phoenix-app-added.png)

  Navigate back to the DR Protection group page; the status of DRPG should be active.

7. Add Standby PeopleSoft Process Scheduler Server Compute instance (Linux).

  Select **FSCM92-FSDR-Group-Phoenix** DRPG, click on **Members**, click on **Manage Members** and hit **Add Member**

   ![drpg add member](./images/phoenix-add-member.png)

  It will show various resource types and select **Instance**
   ![drpg resource type](./images/phoenix-add-prcs.png)

- Resource Type is **Instance**
- Instances in Compartment, select PeopleSoft Process Scheduler Server Compute Instance
- **Check** the checkmark of **Non-moving instance**.
- Click Add

  **FSCM92-FSDR-Group-Phoenix** DRPG status will change to updating; wait for a few seconds. DRPG status will change to active.You should be able to see that Standby PeopleSoft Process Scheduler Server compute instance (Linux) has been added as a member. Refresh the DRPG page if required. You can monitor the status in the *Work requests*.

   ![drpg compute added](./images/phoenix-prcs-added.png)

  Navigate back to the DR Protection group page; the status of DRPG should be active.

8. Add Standby PeopleSoft Process Scheduler Server Compute instance (Windows).

  Select **FSCM92-FSDR-Group-Phoenix** DRPG, click on **Members**, click on **Manage Members** and hit **Add Member**

   ![drpg add member](./images/phoenix-add-member.png)

  It will show various resource types and select **Instance**
   ![drpg resource type](./images/phoenix-add-prcs-win.png)

- Resource Type is **Instance**
- Instances in Compartment, select PeopleSoft Application Server Compute Instance
- **Check** the checkmark of **Non-moving instance**.
- Click Add

  **FSCM92-FSDR-Group-Phoenix** DRPG status will change to updating; wait for a few seconds. DRPG status will change to active.You should be able to see that Standby PeopleSoft Process Scheduler Server compute instance (Windows) has been added as a member. Refresh the DRPG page if required. You can monitor the status in the *Work requests*.

   ![drpg compute added](./images/phoenix-prcs-win-added.png)

  Navigate back to the DR Protection group page; the status of DRPG should be active.

9. Add Standby PeopleSoft Web Server Compute instance.

  Select **FSCM92-FSDR-Group-Phoenix** DRPG, click on **Members**, click on **Manage Members** and hit **Add Member**

   ![drpg add member](./images/phoenix-add-member.png)

  It will show various resource types and select **Instance**
   ![drpg resource type](./images/phoenix-add-web.png)

- Resource Type is **Instance**
- Instances in Compartment, select PeopleSoft Application Server Compute Instance
- **Check** the checkmark of **Non-moving instance**.
- Click Add

  **FSCM92-FSDR-Group-Phoenix** DRPG status will change to updating; wait for a few seconds. DRPG status will change to active.You should be able to see that Standby PeopleSoft Web Server compute instance has been added as a member. Refresh the DRPG page if required. You can monitor the status in the *Work requests*.

   ![drpg compute added](./images/phoenix-web-added.png)

  Navigate back to the DR Protection group page; the status of DRPG should be active.

10. Add Standby Elastic Search and Kibana Service Compute instance.

  Select **FSCM92-FSDR-Group-Phoenix** DRPG, click on **Members**, click on **Manage Members** and hit **Add Member**

   ![drpg add member](./images/phoenix-add-member.png)

  It will show various resource types and select **Instance**
   ![drpg resource type](./images/phoenix-add-elk.png)

- Resource Type is **Instance**
- Instances in Compartment, select PeopleSoft Application Server Compute Instance
- **Check** the checkmark of **Non-moving instance**.
- Click Add

  **FSCM92-FSDR-Group-Phoenix** DRPG status will change to updating; wait for a few seconds. DRPG status will change to active.You should be able to see that Standby Elastic Search & Kibana Service compute instance has been added as a member. Refresh the DRPG page if required. You can monitor the status in the *Work requests*.

   ![drpg compute added](./images/phoenix-elk-added.png)

  Navigate back to the DR Protection group page; the status of DRPG should be active.

You may now **proceed to the next lab**.

## Troubleshooting tips

1. After adding the member, in case if the member is not showing up. Re-add the member again.

## Acknowledgements

- **Author** -  Vinay Shivanna, Principal Cloud Architect
- **Last Updated By/Date** -  Vinay Shivanna, Principal Cloud Architect, November 2025
