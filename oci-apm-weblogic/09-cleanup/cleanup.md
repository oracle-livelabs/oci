# Clean up the workshop environment

## Introduction

In this lab, you will clean up the workshop environment by running commands from the Cloud shell, also manually removing the Oracle cloud resources using the Oracle Cloud console.

Estimated time: 10 minutes

### Objectives

* Remove the lab configurations and setups

### Prerequisites

* Completion of preceding labs in this workshop.

## Task1: Clean Up the application setup

To delete the workshop setup from your tenancy, follow the steps below.

1. Remove the application deployment.

    ``` bash
    <copy>
    kubectl delete -f ~/wls-hol/domain.yaml -n sample-domain1-ns
    </copy>
    ```

2. Remove the storage configuration from the cluster.

    ``` bash
    <copy>
    kubectl delete -f ~/wls-hol/apmlab-fss.yaml -n sample-domain1-ns
    </copy>
    ```
    ![Oracle Cloud, Cloud Shell](images/4-1-cleanup.png " ")


3. Remove the WebLogic domain

    ``` bash
    <copy>
    cd ~/wls-hol; ./deleteWls.sh
    </copy>
    ```




## Task2: Remove the Target Mount and the File System

1. From the navigation menu in the Oracle Cloud console, select **Storage** > **Mount Target**.
   Then click the link to the MountTarget configured in the workshop.

    ![Oracle Cloud, Cloud console](images/4-2-cleanup.png " ")

2. In the **Mount Target Details** page, click **Delete**. In the confirmation window, click **Delete**.

    ![Oracle Cloud, Cloud console](images/4-3-cleanup.png " ")    

3. Deletion of the Mount Target starts and completes.

    ![Oracle Cloud, Cloud console](images/4-4-cleanup.png " ")    

4. From the navigation menu in the Oracle Cloud console, select **Storage** > **File Systems**. Then click the link to the File System configured in the workshop.

    ![Oracle Cloud, Cloud console](images/4-5-cleanup.png " ")       

5. In the **File System Details** page, click **Delete**. In the confirmation window, click **Delete**.

    ![Oracle Cloud, Cloud console](images/4-6-cleanup.png " ")    

6. Deletion of the File System starts and completes.

    ![Oracle Cloud, Cloud console](images/4-7-cleanup.png " ")    

## Task3: Remove the container

1. From the navigation menu in the Oracle Cloud console, select **Developer Services** > **Kubernetes Container(OKE)**. Then click the link to the Cluster configured in the workshop.

    ![Oracle Cloud, Cloud console](images/4-8-cleanup.png " ")       

2. In the **Cluster Details** page, click **Delete**. In the confirmation window, enter the name of the cluster, then click **Delete**.

    ![Oracle Cloud, Cloud console](images/4-9-cleanup.png " ")    

3. Deletion of the File System starts and completes.

    ![Oracle Cloud, Cloud console](images/4-10-cleanup.png " ")  

## Task4: Remove the VCN

1. From the navigation menu in the Oracle Cloud console, select **Networking** > **Virtual Cloud Networks**. Then click the link to the VCN configured in the workshop.

    ![Oracle Cloud, Cloud console](images/4-11-cleanup.png " ")       

2. In the **Virtual Cloud Network Details** page, scroll down to locate the **Subnets** section. Select one of the subnets and click the three-dot icon on the right-hand side of the row.

    ![Oracle Cloud, Cloud console](images/4-12-cleanup.png " ")    

3. From the pulldown menu, select **Terminate**. In the confirmation window, click **Terminate**.

    ![Oracle Cloud, Cloud console](images/4-13-cleanup.png " ")      

3. Repeat to terminate other subnets. Once all the subnets are deleted, from the upper side of the VCN details page, click **Terminate** to remove the VCN.

    ![Oracle Cloud, Cloud console](images/4-14-cleanup.png " ")    

3. Click the **Terminate All** button when activated. Termination of the resources begins. Once the message **Virtual Cloud Network termination complete** shows, click **Close**.
    ![Oracle Cloud, Cloud console](images/4-15-cleanup.png " ")    

## Task5: Remove the workshop directory

1. Open the Oracle Cloud shell, and run the following commands to remove the files and the workshop directory.

    ``` bash
    <copy>
    rm apm-java-agent-installer-1.6.2363.jar; rm ProbeConfig.acml; rm AgentConfig.properties; rm -r wls-hol;rm wls-hol.zip
    </copy>
    ```
   ![Oracle Cloud, Cloud console](images/4-16-cleanup.png " ")   

## Acknowledgements

* **Author** - Yutaka Takatsu, Product Manager, Enterprise and Cloud Manageability
- **Contributors** - Steven Lemme, Senior Principal Product Manager,  
Avi Huber, Senior Director, Product Management
* **Last Updated By/Date** - Yutaka Takatsu, August 2022
