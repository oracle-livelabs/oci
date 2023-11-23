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

In OCI, private Compute Instances need a NAT Gateway to exit to the Public Internet. Since we will add the Network Firewall on the path, we need to add a Route Table to the NAT Gateway so we can reroute the traffic. 

1. On the Oracle Cloud Infrastructure Console Home page, go to the Burger menu (on top left), select Networking and click on **Virtual cloud networks**. Next, click the VCN named **LiveLab-OCIFW-VCN**. On the VCN Details page, on the left menu, click **Route Tables**. Press **Create Route Table**. In the menu that opens, give it a name - **NAT-GW-RT**. No entries for the moment, we will do that at a later step.
  ![NAT GW1](images/natgw1.png)
 
  Next, in the VCN Details page, click **NAT Gateways** on the left menu then click **Create NAT Gateway**. In the menu that opens, give it a name and attach the Route table previously created.
  ![NAT GW2](images/natgw2.png)

## Task 2: Adjust VCN routing

  Now that we have a **NAT Gateway**, we need to adjust VCN routing to use it. 
  ![VCN Routetables](images/vcnrt.png)

  We will modify all **Route Tables** in the VCN, that we deployed in the previous LABs, with the following rules:

* The Application Subnets route tables, called **App-Subnet1-RT** and **App-Subnet2-RT**, will each get the default route (0.0.0.0/0) next-hop the firewall's IP (10.0.0.12).
* The Network Firewall route table, called **Firewall-Subnet-Private-RT**, will get the default 0.0.0.0/0 route next-hop the NAT Gateway.
* Finally, the NAT Gateway Route table will need return routes for 10.0.0.32/27 (App-Subnet1) and 10.0.0.64/27 (App-Subnet2) next-hop the firewall's IP (10.0.0.12).

1. On the VCN Details page, on the left menu, click **Route Tables** and then click on **App-Subnet1-RT**. In the menu that opens, click on **Add Route Rules** and add 0.0.0.0/0 with next-hop the firewall's IP.
  ![Default app1rt](images/defapp1rt.png)

2. **Repeat** the procedure and add the same route rule to **App-Subnet2-RT**
  
3. Next, click on **Firewall-Subnet-Private-RT** and add the default route with next-hop the NAT Gateway.
  ![Default fwrt](images/deffwrt.png)

4. Next, click on **NAT-GW-RT** and add routes for 10.0.0.32/27 (App-Subnet1) and 10.0.0.64/27 (App-Subnet2) next-hop the firewall's IP (10.0.0.12)
  ![NAT Routes](images/natgwroutes.png)

  Note: the image shows the route for 10.0.0.32/27. Repeat the procedure and add 10.0.0.64/27 too.

## Task 3: Modify the OCI Firewall policy

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

## Task 4: Test traffic and observe logs

**Congratulations!** You have successfully completed this LAB.

## Acknowledgements

* **Author** - Radu Nistor, Principal Cloud Architect, OCI Networking
* **Last Updated By/Date** - Radu Nistor, November 2023
