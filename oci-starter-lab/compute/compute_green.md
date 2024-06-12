
# Create Cloud Native Applications on Compute

## Introduction

Estimated time: 10 min

### Objectives

![Architecture Compute](images/architecture_compute.png =50%x*)

In this sample, using terraform, we will create:
- a compute (VM)
- with a Java program, 
- HTML pages (on NGINX)
- and an Autonomous Database. 

The steps are identical for all other user interfaces, backends or database.

### Prerequisites

Please read the chapter: Introduction and Get Started.

You are in the Green Button version of the lab. The lab is limited only to Compute and Autonomous Database due the limits of the green button 
cloud account. 

  ![OCI Starter Green Button Limit](images/starter-compute-green-button-limits.png =50%x*)

If later, you want to try the full version of the lab for ex with Kubernetes or Container engine, you will need your own tenancy.

## Task 1: Create the Application

We will use to Advanced tab to work with the limits of the LiveLab sandbox. (Existing network, ...)

1. In your browser, go to https://www.ocistarter.com/
2. Choose:
    - Advanced
    - Existing VCN 
    - Shared Compute 
    - Keep:
        - Compute
        - HTML
        - Java
        - SpringBoot
        - GraalVM
        - Autonomous database
3. Click *Cloud Shell*
    - You will see the commands to use.
  ![OCI Starter Compute Java](images/starter-compute-green-button-java.png)
4. Login to your OCI account
    - Click *Code Editor*
    - Click *New Terminal*
    - Copy paste the command below. And check the README.md
    ```
    <copy>
    curl -k "https://www.ocistarter.com/app/zip?prefix=starter&deploy=compute&ui=html&language=java&db_install=shared_compute&database=atp&vcn_strategy=existing" --output starter.zip
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
3. Check the env.sh file:
    - Choose the env.sh file.
    - Since we are in LiveLasbs installation, all the settings will be found automatically.
          - TF_VAR\_compartment\_ocid, TF\_VAR\_vcn\_ocid / TF\_VAR\_public\_subnet\_ocid, TF\_VAR\_private\_subnet\_ocid will be found automatically.
          - The database password, if not filled, will be randomly generated.
    ![Editor env.sh](images/starter-compute-env.png)

## Task 3: Build.sh

During the build, Terraform will reuse the 
- Network resources: VCN, Subnet
Then create: 
- A database
- A compute instance to run NGINX + the Java App
- A bastion used mostly to populate the database with the table

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
    - All running in a Compute 
    - You have HTML pages in NGINX doing REST calls 
    - To a Java SpringBoot backend
    - That backend gets data from the Autonomous database. 
    ![Result](images/starter-compute-result.png)

## Task 4: More info

OCI Starter running in your own tenancy or not has a lot more options like Kubernetes or Container Instances.

You can also check how it works and how to customize what you built.

### Customize

Please also check the  "Lab 3 - How to Customize" to see how to customize this sample to your needs

### SSH

During the build, it has generated 2 files:
- id\_starter\_rsa : a ssh private key to login to the compute and bastion
- id\_starter\_rsa.pub : the public ssh private key installed in the compute and bastion

You can login to the compute by running:
```
<copy>
bin/ssh_compute.sh
</copy>
```

The interesting directories are:
- $HOME/app with the compiled application
- /usr/share/nginx/html/ with the HTML pages

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

