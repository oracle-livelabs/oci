
# Prerequisite

## Introduction

The lab assume that you have access to OCI Cloud Shell with Public Network access.
If that is not the case for some reasons here are the solution.

## Task 1 - Check Cloud Shell - Public Network

If you start Cloud Shell and that you see **Network: Public** on the top or that you may change to **Public Network**, there is nothing to do.
For ex, OCI Administrator have that right automatically. Or your administrator has added the right already.

### Solution 1 - Add Policy

If this is not the case, please ask your Administrator to follow this document.

https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cloudshellintro_topic-Cloud_Shell_Networking.htm#cloudshellintro_topic-Cloud_Shell_Public_Network

He/She just need to add a Policy to your tenancy :

```
allow group <GROUP-NAME> to use cloud-shell-public-network in tenancy
```

### Solution 2 - Use a compute to run the build

If for some reasons, Cloud Shell access can be be granted. The another way is to have a Virtual Machine to run the build with internet access (via Internet or NAT Gateway).
In short, 
- Create a VCN 
    - Go to Menu / Networking / Virtual Cloud Network
    - Click **Start VCN Wizard**
    - Choose **Create VCN with Internet Connectivity**
    - Follow the wizard
- Create a VM
    - Go to Menu / Compute / Instance
    - Click **Create Instance**
    - Choose the shape. The shape can be an ARM or X86 based on what you want to build.
    - Follow the wizard
- Log on the VM
    - ssh opc@YOUR_DEVVM
    - Follow https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm#configfile
        - oci setup config
    - Download this script to install the needed tools and check what it does:
        ```
        <copy>
        wget https://raw.githubusercontent.com/oracle-devrel/oci-starter/main/test_suite/install_dev.sh
        </copy>
        ```
    - Run it:
        ```
        <copy>
        bash install_dev.sh
        </copy>
        ```
        [Script: https://raw.githubusercontent.com/oracle-devrel/oci-starter/main/test_suite/install_dev.sh][https://raw.githubusercontent.com/oracle-devrel/oci-starter/main/test_suite/install_dev.sh]
- Restart the lab

## Acknowledgements 

* Author - Marc Gueury
* Contributors - Ewan Slater 
* Last Updated - Jan, 20th 2025
