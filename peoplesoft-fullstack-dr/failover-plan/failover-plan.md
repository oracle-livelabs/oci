# Create and Customize the DR Failover Plan

## Introduction

In this lab, we will create a DR Failover plan and customize the plan with the additional steps. Ashburn is the primary region and Phoenix is the standby region. FSDR provides two types of plan

- Failover (Maintenance/Planned Disaster Recovery)
- Failover   (Actual Disaster Recovery/Unplanned)

This lab will focus on how to create a Failover plan and customize the plan as per PeopleSoft application requirements. 

**DR Plan *must* be created in the standby region (Phoenix)**. It is because, in the case of the worst-case scenario, the entire primary region outside the FSDR will not be accessible from the primary region.

Estimated Time: 60 Minutes

### Objectives

- Create a Failover plan
- Customize the Failover plan - Add DNS Record Update Script
- Customize the Failover plan - Add PeopleSoft Application boot up group in Phoenix
- Customize the Failover plan - Add Elastic Search Service boot up group in Phoenix
- Customize the Failover plan - Add Kibana Service boot up group in Phoenix
- Customize the Failover plan - Enable files synchronization (rsync) jobs in Phoenix 
- Customize the Failover plan - DR Plan Re-Ordering

## Task 1: Create a Failover plan

1. Login into OCI Console. Select region as **Phoenix**.

  ![phoenix region](./images/phoenix-region1.png)

2. Select Migration and Disaster Recovery from the Hamburger menu, then **Disaster Recovery** -> **DR Protection Groups**. Verify the region is **Phoenix**

  ![phoenix region drpg](./images/phoenix-drpgpage.png)

3. You will land on the Disaster Recovery Protection group home page; make sure you have selected the Phoenix region. **DR Plans always be created in the Standby DRPG (Phoenix region)**

  ![drpg home](./images/phoenix-drpg.png)

4. Select the **FSCM92-FSDR-Group-Phoenix** DRPG and navigate to Plans under the resources section. Click on Create Plan.

  ![drpg dr plan](./images/phoenix-drplan.png)

  Provide a name for the Failover Plan.

  Select Plan type as **Failover (planned)**.

  ![drpg create plan](./images/phoenix-create-drplan.png)

  The plan will start creating.

  ![drpg creating plan](./images/phoenix-drplan-creating.png)

  Refresh the DR Plan page if required. You can monitor the request's status in the **Work requests** section under Resources. Within few minutes, the plan will get created, and it should be in *active* State.

  ![drpg plan created](./images/phoenix-drplan-created.png)

  Select the **FSCM92\_FSDR\_Failover\_From\_Ashburn\_To\_Phoenix** plan, and you should be able to see the built-in plan groups.

  ![drpg plan details](./images/phoenix-drplan-details.png)

  Based on the members we added in both primary and standby DRPG, FSDR created these built-in plans.

- **Built-in Prechecks** - These are the prechecks for the DB Failover.
- **Failover Databases (Standby)** - Database Failover.

  ![drpg plan details](./images/phoenix-drplan-detail.png)

## Task 2: Customize the Failover plan - Add DNS Record Update Script

1. Click on Add group.

    ![add plan group](./images/phoenix-plangroup-add.png)

2. Add "DNS Record Update" User defined group. Click on Add Step.

    ![phoenix-add-dns-update-script](./images/phoenix-add-dns-update-script1.png)

    ![phoenix-add-dns-update-script](./images/phoenix-add-dns-update-script.png)

  - Add *Update DNS Record* in Step name
  - Leave the Enable Step as ticked
  - Select Error mode as "Stop on error"
  - Leave the default "3600" seconds in Timeout in seconds
  - In the region, select "US West (Phoenix)"
  - Select the "Run local script" option
  - Select the server instance in "Target instance in compartment" where you have placed the DNS record update script
  - In the script parameters, add the location of the DNS Record update script.
  - Run as user will be the username who has access to update DNS records.

  Click on Add Step.
 
  Click on Add.

  ![phoenix-add-dns-update-group](./images/phoenix-add-dns-update-group.png)

## Task 3: Customize the Failover plan - Add PeopleSoft Application Boot-up Group in Phoenix

1. Click on Add group.

  ![add plan group](./images/phoenix-plangroup-add1.png)

2. Add "Start Application Server Domains" User defined group. We will now add PeopleSoft Application Server boot up step. Click on Add Step.

    ![add-app-boot-script](./images/phoenix-add-app-boot-script.png)

    ![add-app-boot-script](./images/phoenix-add-app-boot-script2.png)

  - Add *Start PeopleSoft Application in Phoenix* in Group name
  - Add *Boot of Application Server Domains* in Step name
  - Leave the Enable Step as ticked
  - Select Error mode as "Stop on error"
  - Leave the default "3600" seconds in Timeout in seconds
  - In the region, select "US West (Phoenix)"
  - Select the "Run local script" option
  - Select application server instance in "Target instance in compartment"
  - In script parameters, add the location of the application server domain start-up script.
  - Run as user will be the username who has access to boot Application Server domain

Click on Add Step.
 
3. We will now add PeopleSoft Process Scheduler (Linux) boot up step.

    ![add-prcs-boot-script](./images/phoenix-add-prcs-boot-script.png)

    ![phoenix-add-prcs-linux-boot-script](./images/phoenix-add-prcs-linux-boot-script.png)

  - Add *Boot up Process Scheduler Domains (Linux)* in Step name
  - Leave the Enable Step as ticked
  - Select Error mode as "Stop on error"
  - Leave the default "3600" seconds in Timeout in seconds
  - In the region, select "US West (Phoenix)"
  - Select the "Run local script" option
  - Select process scheduler server instance in "Target instance in compartment"
  - In script parameters, add the location of the process scheduler server domain start-up script.
  - Run as user will be the username who has access to boot Process Scheduler Server domain.

Click on Add Step.
 
4. We will now add PeopleSoft Process Scheduler (Windows) boot up step. Click on Add Step.

    ![phoenix-add-prcs-windows-boot-script](./images/phoenix-add-prcs-windows-boot-script.png)

    ![phoenix-add-prcs-windows-boot-script](./images/phoenix-add-prcs-windows-boot-script2.png)

  - Add *Boot up Process Scheduler Domains (Windows)* in Step name
  - Leave the Enable Step as ticked
  - Select Error mode as "Stop on error"
  - Leave the default "3600" seconds in Timeout in seconds
  - In the region, select "US West (Phoenix)"
  - Select the "Run local script" option
  - Select process scheduler server instance in "Target instance in compartment"
  - In script parameters, add the location of the process scheduler server domain start-up script
  - Run as user will be blank for Windows compute instance

Click on Add Step.
 
Click on Add.

5. We will now add Web Server Boot up step. Click on Add Step.

    ![phoenix-add-web-boot-script](./images/phoenix-add-web-boot-script.png)

    ![phoenix-add-web-boot-script](./images/phoenix-add-web-boot-script2.png)

  - Add *Boot up Web Server Domains* in Step name
  - Leave the Enable Step as ticked
  - Select Error mode as "Stop on error"
  - Leave the default "3600" seconds in Timeout in seconds
  - In the region, select "US West (Phoenix)"
  - Select the "Run local script" option
  - Select web server instance in "Target instance in compartment"
  - In script parameters, add the location of the web server domain start-up script
  - Run as user will be the username who has access to boot Web Server domain

  Click on Add Step.

  Click on Add.

      ![phoenix-add-app-boot-group2](./images/phoenix-add-app-boot-group2.png)

## Task 4: Customize the Failover plan - Add Elastic Search Services Boot-up Scripts in Phoenix
    
1. Click on Add group. Provide a name to the group as Start Elastic Search Services.

    ![add plan group](./images/phoenix-plangroup-add_els.png)

2. We will now add Elastic Search boot up script. Click on Add Step.

    ![phoenix-add-elk-boot-script](./images/phoenix-add-elk-boot-script.png)

    ![phoenix-add-elk-boot-script](./images/phoenix-add-elk-boot-script2.png)

  - Add *Start Elastic Search Services* in group name
  - Add *Boot up Elastic Search Services* in Step name
  - Leave the Enable Step as ticked
  - Select Error mode as "Stop on error"
  - Leave the default "3600" seconds in Timeout in seconds
  - In the region, select "US West (Phoenix)"
  - Select the "Run local script" option
  - Select Elastic Search server instance in "Target instance in compartment"
  - In the script parameters, add the location of the Elastic Search services start-up script
  - Run as user will be the username who has access to boot Elastic Search services

  Click on Add.

    ![phoenix-add-elk-boot-group](./images/phoenix-add-elk-boot-group.png)

## Task 5: Customize the Failover plan - Add Kibana Services Boot-up Scripts in Phoenix

1. Click on Add group. Provide a name to the group as Start Kibana Services.

    ![add plan group](./images/phoenix-plangroup-add-kib.png)

2. We will now add Kibana Services boot up script. Click on Add Step.

    ![phoenix-add-kibana-boot-script](./images/phoenix-add-kibana-boot-script.png)
 
    ![phoenix-add-kibana-boot-script](./images/phoenix-add-kibana-boot-script2.png)

  - Add *Start Kibana Services* in group name
  - Add *Boot up Kibana Services* in Step name
  - Leave the Enable Step as ticked
  - Select Error mode as "Stop on error"
  - Leave the default "3600" seconds in Timeout in seconds
  - In the region, select "US West (Phoenix)"
  - Select the "Run local script" option
  - Select Kibana server instance in "Target instance in compartment"
  - In the script parameters, add the location of the Kibana services start-up script
  - Run as user will be the username who has access to boot Kibana services

  Click on Add.

    ![phoenix-add-kibana-boot-group](./images/phoenix-add-kibana-boot-group3.png)

## Task 6: Customize the Failover plan - Enable files synchronization (rsync) jobs in Phoenix

 As part of this task, we will enable synchronization (rsync) jobs in Phoenix to reverse the sync from Phoenix to Ashburn post Failover as the roles (priamry and standby) will be reversed.

 1. Click on Add group.

    ![add plan group](./images/phoenix-plangroup-add_rsync.png)

2. We will enable cronjob (rsync) in Application Server. Add "Enable\_rsync\_in\_Phoenix" User defined group. Click on Add Step.

    ![phoenix-add-sync-start-script](./images/phoenix-add-sync-start-script.png)

    ![phoenix-add-app-sync-start-script](./images/phoenix-add-app-sync-start-script.png)    

    - Add *Enable-rsync-in-Phoenix-App* in Step name
    - Leave the Enable Step as ticked
    - Select Error mode as "Stop on error"
    - Leave the default "3600" seconds in Timeout in seconds
    - In the region, select "US West (Phoenix)"
    - Select the "Run local script" option
    - Select the server instance in "Target instance in compartment" where you have placed the cronjob (rsync) enable script
    - In the script parameters, add the location of the cronjob (rsync) enable script
    - Run as user will be the user who has access to enable cronjobs
  
    Click on Add Step.

3. We will now enable cronjob (rsync) in Process Scheduler Server. Click on Add Step.

    ![phoenix-add-sync-stop-script](./images/phoenix-add-sync-start-script2.png)

    ![phoenix-add-prcs-sync-stop-script](./images/phoenix-add-prcs-sync-start-script.png)    

    - Add *Enable-rsync-in-Phoenix-PRCS* in Step name
    - Leave the Enable Step as ticked
    - Select Error mode as "Stop on error"
    - Leave the default "3600" seconds in Timeout in seconds
    - In the region, select "US West (Phoenix)"
    - Select the "Run local script" option
    - Select the server instance in "Target instance in compartment" where you have placed the cronjob (rsync) enable script
    - In the script parameters, add the location of the cronjob (rsync) enable script
    - Run as user will be the user who has access to enable cronjobs

    Click on Add Step.

4. We will now enable cronjob (rsync) in Web Server. Click on Add Step.

    ![phoenix-add-sync-stop-script](./images/phoenix-add-sync-start-script3.png)

    ![phoenix-add-web-sync-stop-script](./images/phoenix-add-web-sync-start-script.png)    

    - Add *Enable-rsync-in-Phoenix-WEB* in Step name
    - Leave the Enable Step as ticked
    - Select Error mode as "Stop on error"
    - Leave the default "3600" seconds in Timeout in seconds
    - In the region, select "US West (Phoenix)"
    - Select the "Run local script" option
    - Select the server instance in "Target instance in compartment" where you have placed the cronjob (rsync) enable script
    - In the script parameters, add the location of the cronjob (rsync) enable script
    - Run as user will be the user who has access to enable cronjobs

  Click on Add Step.

  Click on Add.

      ![phoenix-add-sync-stop-script](./images/phoenix-add-sync-start-script4.png)

DR Failover plan is now updated with customized steps.

   ![phoenix-add-sync-stop-script](./images/phoenix-dr-plan-done.png)

   You may now **proceed to the next lab**.

## Acknowledgements

- **Author** -  Vinay Shivanna, Principal Cloud Architect
- **Last Updated By/Date** -  Vinay Shivanna, Principal Cloud Architect, April 2023
