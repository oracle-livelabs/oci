# Perform pre-checks for the DR Failover Plan

## Introduction

In this lab, we will execute **Run Prechecks** for the **FSCM92\_FSDR\_Failover\_From\_Ashburn\_To\_Phoenix** Failover plan, which we have created in lab 12.

Execute **Run Prechecks**  will perform only the *pre-checks* and not the actual execution. Having the pre-checks completed successfully is essential as a pre-requisite for running the actual Failover plan.

Estimated Time: 15 Minutes

### Objectives

- Perform Run prechecks for the FSCM92\_FSDR\_Failover\_From\_Ashburn\_To\_Phoenix plan
- Monitor the executed prechecks plan
- Verify the executed prechecks plan

## Task 1: Perform Run prechecks for the Failover plan

1. Login into OCI Console. Select region as **Phoenix**.

  ![phoenix oci console](./images/phoenix-region.png)

2. Select Migration and Disaster Recovery from the Hamburger menu, then **Disaster Recovery** -> **DR Protection Groups**. Verify the region is **Phoenix**

  ![phoenix navigate drpg](./images/phoenix-drpgpage.png)

3. You will land on the Disaster Recovery Protection group home page; make sure you have selected the Phoenix region.

  ![drpg landing page](./images/phoenix-drpg.png)

4. Select the **FSCM92-FSDR-Group-Phoenix** DRPG and select **FSCM92\_FSDR\_Failover\_From\_Ashburn\_To\_Phoenix** plan

  ![drpg Failover plan](./images/phoenix-sw-plan.png)

5. Click on **Run prechecks** section, which will be right below the **FSCM92\_FSDR\_Failover\_From\_Ashburn\_To\_Phoenix** plan

  ![navigate drpg prechecks](./images/phoenix-run-prechecks.png)

6. In the **Run prechecks** window, provide the Plan execution name as **FSCM92-FSDR-Failover-From-Ashburn-To-Phoenix-Prechecks** and hit **Run prechecks**

  ![drpg execute prechecks](./images/phoenix-execute-prechecks.png)

## Task 2: Monitor the executed prechecks plan

1. Navigate to **Plan executions** section under **Resources** and select the **FSCM92-FSDR-Failover-From-Ashburn-To-Phoenix-Prechecks** plan execution.Initially, it will show all the **Built-in Prechecks** as *queued or in-progress*

  ![prechecks status](./images/phoenix-execute-in-progress.png)


2. After 2-3 mins, **Built-in Prechecks**  will be completed successfully. You can verify the duration of each step, status, duration of entire prechecks, etc. *It is essential to have successful completion of pre-check execution*

      ![prechecks completed](./images/phoenix-execute-done.png)

   You may now **proceed to the next lab**.

## Acknowledgements

- **Author** -  Vinay Shivanna, Principal Cloud Architect
- **Last Updated By/Date** -  Vinay Shivanna, Principal Cloud Architect, April 2023
