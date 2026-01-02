# Verify the DR Protection group status and PeopleSoft Application post Switchover (Rollback)

## Introduction

We will verify the DR Protection Group (DRPG) status and PeopleSoft Application post switchover (rollback).

Estimated Time: 15 Minutes

### Objectives

- Verify the DRPG status
- Access the PeopleSoft Application from the phoenix region
- Verify DNS domain record and PeopleSoft Process Instances

## Task 1: Verify the DRPG status

1. Login into OCI Console. Select region as **Ashburn**.

  ![oci console phoenix](./images/ashburn-region.png)

2. Select Migration and Disaster Recovery from the Hamburger menu, then **Disaster Recovery** -> **DR Protection Groups**. Verify the region is **Ashburn**.

  ![drpg navigation page](./images/ashburn-drpgpage.png)

3. Notice the *Role* of the **FSCM92-FSDR-Group-Ashburn** DRPG; it has automatically changed to *Primary*. Now the PeopleSoft application is back on primary region which is *Ashburn region*.

  ![phoenix drpg status](./images/ashburn-drpg-status.png)

4. Change the region to **Phoenix**.

  ![oci console ashburn](./images/phoenix-region.png)

5. Select Migration and Disaster Recovery from the Hamburger menu, then **Disaster Recovery** -> **DR Protection Groups**. Verify the region is **Phoenix**.

  ![drpg navigation page](./images/phoenix-drpgpage.png)

6. Notice the *Role* of the **FSCM92-FSDR-Group-Phoenix** DRPG; it has automatically changed to *Standby*. Now the PeopleSoft application standby region is back to *Phoenix region*.

## Task 2: Access PeopleSoft Application from the phoenix region

1. From the Hamburger menu, select **Networking**, then **Load Balancers** .Verify the region is **Ashburn**
  
     ![ashburn load balancer navigation](./images/ashburn-loadbalancer-navigate.png)

  The Overall Health status of the Load Balancer will be OK.

     ![ashburn-loadbalancer-health](./images/ashburn-loadbalancer-health.png)

2. Open a tab in your browser and access the PeopleSoft Application. You should be able to see that the application is working as expected from the Ashburn region.

      ![ashburn-peoplesoft-app-verify](./images/phoenix-peoplesoft-app-verify.png)

  **PeopleSoft application is accessible from the primary region (Ashburn)**

## Task 3: Verify DNS domain record and PeopleSoft Process Instances

1. Run nslookup command to verify that DNS domain record is resolving to public IP of Phoenix Load Balancer.

     ![ashburn-dns-verify](./images/ashburn-dns-verify.png)

2. Login to PeopleSoft application and go to Process Monitor to check and verify that Processes which were ran in Phoenix region are still present and accessible after switching to Ashburn region.

     ![ashburn-sample-process](./images/ashburn-sample-process.png)

We have now achieved the complete automation of switching over (rollback) a PeopleSoft application (Full Stack) from Phoenix region to Ashburn region with a single click of a button.

## Acknowledgements

- **Author** -  Vinay Shivanna, Principal Cloud Architect
- **Last Updated By/Date** -  Vinay Shivanna, Principal Cloud Architect, November 2025
