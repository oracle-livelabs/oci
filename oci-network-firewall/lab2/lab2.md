# East-West Traffic Inspection

## Introduction

Estimated Time: 30-45 minutes

### About East-West Traffic Inspection

East-West Traffic Inspection is done when two or more hosts from the same environment(in our case, OCI) communicate with each other and there is a Network Firewall on the path that is policing the traffic. 

### Objectives

In this lab, you will:

* Configure OCI Cloud Shell for management access to private Compute Instances.
* Deploy two application subnets in the same VCN as the OCI Network Firewall
* Deploy two private OCI Compute Instaces, one in each application subnet.
* Adjust VCN routing so the traffic between the two Instances passes through the OCI Network Firewall.
* Modify the OCI Firewall policy to allow some connectivity between the two hosts.
* Test both allowed and denied traffic and observe the Firewall Traffic Log. 

![lab2](images/lab2.png)


## Task 1: Configure the OCI Cloud Shell

In this lab and the next ones, we will need to connect to test Compute Instances to generate traffic and test connectivity. While this can be acomplished in any ways, one of the easiest is to use the **Cloud Shell** embedded in the OCI Console. We will configure the service to run in a **private** mode so that we can use it to connect to private resources. In private mode we will have to give it a VCN and Subnet to be deployed in so we will use the Firewall Subnet created in the previous lab. This functionality is only available in the **HOME** region of your account.

1. Log into the Oracle Cloud console. Make sure you are in the **HOME** region of the tenancy. On the top right side, start **Cloud Shell**.
  ![Start Cloud Shell](images/startcs.png)

   If you have never used Cloud Shell before, Oracle will start the Instance with a **Public** network.
  ![Public Cloud Shell](images/publiccs.png)

  **Note:**This tutorial works on the asumption you don't have a custom setup for your Cloud Shell deployment. If you do, adjust the guide below to not interfere with your existing setup.

2. On the Cloud Shell deployment, click on the down arrow next to **Network:Public** and click **Private netwrok definition list**.
  ![Define private network](images/privatecs1.png)

3. In the menu that opens, click **Create private network definition** and, in the next menu, give it a name and select the existing Firewall VCN and subnet.
  ![Deploy private network](images/privatecs2.png)

  Next, select it as the default network for Cloud Shell.
  ![Default private network](images/privatecs3.png). 

  Next, close the Cloud Shell and open it again. It should now show the Cloud Shell instance deployed in the private firewall subnet.
  ![Private network cloudshell](images/privatecs4.png). 

4. Select **VCN with Internet Connectivity**, and then select **Start VCN Wizard**.
  ![VCN with Internet Connectivity](images/vcn-2.png)
5. The default parameters for the VCN quickstart will be used. Verify your configuration looks similar to the following, and select **Next**.
  ![Create a VCN Configuration](images/vcn-3.png)
6. Overview the configuration, then select **Create**.
    ![Review CV Configuration](images/vcn-4.png)
7. When VCN creation is complete, click on **View VCN**.
    ![Workflow](images/vcn-5.png)
8. You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - Jake Bloom, Principal Solution Architect, OCI Networking
* **Last Updated By/Date** - Jake Bloom, August 2023
