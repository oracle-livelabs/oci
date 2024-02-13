
# Create Cloud Native Applications on Compute

## Introduction

Estimated time: 10 min

### Objectives

![Architecture Compute](images/architecture_instance_pool.png =50%x*)

In this sample, using terraform, we will create:
- an instance pool with 2 Virtual Machines and a load balancer in front of it
- a PHP program running on each of the machine
- and an Autonomous Database. 

During the build, the program will 
- first create a compute
- install the PHP program on oit
- then create a *custom image* of that compute
- create an instance pool of 2 Virtual Machines using the *custom image*
- and a load-balancer in front of the 2 Virtual Machines.

The steps are identical for all other user interfaces, backends or database.

### Prerequisites

Please read the chapter: Introduction and Get Started.

## Task 1: Create the Application

1. Using your browser, go to https://www.ocistarter.com/
2. Choose 
    - Instance Pool
    - HTML
    - PHP
    - Autonomous database
3. Click *Cloud Shell*
    - You will see the commands to use.
  ![OCI Starter Compute Java](images/starter-instance-pool-java.png)
4. Login to your OCI account
    - Click *Code Editor*
    - Click *New Terminal*
    - Copy paste the command below. And check the README.md
    ```
    <copy>
    curl -k "https://www.ocistarter.com/app/zip?prefix=starter&deploy=instance_pool&ui=php&language=php&database=atp" --output starter.zip
    unzip starter.zip
    cd starter
    cat README.md
    </copy>
    ```
    ![OCI Starter Editor](images/starter-editor.png)

## Task 2: Main files

1. In the code editor:
    - Click *File* / *Open*
    - Choose the directory *starter*
    - Click *Open*
    ![Editor File Open](images/starter-compute-dir.png)
2. The main files are:
    - Commands:
        - build.sh      : Build the whole program: Run Terraform, Configure the DB, Build the App, Build the UI
        - destroy.sh    : Destroy the objects created by Terraform
        - env.sh        : Contains the settings of your project
    - Directories:
        - src           : Sources files
            - app         : Source of the Backend Application (Command: build_app.sh)
            - ui          : Source of the User Interface (Command: build_ui.sh)
            - db          : SQL files of the database
            - terraform   : Terraform scripts (Command: plan.sh / apply.sh)
            - compute     : Contains the deployment files to Compute
        - bin           : with some helper commands
            - bin/ssh\_compute.sh (to ssh to the Compute)
            - bin/ssh\_bastion.sh (to ssh to the Bastion)
3. Edit the env.sh file:
    - Choose the env.sh file.
    - Look for \_\_TO_FILL\_\_ in the file
    - You may leave it like this.
        - If not filled, the "db password" will be randomly generated
    - Ideally, you can also use an existing compartment if you have one. 
        - If not, the script will create a "oci-starter" compartment
    ![Editor env.sh](images/starter-compute-env.png)

## Task 3: Build.sh

During the build, Terraform will create:
1. Network resources: VCN, Subnet
2. A database
3. A compute instance to run NGINX + the PHP App
4. A bastion used mostly to populate the database with the table
5. A custom image of that compute instance (3)
6. A Instance Pool with 2 VMs using that custom image (5)
7. A load-balancer in front of the instance pool

1. In the code editor, 
    - in the menu *Terminal / New Terminal*. 
    - then run:
    ```
    <copy>
    ./build.sh
    </copy>
    ```
    - It will build all and at the end you will see:
    ```
    <copy>
    - User Interface : http://123.123.123.123/
    - Rest DB API : http://123.123.123.123/app/dept
    - Rest Info API : http://123.123.123.123/app/info
    </copy>
    ```
2. Click on the URL or go to the link to check that it works:
    - All running in an Instance Pool with 2 VMs
    - On each VM, you have PHP pages 
    - That backend gets data from the Autonomous database. 
    ![Result](images/starter-compute-result.png)

## Task 4: More info

### Customize

Instance Pool is working in the same way than the "Compute". See the "Compute" lab for more info.

You can see the IP of the 2 VMs of the Instance Pool and of the Loab-Balancer at the end of the build:

````
pooled_instances_hostname_labels = [
  [
    "starter-pool2",
    "starter-pool1",
  ],
]
pooled_instances_private_ips = [
  [
    "10.0.1.4",
    "10.0.1.116",
  ],
]
pooled_instances_public_ips = [
  [
    "141.147.42.166",
    "152.70.169.28",
  ],
]
ui_url = "http://141.147.42.164"
````


Please also check the  "Lab 6 - How to Customize" to see how to customize this sample to your needs

### Cleanup

1. To clean up, run 
    ```
    <copy>
    ./destroy.sh
    </copy>
    ```

    ```
    <copy>
    cd ..
    rm -R starter
    </copy>
    ```

## Acknowledgements

* Author - Marc Gueury
* Contributors - Ewan Slater 
* Last Updated - Nov, 2th 2023

