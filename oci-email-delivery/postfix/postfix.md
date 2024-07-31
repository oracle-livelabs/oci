# Install and Configure Postfix

## Introduction

Once you have Email Delivery configured, you can use it with a wide variety of OCI services. For this lab, we will install and configure Postfix on a previously created Linux virtual machine to test our email delivery setup.

Estimated Lab Time: 15 minutes

### About <Product/Technology>
Postfix is an open source email server and Mailx is an email client. In this lab, we are using them to test the Email Delivery and DNS setup.

### Objectives

In this lab, you will:
* Generate SMTP Credentials
* Install Postfix
* Configure Postfix
* Send Test Email

### Prerequisites

This lab assumes you have:
* Oracle Cloud account
* All previous labs successfully completed
* Oracle Linux Virtual Machine in OCI Previously Created


## Task 1: Generate SMTP Credentials

1. While in the OCI Console, Click on your **Profile** which can be found in the upper-right corner of any screen in the OCI console. Select **My Profile**.
![Open User Profile in Console](images/picture1.png)

2. Click on **SMTP credentials** on the left-hand side of your profile under Resources.

3. Click on the **Generate SMTP Credentials** button.
![Generate SMTP Credentials](images/picture2.png)

4. Enter a description for the credentials and then click on the **Generate credentials** button.

5. Copy the Username and Password. Save them to a secure location for use in the next task. **Close** the Generate credentials window when complete.
![Copy SMTP Credentials](images/picture3.png)

6. There is one more piece of information you need for your Postfix configuration. Before you leave the console, click the **Navigation menu** in the upper left, navigate to **Developer Services** then select **Application Integration - Email Delivery**. Once at the Email Delivery screen, click **Configuration** in the left-hand side.
![Email Delivery Configuration Navigation](images/picture4.png)

6. Copy the Relay Host Public Endpoint and SMTP Ports for use in the next task. Save for use later.
![Email Delivery Relay Host Configuration](images/picture5.png)

## Task 2: Install Postfix
Log into an existing OCI virtual machine. If you do not have one already, please create one for your testing. If you are unfamiliar with the process of creating a virtual machine, there are several links in the "Other LiveLabs" section to take you through that process. Once you have a VM, please use SSH to connect to that VM and then begin the instructions below.
1. Install Postfix
    ```bash
    <copy>sudo dnf install -y postfix</copy>
    ```
2. Allow SMTP traffic through the firewall
    ```bash
    <copy>sudo firewall-cmd --zone=public --add-service=smtp --permanent</copy>
    ```
3. Reload firewall
    ```'.bash'
    <copy> sudo firewall-cmd --reload</copy>
    ```
4. Remove sendmail package if present
    ```bash
    <copy>sudo dnf remove -y sendmail</copy>
    ```
5. Set Postfix as the default Mail Transfer Agent
    ```'.sh'
    <copy>sudo alternatives --set mta /usr/sbin/sendmail.postfix</copy>
    ```
6. Enable and start Postfix service
    ```'.bash'
    <copy>sudo systemctl enable --now postfix</copy>
    ```
7. Make a copy of the Postfix configuration file as a backup
    ```bash
    <copy>sudo cp /etc/postfix/main.cf /etc/postfix/main.bak</copy>
    ```
8. Edit your Postfix configuration file
    ```bash
    <copy>sudo vi /etc/postfix/main.cf</copy>
    ```
9.  You will need to add the following entries to the end of the main.cf file and save it. For this lab we are using opportunistic TLS but you may want to change the TLS Security Level from may (opportunistic) to encrypt (mandatory). Please see more in documentation.
    ```'.bash'
    <copy>
    smtp_tls_security_level = may
    smtp_sasl_auth_enable = yes
    smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
    smtp_sasl_security_options =
    </copy>
    ```
You will also need to add an entry for your relay host and port.
    ```'.bash'
    <copy>relayhost = smtp.email.us-ashburn-1.oci.oraclecloud.com:587</copy>
    ```
This is what the entries look like in an example main.cf.
![Postfix Configuration File Added Entries](images/picture6.png)

## Task 3: Configure Postfix
1. The next step is to generate your sasl_passwd file. This file uses the relay host, SMTP Port, SMTP Username and SMTP Password information you saved in Task 1 of this lab. The SASL Passwd file uses this format.
server:port user:pass
    ```'.bash'
    <copy>sudo vi sasl_passwd</copy>
    ```
2. Add your relay host and port by entering. Save your sasl_passwd file when complete.
    ```'.bash'
    server:port user:pass
    ```
3. Change the permissions on the sasl_passwd file
    ```'.bash'
    <copy>sudo chown root:root /etc/postfix/sasl_passwd && sudo chmod 600 /etc/postfix/sasl_passwd</copy>
    ```
4. Generate the SASL Hash
    ```'.bash'
    <copy>sudo postmap hash:/etc/postfix/sasl_passwd</copy>
    ```
5. Reload Postfix
    ```'.bash'
    <copy>sudo postfix reload</copy>
    ```
6. Install MailX
    ```'.bash'
    <copy>sudo dnf install -y mailx</copy>
    ```
7. You are now ready to test everything. Use the command below and substitute in your *Approved Sender* email and *Recepient Email* Address
    ```bash
    <copy>echo "This is a test message." | mailx -s "Test" -r APPROVEDSENDER@YOURDOMAIN.com RECEPIENTEMAIL@DOMAIN.com</copy>
    ```
8. If you need to troubleshoot, please check the Postfix logs to see what may have gone wrong. You have completed the workshop when you successfully receive your test email.
    ```'.bash'
    <copy>sudo tail -f /var/log/maillog</copy>
    ```
9. You are now complete the lab. If you'd like, navigate back to the Email Deliverability and Reputation Governance Dashboard to see statistics on your email usage.

## Learn More

* [Installing Postfix with OCI Email Delivery](https://docs.oracle.com/en-us/iaas/Content/Email/Reference/postfix.htm)

## Acknowledgements
* **Author** - Kevin McCoy, Cloud Architect
* **Contributors** -  Germain Vargas, Cloud Architect
* **Last Updated By/Date** - Kevin McCoy, July 2024
