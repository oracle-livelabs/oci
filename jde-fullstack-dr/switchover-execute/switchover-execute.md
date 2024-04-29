# Execute DR Switchover Plan

## Introduction

In this lab, we will execute the actual switchover plan  **FSDR_Moving\_Ash\_to\_Phx\_DB\_with\_All Steps\_Standby**. The switchover plan will execute the series of steps as per the order.

Estimated Time: 25 Minutes

### Objectives

- Verify JDE application status in Ashburn
- Execute the switchover plan
- Monitor the executed switchover plan

## Task 1: Check and verify JDE application status in Ashburn

As the JDE VMs are on private subnet, the links will not be directly accessible from public internet. You need to login to the bastion host on the Ashburn region and access the links. Or you can configure SSH tunneling via bastion host to access the links from your local machine. 

1. Login to JDE application and see if its successful. 

    ![jde login](./images/ashburn-jde-login.png)

2. Run a sample report in JDE running in Ashburn region and make sure that its completed successfully running on the required server.

    ![ashburn-sample-report](./images/ashburn-sample-report.png)

3. Login to the JDE Orchestrator and see if its successful.

    ![ashburn-sample-ais](./images/ashburn-sample-ais.png) 

## Task 2: Execute the switchover plan

1. Login into OCI Console. Select region as **Phoenix**.
 
    ![oci console phoenix](./images/phoenix-region.png)

2. Select Migration and Disaster Recovery from the Hamburger menu, then **Disaster Recovery** -> **DR Protection Groups**. Verify the region is **Phoenix**

    ![drpg navigation](./images/phoenix-drpgpage.png)

3. You will land on the Disaster Recovery Protection group home page; make sure you have selected the Phoenix region.

  ![drpg landing page](./images/phoenix-drpg.png)

4. Select the **FSDR_Moving\_Ash\_to\_Phx\_DB\_with\_All Steps\_Standby** DRPG and select plan **JDE\_FSDR\_SwitchOver\_Ashburn\_to\_Phoenix**

  ![drpg switchover plan](./images/phoenix-sw-plan.png)

5. Navigate to the **Execute DR plan** section, which will be right below the **JDE\_FSDR\_SwitchOver\_Ashburn\_to\_Phoenix** plan, and select

    ![drpg execute plan](./images/phoenix-execute-plan.png)

6. In the **Execute DR plan** window

- Provide a name for the Plan execution like **Execution_1**
- You can choose to uncheck the **Enable prechecks**  (Prechecks were executed successfully in earlier step)
- Leave the **Ignore warnings** as it is
- Verify and hit **Execute DR Plan**

    ![drpg execute confirm](./images/phoenix-execute-run-1.png)

## Task 3: Monitor the executed switchover Plan

1. Navigate to **Plan executions** section under **Resources** and select the **JDE\_FSDR\_SwitchOver\_Ashburn\_to\_Phoenix**  plan execution. Initially, it will show all the steps as *Queued*.

  Refresh the page; within a few seconds, the **State** will change from *Queued* to *In Progress*.

    ![drpg execute monitor1](./images/phoenix-execute-inprogress.png)

    Click on the **Execution_1** to open the plan execution details. It should show as **ACCEPTED** initially and will change to **IN PROGRESS**
    ![drpg execute monitor1](./images/phoenix-execute-inprogress-1.png)

    It should show as **ACCEPTED** initially and will change to **IN PROGRESS**
    ![drpg execute monitor1](./images/phoenix-execute-inprogress-2.png)

2. All the *plan groups* will run serially, but steps inside each *plan group* will be parallel. Monitor the various plan group and steps which are running. Navigate to the three dots section for the respective plan group step and click. You can view or download the log. If the step is in *Failed* status, you will have the option to **Retry** or **Skip** the step to proceed with other steps. Few steps like stopping services might fail if the service is already stopped in the primary server, we can skip those steps after checking the log.

     ![drpg execute monitor log](./images/phoenix-execute-viewlog.png)
     Logs are stored in the object storage bucket provided during the DRPG creation. 

3. Once each plan group is executed successfully, it will move on to the next group for execution. 

     ![drpg execute monitor progress](./images/phoenix-execute-moving.png)

4. Keep monitoring the rest of the groups and steps; each step will complete depending on the actual task and you should see a SUCCESS status for the execution plan. Few groups where you have skipped or ignored any step will show as *Partially Succeeded*. 

     ![drpg execute monitor progress](./images/phoenix-execute-moving2.png)

    You may now **proceed to the next lab**.

## Acknowledgements

- **Author:** Tarani Meher, Senior JDE Specialist
- **Last Updated By/Date:** Tarani Meher, Senior JDE Specialist, 02/2024

