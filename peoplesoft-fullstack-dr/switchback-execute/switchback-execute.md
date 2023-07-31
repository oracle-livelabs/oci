# Execute DR Switchover (Rollback) Plan

## Introduction

In this lab, we will execute the actual switchover (rollback) plan  **FSCM92-FSDR-Switchover-From-Phoenix-To-Ashburn**, which we have created in lab 8. The switchover (rollback) plan will execute the series of steps as per the order.

Estimated Time: 25 Minutes

### Objectives

- Verify PeopleSoft Application status in Phoenix
- Execute the switchover plan
- Monitor the executed switchover plan
- Verify the executed switchover plan

## Task 1: Check and verify PeopleSoft Application status in Phoenix

1. Do a nslookup to PeopleSoft Application DNS domain name and notice that it resolves to public IP of Phoenix Load Balancer.

    ![oci phoenix nslookup](./images/phoenix-nslookup.png)

2. Run a sample process in PeopleSoft Application running in Ashburn region and make an note of the Process Instance number and report output.

    ![phoenix-sample-process](./images/phoenix-sample-process.png)

## Task 1: Execute the switchover plan

1. Login into OCI Console. Select region as **Ashburn**.
 
    ![oci console phoenix](./images/ashburn-region.png)

2. Select Migration and Disaster Recovery from the Hamburger menu, then **Disaster Recovery** -> **DR Protection Groups**. Verify the region is **Ashburn**

    ![drpg navigation](./images/ashburn-drpgpage.png)

3. You will land on the Disaster Recovery Protection group home page; make sure you have selected the Phoenix region.

    ![drpg landing page](./images/ashburn-drpg.png)

4. Select the **FSCM92-FSDR-Group-Ashburn** DRPG and select **FSCM92-FSDR-Switchover-From-Phoenix-To-Ashburn** plan

    ![drpg switchover plan](./images/phoenix-sw-plan.png)

5. Navigate to the **Execute Plan** section, which will be right below the **FSCM92-FSDR-Switchover-From-Phoenix-To-Ashburn** plan, and select

    ![drpg execute plan](./images/phoenix-execute-plan.png)

6. In the **Execute Plan** window

- Provide a name for the Plan execution like **FSCM92-FSDR-Switchover-From-Phoenix-To-Ashburn**
- Uncheck the **Enable prechecks**  (  Prechecks were executed successfully in Lab 5)
- Leave the **Ignore warnings** as it is
- Verify and hit **Execute DR Plan**

    ![drpg execute confirm](./images/phoenix-execute-run-1.png)

## Task 2: Monitor the executed switchover Plan

1. Navigate to **Plan executions** section under **Resources** and select the **FSCM92-FSDR-Switchover-From-Ashburn-To-Phoenix** plan execution.Initially, it will show all the steps as *Queued*.

  Refresh the page; within a few seconds, the **State** will change from *Queued* to *In Progress*.

    ![drpg execute monitor1](./images/phoenix-execute-inprogress.png)

2. All the *plan groups* will run serially, but steps inside each *plan group* will be parallel. Monitor the various plan group and steps which are running. Navigate to the three dots section for the respective plan group step and click. You get the option to view the log and download the log. These logs are stored in the object storage bucket provided during the DRPG creation. You can monitor the Progress and download the log if necessary for troubleshooting.

     ![drpg execute monitor log](./images/phoenix-execute-viewlog.png)

3. Once each plan group is executed successfully, it will move on to the next group for execution. 

     ![drpg execute monitor progress](./images/phoenix-execute-moving.png)

4. Keep monitoring the rest of the groups and steps; each step will complete depending on the actual task.

     ![drpg execute monitor progress](./images/phoenix-execute-moving2.png)

5. Wait for all the steps to complete successfully.  It is important to monitor the progress of each step and take actions in case of any failures. 

## Task 3: Verify the executed switchover plan

1. From the plan execution detail, verify the duration of each step, status, duration of the entire switchover plan, etc. *It is essential to have successful completion of all steps*. Use the Expand all button to expand all the steps and the Collapse all button for collapsing. Use the view or download log option to see step execution details.

      ![drpg execution done](./images/phoenix-execute-done.png)

   **The entire DR Switchover (rollback) operation took around 18 minutes to complete.** This time will vary based on various factors like custom scripts execution, number of compute instances involved in DR operations etc.

You may now **proceed to the next lab**.

## Acknowledgements

- **Author** -  Vinay Shivanna, Principal Cloud Architect
- **Last Updated By/Date** -  Vinay Shivanna, Principal Cloud Architect, April 2023

