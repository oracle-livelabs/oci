# SSL Decryption and Intrusion Detection

## Introduction

Estimated Time: 60 minutes

### About this lab

  In this LAB we will focus on HTTPS, as this is the most common way to expose **web** services. To be able to complete this lab you will need the following:
  * SSL Certificate
  * SSL Certificate Chain
  * SSL Private Key for the certificate

  This lab will not cover the procedure to obtain these items. If you own a DNS Domain, you may be able to get them from the Registrar or you can use **openssl** on any Linux system and create a self-signed certificate. Regardless of the method, proceed with this LAB only after you have the three components.

### Objectives

In this lab, you will:

* Deploy an OCI Vault Service to store the SSL Certificate.
* Enable an Inbound SSL Decryption policy on the OCI Network Firewall.
* Enable Intrusion Detection in the OCI Network Firewall.
* Enable SSL Offloading in the OCI Load Balancer.
* Test and observe Firewall Logs.

![lab6](images/lab6.png)

## Task 1: Deploy and configure the OCI Vault

  The OCI Network Firewall can decrypt incoming SSL traffic. For that, it needs a copy of the SSL certificates and the only place it can store them is the OCI Vault.

1. Log into the Oracle Cloud console and go to the Burger menu (on top left), select **Identity and Security** and click on **Vault**
  ![Click Vault](images/clickvault.png)
  
2. In the menu that opens, click **Create Vault** and, in the next menu, give it a name and press Create.
  ![Create VCN](images/createvault.png)

3. You will be redirected to the Vault Details Page. Select **Master Encryption Keys** on the left and click **Create Key**. In the new menu, give it a name (LAB-Master-Key) and make sure you select the **symmetric**  algorithm. Any protection mode is fine.
  ![Create Masterkey](images/createmasterkey.png)

4. The next step is to create a Vault **Secret** using the Certificate, Certificate Chain and Certificate Private Key. The Vault Secret has a very specific format that you need to follow in order for the firewall to be able to read it.
  ![Secret Format](images/secretformat.png)

  Open any text editor, such as Notepad, and create the Secret in the specified format. Use the following links for reference:

  [Official documentation](https://docs.public.oneportal.content.oci.oraclecloud.com/en-us/iaas/Content/network-firewall/setting-up-certificate-authentication.htm#network-firewall-setting-up-certificate-authentication) 

  [Example Secret](images/vault_secret_example.txt)

  After you prepared the **text** file with the proper format, go to the OCI Vault, click **Secrets** and click **Create Secret**. In the new menu, add the contents of the text file. 
  ![Create secret](images/createsecret.png)

5. As a final step, we need an **IAM Policy** to allow the OCI Network Firewall access to the OCI Vault. On the Oracle Cloud console, go to the Burger menu (on top left), select **Identity and Security** and click on **Policies** under the **Indentity** service.
  ![Click policy](images/clickpolicy.png)

  In the menu that opens, click **Create Policy**. In the new menu, select "**Show manual editor** and input the following IAM rule: 

  *allow service ngfw-sp-prod to read secret-family in compartment LAB*

  Note: **LAB** is the Compartment I worked with in this Workshop. Change that policy to the Compartment you used.
  ![Create policy](images/createpolicy.png)


## Task 2: OCI Network Firewall - enable inbound SSL decryption and Intrusion Detection 

  After we prepared the Vault, we need to modify the Firewall Policy to add Decryption.

1. On the Oracle Cloud Infrastructure Console Home page, go to the Burger menu (on top left), select **Identity and Security** and click on **Network firewalls**. Select **OCI Firewall2** which is the firewall inspecting **Inbound** traffic from the Internet. There, click on its running Policy - **network_firewall_policy_ingress**.
  ![click fwpol](images/clickfwpol.png)

2. In the Policy details page, click **Clone** and give the clone a new name - **network_firewall_policy_ingress_decrypt**.
  ![Clone fwpol](images/fwclonepol.png)

3. Now go to the Burger menu (on top left), select **Identity and Security** and click on **Network firewall policies**. Click on **network_firewall_policy_ingress_decrypt**. Make sure it is in **ACTIVE** state. 
  ![Click policy2](images/clickpol2.png)
  
4. In the Policy details menu, on the left, click on **Decryption profiles**. Click **Create decryption profile** and create an **SSL Inbound Inspection** profile.
  ![Create decrypt](images/createdecrypt.png)
 
5. In the Policy details menu, on the left, click on **Decryption rules**. Click **Create decryption rule**.
  ![Create decrule1](images/createdecrule1.png)

  In the menu that opens, for Source select **Any** and for Destination select the Load Balancer subnet address list.
  ![Create decrule2](images/createdecrule2.png)

  Next, under **Rule action**, select SSL Inbound Inspection, select the Profile created at point 4 and press Create Secret.
  ![Create decrule3](images/createdecrule3.png)

  In the Secret creation menu, make sure you choose the Vault, the Secret and the correct **Secret Version**. Secret Version will increase if you edit the Secret.
  ![Create decrule4](images/createdecrule4.png)

  ![Create decrule5](images/createdecrule5.png)

6. In the Policy details menu, on the left, click on **Security rules**. There should be only one. Click Edit.
  ![Edit secrule](images/editsecrule.png)

  Under **Rule action** switch from Allow to Intrusion Detection.
  ![Edit secrule2](images/editsecrule2.png)

Note: Enabling Intrusion Detection will make the firewall send a log entry to the **Threat Log** each time an attack is detected.

7. On the Oracle Cloud Infrastructure Console Home page, go to the Burger menu (on top left), select **Identity and Security** and click on **Network firewalls**. Click **OCI Firewall2** which is the firewall inspecting **Inbound** traffic from the Internet and click **Edit**. Make it use the new policy called **network_firewall_policy_ingress_decrypt**.
  ![Edit fw](images/editfw.png)

The firewall will go into the **Updating** state. Wait for it to become **ACTIVE** before moving on.


## Task 3: Enable SSL Offloading on the Load Balancer

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


## Task 4: Tests and Logs. - TO DO

**Congratulations!** You have successfully completed this LAB and this **Workshop**. 

## Acknowledgements

* **Author** - Radu Nistor, Principal Cloud Architect, OCI Networking
* **Last Updated By/Date** - Radu Nistor, November 2023
