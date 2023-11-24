# Inspecting inbound Internet traffic

## Introduction

Estimated Time: 60-90 minutes

### About this lab

In the previous LABs we looked into how we can inspect east-west (subnet to subnet) traffic inside an OCI VCN and how we can inspect **oubound** traffic to either the Internet or Oracle Services with various VCN Gateways. In this lab we will focus on **Inbound** traffic from the Internet. As the most common Internet service is **web** we will deploy a Public Web Load Balancer which will use one of the previously deployed Compute Instances as the backend. To inspect this traffic we need a new OCI Network Firewall, deployed in a Public Subnet. 

### Objectives

In this lab, you will:

* Deploy new subnets inside the existing VCN, for a new Network Firewall and a Load Balancer.
* Deploy a new Network Firewall, dedicated to inspecting inbound Internet traffic
* Deploy an Application Load balancer. 
* Configure and start a webserver on one of the private Compute Instances. 
* Deploy a VCN Internet Gateway with a dedicated route table.
* Adjust VCN routing to enable the new flows.
* Configure the new OCI Network Firewall to inspect inbound traffic.
* Test the new Firewall and observe the Firewall Traffic Log

![lab5](images/lab5.png)

## Task 1: Deploy new VCN subnets

  We will start by preparing the VCN for the new deployments. We need to:
* deploy a new firewall subnet with a dedicated route table and security list
* deploy a new load balancer subnet with a dedicated route table and security list

  The exact procedure to do this is detailed under **LAB 1** so I will not repeat it here. In the end, you should have:
* Firewall Subnet:
    - name: FW-Subnet-Public
    - Subnet Access: Public
    - CIDR: 10.0.0.96/27
    - Route table: FW-Subnet-Public-RT with no entries
    - Security List: FW-Subnet-Public-SL with allow 0.0.0.0/0 on both ingress and egress
* Load balancer Subnet:
    - name: LB-Subnet-Public
    - Subnet Access: Public
    - CIDR: 10.0.0.128/27
    - Route table: LB-Subnet-Public-RT with no entries
    - Security List: LB-Subnet-Public-SL with allow 0.0.0.0/0 on both ingress and egress

  ![VCN Subnets](images/vcnsubnets.png)

  ![VCN Subnets1](images/vcnsubnets1.png)
 
  ![VCN Subnets2](images/vcnsubnets2.png)

## Task 2: Deploy a new Network Firewall - TO DO

Now that we have a VCN and a Subnet, we need to add a VCN Route Table and a Security List to that subnet. While the default ones, deployed automatically by OCI, can be used, it is recommended to have dedicated ones.

1. On the VCN Details page, on the left menu, click **Route Tables** and then click on **Create Route Table**.
  ![Create route table1](images/creatert1.png)

   In the menu that opens, give this route table a name and press **Create**. No routes are needed at this step of the Lab.
  ![Create route table2](images/creatert2.png)

2. On the VCN Details page, on the left menu, click **Subnets** and then click on the Firewall subnet created earlier.
  ![Click subnet](images/clicksubnet.png)

   In the menu that opens (subnet details), click **Edit**. In the new menu, replace the default Route Table with the one previously created and save the changes.
  ![Replace Route Table](images/subnetrt.png)


## Task 3: Deploy an Application Load balancer.

We will deploy an Application Load Balancer with a basic HTTP listener and with APP-VM2 as a backend.

1. On the Oracle Cloud Infrastructure Console Home page, go to the Burger menu (on top left), select **Networking** and click on **Load balancer**.
  ![Click LoadBalancer](images/clicklb.png)

   In the menu that opens, click **Create load balancer**. 
  ![Click LoadBalancer](images/clickcreatelb.png)

2. The Load Balaner creation wizard starts. Give it a name - **LAB-Public-LB** and make it Public. 
  ![Create lb1](images/createlb1.png)

   Leave everything else on defaults and scrool down until the networking details menu. There, input the correct VCN and Subnet and press Next.
  ![Create lb2](images/createlb2.png)

3. In the next menu, press **Add backends** and add one of the existing Compute Instances.
  ![Add backend](images/lbaddbackend.png)

  In the same tab, configure the health checks to use TCP and press Next.
  ![Configure hc](images/confhc.png)

4. In the next menu, select an HTTP listener and press Next.
  ![Configure listener](images/conflsn.png)

5. In the next menu, select **Default Group** for the logs and press Submit.
  ![Configure log](images/conflog.png)

  After the LB finishes the deployment, you will the the Public IP assigned to it. Take a note of it as we will use it for tests in the upcoming tasks and labs.
  ![LB PublicIP](images/lbpubip.png)

For the moment, the LB will remain in an **unhealthy** state as the backend does not have the web service enabled. We will fix that in the next task.

## Task 4: Configure and start a webserver on one of the private Compute Instances. - TO DO

## Task 5: Deploy a VCN Internet Gateway with a dedicated route table.

In OCI, Public resources (such as Load Balancers or Compute Instances) need an **Internet Gateway** to exchange packets with the Internet. Since we will add the Network Firewall on the path, we need to add a Route Table to the Internet Gateway so we can reroute the traffic. 

1. On the Oracle Cloud Infrastructure Console Home page, go to the Burger menu (on top left), select Networking and click on **Virtual cloud networks**. Next, click the VCN named **LiveLab-OCIFW-VCN**. On the VCN Details page, on the left menu, click **Route Tables**. Press **Create Route Table**. In the menu that opens, give it a name - **IGW-RT**. No entries for the moment, we will do that at a later step.
  ![Internet GW1](images/igw1.png)
 
2. In the VCN Details page, click **Internet Gateways** on the left menu then click **Create Internet Gateway**. In the menu that opens, give it a name and attach the Route table previously created.
  ![Internet GW2](images/igw2.png)

## Task 6: Adjust VCN routing to enable the new flows. - TO DO
## Task 7: Configure the new OCI Network Firewall to inspect inbound traffic. - TO DO
## Task 8: Test the new Firewall and observe the Firewall Traffic Log - TO DO

**Congratulations!** You have successfully deployed an OCI Network Firewall.

## Acknowledgements

* **Author** - Radu Nistor, Principal Cloud Architect, OCI Networking
* **Last Updated By/Date** - Radu Nistor, November 2023
