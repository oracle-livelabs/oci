# Configure VM Series Firewalls

## Introduction

In this lab you will be configuring VM Series Firewall firewalls initial configuration, hostname, interfaces, high availability, external OCI connector and route tables to support traffic between VCNs.

Estimated Lab Time: 20 minutes.

### Objectives

- Initial Configuration on Primary VM Series Firewall
- Initial Configuration on Secondary VM Series Firewall

### Prerequisites

- Oracle Cloud Infrastructure paid account credentials (User, Password, Tenant, and Compartment)  

## Task 1: Initial Configuration on Primary VM Series Firewall

1. Setup initial **admin** user password using **CLI**. Connect to **vm-series-firewall-1** instance using your ssh private key which you used earlier via **admin** user:  

      ```
      <copy>
      ssh -i private-key-path admin@vm-series-firewall-1-mgmt-public-ip
      </copy>
      ```

2. Once you login successfully, you need to setup **admin** password so you can login to GUI. Enter **configure** command to configuration mode. Run below command and setup password. In your case you can hose **PaloAlto@1234** as password example or your unique password. 

      ```
      <copy>
      configure 
      set mgt-config users admin password
      </copy>
      ```
3. Once you confirm password, make sure to commit your change using **commit** command on the same shell prompt. Below snippet shows an **example** of setting initial password. 

   ![Primary Firewall Mgmt Password Configuration](../common/images/firewall1-initial-config.png " ")

4. Connect to **VM-Series-Firewall-1** instance public IP on your local machine's web browser: **https://public_ip**. It will ask you to enter username/password so enter **admin/PaloAlto@1234** or the password which you picked in **step2** earlier. 

   ![Primary Firewall Login Page](../common/images/first-time-firewall-login-page.png " ")

5. Close the initial dialog box and select **Remind Me Later** option as below: 

   ![Primary Firewall Telemetry Configuration Page](../common/images/firewall-initial-config-telemtry.png " ")

6. Click on the link below to open the **xml** configuration file which you need to setup initial configuration on Firewall.  

    - Click here: [vm-series-firewall-1.xml](https://objectstorage.us-ashburn-1.oraclecloud.com/p/iPLJ5NPlwhpWx2UlZVCz0xoArKZFRsert5k1LYY7Snxpb1K-e1hTvKJws3xnXlnJ/n/partners/b/files/o/vm-series-firewall-1.xml) 
    - **PAR URL** is valid until **Dec, 2025**.

7. Save in your local machine's downloads folder and open the file.

8. Update **vm-series-firewall1.xml** file variables as per below table and make sure details matches to your **VM-Series-Firewall-1** instance.

    | Parameter                                 | Value                                                            | Comment                            |
    |-------------------------------------------|------------------------------------------------------------------|------------------------------------|
    | untrust-interface-floating-ip/subnet-mask | Primary Firewall Untrust Secondary Interface Floating Private IP | Example: 192.168.3.47/24           |
    | trust-interface-floating-ip/subnet-mask   | Primary Firewall Trust Secondary Interface Floating Private IP   | Example: 192.168.2.156/24          |
    | untrust-subnet-default-gateway            | First IP of Untrust Subnet                                       | Example: 192.168.3.1               |
    | trust-subnet-default-gateway              | First IP of Trust Subnet                                         | Example: 192.168.2.1               |
    | spoke-vcns-cidr/mask                      | Collective or Single Values of Spoke VCNs                        | Example: 10.0.0.0/16               |
    | object-storage-cidr/mask                  | Object Storage Network CIDR; Specific to your Region             | Example: 134.70.0.0/16 for Ashburn |
    | first-firewall-hostname                   | First Firewall Hostname                                          | Example: Firewall-A                |
    | first-firewall-mgmt-ip                    | First Firewall MGMT IP                                           | Example: 192.168.1.108             |
    | mgmt-subnet-default-gateway               | First IP of Mgmt Subnet                                          | Example: 192.168.1.1               |
    | first-firewall-ha-interface-ip            | First Firewall HA Interface IP                                   | Example: 192.168.4.200             |
    | ha-subnet-default-gateway                 | First IP of HA Subnet                                            | Example: 192.168.4.1               |
    | second-firewall-mgmt-private-ip           | Second Firewall MGMT IP                                          | Example: 192.168.1.136             |
    | db-app1-vm-ip                             | DB VCN App1 VM Private IP                                        | Example: 10.0.1.50                 |
    | web-app1-vm-ip                            | Web VCN App1 VM Private IP                                       | Example: 10.0.0.19                 |

9. Once you have updated local **xml** file. It's time to upload that configuration to your **vm-series-firewall-1** i.e. Primary instance.

10. This will add below configuration to your **vm-series-firewall-1** instance: 

    - **Hostname** and mgmt **IP Address**
    - Untrust, Trust and HA **Interfaces**
    - Static **Routes** **entries**
    - **Security** policies 
    - **NAT** policies 
    - **HA Communication** 

11. Navigate to **Device > Operations > Import named configuration snapshot** as per below. 

   ![Primary Firewall Import Configuration Navigation Window1](../common/images/firewall-device-import-config-1.png " ")

   ![Primary Firewall Import Configuration Navigation Window2](../common/images/firewall-device-import-config-2.png " ")

12. Click on **Import named configuration snapshot** and browse your local file which you just updated with required variable. 

   ![Primary Firewall Import Configuration Navigation Window3](../common/images/firewall-local-xml-file.png " ")

13. Click on **Load named configuration snapshot** and select the file which you just imported. 

   ![Primary Firewall Load Configuration Navigation Window](../common/images/firewall-local-load-xml-file.png " ")

13. Do a sanity check and verify that configuration which you are trying to push to Firewall is correct: 

    - **Interfaces**
      
      ![Primary Firewall Interfaces](../common/images/firewall-initial-push-sanity-check1.png " ")

    - **Security Policies**

      ![Primary Firewall Security Policies](../common/images/firewall-initial-push-sanity-check3.png " ")

    - **NAT Policies**

      ![Primary Firewall NAT Policies](../common/images/firewall-initial-push-sanity-check4.png " ")

    - **Address Objects**
   
       ![Primary Firewall Address Objects](../common/images/firewall-initial-push-sanity-check2.png " ")

    - **HA Communication**

       ![Primary Firewall HA Configuration](../common/images/firewall-initial-push-sanity-check5.png " ")

14. Commit your changes to **vm-series-firewall-1** instance and it should be successful: 

   ![Primary Firewall Initial Commit](../common/images/firewall-initial-commit.png " ")

   ![Primary Firewall Initial Commit Success](../common/images/firewall-initial-commit-success.png " ")

15. You can verify configuration by navigating to **interfaces**, **policies** etc section. For example, below image shows interfaces are created successfully: 

   ![Primary Firewall Hostname Verification](../common/images/firewall1-hostname.png " ")

   ![Primary Firewall Sanity Check](../common/images/firewall-initial-commit-sanity-check.png " ")

16. You need to enable **Jumbo Frame** so to enable that navigate: **Device > Setup > Session** and check mark **Enable Jumbo Frame** option:

   ![Primary Firewall Enable Jumbo Frames](../common/images/enable-jumbo-frame.png " ")

17. You must reboot the device to reflect jumbo frame changes. You can do that from OCI console or using **Operations > Reboot Device** option within your **vm-series-firewall-1** GUI. 

   ![Primary Firewall Enable Jumbo Frames Reboot Required](../common/images/reboot-device.png " ")

## Task 2: Initial Configuration on Secondary VM Series Firewall**

1. Setup initial **admin** user password using **CLI**. Connect to **vm-series-firewall-2** instance using your ssh private key which you used earlier via **admin** user:  

      ```
      <copy>
      ssh -i private-key-path admin@vm-series-firewall-1-mgmt-public-ip
      </copy>
      ```

2. Once you login successfully, you need to setup **admin** password so you can login to GUI. Enter **configure** command to configuration mode. Run below command and setup password. In your case you can hose **PaloAlto@1234** as password example or your unique password. 

      ```
      <copy>
      configure 
      set mgt-config users admin password
      </copy>
      ```
3. Once you confirm password, make sure to commit your change using **commit** command on the same shell prompt. Below snippet shows an **example** of setting initial password. 

   ![Secondary Firewall Mgmt Password Configuration](../common/images/firewall1-initial-config.png " ")

4. Connect to **VM-Series-Firewall-2** instance public IP on your local machine's web browser: **https://public_ip**. It will ask you to enter username/password so enter **admin/PaloAlto@1234** or the password which you picked in **step2** earlier. 

   ![Secondary Firewall Login Page](../common/images/first-time-firewall-login-page.png " ")

5. Close the initial dialog box and select **Remind Me Later** option as below: 

   ![Secondary Firewall Telemetry Configuration Page](../common/images/firewall-initial-config-telemtry.png " ")

6. Click on the link below to open the **xml** configuration file which you need to setup initial configuration on Firewall.  

    - Click here: [vm-series-firewall-2.xml](https://objectstorage.us-ashburn-1.oraclecloud.com/p/JRG_oc_JjiPblTGk3PhuiqhWLJ9D7kot7IOLOCgWCyHreT4POSk0AcI9hC35-f4y/n/partners/b/files/o/vm-series-firewall-2.xml) 
    - **PAR URL** is valid until **Dec, 2025**.

7. Save in your local machine's downloads folder and open the file.

8. Update **vm-series-firewall2.xml** file variables as per below table and make sure details matches to your **VM-Series-Firewall-2** instance.

    | Parameter                                 | Value                                                            | Comment                            |
    |-------------------------------------------|------------------------------------------------------------------|------------------------------------|
    | untrust-interface-floating-ip/subnet-mask | Primary Firewall Untrust Secondary Interface Floating Private IP | Example: 192.168.3.47/24           |
    | trust-interface-floating-ip/subnet-mask   | Primary Firewall Trust Secondary Interface Floating Private IP   | Example: 192.168.2.156/24          |
    | untrust-subnet-default-gateway            | First IP of Untrust Subnet                                       | Example: 192.168.3.1               |
    | trust-subnet-default-gateway              | First IP of Trust Subnet                                         | Example: 192.168.2.1               |
    | spoke-vcns-cidr/mask                      | Collective or Single Values of Spoke VCNs                        | Example: 10.0.0.0/16               |
    | object-storage-cidr/mask                  | Object Storage Network CIDR; Specific to your Region             | Example: 134.70.0.0/16 for Ashburn |
    | second-firewall-hostname                  | Second Firewall Hostname                                         | Example: Firewall-B                |
    | second-firewall-mgmt-ip                   | Second Firewall MGMT Interface Private IP                        | Example: 192.168.1.136             |
    | mgmt-subnet-default-gateway               | First IP of Mgmt Subnet                                          | Example: 192.168.1.1               |
    | second-firewall-ha-interface-ip           | Second Firewall HA Interface IP                                  | Example: 192.168.4.109             |
    | ha-subnet-default-gateway                 | First IP of HA Subnet                                            | Example: 192.168.4.1               |
    | first-firewall-mgmt-private-ip            | First Firewall MGMT Interface Private IP                         | Example: 192.168.1.108             |
    | db-app1-vm-ip                             | DB VCN App1 VM Private IP                                        | Example: 10.0.1.50                 |
    | web-app1-vm-ip                            | Web VCN App1 VM Private IP                                       | Example: 10.0.0.19                 |

9. Once you have updated local **xml** file. It's time to upload that configuration to your **vm-series-firewall-2** i.e. Primary instance.

10. This will add below configuration to your **vm-series-firewall-2** instance: 

    - **Hostname** and mgmt **IP Address**
    - Untrust, Trust and HA **Interfaces**
    - Static **Routes** **entries**
    - **Security** policies 
    - **NAT** policies 
    - **HA Communication** 

10. Navigate to **Device > Operations > Import named configuration snapshot** as per below. 

   ![Secondary Firewall Import Configuration Navigation Window1](../common/images/firewall-device-import-config-1.png " ")

   ![Secondary Firewall Import Configuration Navigation Window2](../common/images/firewall-device-import-config-2.png " ")

11. Click on **Import named configuration snapshot** and browse your local file which you just updated with required variable. 

   ![Secondary Firewall Import Configuration Navigation Window3](../common/images/firewall-local-xml-file.png " ")

12. Click on **Load named configuration snapshot** and select the file which you just imported. 

   ![Secondary Firewall Load Configuration Navigation Window](../common/images/firewall-local-load-xml-file.png " ")

13. Do a sanity check and verify that configuration which you are trying to push to Firewall is correct: 

    - **Interfaces**
      
      ![Secondary Firewall Interfaces](../common/images/firewall-initial-push-sanity-check1.png " ")

    - **Security Policies**

      ![Secondary Firewall Security Policies](../common/images/firewall-initial-push-sanity-check3.png " ")

    - **NAT Policies**

      ![Secondary Firewall NAT Policies](../common/images/firewall-initial-push-sanity-check4.png " ")

    - **Address Objects**
   
       ![Secondary Firewall Address Objects](../common/images/firewall-initial-push-sanity-check2.png " ")

    - **HA Communication**

       ![Secondary Firewall HA Configuration](../common/images/firewall-initial-push-sanity-check5.png " ")

14. Commit your changes to **vm-series-firewall-2** instance and it should be successful: 

   ![Secondary Firewall Initial Commit](../common/images/firewall-initial-commit.png " ")

   ![Secondary Firewall Initial Commit Success](../common/images/firewall-initial-commit-success.png " ")

15. You can verify configuration by navigating to **interfaces**, **policies** etc section. For example, below image shows interfaces are created successfully: 

   ![Secondary Firewall Hostname Verification](../common/images/firewall2-hostname.png " ")

   ![Secondary Firewall Sanity Check](../common/images/firewall-initial-commit-sanity-check.png " ")

16. Navigate to **Dashboard > Widgets > System > High Availability** to add a high availability widget on each **vm-series-firewall** instances.

   ![Check HA Validation](../common/images/high-availability-widget.png " ")

17. Either you can wait for configuration to sync or you can force initial configuration sync. In this lab you will do that from **vm-series-firewall-1** instance. 

   ![Sync HA Configuration If Needed](../common/images/high-availability-sync.png " ")

18. Successful HA configuration should look like this on each firewall (primary or standby): 

   ![Successful HA Configuration](../common/images/high-availability-sync-success.png " ")

19. You need to enable **Jumbo Frame** so to enable that navigate: **Device > Setup > Session** and check mark **Enable Jumbo Frame** option:

   ![Secondary Firewall Enable Jumbo Frames](../common/images/enable-jumbo-frame.png " ")

20. You must reboot the device to reflect jumbo frame changes. You can do that from OCI console or using **Operations > Reboot Device** option within your **vm-series-firewall-2** GUI. 

   ![Secondary Firewall Enable Jumbo Frames Reboot Required](../common/images/reboot-device.png " ")

***Congratulations! You have successfully completed the lab.***

You may now [proceed to the next lab](#next).

## Learn More

1. [OCI Training](https://cloud.oracle.com/en_US/iaas/training)
2. [Familiarity with OCI console](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm)
3. [Overview of Networking](https://docs.us-phoenix-1.oraclecloud.com/Content/Network/Concepts/overview.htm)
4. [Familiarity with Compartment](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/concepts.htm)
5. [Connecting to a compute instance](https://docs.us-phoenix-1.oraclecloud.com/Content/Compute/Tasks/accessinginstance.htm)
6. [OCI VM Series Firewall Administration Guide](https://docs.paloaltonetworks.com/vm-series/10-0/vm-series-deployment/set-up-the-vm-series-firewall-on-oracle-cloud-infrastructure.html)

## Acknowledgements

- **Author** - Arun Poonia, Principal Solutions Architect
- **Adapted by** - Palo Alto Networks
- **Contributors** - N/A
- **Last Updated By/Date** - Arun Poonia, Aug 2023