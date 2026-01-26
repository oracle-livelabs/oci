# Create and Associate Disaster Recovery Protection Groups

## Introduction

In this lab, we will Create and Associate Disaster Recovery Protection Groups (DRPG). Ashburn is the primary region and Phoenix is the standby region.

What is DRPG – A resource type used by Full Stack Disaster Recovery.  A DR Protection Group represents a consistency grouping defined for the purposes of disaster recovery.  It is a collection of different OCI resources that comprise an application and must be treated as a combined group when performing disaster recovery operations.  For example, a DR Protection Group may consist of application servers (compute instances), associated block storage (grouped as volume groups) and databases.

Estimated Time: 15 Minutes

### Objectives

- Create DRPG in Ashburn and Phoenix regions.
- Associate Ashburn DRPG as primary and Phoenix DRPG as Standby

## Task 1: Create DRPG in Ashburn and Phoenix regions

1. Login into OCI Console. The primary region should be **Ashburn**.

    ![Ashburn OCI Console](./images/ashburn-region.png)

  Open another browser tab and then select the region as **Phoenix** (Standby Region)

    ![Phoenix OCI Console](./images/phoenix-region.png)

2. In the first browser tab,Select **Migration and Disaster Recovery** from the Hamburger menu, then **Disaster Recovery** -> **DR Protection Groups**. Verify the region is **Ashburn**

    ![DRPG from ashburn](./images/ashburn-drpgpage.png)

3. In the second browser tab,Select **Migration and Disaster Recovery** from the Hamburger menu, then **Disaster Recovery** -> **DR Protection Groups** Verify the region is **Phoenix**

    ![DRPG from phoenix](./images/phoenix-drpgpage.png)

4. You will land up at the Full Stack Disaster Recovery home page; click on DR Protection Groups and make sure to have two tabs opened for Ashburn and Phoenix region.

    ![DRPG landing page](./images/ashburn-drpg.png)
    ![DRPG landing page](./images/phoenix-drpg.png)

5. Create DRPG in the Ashburn region. Click on Create DR Protection group in the Ashburn region browser tab.

    - Provide a name for the Full Stack Disaster Recovery Protection Group
    - Select the right compartment
    - Select the object storage bucket created in Lab 1 which is **FSDR\_Bucket\_Ashburn**
    - Ignore Role and leave as **Not Configured**
    - Ignore Add member 

    ![create drpg](./images/ashburn-create-drpg.png)

    Click on Create.

  Navigate back to the DR Protection group page; the state of DRPG will change from creating to active in a few seconds.

   ![drpg status](./images/ashburn-drpgactive.png)

6. Create DRPG in the Phoenix region. Select Create DR Protection group in the Phoenix region browser tab.

    - Provide a name for the Full Stack Disaster Recovery Protection Group
    - Select the right compartment
    - Select the object storage bucket created in Lab 1 which is **FSDR\_Bucket\_Phoenix**
    - Ignore Role and leave as **Not Configured**
    - Ignore Add member

    ![create drpg](./images/phoenix-create-drpg.png)

    Click on Create.

  Navigate back to the DR Protection group page; the state of DRPG will change from creating to active in a few seconds.

   ![drpg status](./images/phoenix-drpgactive.png)

## Task 2: Associate Ashburn DRPG as primary and Phoenix DRPG as Standby

1. From the Ashburn region OCI console, select **FSCM92-FSDR-Group-Ashburn** DRPG. Click on Actions and select the **Associate** button

  ![drpg associate](./images/drpg-associate.png)

- Select Role as **Primary**
- Select Peer Region as **US West (Phoenix)**,
- Select Peer DR Protection group in the compartment (change assigned compartment if required); you should select **FSCM92-FSDR-Group-Phoenix**
- Verify and associate

  ![drpg associate confirm](./images/drpg-associate-1.png)

  **FSCM92-FSDR-Group-Ashburn** DRPG will change to *Updating* State

  Navigate back to the DR Protection group home page. You should be able to see DRPG **FSCM92-FSDR-Group-Ashburn** state as *Active*, role as *Primary*, peer region as *US West (Phoenix)*

  ![drpg associate done](./images/drpg-status-ashburn.png)

2.From the Phoenix region OCI console, navigate to the DR Protection group home page. You should be able to see DRPG **FSCM92-FSDR-Group-Phoenix** state as *Active*, role as *Standby*, peer region as *US East (Ashburn)*

   ![drpg associate status](./images/drpg-status-phoenix.png)

   Now, we have associated **FSCM92-FSDR-Group-Ashburn** as *Primary DRPG* and **FSCM92-FSDR-Group-Phoenix**  as *Standby DRPG*

   You may now **proceed to the next lab**.

## Acknowledgements

- **Author** -  Vinay Shivanna, Principal Cloud Architect
- **Last Updated By/Date** -  Vinay Shivanna, Principal Cloud Architect, November 2025
