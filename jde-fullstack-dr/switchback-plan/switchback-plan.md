# Create a DR Switchover Plan (Rollback) from Phoenix to Ashburn region

## Introduction

In our previous lab, we have switched over JDE application from *Ashburn* to *Phoenix* region.

In this lab, we will create a Switchover plan (from *Phoenix* to *Ashburn*) only for the database to use for further labs. As this is a planned switchover, we have our primary servers available without any impact. For actual DR scenarios where we will have no access to servers in our primary region, we will be using Failover plans which is explained in subsequent labs. Now we just need to switchover the database server using DataGuard and use all other JDE servers from the Ashburn region itself. 
Please note that *Phoenix* is the primary region and *Ashburn* is the standby region as of now.  

**DR Plan *must* be created in the standby region (Ashburn)**. 

Estimated Time: 20 Minutes

### Objectives

- Prepare DRPG for Database Rollback
- Prepare primary and standby servers for the rollback
- Create the default Switchover plan
- Run Precheck for the Rollback plan from Ashburn region
- Execute Switchover for the Rollback plan from Ashburn region
- Verify the DRPG status
- Access the Server Manager from Ashburn region
- Verify login to JDE application from Ashburn region

## Task 1: Prepare DRPG for Database Rollback

1. Login into OCI Console. Select region as **Phoenix**.

   ![phoenix region](./images/phoenix-region1.png)

2. Select Migration and Disaster Recovery from the Hamburger menu, then **Disaster Recovery** -> **DR Protection Groups**. Verify the region is **Phoenix**

    ![phoenix region drpg](./images/phoenix-drpgpage.png)

3. You will land on the Disaster Recovery Protection group home page; make sure you have selected the Phoenix region. **DR Plans always be created in the Standby DRPG (Phoenix region)**

    ![drpg home](./images/phoenix-drpg.png)

4. Select the **FSDR\_Moving\_Ash\_to\_Phx\_DB\_with\_All Steps\_Standby** DRPG and navigate to Members under Resources. 

    ![drpg members](./images/phoenix-drpg-members-delete.png)

5. Remove all the members keeping only database in the Phoenix region. Validate that the database is only there as a member. 

    ![drpg members details](./images/phoenix-drpg-members.png)

## Task 2: Prepare primary and standby servers for the rollback

1. Make sure that the JDE applications (all web servers and enterprise servers) at the Phoenix region (current primary) are down to have a clean rollback of the database. 
    
    ![sm console status](./images/phoenix-sm-console.png)

2. Validate the JDE server on the ashburn region (current standby) are available and in stopped status.  

    ![sm console status](./images/ashburn-sm-console.png)

3. Clear the logs from all the JDE servers at Ashburn region and make sure sufficient space is available.

## Task 3: Create the default Switchover plan
    
1. Change the region to Ashburn in OCI Console and go to the DRPG **FSDR\_Moving\_Ash\_to\_Phx\_DB\_with\_All Steps\_Standby**. 
   Validate that the Ashburn region also has only the database as its member. 

    ![drpg member ashburn](./images/ashburn-drpg-members.png)

2. Go to Plans and click on **Create plan** button. 

    ![ashburn create](./images/ashburn-create-plan.png)

3. Select the newly created DR plan and see that it has created the default switchover steps for the database. 

    ![ashburn plan database](./images/ashburn-db-switchback.png)

    ![ashburn plan steps](./images/ashburn-db-switchback-steps.png)

## Task 4: Run Precheck for the Rollback plan from Ashburn region

As part of this task, we will only switchover the Database from Phoenix back to Ashburn as we already have our JDE servers available after the disaster period is over. 

1. Perform pre-check for the new default plan from the plan details page. Click the **Run prechecks** available beside the plan status. 

    ![precheck plan](./images/ashburn-precheck-rollback.png)

2. Provide a suitable name to the precheck execution and click **Run prechecks**. Leave the Ignore warnings option unselected. 

    ![precheck run](./images/ashburn-precheck-run.png)

3. Check the precheck is completed successfully without any error. 

    ![precheck status](./images/ashburn-precheck-status.png)

## Task 5: Execute Switchover for the Rollback plan from Ashburn region

1. Go back to 'DR protection group details' page and then to 'Plan executions' under 'Resources'. 

    ![plan executions](./images/ashburn-rollback-run.png)

2. Click the **Execute DR plan** button to start the switchover. The status of the plan will set to ACTIVE then it will move to IN PROGRESS in few seconds. 

    ![plan executions](./images/ashburn-rollback-execute.png)

3. Check that the plan execution completed successfully. 

    ![plan executions](./images/ashburn-rollback-success.png)

4. Validate that the database role for the Ashburn region database is changed to Primary and the phoenix region's database role is standby.

    ![plan executions](./images/ashburn-db-role.png)
    ![plan executions](./images/phoenix-db-role.png) 

## Task 6: Verify the DRPG status

1. Go to the **DR Protection Groups** page for both primary and standby regions, notice that the *Role* of DRPG at Phoenix has changed to *standby*, and the new *primary* region is Ashburn. 

  ![drpg navigation page](./images/ashburn-drpgpage1.png)

  ![ashburn drpg status](./images/phoenix-drpgpage1.png)

## Task 7: Access the Server Manager from Ashburn region

1. Open the link to the WebLogic Admin Console for the Server Manager at the standby region. The links are only accessible from public internet via SSH tunneling using the bastion host, please configure the same before accessing the links.
  
     ![phoenix weblogic admin](./images/phoenix-weblogic-admin.png)

  Start the SMC Management Console from the WebLogic server, then open the link for the Server Manager console.  

     ![ashburn-servermanager-console](./images/ashburn-servermanager-console1.png)

## Task 8: Verify login to JDE application from Ashburn region

1. Access the JDE application from the browser after doing the required changes for bastion host tunnelling. You should be able to see that the application is working as expected from the Ashburn region.

      ![phoenix-jde-app-verify](./images/phoenix-jde-app-verify.png)
     **JDE is now accessible from the new primary region (Ashburn)**

2. Enter the JDE credentials and validate the login is successful, submit a report to validate the batch server is running fine.

     ![phoenix-jde-app-login](./images/phoenix-jde-app-login.png)

     ![phoenix-jde-app-batch](./images/phoenix-jde-app-batch.png)

3. Open the link for the Orchestrator Studio and make sure its accessible. 

     ![phoenix-orch-login](./images/phoenix-orch-login.png)

We have now rolled back the database to Ashburn from Phoenix region so that we can again use the our original JDE setup for further labs.

   You may now **proceed to the next lab**.

## Acknowledgements

- **Author:** Tarani Meher, Senior JDE Specialist
- **Last Updated By/Date:** Tarani Meher, Senior JDE Specialist, 02/2024
