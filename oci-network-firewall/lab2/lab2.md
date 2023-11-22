# East-West Traffic Inspection

## Introduction

Estimated Time: 30-45 minutes

### About East-West Traffic Inspection

East-West Traffic Inspection is done when two or more hosts from the same environment(in our case, OCI) communicate with each other and there is a Network Firewall on the path that is policing the traffic. 

### Objectives

In this lab, you will:

* Configure OCI Cloud Shell for management access to private Compute Instances.
* Deploy two application subnets in the same VCN as the OCI Network Firewall
* Deploy two private OCI Compute Instances, one in each application subnet.
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

2. On the Cloud Shell deployment, click on the down arrow next to **Network:Public** and click **Private network definition list**.
  ![Define private network](images/privatecs1.png)

3. In the menu that opens, click **Create private network definition** and, in the next menu, give it a name and select the existing Firewall VCN and subnet.
  ![Deploy private network](images/privatecs2.png)

  Next, select it as the default network for Cloud Shell.
  ![Default private network](images/privatecs3.png). 

  Next, **close** the Cloud Shell and **open** it again. It should now show the Cloud Shell instance deployed in the private firewall subnet.
  ![Private network cloudshell](images/privatecs4.png). 

4. With the Cloud Shell instance deployed in the private subnet, we will now need to generate **SSH keys** that we will use to connect to private Instances. Just issue the **ssh-keygen** command and press **Enter** until the keys are generated. Next, view the public key that was generated. We will use that **Public Key** on each private Compute instance that we will deploy.
  ![Generate ssh keys](images/keygencs.png)

**Note:** Even if you close Cloud Shell and log out of the OCI Console, the files on the Instance (like the SSH keys) are kept and will be available next time you start Cloud Shell.

## Task 2: Deploy two application subnets with Route Tables and Security Lists

We are now ready to deploy two application subnets, in the Firewall VCN deployed in the previous lab. The procedure is identical to the one described in **LAB 1 - Tasks 1 and 2**. 

1. Application subnet1 will have the following configuration:

* Name: App-Subnet1
* CIDR: 10.0.0.32/27
* Subnet Access: Private
* Route table: new Route Table called "App-Subnet1-RT" with no entries
* Security List: new Security List called "App-Subnet1-SL" with a single "Allow all-0.0.0.0/0" rule on both Ingress and Egress.

  ![Application subnet1](images/appsubnet1.png)

1. Application subnet2 will have the following configuration:

* Name: App-Subnet2
* CIDR: 10.0.0.64/27
* Subnet Access: Private
* Route table: new Route Table called "App-Subnet2-RT" with no entries
* Security List: new Security List called "App-Subnet2-SL" with a single "Allow all-0.0.0.0/0" rule on both Ingress and Egress.

  ![Application subnet2](images/appsubnet2.png)

   In the end, in the VCN Details page, you should see three subnets.
  ![Subnet overview](images/subnetov.png)

## Task 3: Deploy two private OCI Compute Instances

Now that we have the subnets, we can go ahead and deploy Compute Instances.

1. On the Oracle Cloud Infrastructure Console Home page, go to the Burger menu (on top left), select Compute and click on **Instances**. In the menu that opens, click **Create Instance**
  ![Instance overview](images/createinstance1.png)

2. In the menu that opens, we need to input data into multiple fields. Unless specified otherwise in this tutorial, leave the fields with the **Default** input.

* Compute Name: APP-VM1
* Everything else until **Primary VNIC information** remains on default
* Network details: select the VCN and the APP-Subnet1 subnet

  ![Deploy VM subnet](images/createinstance2.png)

* In the **Add SSH keys** menu, select **Paste Public Keys** and paste the paste the Public SSH Key created at **Task 1**, in the Cloud Shell instance.
  ![Deploy VM keys](images/createinstance3.png)

* Leave everything else on **Default** and press **Create**.

* Wait for the Instance to go into the **Running** state and note the private IP it was assigned.
  ![Deploy VM first](images/createinstance4.png)

3. **Repeat** the procedure and deploy a second Compute Instance. Name it **APP-VM2** and make sure you select **APP-Subnet2** as the target.
  ![Deploy VM second](images/createinstance5.png)

4. Start the **Cloud Shell** instance and try to SSH to both Compute Instances. The user is **opc**.
  ![Connect vms](images/connectvms.png)

## Task 4: Adjust VCN routing

With VCN Default Routing, any Compute Instance in the VCN will be routed directly to any other Compute Instance from the same VCN. To change that and add the Network Firewall on the path, we will need to modify the subnet Route Tables.

1. On the Oracle Cloud Infrastructure Console Home page, go to the Burger menu (on top left), select **Identity and Security** and click on **Network firewalls**. In the menu that opens, click on the Network firewall deployed in the previous LAB. In the details page that opens, note the Firewall's Private IP.
  ![Firewall details](images/firewalldetails.png)

2. On the Oracle Cloud Infrastructure Console Home page, go to the Burger menu (on top left), select Networking and click on **Virtual cloud networks**. Next, click the VCN named **LiveLab-OCIFW-VCN**. On the VCN Details page, on the left menu, click **Route Tables**. We will modify the APP-Subnet Route tables.
  ![VCN Route tables](images/vcnroutetables.png)

3. Click on the Route table named **App-Subnet1-RT**. In the menu that opens, click **Add Route Rules**. We will add a route for APP-Subnet2 (10.0.0.64/27) with next hop the Firewall.
  ![Static route1](images/staticroute1.png)

4. Go back to the Route Tables overview and click on the route table named **App-Subnet2-RT**. In the menu that opens, click **Add Route Rules**. We will add a route for APP-Subnet1 (10.0.0.32/27) with next hop the Firewall.
  ![Static route2](images/staticroute2.png)

And that's it! Communication between the two Application Subnets will now be forced through the OCI Network Firewall.   

## Task 5: Modify the OCI Firewall policy

In a previous **LAB** we deployed a Network Firewall with an empty Firewall Policy. As we've create the new subnets and Compute Instances, we need to adjust the Firewall Policy to allow traffic between those subnets. 
Since we cannot modify a Firewall Policy that is **IN-USE** by a Firewall, the usual procedure follows this workstream: we clone the existing Policy that is in use -> we add or remove any configuration from the new, cloned Policy -> we modify the OCI Network Firewall to use the Cloned Policy. 

1. On the Oracle Cloud Infrastructure Console Home page, go to the Burger menu (on top left), select **Identity and Security** and click on **Network firewalls**. In the menu that opens, click on the Network firewall deployed in the previous LAB. In the details page that opens, click the Policy that is in use.
  ![Click Policy](images/clickpolicy.png)

2. In the menu that opens, click **Clone Policy** and give the new Policy a name. I will name it **network_firewall_policy_1**.
  ![Clone Policy](images/clonepolicy.png)

3. Go back to the **Network Firewall policies** and click on the newly cloned policy called **network_firewall_policy_1**.
  ![Click Policy2](images/clickpolicy2.png)

In the Network Firewall Policy we will create the following constructs:
* One Application that defines PING
* One Application List that contains the Application above
* One Service that defines SSH
* One Service List that contains the SSH Service
* One Address list that contains the two application subnets CIDRs
* One Firewall Security Rule that allows SSH between the Application subnets.
* One Firewall Security Rule that allows PING between the Application subnets.

4. In the **Network firewall policy details** menu, click on **Applications** on the left menu and click **Create application**. Create an application that allows **Echo requests**.
  ![Create application](images/createapp.png)

5. In the **Network firewall policy details** menu, click on **Application lists** on the left menu and click **Create application list**. Create an application list that contains the Application created at the previous step.
  ![Create application list](images/createapplist.png)

6. In the **Network firewall policy details** menu, click on **Services** on the left menu and click **Create service**. Create a service that allows **SSH / TCP on port 22**.
  ![Create service](images/createsrv.png)

7. In the **Network firewall policy details** menu, click on **Service lists** on the left menu and click **Create service list**. Create a service list that contains the SSH service created at the previous step.
  ![Create service](images/createsvclist.png)

8. In the **Network firewall policy details** menu, click on **Address lists** on the left menu and click **Create address list**. Create an address list that contains the CIDRs of the two application subnets.
  ![Create address list](images/createaddrlist.png)

**NEXT** let's create our first firewall rules.

9. In the **Network firewall policy details** menu, click on **Security rules** on the left menu and click **Create security rule**. 
  ![Create security rule](images/createsecrule.png)

10. In the menu that opens, give the rule a name -> **Allow-SSH-inside-the-VCN**. In the **Match condition**, under Source addresses, click **Select address lists** and add the previously created address list.
  ![Security rule source](images/secrule1.png)

  For this rule we will use the same address list for both source and destination so **repeat** the procedure above to add the same address ist as a destination. In the end, the source and destination fields should look like this:
  ![Security rule sd](images/secrule2.png)

  For applications we will leave it with **Any application** but for service we will add the service list created at step 7, named **Service-list1**. For URL, we will let **Any URL**.
  ![Security rule srv](images/secrule3.png)

  Last, for the **Rule action**, we will select **Allow traffic**. Press **Create Security Rule**.
  ![Security rule create](images/secrule4.png)

11. Next, repeat the procedure above to create a second firewall rule, called **Allow-PING-inside-the-VCN**. The Source, Destination, URLs will be the same as before but the Application will be the **Application list** created at step 5 while the **Services** will remain with **Any service**. 
  ![Security rule create2](images/secrule5.png)

  The reason we create two security rules is because it is not supported to have both Applications and Services inside the same rule. In the end, you should have two **Security Rules** in the Policy, one that allows **SSH** inside the VCN and the other one that allows **PING**.
  ![Security rules](images/secrule6.png)

12. Now that we have finished configuring the policy, it is time to modify the firewall to use this new policy. Go to **Identity and Security** and click on **Network firewalls**. Next, click on the Network Firewall we deployed. Click **Edit** and configure it to use the new policy, called **network_firewall_policy_1**.
  ![Modify firewall](images/modifyfw.png)  

  The firewall will change from the **ACTIVE** state to **UPDATING**. Wait for it to become **ACTIVE** again before moving to the next task.

## Task 6: Test traffic and observe logs

## Acknowledgements

* **Author** - Radu Nistor, Principal Cloud Architect, OCI Networking
* **Last Updated By/Date** - Radu Nistor, November 2023
