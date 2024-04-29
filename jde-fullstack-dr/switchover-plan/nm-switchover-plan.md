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

4. Select the **FSDR\_Non-Moving\_Ash\_to\_Phx\_DB\_with\_All Steps** DRPG and navigate to Plans under the resources section. Click on Create Plan.

  ![drpg dr plan](./images/nm-phoenix-drplan.png)

  Provide a name for the Switchover Plan.

  Select Plan type as **Switchover (planned)**.

  ![drpg create plan](./images/nm-phoenix-create-drplan.png)

  Refresh the DR Plan page if required. You can monitor the request's status in the **Work requests** section under Resources. Within few minutes, the plan will get created, and it should be in *active* State.

  ![drpg plan created](./images/nm-phoenix-drplan-created.png)

  Select the **JDE\_FSDR\_Non-Moving Plan\_Ash to Phx** plan, and you should be able to see the built-in plan groups.

  ![drpg plan details](./images/nm-phoenix-drplan-groups.png)

  Based on the members we added in both primary and standby DRPG, FSDR created these built-in plans. As we have added the Database as a member in the primary region, it has created the build in steps for DB only. We will add the steps to update and start the other JDE servers in separate custom groups. 
  
  *Note:* To create a DR Plan using CLI, please follow the link [Automate FSDR with CLI](https://docs.oracle.com/en/learn/full-stack-dr-oci-cli-command/#introduction)

## Task 2: Customize the Switchover plan - Add a group to Start E1 Services and Agents

 Add this custom update group after the "**Start Compute Instances**" group as a sequence.

  1. Click on **Add group**.

    ![phoenix-group-add-service-start](./images/nm-phoenix-group-add-service-start.png)
      In "Add plan group" page, enter a suitable **Group name**

      Select the **Add after** button to add the group after a particular group.
      
      Select the **Group** after which you want to add this custom group.

      Click **Add step** to add the scripts parameters. 

    ![phoenix-group-add-service-start-jde-logic1](./images/nm-phoenix-group-add-service-start-jde-logic1.png)
      In "Add plan group step" page, enter a suitable **Step name**

      Select the **standby region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the dgdrlogic1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present.

      Enter the user with which you want to run the script in the **Run as user** field. 

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed. 

  2. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-service-start-jde-batch1](./images/nm-phoenix-group-add-service-start-jde-batch1.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **standby region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the dgdrbatch1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  3. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-service-start-agent-logic1](./images/nm-phoenix-group-add-service-start-agent-logic1.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the dgdrlogic1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  4. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-service-start-agent-batch1](./images/nm-phoenix-group-add-service-start-agent-batch1.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the dgdrbatch1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  5. Validate that all the steps are added and click **Add** to continue.

    ![phoenix-group-add-service-start-group1-all](./images/nm-phoenix-group1-add-service-all.png)

## Task 3: Customize the Switchover plan - Add a group to Start Agents and and Services on Web Server and SM Server

  Add this custom update group after the "**Start Enterprise Server Services**" group to maintain a sequence.

  1. Click on **Add group**.

    ![phoenix-group-add-agent-nm-start](./images/nm-phoenix-group-add-agent-nm-start.png)
      In "Add plan group" page, enter a suitable **Group name**

      Select the **Add after** button to add the group after a particular group.
      
      Select the **Group** after which you want to add this custom group.

      Click **Add step** to add the scripts parameters. 

    ![phoenix-group-add-agent-start-wls1](./images/nm-phoenix-group-add-agent-start-wls1.png)
      In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the dgdrwls1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present.

      Enter the user with which you want to run the script in the **Run as user** field. 

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed. 

  2. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-agent-start-wls2](./images/nm-phoenix-group-add-agent-start-wls2.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the dgdrwls2 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  3. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-nm-start-wls1](./images/nm-phoenix-group-add-nm-start-wls1.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the dgdrwls1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  4. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-nm-start-wls2](./images/nm-phoenix-group-add-nm-start-wls2.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the dgdrwls2 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  5. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-nm-start-sm](./images/nm-phoenix-group-add-nm-start-wls1console.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the dgdrwls1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  6. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-nm-start-sm](./images/nm-phoenix-group-add-nm-start-wls2console.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the dgdrwls2 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  7. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-nm-start-sm](./images/nm-phoenix-group-add-nm-start-sm.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the fsdr1smc1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  8. Click **Add Step** to add another step in the group. 
    ![phoenix-group-add-nm-start-sm](./images/nm-phoenix-group-add-wls-start-smc.png)
    In "Add plan group step" page, enter a suitable **Step name**

      Select the **primary region** from the **Region** drop down to run the scripts in the standby after instance launch.

      Select the **Run local script** button.

      Select the fsdr1smc1 server as **Target instance** from the drop down.

      Add below parameters in the **Script parameters**. This is based on where you have your script and the configuration file present. Refer to the Pre-requisites Setup section for details.

      Enter the user with which you want to run the script in the **Run as user** field.

      Select **Stop on error** on the **Error mode**

      Keep default 3600 as the **Timeout in seconds** and tick the **Enable step** option.

      Click **Add Step** to proceed.

  9. Validate that all the steps are added and click **Add** to continue.
    ![phoenix-group-add-agent-nm-start-all](./images/nm-phoenix-group-add-service-wlservice-nm-all.png)
  
    You may now **proceed to the next lab**.

## Acknowledgements

- **Author:** Tarani Meher, Senior JDE Specialist
- **Last Updated By/Date:** Tarani Meher, Senior JDE Specialist, 02/2024
