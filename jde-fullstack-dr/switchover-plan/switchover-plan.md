# Create and Customize the DR Switchover Plan

## Introduction

In this lab, we will create a DR Switchover plan and customize the plan with the additional steps. Ashburn is the primary region and Phoenix is the standby region. FSDR provides two types of plan

- Switchover (Maintenance/Planned Disaster Recovery)
- Failover   (Actual Disaster Recovery/Unplanned)
- Start drill (Validating DR affectiveness by creating a replica)
- Stop drill (Removing the replica created by start drill)

This lab will focus on how to create a Switchover plan and customize the plan as per the JDE application requirements. 

**DR Plan *must* be created in the standby region (Phoenix)**. It is because, in the case of the worst-case scenario, the entire primary region outside the FSDR will not be accessible from the primary region.

Estimated Time: 180 Minutes

### Objectives

- Create a Switchover plan
- Customize the Switchover plan - Update Logic Server Configuration
- Customize the Switchover plan - Update Batch Server Configuration
- Customize the Switchover plan - Update HTML server configuration files
- Customize the Switchover plan - Update SM Agents of all DR servers
- Customize the Switchover plan - Update SM Server management-console.xml
- Customize the Switchover plan - Stop E1 Services and Agents
- Customize the Switchover plan - Stop NodeManager and WebLogic Services on SM Server and Agents on Web Servers
- Customize the Switchover plan - Start E1 Services and Agents
- Customize the Switchover plan - Start Agents and Node Manager on Web Server and SM Server
- Customize the Switchover plan - Start WebLogic on Web Servers and SM Server


## Task 1: Create a Switchover plan

1. Login into OCI Console. Select region as **Phoenix**.

   ![phoenix region](./images/phoenix-region1.png)

2. Select Migration and Disaster Recovery from the Hamburger menu, then **Disaster Recovery** -> **DR Protection Groups**. Verify the region is **Phoenix**

    ![phoenix region drpg](./images/phoenix-drpgpage.png)

3. You will land on the Disaster Recovery Protection group home page; make sure you have selected the Phoenix region. **DR Plans always be created in the Standby DRPG (Phoenix region)**

    ![drpg home](./images/phoenix-drpg.png)

4. Select the **FSDR\_Moving\_Ash\_to\_Phx\_DB\_with\_All Steps\_Standby** DRPG and navigate to Plans under the resources section. Click on Create Plan.

  ![drpg dr plan](./images/phoenix-drplan.png)

  Provide a name for the Switchover Plan.

  Select Plan type as **Switchover (planned)**.

  ![drpg create plan](./images/phoenix-create-drplan.png)

  Refresh the DR Plan page if required. You can monitor the request's status in the **Work requests** section under Resources. Within few minutes, the plan will get created, and it should be in *active* State.

  ![drpg plan created](./images/phoenix-drplan-created.png)

  Select the **JDE\_FSDR\_Switchover\_Ashburn\_to\_Phoenix** plan, and you should be able to see the built-in plan groups.

  ![drpg plan details](./images/phoenix-drplan-details.png)

  Based on the members we added in both primary and standby DRPG, FSDR created these built-in plans.
  
  ![phoenix-precheck-builtin](./images/phoenix-precheck-builtin.png)

  - **Built-in Prechecks** - These are the prechecks for the plan with all servers and database. Expand to see all steps and details.

  - **Stop Compute Instances** - Stopping all the instances in the primary as a part of moving instance.

  - **Switchover Volume Groups** - Restore volume group switchover.

  - **Switchover Databases** - Database switchover to standby using dataguard.

  - **Launch Compute Instances** - Launch the compute instances at the standby region as a part of moving instance.

  - **Reverse Volume Groups' Replication** - Reverse volume group.

  - **Terminate Compute Instances** - Terminate compute instances at primary, this is disabled by default.

  - **Remove Compute Instances from DR Protection Group** - Remove Compute Instances from DR Protection Group.

  - **Terminate Compute Instances** - Terminate compute instances at primary, this is disabled by default.

  - **Terminate Volume Groups** - Terminate volume group.

  - **StepsRemove Volume Groups from DR Protection Group** - StepsRemove Volume Groups from DR Protection Group.

  *Note:* To create a DR Plan using CLI, please follow the link [Automate FSDR with CLI](https://docs.oracle.com/en/learn/full-stack-dr-oci-cli-command/#introduction)

## Task 2: Customize the Switchover plan - Add a group to update Logic Server configuration

We need to add the custom update groups after the "**Launch Compute Instances**" pre-built group so that the scripts will run in the newly launched instances.

  1. Click on **Add group**.

    ![add plan group](./images/phoenix-group-add_logic.png)
      In "Add plan group" page, enter a suitable **Group name**

      Select the **Add after** button to add the group after a particular group.
      
      Select the **Group** after which you want to add this custom group.

      Click **Add step** to add the scripts parameters. 

    ![phoenix-step-add-logic-tns](./images/phoenix-step-add-logic-tns.png)
      In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch. *This is intentional as we do not have the instance available in the stand-by region for a movable instance setup*.

      Select the **Run local script** button.

      Select the logic server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present.

      Enter the user with which you want to run the script in the **Run as user** field. 

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed. 

  2. Click **Add Step** to add another step in the group. 
    ![phoenix-step-add-logic-jde](./images/phoenix-step-add-logic-jde.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the logic server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  3. Click **Add Step** to add another step in the group. 
    ![phoenix-step-add-logic-host](./images/phoenix-step-add-logic-host.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the logic server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  4. Validate that all three steps are added and click **Add** to proceed.
  ![phoenix-step-add-logic-all](./images/phoenix-step-add-logic-all.png)


## Task 3: Customize the Switchover plan - Add a group to update Batch Server configuration

Add this custom update group after the "**Update Logic Server Configuration**" group to maintain a sequence.

  1. Click on **Add group**.

    ![add plan group](./images/phoenix-group-add_batch.png)
      In "Add plan group" page, enter a suitable **Group name**

      Select the **Add after** button to add the group after a particular group.
      
      Select the **Group** after which you want to add this custom group.

      Click **Add step** to add the scripts parameters. 

    ![phoenix-step-add-batch-tns](./images/phoenix-step-add-batch-tns.png)
      In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the logic server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present.

      Enter the user with which you want to run the script in the **Run as user** field. 

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed. 

  2. Click **Add Step** to add another step in the group. 
    ![phoenix-step-add-batch-jde](./images/phoenix-step-add-batch-jde.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the logic server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  3. Click **Add Step** to add another step in the group. 
    ![phoenix-step-add-batch-host](./images/phoenix-step-add-batch-host.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the batch server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  4. Validate that all three steps are added and click **Add** to proceed.
  ![phoenix-step-add-batch-all](./images/phoenix-step-add-batch-all.png)

## Task 4: Customize the Switchover plan - Add a group to update HTML Server configuration files

Add this custom update group after the "**Update Batch Server Configuration**" group to maintain a sequence.

  1. Click on **Add group**.

    ![phoenix-group-add-html](./images/phoenix-group-add-html.png)
      In "Add plan group" page, enter a suitable **Group name**

      Select the **Add after** button to add the group after a particular group.
      
      Select the **Group** after which you want to add this custom group.

      Click **Add step** to add the scripts parameters. 

    ![phoenix-step-add-htm1-wls1-tns-jdbj](./images/phoenix-step-add-htm1-wls1-tns-jdbj.png)
      In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the wls1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present.

      Enter the user with which you want to run the script in the **Run as user** field. 

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed. 

  2. Click **Add Step** to add another step in the group. 
    ![phoenix-step-add-htm4a1-wls1-tns-jdbj](./images/phoenix-step-add-htm4a1-wls1-tns-jdbj.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the wls1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  3. Click **Add Step** to add another step in the group. 
    ![phoenix-step-add-htm1-wls2-tns-jdbj](./images/phoenix-step-add-htm1-wls2-tns-jdbj.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the wls2 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  4. Click **Add Step** to add another step in the group. 
    ![phoenix-step-add-htm4a1-wls2-tns-jdbj](./images/phoenix-step-add-htm4a1-wls2-tns-jdbj.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the wls2 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  5. Click **Add Step** to add another step in the group. 
    ![phoenix-step-add-ais-wls1-rest](./images/phoenix-step-add-ais-wls1-rest.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the wls1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  6. Click **Add Step** to add another step in the group. 
    ![phoenix-step-add-ais-wls2-rest](./images/phoenix-step-add-ais-wls2-rest.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the wls2 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  7. After clicking **Add** you should be able to see all the steps listed under the new group.
    ![phoenix-group-add-html-ais-all](./images/phoenix-group-add-html-ais-all.png)


## Task 5: Customize the Switchover plan - Add a group to update SM Agents of all DR servers

Add this custom update group after the "**Update HTML Server configuration files**" group to maintain a sequence.

  1. Click on **Add group**.

    ![phoenix-group-add-smagents](./images/phoenix-group-add-smagents.png)
      In "Add plan group" page, enter a suitable **Group name**

      Select the **Add after** button to add the group after a particular group.
      
      Select the **Group** after which you want to add this custom group.

      Click **Add step** to add the scripts parameters. 

    ![phoenix-group-add-smagents-wls1](./images/phoenix-group-add-smagents-wls1.png)
      In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the wls1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present.

      Enter the user with which you want to run the script in the **Run as user** field. 

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed. 

  2. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-smagents-wls2](./images/phoenix-group-add-smagents-wls2.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the wls2 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  3. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-smagents-logic](./images/phoenix-group-add-smagents-logic.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the logic1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  4. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-smagents-batch](./images/phoenix-group-add-smagents-batch.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the batch1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  5. Validate that all the steps are added and click **Add** to continue.
    ![phoenix-group-add-smagents-all](./images/phoenix-group-add-smagents-all.png)

## Task 6: Customize the Switchover plan - Add a group to update SM Server management-console.xml

Add this custom update group after the "**Update SM agents of all DR Servers**" group to maintain a sequence.

  1. Click on **Add group**.

    ![phoenix-group-add-smconsole](./images/phoenix-group-add-smconsole.png)
      In "Add plan group" page, enter a suitable **Group name**

      Select the **Add after** button to add the group after a particular group.
      
      Select the **Group** after which you want to add this custom group.

      Click **Add step** to add the scripts parameters. 

    ![phoenix-group-add-smconsole-update](./images/phoenix-group-add-smconsole-update.png)
      In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the wls1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present.

      Enter the user with which you want to run the script in the **Run as user** field. 

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed. 

  2. Validate that all the steps are added and click **Add** to continue.
    ![phoenix-group-add-smconsole-final](./images/phoenix-group-add-smconsole-final.png)

## Task 7: Customize the Switchover plan - Add a group to Stop E1 Services and Agents
  
  Add this custom update group after the "**Update SM Server management-console.xml**" group to maintain a sequence.

  1. Click on **Add group**.

    ![phoenix-group-add-jde-service-steps](./images/phoenix-group-add-jde-service-steps.png)
      In "Add plan group" page, enter a suitable **Group name**

      Select the **Add after** button to add the group after a particular group.
      
      Select the **Group** after which you want to add this custom group.

      Click **Add step** to add the scripts parameters. 

    ![phoenix-group-add-jde-service-logic](./images/phoenix-group-add-jde-service-logic.png)
      In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the logic1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present.

      Enter the user with which you want to run the script in the **Run as user** field. 

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed. 

  2. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-jde-agent-logic](./images/phoenix-group-add-jde-agent-logic.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the logic1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  3. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-jde-service-batch](./images/phoenix-group-add-jde-service-batch.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the batch1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  4. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-jde-agent-batch](./images/phoenix-group-add-jde-agent-batch.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the batch1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  5. Validate that all the steps are added and click **Add** to continue.
    ![phoenix-group-add-jde-agent-service-all](./images/phoenix-group-add-jde-agent-service-all.png)

## Task 8: Customize the Switchover plan - Add a group to Stop NodeManager and WebLogic Services on SM Server and Agents on Web Servers

Add this custom update group after the "**Stop E1 Services and Agents**" group to maintain a sequence.

  1. Click on **Add group**.

    ![phoenix-group-add-service-agents](./images/phoenix-group-add-service-agents.png)
      In "Add plan group" page, enter a suitable **Group name**

      Select the **Add after** button to add the group after a particular group.
      
      Select the **Group** after which you want to add this custom group.

      Click **Add step** to add the scripts parameters. 

    ![phoenix-group-add-service-agent-smwls1](./images/phoenix-group-add-service-agent-smwls1.png)
      In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the wls1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present.

      Enter the user with which you want to run the script in the **Run as user** field. 

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed. 

  2. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-service-agent-smwls2](./images/phoenix-group-add-service-agent-smwls2.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the wls2 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  3. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-service-agent-nmwls1](./images/phoenix-group-add-service-agent-nmwls1.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the wls1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  4. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-service-agent-nmwls2](./images/phoenix-group-add-service-agent-nmwls2.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the wls2 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  5. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-service-agent-nm-sm](./images/phoenix-group-add-service-agent-nm-sm.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the smc1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  6. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-service-wlservice-wls1](./images/phoenix-group-add-service-wlservice-wls1.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the wls1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  7. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-service-wlservice-wls2](./images/phoenix-group-add-service-wlservice-wls2.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the wls2 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  8. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-service-wlservice-sm](./images/phoenix-group-add-service-wlservice-sm.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the smc1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  9. Validate that all the steps are added and click **Add** to continue.
    ![phoenix-group-add-service-wlservice-nm-all](./images/phoenix-group-add-service-wlservice-nm-all.png)

## Task 9: Customize the Switchover plan - Add a group to Start E1 Services and Agents

 Add this custom update group after the "**Stop NodeManager and WebLogic Services on SM Server and Agents on Web Servers**" group to maintain a sequence.

  1. Click on **Add group**.

    ![phoenix-group-add-service-start](./images/phoenix-group-add-service-start.png)
      In "Add plan group" page, enter a suitable **Group name**

      Select the **Add after** button to add the group after a particular group.
      
      Select the **Group** after which you want to add this custom group.

      Click **Add step** to add the scripts parameters. 

    ![phoenix-group-add-service-start-jde-logic1](./images/phoenix-group-add-service-start-jde-logic1.png)
      In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the logic1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present.

      Enter the user with which you want to run the script in the **Run as user** field. 

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed. 

  2. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-service-start-jde-batch1](./images/phoenix-group-add-service-start-jde-batch1.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the batch1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  3. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-service-start-agent-logic1](./images/phoenix-group-add-service-start-agent-logic1.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the logic1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  4. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-service-start-agent-batch1](./images/phoenix-group-add-service-start-agent-batch1.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the batch1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  5. Validate that all the steps are added and click **Add** to continue.

## Task 10: Customize the Switchover plan - Add a group to Start Agents and Node Manager on Web Server and SM Server

  Add this custom update group after the "**Stop E1 Services and Agents**" group to maintain a sequence.

  1. Click on **Add group**.

    ![phoenix-group-add-agent-nm-start](./images/phoenix-group-add-agent-nm-start.png)
      In "Add plan group" page, enter a suitable **Group name**

      Select the **Add after** button to add the group after a particular group.
      
      Select the **Group** after which you want to add this custom group.

      Click **Add step** to add the scripts parameters. 

    ![phoenix-group-add-agent-start-wls1](./images/phoenix-group-add-agent-start-wls1.png)
      In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the wls1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present.

      Enter the user with which you want to run the script in the **Run as user** field. 

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed. 

  2. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-agent-start-wls2](./images/phoenix-group-add-agent-start-wls2.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the wls2 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  3. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-nm-start-wls1](./images/phoenix-group-add-nm-start-wls1.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the wls1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  4. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-nm-start-wls2](./images/phoenix-group-add-nm-start-wls2.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the wls2 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  5. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-nm-start-sm](./images/phoenix-group-add-nm-start-sm.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the smc1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  6. Validate that all the steps are added and click **Add** to continue.
    ![phoenix-group-add-agent-nm-start-all](./images/phoenix-group-add-service-wlservice-nm-all.png)

## Task 11: Customize the Switchover plan - Add a group to Start WebLogic on Web Servers and SM Server

  Add this custom update group after the "**Start Agents and Node Manager on Web Server and SM Server**" group to maintain a sequence.

  1. Click on **Add group**.

    ![phoenix-group-add-wls-start](./images/phoenix-group-add-wls-start.png)
      In "Add plan group" page, enter a suitable **Group name**

      Select the **Add after** button to add the group after a particular group.
      
      Select the **Group** after which you want to add this custom group.

      Click **Add step** to add the scripts parameters. 

    ![phoenix-group-add-wls-start-wls1](./images/phoenix-group-add-wls-start-wls1.png)
      In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the wls1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present.

      Enter the user with which you want to run the script in the **Run as user** field. 

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed. 

  2. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-wls-start-wls2](./images/phoenix-group-add-wls-start-wls2.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the wls2 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  3. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-wls-start-smc1](./images/phoenix-group-add-wls-start-smc1.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the smc1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  4. Validate that all the steps are added and click **Add** to continue.
    ![phoenix-group-add-wls-start-all](./images/phoenix-group-add-wls-start-all.png)
  
    You may now **proceed to the next lab**.

## Acknowledgements

- **Author:** Tarani Meher, Senior JDE Specialist
- **Last Updated By/Date:** Tarani Meher, Senior JDE Specialist, 02/2024
