# Perform pre-checks for the DR Switchover Plan

## Introduction

In this lab, we will execute **Run Prechecks** for the **mushop-app-switchover** switchover plan which we have created in lab4. **Run Prechecks**
will execute all the **Built-in Prechecks** in parallel. 

As the name, execute **Run Prechecks**  will perform only the *pre-checks* and not the actual execution. It is quite important to have the pre-checks run successfully as a pre-reqisuite for running the actual switchover plan.

Estimated Lab Time: 10 Minutes

Watch the video below for a quick walk through of the lab.

[](youtube:6Dp49VXqjtQ)

### Objectives

- Perform Run prechecks for the mushop-app-switchover  plan
- Monitor the executed prechecks plan
- Verify the executed prechecks plan
- Verify the Mushop application and break the application

## Task 1: Perform Run prechecks for the mushop-app-switchover plan

1. Login into OCI Console with your provided Credentials. Select region as **Pheonix**.

  ![](./images/phoenix-region.png)

2. From the Hamburger menu, select **Migration and Disaster Recovery**, then **Disaster Recovery Protection Groups**.Verify the region is **Phoenix**

  ![](./images/phoenix-drpgpage.png)

3. You will land up in the Disaster Recovery Protection group home page, make sure you have selected the Phoenix region.

  ![](./images/phoenix-drpg.png)

4. Select the **mushop-phoenix** DRPG and select **mushop-app-switchover** plan

  ![](./images/phoenix-sw-plan.png)

5. Navigate to **Run prechecks** section which will be right below the **mushop-app-switchover** plan

  ![](./images/phoenix-run-prechecks.png)

6. In the **Run prechecks** window, provide the Plan execution name as **mushop-app-switchover-prechecks** and hit **Run prechecks**

  ![](./images/phoenix-execute-prechecks.png)

## Task 2: Monitor the executed prechecks plan

1. Navigate to **Plan executions** section under **Resources** and select the **mushop-app-switchover-prechecks** plan execution.Intially it will show as all the **Built-in Prechecks** as *Queued**.

  ![](./images/phoenix-execute-queued.png)

2. Refresh the page, within few seconds the **State** will change from *Queued* to *In Progess*. 

  ![](./images/phoenix-execute-inprogress.png)

3. All the **Built-in Prechecks**  steps will execute in parallel, you can monitor the various steps log. Navigate to three dots section for the respective buil-in step and click. You get option to view log and download log. These logs are stored in the object storage bucket which was provided during the DRPG creation. You can monitor the progress and download log if required for any troubleshooting.

   ![](./images/phoenix-execute-monitor.png)


## Task 3: Verify the executed prechecks plan

1. After 2-3 mins, **Built-in Prechecks**  will be completed successfully.  You can verify the duration of each step, status, duration of entire prechecks etc. *It is important to have successful completion of pre-check execution*

      ![](./images/phoenix-execute-done.png)

This concludes this Lab 5. Now you can move to Lab 6. 

Refer the **Troubleshooting tips** section for known failures and correction actions.

## Task 4: Verify the Mushop application and break the application

1. Login into OCI Console with your provided Credentials. Select region as **Ashburn**.

  ![](./images/ashburn-region.png)
  
2. Gather the Load Balancer public IP

  From the Hamburger menu, select **Networking**, then **Load Balancers**
  
     ![](./images/loadbalancer-navigate.png)

 Gather the Public IP address of the Load Balancer

     ![](./images/loadbalancer-ip.png)

  In your browser, open up a tab and verify the Mushop Application using the gathered public IP address. Play around the site and verify various cat products!!

      ![](./images/mushop-app.png)

3. Let us break the MuShop Application to create an outage. 

   Click the mushop-xxxxx load balancer details, in the resources section select Listeners

   ![](./images/loadbalancer-ash.png)

   ![](./images/loadbalancer-listeners.png)


4. Select the edit option using 3 dots symbol in the right end of the port 80 listener, mushop-xxxxx-80 

      ![](./images/port80-edit.png)

   Modify the listener port from 80 to 81 to break the application, save changes.  You will get work request submitted and select close requests.
    
      ![](./images/port80-edit1.png)
      ![](./images/port81-edit.png)
      ![](./images/workrequest-listener.png)

  Wait for few seconds and refresh the browser tab of the Mushop application. You should see, this site can't be reached.  

      ![](./images/mushop-broken.png)


We have created an outage to a working Mushop application, in next set of labs we will use Ful

## Troubleshooting tips 

1. During the pre-check execution logs, if you messages like "Requests are being throttled for instance ocid1", retry the **Run prechecks** again

[ocid1.instance.oc1.iad.anuwcljt5h22avqcjswxs6tublhrz2qonyjmucpxlyjxplybldbpxz2jqkaq] -- Error returned by PutObject operation in ObjectStorage service.(409, Conflict, false) Server is busy. Requests are being throttled for instance ocid1.instance.oc1.iad.anuwcljt5h22avqcjswxs6tublhrz2qonyjmucpxlyjxplybldbpxz2jqkaq (opc-request-id: B7721980580148749787FE758C9440FC/3D8758622598943932D50842DCD7EAA1/143166BA790ECD35695B548600382010)

## Acknowledgements

- **Author** -  Suraj Ramesh, Principal Product Manager
- **Last Updated By/Date** -  Suraj Ramesh,August 2022
