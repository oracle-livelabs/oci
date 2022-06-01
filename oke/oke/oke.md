# Deploying Oracle Container Engine for Kubernetes

## Introduction

A Kubernetes cluster is a group of nodes. The nodes are the machines running applications. Each node can be a physical machine or a virtual machine. The node's capacity (its number of CPUs and amount of memory) is defined when the node is created. A cluster comprises:

- one or more master nodes (for high availability, typically there will be a number of master nodes)
- one or more worker nodes (sometimes known as minions)

A Kubernetes cluster can be organized into namespaces to divide the cluster's resources between multiple users. Initially, a cluster has the following namespaces:

- default, for resources with no other namespace
- kube-system, for resources created by the Kubernetes system
- kube-node-lease, for one lease object per node to help determine node availability
- kube-public, usually used for resources that have to be accessible across the cluster

Estimated time: 45 minutes

### Objectives
- Create Kubernetes Cluster


### Prerequisites
- OCI Command Line Interface (CLI) installation on your local machine


## Task 1: Create Kubernetes Cluster

1. From the OCI Services menu, click **Developer Services** > **Kubernetes Clusters (OKE)**.

    **No need to create any policies for OKE, all the policies are pre-configured**
        ![Click Kubernetes Clusters (OKE)](./../OKE/images/OKE_S1P1.PNG " ")

2. Under **List Scope**, select the compartment in which you would like to create a cluster. Click **Create Cluster**.

    ![Click Create Cluster](./../OKE/images/OKE_S1P2.PNG " ")

3. Choose **Quick Create** and click **Launch Workflow**.

    ![Click Launch Workflow](./../OKE/images/launch_workflow.png " ")

4. Fill out the dialog box:

      - Name: Provide a name (oke-cluster in this example)
      - Compartment: Choose your compartment
      - Kubernetes Version: Choose the most recent version
      - Kubernetes API Endpoint: Public Endpoint
      - Kubernetes Worker Nodes: Private Workers
      - Shape: VM.Standard.E3.Flex
      - Number of nodes: 1

    Click **Next** 

    ![Quick Create Cluster](./../OKE/images/quick_create_cluster.png " ")

5. Click "**Create Cluster**".

    ![Create Cluster](./../OKE/images/quick_create_cluster2.png " ")

    **We now have a OKE cluster with 1 node and Virtual Cloud Network with all the necessary resources and configuration needed**

    ![Create Cluster](./../OKE/images/OKE_015.PNG " ")


## Task 2: Check OCI CLI in Cloud Shell

OCI Command Line comes preinstalled in Oracle Cloud Shell.

1.  Check the installed version of OCI CLI.  Start up the Oracle Cloud Shell if it's not already running and enter the following command to check OCI CLI version which should be 2.5.x or higher..

    ```
    <copy>
    oci -v
    </copy>
    ```

    ![Check OCI CLI version](./../OKE/images/ocicli.png" ")

## Task 3: Install Kubectl

In this section we will install kubectl. You can use the Kubernetes command line tool kubectl to perform operations on a cluster you've created with Container Engine for Kubernetes.

1. In Cloud Shell, enter the following commands:

    ```
    <copy>
    mkdir -p $HOME/.kube
    </copy>
    ```
    ```
    <copy>
    cd $HOME/.kube
    </copy>
    ```

    ```
    <copy>
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.15.0/bin/windows/amd64/kubectl.exe
    </copy>
    ```

    ![Enter the following commands](./../OKE/images/OKE_004.PNG " ")

2.  Wait for the download to complete. Enter the following command to verify kubectl.exe file exists.

    ```
    <copy>
    ls
    </copy>
    ```

## Task 4: Download get-kubeconfig.sh file and Initialize your environment

1. In the OCI console window, navigate to your cluster. In Cluster detail window, scroll down and click **Quick Start**, under **Resources**.
Follow the steps under the **Quick Start** Section.
    ![Click Quick Start](./../OKE/images/OKE_S4P1.PNG " ")

2. The **Quick Start** directions will direct you to copy and execute the following commands depicted below in your local terminal.

    ![Quick Start Directions](./../OKE/images/OKE_006.PNG " ")

## Task 5: Deploying a Sample Nginx App on Cluster Using kubectl

1. Create nginx deployment with three replicas,  Enter Command:
    ```
    <copy>
    kubectl run nginx  --image=nginx --port=80
    </copy>
    ```

2. Get Deployment data, Enter Command:
    ```
    <copy>
    kubectl get deployments
    </copy>
    ```

3. get PODs data, Enter command:
    ```
    <copy>
    kubectl get pods -o wide
    </copy>
    ```

    **NOTE:** You can see the deployment using Kubernetes Dashboard under Deployment.

    ![Kubernetes Dashboard](./../OKE/images/OKE_010.PNG " ")

4.  Create a service to expose the application. The cluster is integrated with the OCI Cloud Controller Manager (CCM). As a result, creating a service of type --type=LoadBalancer will expose the pods to the Internet using an OCI Load Balancer.In git-bash window Enter command:
    ```
    <copy>
    kubectl expose pod nginx --port=80 --type=LoadBalancer
    </copy>
    ```

5. Switch to OCI console window. From OCI Services menu click **Networking** > **Load Balancers**. A new OCI LB should be getting  provisioned (This is due to the command above).

    ![Click Load Balancers](./../OKE/images/load_balancer.png " ")

6. Once the Load Balancer is Active, click the Load Balancer name and from Load Balancer details page note down its IP address.

    ![Load Balancer Details](./../OKE/images/ip-address.png " ")

7. open a new browser tab and enter URL  http://`<Load-Balancer-Public-IP>` (http://129.213.76.26 in this example). The Nginx welcome screen should be displayed.

    ![Nginx welcome screen](./../OKE/images/OKE_013.PNG " ")


##  Step 6: Delete the resources

### Delete Kubernetes nodes

1. In cloud shell window Enter command:

    ```
    <copy>
    kubectl delete service nginx
    </copy>
    ```
    and then  
    ```
    <copy>
    kubectl delete pod nginx
    </copy>
    ```

### Delete OKE Cluster

1. To navigate back to your OCI Console window, click **Developer Services** > **Kubernetes Clusters (OKE)**.

   ![Click Kubernetes Clusters (OKE)](./../OKE/images/OKE_S1P1.PNG " ")

2. Navigate to your cluster. Click the action icon and **Delete** and click **Delete** in the confirmation window.

    ![Delete Cluster](./../OKE/images/delete-cluster.png " ")

### Delete VCN

1. From OCI services menu Click **Virtual Cloud Networks** under Networking, list of all VCNs will appear.
    ![Click Virtual Cloud Networks](./../OKE/images/vcn.png " ")

2. Locate your VCN , click the action icon and then **Terminate**. Click **Terminate All** in the Confirmation window. Click **Close** once VCN is deleted.

    ![Terminate VCN](./../OKE/images/terminate-vcn.png " ")


**Congratulations! You have successfully completed the lab.**

## Acknowledgements

- **Author** - Flavio Pereira, Larry Beausoleil
- **Adapted by** -  Yaisah Granillo, Cloud Solution Engineer
- **Contributors** - LiveLabs QA Team (Arabella Yao, Product Manager Intern | Isa Kessinger, QA Intern)
- **Last Updated By/Date** - Kamryn Vinson, May 2022

