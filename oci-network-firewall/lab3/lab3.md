# Inspecting outbound Internet traffic

## Introduction

Estimated Time: 30 minutes

### Objectives

In this lab, you will:

In this lab, you will:

* Deploy a VCN NAT Gateway for outbound Internet connectivity
* Adjust VCN routing so the traffic so the traffic to the Internet goes through the OCI Network Firewall.
* Modify the OCI Firewall policy to allow outbound Internet traffic and filter URLs.
* Test both allowed and denied traffic and observe the Firewall Traffic Log. 

![lab3](images/lab3.png)

## Task 1: Deploy a VCN NAT Gateway with a dedicated Route Table

We will start with a basic VCN deployment. One of the goals of this livelab is also to provide an understanding of OCI routing and gateways, in relation to the OCI Network Firewall service. For this reason, we will not use the VCN Wizard which deploys all OCI Gateways and creates basic routing rules. Instead, we will manually create each artifact as needed.

1. Log into the Oracle Cloud console and select the **HOME** region.
  ![Ashburn Region Select](images/home.png)
  Note: This Lab can be completed in any OCI region. However, as explained in the **Get Started** chapter, we will use OCI CLI to connect to deployed private Compute Instances. That functionality is only available in the Home Region. If you want to use a different region, make sure you have connectivity to the private instances.
2. On the Oracle Cloud Infrastructure Console Home page, go to the Burger menu (on top left), select Networking and click on **Virtual cloud networks**. Press **Create VCN**, making sure you have the correct Compartment selected. Give the VCN a name and assign an IPv4 CIDR Block. For this LiveLab, I will use the LAB Compartment and the VCN CIDR 10.0.0.0/16. Leave everything else on default settings and press **Create VCN**.
  ![Create VCN](images/createvcn.png)
3. After you press **Create VCN**, you will be redirected to the VCN Details page, with the Subnets menu selected. Press **Create Subnet**. In the subnet creation menu, give it a name, assign a CIDR (I will use 10.0.0.0/27) and make it a **Private** subnet. Leave everything else with default settings.
  ![Create Subnet](images/createsubnet.png)

## Task 2: VCN Route table and Subnet Security List

Now that we have a VCN and a Subnet, we need to add a VCN Route Table and a Security List to that subnet. While the default ones, deployed automatically by OCI, can be used, it is recommended to have dedicated ones.

1. On the VCN Details page, on the left menu, click **Route Tables** and then click on **Create Route Table**.
  ![Create route table1](images/creatert1.png)

   In the menu that opens, give this route table a name and press **Create**. No routes are needed at this step of the Lab.
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

3. Once the firewall is **ACTIVE**, click on the left hand menu on **Logs** and enable both Traffic and Threat Logs by using the toggle.
  ![Firewall Logs](images/fwlogs.png)

**Congratulations!** You have successfully deployed an OCI Network Firewall.

## Acknowledgements

* **Author** - Radu Nistor, Principal Cloud Architect, OCI Networking
* **Last Updated By/Date** - Radu Nistor, November 2023
