# Instrument the server monitoring

## Introduction

In this lab, you will download the APM Java Agent installer file from the Oracle Cloud console, upload it to the Oracle Cloud shell, transfer it to the Kubernetes container, provision the Java Agent to the file system, and finally, deploy the Agent to the Kubernetes pods.

Estimated time: 10 minutes

### Objectives

* Download the APM Java Agent from the Oracle Cloud console
*	Upload the APM Java Agent to the Cloud shell
*	Copy the Java Agent installer from the Cloud shell to the file system
*	Provision the APM Java Agent in the shared file system directory
*	Deploy the Java Agent to the Kubernetes pods

### Prerequisites

* Completion of the preceding labs in this workshop

## Task 1: Obtain APM Java Agent download link

1.	Open navigation menu from the Oracle Cloud console, select **Observability & Management** > **Administration**.

   ![Oracle Cloud console, Navigation Menu](images/4-1-1-menu.png " ")

2.	Under **Resources** at the lower left side of the screen, click **Download APM Agent**

   ![Oracle Cloud console, APM Domains](images/4-1-2-apmdomain.png " ")

3.	Mouse-click the **Java Agent** link. Select **Copy Link Address**. This will save the download link to the memory on your computer. Paste the copied link to a text file.

   ![Oracle Cloud console, APM Domains](images/4-1-3-apmdomain.png " ")

4. 	Open the Cloud Shell by clicking the **>..** icon from the top right corner of the Oracle Cloud console. Restore the Cloud Shell if minimized.

   ![Oracle Cloud console, APM Domains](images/4-1-4-cloudshell.png " ")


## Task 2: Download the APM Java Agent to the Cloud shell

1.  Type the following command to the Cloud Shell.

    ``` bash
    <copy>
    cd ~/; wget <copied APM Java Agent link>
    </copy>
    ```
    If the link is still in the clipboard of your computer, simply type **wget** in the Cloud Shell home directory, then paste the APM Java Agent download link.

   ![Oracle Cloud console, Cloud Shell](images/4-1-5-cloudshell.png " ")

2.	Hit the enter key and verify the message to ensure the successful file transfer.

   ![Oracle Cloud console, Cloud Shell](images/4-1-6-cloudshell.png " ")

3.  Type the ls command. Confirm that the java agent file installer is in the home directory.

    ``` bash
    <copy>
    ls ~
    </copy>
    ```
   ![Oracle Cloud console, Cloud Shell](images/4-1-7-cloudshell.png " ")

## Task 3: Copy the Java Agent installer to the file system

1.	Run the command below to copy the Java Agent installer file to the file system. Ensure to ***replace*** the **apm-agent-version** with that of the APM Java Agent you have, before the command execution.

    ``` bash
    <copy>
    kubectl cp apm-java-agent-installer-<apm-agent-version>.jar wstore-front-0:/apmlab-fss/
    </copy>
    ```

    > - e.g., kubectl cp apm-java-agent-installer-1.6.2363.jar wstore-front-0:/apmlab-fss/  
    - The command copies the Agent installer to the **wstore-front**, but it can be copied to any pod as the way we set up, all pods share the same file system.


2.	Use the kubectl command below to remotely run the ls command in the container in the Kubernetes pod.

    ``` bash
    <copy>
    kubectl exec -it wstore-front-0 -- bash -c "cd /apmlab-fss && ls "
    </copy>
    ```

    If you see the java agent installer file in the location, the file transfer was successful.

   ![Oracle Cloud console, Cloud Shell ](images/4-1-8-cloudshell.png " ")

    >**Note:** The APM version may be different from what is shown in the example.

## Task 4: Provision of the APM Java Agent


1.	Execute the command below to provision the APM Java agent. ***Replace*** the **APM Domain Private key** and **APM Domain Endpoint**, with the values saved in Lab2, Task2. Please also ***change*** the **apm-agent-version** in the file name to the version of the agent you have.

    ``` bash
    <copy>
    kubectl exec -it wstore-front-0 -- bash -c "cd /apmlab-fss && java -jar ./apm-java-agent-installer-<apm-agent-version>.jar provision-agent -service-name=WS-svc -destination=.  -private-data-key=<APM Domain Private Key> -data-upload-endpoint=<APM Domain Endpoint>"
    </copy>
    ```
    E.g., kubectl exec -it wstore-front-0 -- bash -c "cd /apmlab-fss && java -jar apm-java-agent-installer-1.6.2363.jar provision-agent -service-name=WS-svc -destination=. -private-data-key=ABCDEFG12345ABCDEF123456ABCDE -data-upload-endpoint=https://abcdefgt12345aaaaaaaaabcdef.apm-agt.us-phoenix-1.oci.oraclecloud.com"

    With a successful installation, you should see the output similar to below.

   ![Oracle Cloud console, Cloud Shell ](images/4-1-10-cloudshell.png " ")

2.	Execute the below command to verify ***oracle-apm-agent*** directory is created under the apmlab-fss directory.

    ``` bash
    <copy>
    kubectl exec -it wstore-front-0 -- bash -c "cd /apmlab-fss && ls "
    </copy>
    ```

    ![Oracle Cloud console, Cloud Shell ](images/4-1-11-cloudshell.png " ")

## Task 5: Deploy the Java Agent

The next step is to deploy the Java Agent. First, update the **wstore.yaml** file by adding the java runtime argument that points to the APM Agent jar file bootstrap location, then apply to the Kubernetes pods. Notice that the service names, **wstore-front** and **wstore-back**, that are used to display in the APM Trace Explorer, are also added to the command for the statefulsets.

1.  Use any editor to open the wstore.yaml file.

    ``` bash
    <copy>
    vi ~/sb-hol/wstore.yaml
    </copy>
    ```
2. Find the following line in each statefulset, where Java runtime arguments are set. (Look for lines 49 and 80, assuming the volumes were added as expected in the previous steps).

    >command: ["java", "-jar", "./wineStore.jar", "--spring.config.location=file:/spring/wstore.properties"]


3. Hit **i**. Locate line 49, then insert the following arguments after the **command: ["java",**.

    ``` bash
    <copy>
     "-javaagent:/apmlab-fss/oracle-apm-agent/bootstrap/ApmAgent.jar", "-Dcom.oracle.apm.agent.service.name=wstore-front",
    </copy>
    ```

4. Next, locate line 80, and insert the following arguments after the **command: ["java",**.

    ``` bash
    <copy>
     "-javaagent:/apmlab-fss/oracle-apm-agent/bootstrap/ApmAgent.jar", "-Dcom.oracle.apm.agent.service.name=wstore-back",
    </copy>
    ```
    The image below shows the **wstore-back** statefulset after the successful editing, for example. Please note that you will need to add the arguments to both statefulsets, **wstore-front** and **wstore-back**, and the service names have to be configured differently.

  ![Oracle Cloud console, Cloud Shell ](images/4-6-1-cloudshell.png " ")    


    > ***Troubleshooting***: For learning purposes, we have preconfigured the java argument editing in the **wstore-deploy-agent.yaml** file. If you encounter any issues run the following command to review how the changes are expected to be done.
    - vi ~/sb-hol/wstore-deploy-agent.yaml


5.	Recreate the Kubernetes pods by applying the **wstore-deploy-agent.yaml** file.

    ```bash
    <copy>
    kubectl apply -f ~/sb-hol/wstore.yaml --validate=false
    </copy>
    ```

    Verify the service and the statefulsets are configured.

    ![Oracle Cloud console, Cloud Shell ](images/4-6-2-cloudshell.png " ")    

6.	Run the following command to check the status of the pods. Make sure they are in the Running state and Ready. If the status is pending, re-run the command. If they do not come back after a few minutes, review the file to ensure the editing was done correctly.  

    ```bash
    <copy>
    kubectl get pods
    </copy>
    ```
    ![Oracle Cloud console, Cloud Shell ](images/4-6-3-cloudshell.png " ")

    Once the pods are in the Running state, the APM Java Agent is active and listening to the WineCellar application. It captures backend traces and spans which you can view in the APM Trace Explorer.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - Yutaka Takatsu, Product Manager, Enterprise and Cloud Manageability
- **Contributors** - Steven Lemme, Senior Principal Product Manager,  
Anand Prabhu, Sr. Member of Technical Staff,  
Avi Huber, Vice President, Product Management
* **Last Updated By/Date** - Yutaka Takatsu, August 2022
