# Deploy the Web Services in OCI

### Introduction

Estimated Time: 60 minutes

### About this lab

We will start the workshop with the environment setup. For the entire workshop we will use the same deployment ( VCNs, Web Servers) and only change configuration related to the DNS Policies. Also, we will use two Oracle Cloud regions, Chicago and Franfurt, to host the Web Servers which the DNS records will point to. When you do this workshop in your tenancy you can choose any two regions in the Oracle Cloud.

### Objectives

In this lab, you will:

* Build a Virtual Cloud Network (VCN), with the needed subcomponents, in two OCI regions.
* Deploy and configure two public OCI Compute instances with a WEB server


![lab1](images/lab1.png)

## Task 1: Deploy a VCN (Virtual Cloud Network) 

We will start with a basic VCN deployment. Since the main goal is to have a publicly accesible web server we will not get into many details and we will use the VCN Creation Wizard which OCI provides.  

1. Log into the Oracle Cloud console and select the **Chicago** region. On the Oracle Cloud Infrastructure Console Home page, go to the Burger menu (on top left), select Networking and click on **Virtual cloud networks**. Press **Start VCN Wizard**.
  ![Create VCN1](images/createvcn1.png)

2. In the menu that opens leave option 1 selected and press **Start VCN Wizard**.
  ![Create VCN2](images/createvcn2.png)

3. In the next menu, give the VCN a name, leave everything else as it is and press **Next**. In the new menu, simply press **Create** and wait for the VCN to be created. After it is done, press **View VCN**.
  ![Create VCN3](images/createvcn3.png)

  ![Create VCN4](images/createvcn4.png)

## Task 2: VCN Route table and Subnet Security List

  Now that we have a VCN and a Subnet, we need to add a VCN Route Table and a Security List to that subnet. While the default ones, deployed automatically by OCI, can be used, it is recommended to have dedicated ones.

1. On the VCN Details page, on the left menu, click **Route Tables** and then click on **Create Route Table**.
  ![Create route table1](images/creatert1.png)

   In the menu that opens, give this route table a name and press **Create**. No routes are needed at this step of the lab.
  ![Create route table2](images/creatert2.png)

2. On the VCN Details page, on the left menu, click **Subnets** and then click on the Firewall subnet created earlier.
  ![Click subnet](images/clicksubnet.png)

   In the menu that opens (subnet details), click **Edit**. In the new menu, replace the default Route Table with the one previously created and save the changes.
  ![Replace Route Table](images/subnetrt.png)

3. On the VCN Details page, on the left menu, click **Security Lists** and then click on **Create Security List**.
  ![Create sec list1](images/createsl.png)

   In the menu that opens, give it a name and press **+Another Ingress Rule** and **+Another Egress Rule**.
  ![Create sec list2](images/addrule1.png)

   In the rule menus that open, create an entry that allows **0.0.0.0/0** on Ingress and Egress, respectively. 
  ![Create sec list3](images/ingressrule.png)
  ![Create sec list4](images/egressrule.png)
  
  Press **Create Security List**. 

4. On the VCN Details page, on the left menu, click **Subnets** and then click on the Firewall subnet created earlier.
  ![Click subnet2](images/clicksubnet.png)

   In the menu that opens (subnet details), click **Add Security List** and add the new one we created.
  ![Add sec list](images/addsl.png)

   Next, remove the Default Security List by clicking on the 3 **dots** at the end of the row, and clicking **Remove**.
  ![Remove sec list](images/removesl.png)

## Task 3: Deploy an OCI Network Firewall

  Now that we prepared the VCN and the Subnet, it is time to focus on the OCI Network Firewall. To deploy a Firewall we need to give it a policy. We will start by deploying an empty Firewall Policy and then use it to deploy an OCI Network Firewall.

1. On the Oracle Cloud Infrastructure Console Home page, go to the Burger menu (on top left), select **Identity and Security** and click on **Network firewall policies**.
  ![Click firewall policy](images/clickpol.png)

   In the menu that opens, click **Create network firewall policy**. In the next menu, give it a name and press Create...
  ![Empty firewall policy](images/polempty.png)

   The Firewall policy that gets created will be empty of any configuration but we can use it to deploy a Network Firewall.

2. On the Oracle Cloud Infrastructure Console Home page, go to the Burger menu (on top left), select **Identity and Security** and click on **Network firewalls**. In the menu that opens, click **Create Network firewall**.
  ![Create firewall1](images/createfw1.png)

   In the menu that opens, give the firewall a name, select the empty policy we previously created and select the correct VCN and subnet, created earlier in this lab. Then press Create.
  ![Create firewall2](images/createfw2.png)

   Wait for the Firewall to become **ACTIVE** before moving on to the next step.

  Note: OCI Network Firewall creation can take up to 30 minutes. Consider taking a break!

3. Once the firewall is **ACTIVE**, click on the left hand menu on **Logs** and enable both Traffic and Threat Logs by using the toggle.
  ![Firewall Logs](images/fwlogs.png)

**Congratulations!** You have successfully deployed an OCI Network Firewall and completed this lab. You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - Radu Nistor, Principal Cloud Architect, OCI Networking
* **Last Updated By/Date** - Radu Nistor, November 2023
