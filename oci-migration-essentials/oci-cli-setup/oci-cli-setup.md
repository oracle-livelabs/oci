# Setup OCI CLI - Command Line Interface

## Introduction

In this Lab, we will set up the OCI command line interface (CLI). We will use the OCI CLI configuration file with Rclone and OCI CLI to synchronize data into an object storage bucket. 


### About OCI CLI

The CLI is a small-footprint tool you can use on its own or with the Console to complete Oracle Cloud Infrastructure tasks. The CLI provides the same core functionality as the Console, plus additional commands. Some of these, such as the ability to run scripts, extend Console functionality.

Estimated time: 20 minutes

### Objectives

In this lab, you will:

* Get User's OCID
* Add User's API Key
* Generate and Download RSA Key Pair in PEM format
* Install OCI Command Line Interface on your laptop or workstation
* Update the OCI Configuration file
* Use the OCI CLI to determine the OCI tenancy object storage namespace

### Prerequisites

This lab assumes:
* You have completed all the previous labs
* You can change directories/ folders, create/edit files, create directories/folder , run commands, and install software on your laptop or workstaion.

> **Note:** Please refer [Quickstart Installation guide on OCI CLI](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm) for various operating systems, you can **optionally skip this Lab** if you have already installed OCI CLI on your laptop or desktop machine.


## Task 1: Get User's OCID

1. After logging into cloud console, click on User Settings under top right navigation, this will take to **User Details** page,
Copy the OCID into a text file we will need this later.

  ![Navigate to Data Labeling](images/user-ocid.png " ") 

## Task 2: Add User's API Key

1. Under the same page click on **Add API Key** button

  ![Navigate to Data Labeling](images/add-api-keys.png " ") 

## Task 3: Generate and Download RSA Key Pair in PEM Format

1. Choose an Option to Generate a new key pair, if you already have keys generated you can upload them here, most important is when you generate the key pair download both of them, Click **Add** button

  ![Navigate to Data Labeling](images/gen-key-pair.png " ") 

After downloading the key to your home directory/ folder or a path you can remember and where it won't be deleted. Note the path of the private API key, you will need it later in Task 5 below.x

> **Note:** Please do not use a key with a passphrase for this lab series, tools such as Rclone does not currently support API keys with a passphrase..


2. You should now be able to see the Configuration file, copy paste this into a file we will need it later in Task 5 below.

  ![Navigate to Data Labeling](images/config-preview.png " ") 

Click on **Close** button

3. We can now see our newly created fingerprint

  ![Navigate to Data Labeling](images/fingerprint.png " ") 


## Task 4: Install OCI Command Line Interface (CLI)

The CLI is a small-footprint tool that you can use on its own or with the Console to complete Oracle Cloud Infrastructure tasks. The CLI provides the same core functionality as the Console, plus additional commands. Some of these, such as the ability to run scripts, extend Console functionality.

1. Install OCI CLI on Your Laptop or Workstation

#### For Mac OS
If you have not installed brew on your MacOS please refer their official guide [Install Brew on Mac](https://docs.brew.sh/Installation)

Open a terminal.

  ```
  <copy>/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"</copy>
  ```

  ```
  <copy>brew update && brew install oci-cli</copy>
  ```

#### Windows
Open the PowerShell console using the Run as Administrator option. The installer enables auto-complete by installing and running a script. To allow this script to run, you must enable the RemoteSigned

To configure the remote execution policy for PowerShell, run the following command.

Download the installer script

  ```
  <copy>Set-ExecutionPolicy RemoteSigned</copy>
  ```

Force PowerShell to use TLS 1.2 for Windows 2012 and Windows 2016:

  ```
  <copy>[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 </copy>
  ```

Download the installer script:

  ```text
   <copy>Invoke-WebRequest https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.ps1 -OutFile install.ps1
   </copy>
   ```

To run the installer script without prompting the user, accepting the default settings, run the following command:
  ```text
  <copy>./install.ps1 -AcceptAllDefaults
  </copy>
  ```

#### For Linux and Unix

Open a terminal.

Run the installer script with the following command:
  ```
  <copy>
  bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"
  </copy>
  ```
Respond to the Installation Script prompts.

#### For Oracle Linux 9
   ```
   <copy>
   sudo dnf -y install oraclelinux-developer-release-el9
   sudo dnf install python39-oci-cli
   </copy>
   ```
#### For Oracle Linux 8

Use dnf to install the CLI.
  ```
  <copy>
  sudo dnf -y install oraclelinux-developer-release-el8
  sudo dnf install python36-oci-cli
  </copy>
  ```
#### For Oracle Linux 7

Use yum to install the CLI.
  ```
  <copy>
  sudo yum install python36-oci-cli
  </copy>
  ```

2. Verifying the OCI CLI Installation

   ```
   <copy>oci --version</copy>
   ```

Output will be similar to this version number might vary

   ```
   <copy>3.23.4</copy>
   ```

## Task 5: Update OCI Configuration File

1. Update DEFAULT values as per your OCI parameters

Run the following command on all laptops and workstation types:

  ```
  <copy> oci setup config </copy>
  ```
Accept the default location for the config file then answer the prompts for the user OCID, tenancy OCID, home region, and API private pem key path using the information collected in Task 3.

Or manually create a file, start by creating a directory /folder in your home directory/folder called `.oci`, then use to create a file in that directory/ folder named `config`:

  ```
  <copy>
  vi config
  </copy>
  ```

> **Note:** Use the editor which works best for your environment such as `vim` , `pico`, `nano`, `Notepad`, etc.

Copy and paste the information from Task 3 which should have the following information:
    
    ```
    <copy>
    [DEFAULT]
    user=< user OCID >
    fingerprint=< finger print >
    key_file=< Path to .pem Private Key file generated from Task 3>
    tenancy=< Tenancy OCID >
    region=< region >
    </copy>
    ```

The completed file should look similar to the example below, please replace the User OCID, fingerprint, Tenancy OCID, Home region, key_file as per your tenancy and local file path for the key file

   ```
   <copy>[DEFAULT]
   user=ocid1.user.oc1..aaaaaaaaompu-user-ocid-x63smy6knndy5q
   fingerprint=ad:a7:73:a2:23:-user-fingerprint-:0c:a9:22:bb
   tenancy=ocid1.tenancy.oc1..aaaaaaaa6v-tenancy-ocid-sdd6ahdouq
   region=us-ashburn-1
   key_file=/Users/-user-name-/.oci/oci_api_key.pem
   </copy>
   ```

## Task 7: Get the OCI Tenancy Object Storage Namespace with the OCI CLI:

1. Check if we can get the object storage namespace for the tenancy to verify the configuration file setup: 

   ```
   <copy> 
   oci os ns get
   </copy>
   ```

If successful, the following will be returned, with xx as your unique namespace.

  ```
  <copy>
  {
    "data": "xx"
  }
  </copy>
  ```

## Task 8: Make Note of OCI CLI Configuration File

1. We will be using this config file path and OCIDs here in later labs, please make a note of them  

  ```
  <copy>
  cat ~/.oci/config
  </copy>
  ```

In other operating systems you can open the file using text editor such as Notepad or `vi` editor.

    > **Congratulations:** You have now completed the setup for the **OCI Command Line Interface**, which is required for following parts and labs. Now you can proceed to any other Parts of this workshop. 

## Troubleshooting

1. Unable to get object storage namespace for the OCI tenancy through OCI CLI
   
Check for all the OCIDs and Fingerprint in the configuration file if it matches with the one in the tenancy settings.

You may now **proceed to the next lab**.

## Learn More
 
* [OCI Documentation](https://docs.oracle.com/en-us/iaas/Content/home.htm)
* [Configure OCI CLI](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliconfigure.htm)
* [Install Brew on Mac](https://brew.sh/)
* [OCI Command CLI Playground](https://apexapps.oracle.com/pls/apex/r/dbpm/livelabs/view-workshop?wid=650)

## Acknowledgements

* **Authors** - Madhusudhan Rao B M, Principal Product Manager, Oracle Database; Melinda Centeno, Senior Principal Product Manager
* **Last Updated By/Date** - Melinda Centeno, 24 July 2024
