# Create and Customize the DR Switchover Plan (Rollback) from Phoenix to Ashburn region

## Introduction

In our previous lab, we have switched over PeopleSoft application from *Ashburn* to *Phoenix* region.

In this lab, we will create a DR Switchover plan (from *Phoenix* to *Ashburn*) and customize the plan with the additional steps. *Phoenix* is the primary region and *Ashburn* is the standby region. 

This lab will focus on how to create a Switchover plan and customize the plan as per PeopleSoft application requirements. 

**DR Plan *must* be created in the standby region (Ashburn)**. 

Estimated Time: 180 Minutes

### Objectives

- Create a Switchover plan
- Customize the Switchover plan - Add PeopleSoft Application Shutdown group in Phoenix
- Customize the Switchover plan - Disable files synchronization (rsync) jobs in Phoenix
- Customize the Switchover plan - Add DNS Record Update Script
- Customize the Switchover plan - Add PeopleSoft Application Server boot up group in Ashburn
- Customize the Switchover plan - Add Elastic Search Service boot up group in Ashburn
- Customize the Switchover plan - Add Kibana Service boot up group in Ashburn
- Customize the Switchover plan - Enable files synchronization (rsync) jobs in Ashburn 
- Customize the Switchover plan - DR Plan Re-Ordering

## Task 1: Create a Switchover plan

1. Login into OCI Console. Select region as **Ashburn**.

  ![ashburn region](./images/ashburn-region.png)

2. Select Migration and Disaster Recovery from the Hamburger menu, then **Disaster Recovery** -> **DR Protection Groups**. Verify the region is **Ashburn**

  ![ashburn region drpg](./images/ashburn-drpgpage.png)

3. You will land on the Disaster Recovery Protection group home page; make sure you have selected the Ashburn region. **DR Plans always be created in the Standby DRPG (Ashburn region)**. You can notice that Role of this DRPG is *Standby*.

  ![drpg home](./images/ashburn-drpg.png)

4. Select the **FSCM92-FSDR-Group-Ashburn** DRPG and navigate to Plans under the resources section. Click on Create Plan.

  ![drpg dr plan](./images/ashburn-drplan.png)

  Provide a name for the Switchover Plan.

  Select Plan type as **Switchover (planned)**.

  ![drpg create plan](./images/ashburn-create-drplan.png)

  The plan will start creating.

  ![drpg creating plan](./images/ashburn-drplan-creating.png)

  Refresh the DR Plan page if required. You can monitor the request's status in the **Work requests** section under Resources. Within few minutes, the plan will get created, and it should be in *active* State.

  ![drpg plan created](./images/ashburn-drplan-created.png)

  Select the **FSCM92-FSDR-Switchover-From-Phoenix-To-Ashburn** plan, and you should be able to see the built-in plan groups.

  ![drpg plan details](./images/ashburn-drplan-details.png)

  Based on the members we added in both primary and standby DRPG, FSDR created these built-in plans.

- **Built-in Prechecks** - These are the prechecks for the DB switchover.
- **Switchover Databases (Standby)** - Database switchover.

  ![drpg plan details](./images/ashburn-drplan-detail.png)

## Task 2: Customize the Switchover plan - Add PeopleSoft Application Shutdown group in Phoenix

We will shutdown PeopleSoft Applicaitons in **Phoenix** region as we are doing the switchover from *Phoenix* to *Ashburn*. 

1. Click on Add group.

    ![add plan group](./images/ashburn-plangroup-add.png)

2. Add "Stop PeopleSoft Application in Phoenix" User defined group. Click on Add Step.

    ![phoenix-plangroup-shutdown-psft](./images/ashburn-plangroup-shutdown-psft.png)

    ![phoenix-plangroup-shutdown-app](./images/ashburn-plangroup-shutdown-app.png)

  - Add *Stop PeopleSoft Application Server Domain* in Step name
  - Leave the Enable Step as ticked
  - Select Error mode as "Stop on error"
  - Leave the default "3600" seconds in Timeout in seconds
  - In the region, select "**US West (Phoenix)**"
  - Select the "Run local script" option
  - Select the Application Server instance in "Target instance in compartment" where you have placed the Application Server Domain Shutdown script
  - In the script parameters, add the location of the Application Server Domain Shutdown script.
  - Run as user will be the username who has access to shutdown PeopleSoft Application Server Domain.

Click on Add Step.

3. We will now add Process Scheduler server (Linux) shutdown step. Click on Add Step.

    ![ashburn-plangroup-shutdown-prcs](./images/ashburn-plangroup-shutdown-prcs.png)

    ![ashburn-plangroup-shutdown-prcs2](./images/ashburn-plangroup-shutdown-prcs2.png)

  - Add *Stop PeopleSoft Procss Scheduler Server Domain (Linux)* in Step name
  - Leave the Enable Step as ticked
  - Select Error mode as "Stop on error"
  - Leave the default "3600" seconds in Timeout in seconds
  - In the region, select "**US West (Phoenix)**"
  - Select the "Run local script" option
  - Select the Process Scheduler Server (Linux) instance in "Target instance in compartment" where you have placed the Process Scheduler Server Domain Shutdown script
  - In the script parameters, add the location of the Process Scheduler Server Domain Shutdown script. 
  - Run as user will be the username who has access to shutdown PeopleSoft Process Scheduler Server Domain.

Click on Add Step.

4. We will now add Process Scheduler server (Windows) shutdown step. Click on Add Step.

    ![ashburn-plangroup-shutdown-prcs3](./images/ashburn-plangroup-shutdown-prcs3.png)

    ![ashburn-plangroup-shutdown-prcs4](./images/ashburn-plangroup-shutdown-prcs4.png)

  - Add *Stop PeopleSoft Procss Scheduler Server Domain (Windows)* in Step name
  - Leave the Enable Step as ticked
  - Select Error mode as "Stop on error"
  - Leave the default "3600" seconds in Timeout in seconds
  - In the region, select "**US West (Phoenix)**"
  - Select the "Run local script" option
  - Select the Process Scheduler Server (Windows) instance in "Target instance in compartment" where you have placed the Process Scheduler Server Domain Shutdown script
  - In the script parameters, add the location of the Process Scheduler Server Domain Shutdown script. 
  - Leave Run as user blank for Windows Compute Instance.

Click on Add Step.

5. We will now add Web Server shutdown step. Click on Add Step.

    ![ashburn-plangroup-shutdown-web](./images/ashburn-plangroup-shutdown-web.png)

    ![ashburn-plangroup-shutdown-web2](./images/ashburn-plangroup-shutdown-web2.png)

  - Add *Stop PeopleSoft Web Server Domain* in Step name
  - Leave the Enable Step as ticked
  - Select Error mode as "Stop on error"
  - Leave the default "3600" seconds in Timeout in seconds
  - In the region, select "**US West (Phoenix)**"
  - Select the "Run local script" option
  - Select the Web Server instance in "Target instance in compartment" where you have placed the Web Server Domain Shutdown script
  - In the script parameters, add the location of the Web Server Domain Shutdown script. 
  - Run as user will be the username who has access to shutdown PeopleSoft Web Server Domain.

Click on Add Step.

6. We will now add Elastic Search services shutdown step. Click on Add Step.

    ![ashburn-plangroup-shutdown-elk](./images/ashburn-plangroup-shutdown-elk.png)

  - Add *Stop Elastic Search Services in Phoenix* in Step name
  - Leave the Enable Step as ticked
  - Select Error mode as "Stop on error"
  - Leave the default "3600" seconds in Timeout in seconds
  - In the region, select "**US West (Phoenix)**"
  - Select the "Run local script" option
  - Select the Elastic Search Server compute instance in "Target instance in compartment" where you have placed the Elastic Search services Shutdown script
  - In the script parameters, add the location of the Elastic Search services Shutdown script
  - Run as user will be the username who has access to shutdown Elastic Search services

Click on Add Step.

7. We will now add Kibana services shutdown step. Click on Add Step.

    ![ashburn-plangroup-shutdown-kibana](./images/ashburn-plangroup-shutdown-kibana.png)

  - Add *Stop Kibana Services in Phoenix* in Step name
  - Leave the Enable Step as ticked
  - Select Error mode as "Stop on error"
  - Leave the default "3600" seconds in Timeout in seconds
  - In the region, select "**US West (Phoenix)**"
  - Select the "Run local script" option
  - Select the Kibana Server compute instance in "Target instance in compartment" where you have placed the Kibana services Shutdown script
  - In the script parameters, add the location of the Kibana services Shutdown script
  - Run as user will be the username who has access to shutdown Kibana services

  Click on Add Step.

  Now, we have added shutdown steps for PeopleSoft Application Server, Process Scheduler (both Linux and Windows), Web server domains, Elastic Search and Kibana services hosted in *Phoenix* region.
   
  Click on Add.

  DRPG will go to status of Updating, please wait for few minutes.

    ![ashburn-shutdown-phoenix-psft-done](./images/ashburn-shutdown-phoenix-psft-done.png)


## Task 4: Customize the Switchover plan - Disable files synchronization (rsync) jobs in Phoenix

As part of this task, we will disable all the synchronization jobs that are enabled to run in *Phoenix* region to keep DR (standby) in sync with production environment.

1. Click on Add group.

    ![add plan group](./images/ashburn-plangroup-add.png)

2. We will disable cronjob (rsync) in Application Server. Add "Stop\_rsync\_in\_Phoenix\_App" User defined group. Click on Add Step.

    ![ashburn-add-sync-stop-script](./images/ashburn-add-sync-stop-script.png)

    ![ashburn-add-app-sync-stop-script](./images/ashburn-add-app-sync-stop-script.png)    

    - Add *Disable-rsync-in-Phoenix-APP* in Step name
    - Leave the Enable Step as ticked
    - Select Error mode as "Stop on error"
    - Leave the default "3600" seconds in Timeout in seconds
    - In the region, select "**US West (Phoenix)**"
    - Select the "Run local script" option
    - Select the server instance in "Target instance in compartment" where you have placed the cronjob (rsync) disable script
    - In the script parameters, add the location of the cronjob (rsync) disable script
    - Run as user will be the user who has access to disable cronjobs

    Click on Add Step.

3. We will now disable cronjob (rsync) in Process Scheduler Server. Click on Add Step.

    ![phoenix-add-sync-stop-script](./images/phoenix-add-sync-stop-script2.png)

    ![phoenix-add-prcs-sync-stop-script](./images/phoenix-add-prcs-sync-stop-script.png)    

    - Add *Disable-rsync-in-Phoenix-PRCS* in Step name
    - Leave the Enable Step as ticked
    - Select Error mode as "Stop on error"
    - Leave the default "3600" seconds in Timeout in seconds
    - In the region, select "**US West (Phoenix)**"
    - Select the "Run local script" option
    - Select the server instance in "Target instance in compartment" where you have placed the cronjob (rsync) disable script
    - In the script parameters, add the location of the cronjob (rsync) disable script
    - Run as user will be the user who has access to disable cronjobs

    Click on Add Step.

4. We will now disable cronjob (rsync) in Web Server. Click on Add Step.

    ![phoenix-add-sync-stop-script](./images/phoenix-add-sync-stop-script3.png)

    ![phoenix-add-web-sync-stop-script](./images/phoenix-add-web-sync-stop-script.png)    

    - Add *Disable-rsync-in-Phoenix-WEB* in Step name
    - Leave the Enable Step as ticked
    - Select Error mode as "Stop on error"
    - Leave the default "3600" seconds in Timeout in seconds
    - In the region, select "**US West (Phoenix)**"
    - Select the "Run local script" option
    - Select the server instance in "Target instance in compartment" where you have placed the cronjob (rsync) disable script
    - In the script parameters, add the location of the cronjob (rsync) disable script
    - Run as user will be the user who has access to disable cronjobs

    Click on Add Step.

    ![phoenix-add-sync-stop-script-add](./images/add-sync-stop-script-add.png)       

    Click on Add.

    ![phoenix-add-sync-stop-script-done](./images/add-sync-stop-script-done.png)    

## Task 5: Customize the Switchover plan - Add DNS Record Update Script

1. Click on Add group.

    ![add plan group](./images/ashburn-plangroup-add.png)

2. Add "DNS Record Update" User defined group. Click on Add Step.

    ![phoenix-add-dns-update-script](./images/phoenix-add-dns-update-script.png)

    ![phoenix-add-dns-update-script](./images/phoenix-add-dns-update-script2.png)

  - Add *DNS Record Update* in Group name
  - Add *Update DNS Record* in Step name
  - Leave the Enable Step as ticked
  - Select Error mode as "Stop on error"
  - Leave the default "3600" seconds in Timeout in seconds
  - In the region, select "US East (Ashburn)"
  - Select the "Run local script" option
  - Select the server instance in "Target instance in compartment" where you have placed the DNS record update script
  - In the script parameters, add the location of the DNS Record update script
  - Run as user will be the username who has access to update DNS records

  Click on Add Step.
 
  Click on Add.

  ![phoenix-add-dns-update-group](./images/phoenix-add-dns-update-group.png)

## Task 6: Customize the Switchover plan - Add PeopleSoft Application Boot-up Group in Ashburn

1. Click on Add group.

  ![add plan group](./images/ashburn-plangroup-add.png)

2. Add "Start Application Server Domains" User defined group. We will now add PeopleSoft Application Server boot up step. Click on Add Step.

    ![add-app-boot-script](./images/phoenix-add-app-boot-script.png)

    ![add-app-boot-script](./images/phoenix-add-app-boot-script2.png)

  - Add *Start PeopleSoft Application in Ashburn* in Group name
  - Add *Boot of Application Server Domains* in Step name
  - Leave the Enable Step as ticked
  - Select Error mode as "Stop on error"
  - Leave the default "3600" seconds in Timeout in seconds
  - In the region, select "US East (Ashburn)"
  - Select the "Run local script" option
  - Select application server instance in "Target instance in compartment"
  - In script parameters, add the location of the application server domain start-up script
  - Run as user will be the username who has access to boot Application Server domain

Click on Add Step.
 
3. We will now add PeopleSoft Process Scheduler (Linux) boot up step.

    ![add-prcs-boot-script](./images/phoenix-add-prcs-boot-script.png)

    ![phoenix-add-prcs-linux-boot-script](./images/phoenix-add-prcs-linux-boot-script.png)

  - Add *Boot up Process Scheduler Domains (Linux)* in Step name
  - Leave the Enable Step as ticked
  - Select Error mode as "Stop on error"
  - Leave the default "3600" seconds in Timeout in seconds
  - In the region, select "US East (Ashburn)"
  - Select the "Run local script" option
  - Select process scheduler server instance in "Target instance in compartment"
  - In script parameters, add the location of the process scheduler server domain start-up script
  - Run as user will be the username who has access to boot Process Scheduler Server domain

Click on Add Step.
 
4. We will now add PeopleSoft Process Scheduler (Windows) boot up step. Click on Add Step.

    ![phoenix-add-prcs-windows-boot-script](./images/phoenix-add-prcs-windows-boot-script.png)

    ![phoenix-add-prcs-windows-boot-script](./images/phoenix-add-prcs-windows-boot-script2.png)

  - Add *Boot up Process Scheduler Domains (Windows)* in Step name
  - Leave the Enable Step as ticked
  - Select Error mode as "Stop on error"
  - Leave the default "3600" seconds in Timeout in seconds
  - In the region, select "US East (Ashburn)"
  - Select the "Run local script" option
  - Select process scheduler server instance in "Target instance in compartment"
  - In script parameters, add the location of the process scheduler server domain start-up script
  - Run as user will be blank for Windows compute instance

Click on Add Step.
 
5. We will now add Web Server Boot up step. Click on Add Step.

    ![phoenix-add-web-boot-script](./images/phoenix-add-web-boot-script.png)

    ![phoenix-add-web-boot-script](./images/phoenix-add-web-boot-script2.png)

  - Add *Boot up Web Server Domains* in Step name
  - Leave the Enable Step as ticked
  - Select Error mode as "Stop on error"
  - Leave the default "3600" seconds in Timeout in seconds
  - In the region, select "US East (Ashburn)"
  - Select the "Run local script" option
  - Select web server instance in "Target instance in compartment"
  - In script parameters, add the location of the web server domain start-up script
  - Run as user will be the username who has access to boot Web Server domain

Click on Add Step.

Click on Add.

   ![phoenix-add-boot-scripts](./images/phoenix-add-boot-scripts.png)
 
## Task 7: Customize the Switchover plan - Add Elastic Search Services Boot-up Scripts in Ashburn
    
1. Click on Add group. Provide a name to the group as Start Elastic Search Services.

    ![add plan group](./images/ashburn-plangroup-add.png)

2. We will now add Elastic Search boot up script. Click on Add Step.

    ![phoenix-add-elk-boot-script](./images/phoenix-add-elk-boot-script.png)

    ![phoenix-add-elk-boot-script](./images/phoenix-add-elk-boot-script2.png)

  - Add *Start Elastic Search Services* in group name
  - Add *Boot up Elastic Search Services* in Step name
  - Leave the Enable Step as ticked
  - Select Error mode as "Stop on error"
  - Leave the default "3600" seconds in Timeout in seconds
  - In the region, select "US East (Ashburn)"
  - Select the "Run local script" option
  - Select Elastic Search server instance in "Target instance in compartment"
  - In the script parameters, add the location of the Elastic Search services start-up script
  - Run as user will be the username who has access to boot Elastic Search services

  Click on Add.

    ![phoenix-add-elk-boot-group](./images/phoenix-add-elk-boot-group.png)

## Task 8: Customize the Switchover plan - Add Kibana Services Boot-up Scripts in Ashburn

1. Click on Add group. Provide a name to the group as Start Kibana Services.

    ![add plan group](./images/ashburn-plangroup-add.png)

2. We will now add Kibana Services boot up script. Click on Add Step.

    ![phoenix-add-kibana-boot-script](./images/phoenix-add-kibana-boot-script.png)
 
    ![phoenix-add-kibana-boot-script](./images/phoenix-add-kibana-boot-script2.png)

  - Add *Start Kibana Services* in group name
  - Add *Boot up Kibana Services* in Step name
  - Leave the Enable Step as ticked
  - Select Error mode as "Stop on error"
  - Leave the default "3600" seconds in Timeout in seconds
  - In the region, select "US East (Ashburn)"
  - Select the "Run local script" option
  - Select Kibana server instance in "Target instance in compartment"
  - In the script parameters, add the location of the Kibana services start-up script
  - Run as user will be the username who has access to boot Kibana services

  Click on Add.

    ![phoenix-add-kibana-boot-group](./images/phoenix-add-kibana-boot-group3.png)

## Task 9: Customize the Switchover plan - Enable files synchronization (rsync) jobs in Ashburn

 As part of this task, we will enable synchronization (rsync) jobs in Phoenix to reverse the sync from Phoenix to Ashburn post switchover as the roles (priamry and standby) are now reversed.

 1. Click on Add group.

    ![add plan group](./images/ashburn-plangroup-add.png)

2. We will enable cronjob (rsync) in Application Server. Add "Enable-rsync-in-Ashburn" User defined group. Click on Add Step.

    ![phoenix-add-sync-start-script](./images/phoenix-add-sync-start-script.png)

    ![phoenix-add-app-sync-start-script](./images/phoenix-add-app-sync-start-script.png)    

    - Add *Enable-rsync-in-Ashburn-App* in Step name
    - Leave the Enable Step as ticked
    - Select Error mode as "Stop on error"
    - Leave the default "3600" seconds in Timeout in seconds
    - In the region, select "**US East (Ashburn)**"
    - Select the "Run local script" option
    - Select the server instance in "Target instance in compartment" where you have placed the cronjob (rsync) enable script
    - In the script parameters, add the location of the cronjob (rsync) enable script
    - Run as user will be the user who has access to enable cronjobs
  
    Click on Add Step.

3. We will now enable cronjob (rsync) in Process Scheduler Server. Click on Add Step.

    ![phoenix-add-sync-stop-script](./images/phoenix-add-sync-start-script2.png)

    ![phoenix-add-prcs-sync-stop-script](./images/phoenix-add-prcs-sync-start-script.png)    

    - Add *Enable-rsync-in-Ashburn-PRCS* in Step name
    - Leave the Enable Step as ticked
    - Select Error mode as "Stop on error"
    - Leave the default "3600" seconds in Timeout in seconds
    - In the region, select "**US East (Ashburn)**"
    - Select the "Run local script" option
    - Select the server instance in "Target instance in compartment" where you have placed the cronjob (rsync) enable script
    - In the script parameters, add the location of the cronjob (rsync) enable script
    - Run as user will be the user who has access to enable cronjobs

    Click on Add Step.

4. We will now enable cronjob (rsync) in Web Server. Click on Add Step.

    ![phoenix-add-sync-stop-script](./images/phoenix-add-sync-start-script3.png)

    ![phoenix-add-web-sync-stop-script](./images/phoenix-add-web-sync-start-script.png)    

    - Add *Enable-rsync-in-Ashburn-WEB* in Step name
    - Leave the Enable Step as ticked
    - Select Error mode as "Stop on error"
    - Leave the default "3600" seconds in Timeout in seconds
    - In the region, select "**US East (Ashburn)**"
    - Select the "Run local script" option
    - Select the server instance in "Target instance in compartment" where you have placed the cronjob (rsync) enable script
    - In the script parameters, add the location of the cronjob (rsync) enable script
    - Run as user will be the user who has access to enable cronjobs

  Click on Add Step.

  Click on Add.

    ![phoenix-add-sync-start-script-done](./images/add-sync-start-script-done.png)    

## Task 10: Customize the Switchover plan - DR Plan Re-Ordering

  We will now re-order the DR plan to stop PeopleSoft Application in Primary (*Phoenix*) region first, 
  followed by switchover to Standby (*Ashburn*) region.

1. Click on Actions under the DR plan and click on **Reorder groups**.

   ![phoenix-dr-plan-re-order](./images/ashburn-dr-plan-re-order.png)

   Move group **Stop PeopleSoft Application in Phoenix** one order above **Switchover Databases (Standby)** so that Ashburn region hosted Primary production application is shutdown before switchover.

    ![phoenix-dr-plan-re-order-shutdown](./images/phoenix-dr-plan-re-order-shutdown.png)  

    ![phoenix-dr-plan-re-order-shutdown1](./images/phoenix-dr-plan-re-order-shutdown1.png)

   Click Save changes.

2. Click on Actions under the DR plan and click on **Reorder groups**.

   ![phoenix-dr-plan-re-order](./images/ashburn-dr-plan-re-order.png)

   Move group **Stop\_rsync\_in\_Phoenix\_App** one order above **Switchover Databases (Standby)**.

    ![phoenix-dr-plan-re-order-sync](./images/phoenix-dr-plan-re-order-sync.png) 

    ![phoenix-dr-plan-re-order-sync](./images/phoenix-dr-plan-re-order-sync1.png) 

   Click Save changes.

   Now the DR Swithover plan is re-ordered as below.

    ![phoenix-dr-plan-re-order-done](./images/phoenix-dr-plan-re-order-done.png)

   You may now **proceed to the next lab**.

## Acknowledgements

- **Author** -  Vinay Shivanan, Prinicpal Cloud Architect
- **Last Updated By/Date** -  Vinay Shivanan, Prinicpal Cloud Architect, April 2023
