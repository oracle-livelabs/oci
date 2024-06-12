
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

## Task 1: Create the Application

1. Using your browser, go to https://www.ocistarter.com/
2. Choose 
    - AMD (x86)
    - Compute
    - HTML
    - Java
    - SpringBoot
    - Autonomous database
3. Click *Cloud Shell*
    - You will see the commands to use.
  ![OCI Starter Compute Java](images/starter-compute-java.png)
4. Login to your OCI account
    - Click *Code Editor*
    - Click *New Terminal*
    - Copy paste the command below. And check the README.md
    ```
    <copy>
    curl "https://www.ocistarter.com/app/zip?prefix=starter&deploy=compute&ui=html&language=java&database=atp" --output starter.zip
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
- Network resources: VCN, Subnet
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

### Customize

Please also check the  "Lab 6 - How to Customize" to see how to customize this sample to your needs

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

