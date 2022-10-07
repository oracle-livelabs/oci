# Build a microservices application

## Introduction

This workshop uses Spring Boot-based Java microservices as a target application to trace against. In this lab, you will deploy the application to the Kubernetes cluster you created in Lab 1.


Estimated time: 10 minutes

### Objectives

* Build a microservices application for monitoring

### Prerequisites

* Completion of the preceding labs in this workshop

## Task 1: Verify OKE

1. Go back to the Kubernetes cluster page where you left Lab 1, and check the status of the cluster. Open the navigation menu from the top left corner (aka. hamburger menu) in the Oracle Cloud console, and select **Developer Services** > **Kubernetes Clusters (OKE)**.

   ![Oracle Cloud console, Cluster details](images/1-1-menu.png " ")

2. Click the **apmlab-cluser1** link from the table.

   ![Oracle Cloud console, Navigation Menu](images/1-2-menu.png " ")

3. If the status of the cluster is **Active**, creation was successful. If it is still in a **Creating** status, it may take a few more minutes to complete. (Usually, it takes 7 to 10 minutes to finish the jobs to create a cluster).

   ![Oracle Cloud console, Cluster details](images/1-9-OKE.png " ")

## Task 2: Access the OKE in the Oracle Cloud shell


1. Click **Access Cluster** on the cluster details page.

  ![Oracle Cloud console, Cluster details](images/2-1-OKE.png " ")

2. Make sure the **Cloud Shell Access** is selected. Click the **Copy** link from the command to access kubeconfig for the cluster.

  ![Oracle Cloud console, Cluster details](images/2-2-OKE.png " ")

3. Then click **Launch Cloud Shell**.

  ![Oracle Cloud console, Cluster details](images/2-2-2-OKE.png " ")

4. Oracle Cloud Shell window opens at the lower side of the browser screen.

  ![Oracle Cloud console, Cluster details](images/2-3-OKE.png " ")

5. Paste the copied command to the command shell prompt. Then hit enter.   

  ![Oracle Cloud console, Cluster details](images/2-4-OKE.png " ")

  >**Note:** Save the command to a text file on your laptop, and execute it whenever you start a new Cloud Shell session while working in the labs in this workshop.

## Task 3: Download configuration files

1. Download the zip file to the home directory in the Cloud Shell.

    ``` bash
    <copy>
    cd ~; wget https://objectstorage.us-phoenix-1.oraclecloud.com/n/axfo51x8x2ap/b/apmocw-bucket-2022/o/sb-hol.zip
    </copy>
    ```
    ![Oracle Cloud console, Cloud Shell](images/3-1-cloudshell.png " ")

3. Unzip the file. This will create a directory **sb-hol**.

    ``` bash
    <copy>
    unzip ~/sb-hol.zip
    </copy>
    ```

  ![Oracle Cloud console, Cloud Shell](images/3-2-cloudshell.png " ")

## Task 4: Deploy the application

1. Execute the following command from the Cloud Shell.

    ``` bash
    <copy>
    cd ~/sb-hol;ls
    </copy>
    ```
  ![Oracle Cloud console, Cloud Shell](images/4-1-cloudshell.png " ")

    >**Note:** Verify there are the following files in the folder.
    - apmlab-fss.yaml
    - wstore.yaml
    - wstore-add-storage.yaml
    - wstore-deploy-agent.yaml

3. Execute the command below to deploy the application to the cluster.
    ``` bash
    <copy>
    kubectl apply -f ~/sb-hol/wstore.yaml --validate=false
    </copy>
    ```

4. Verify the 2 services and 2 stateful sets are created.

  ![Oracle Cloud console, Cloud Shell](images/4-2-cloudshell.png " ")


5. Run the kubectl command below to display the status of the pod creation. Wait until the statuses become 'Running'. This may take a few minutes.

    ``` bash
    <copy>
    kubectl get pods
    </copy>
    ```
  ![Oracle Cloud console, Cloud Shell](images/4-2-1-cloudshell.png " ")

5. Run the kubectl command below to display the deployed services.

    ``` bash
    <copy>
    kubectl get svc
    </copy>
    ```
5. Copy the External IP of the wstore-frontend service

  ![Oracle Cloud console, Cloud Shell](images/4-3-cloudshell.png " ")

6. Refer to the below example and construct a URL, and paste it into a browser's address bar. If you see the WineCellar content as in the below screenshot, the deployment was successful.

    ``` bash
    <copy>
    http://<IP of the wstore-frontend service>/winestore/
    </copy>
    ```
  ![WineCellar Demo app](images/4-4-winestore.png " ")

    >**Note:** It may take a few minutes to complete the deployment and start loading the page content on the screen for the first time.  

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - Yutaka Takatsu, Product Manager, Enterprise and Cloud Manageability
- **Contributors** - Steven Lemme, Senior Principal Product Manager,  
Anand Prabhu, Sr. Member of Technical Staff,  
Avi Huber, Vice President, Product Management
* **Last Updated By/Date** - Yutaka Takatsu, August 2022
