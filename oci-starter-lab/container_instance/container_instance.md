
# Create Cloud Native Container Instances

## Introduction

Estimated time: 10 min

### Objectives

![Architecture Container Instance](images/architecture_container_instance.png =50%x*)

In this sample, using terraform, we will create:
- a Container Instance running 2 docker containers
- 1 container with a Java program
- 1 container with HTML pages on NGINX
- and an Autonomous Database. 

The steps are identical for all other user interfaces, backends or database.

### Prerequisites

Please read the chapter: Introduction and Get Started.

## Task 1: Create the Application

1. Using your browser, go to https://www.ocistarter.com/
2. Choose 
    - AMD (x86)
    - Container Instance
    - Angular
    - .NET
    - Autonomous database
3. Click *Cloud Shell*
    - You will see the commands to use.
    ![OCI Starter Compute Java](images/starter-container-instance-dotnet.png)

4. Login to your OCI account
    - Click *Code Editor*
    - Click *New Terminal*
    - Copy paste the command below. And check the README.md
    ```
    <copy>
    curl "https://www.ocistarter.com/app/zip?prefix=starter&deploy=container_instance&ui=angular&language=dotnet&database=atp" --output starter.zip
    unzip starter.zip
    cd starter
    cat README.md
    </copy>
    ```
    ![OCI Starter Editor](../public_compute/images/starter-editor.png)

## Task 2: Main files

1. In the code editor:
    - Click *File* / *Open*
    - Choose the directory *starter*
    - Click *Open*
    ![Editor File Open](../public_compute/images/starter-compute-dir.png)
2. The main files are:

   |             |            |           | Description |
   | ----------- | ---------- | --------- | ---|
   | Commands    |            |           |  |
   |             | starter.sh |           | Build or destroy a project. Show a menu with commands if not argument is given | 
   |             | env.sh     |           | Settings of your project | 
   | Directories |            |           | Commands used by starter.sh | 
   |             | bin/       |           | Commands used by starter.sh | 
   |             | src/       |           | Sources files | 
   |             |            | app       | Backend Application (Command: build_app.sh) | 
   |             |            | ui        | User Interface (Command: build_ui.sh) | 
   |             |            | db        | Database initialisation files (SQL, ...) | 
   |             |            | terraform | Terraform scripts  | 
   |             | target/    |           | Output directory  | 

3. (Optional) Edit the env.sh file:
    - Choose the env.sh file.
    - Look for \_\_TO_FILL\_\_ in the file
    - You may leave it like this.
        - If not filled, the "db password" will be randomly generated
    - Ideally, you can also use an existing compartment if you have one. 
        - If not, the script will create a "oci-starter" compartment
    ![Editor env.sh](../public_compute/images/starter-compute-env.png)

## Task 3: Starter.sh

During the build, Terraform will create:
- Network resources: VCN, Subnet
- A database
- A container instance to run a docker container with Angular + another Docker container with the .NET App
- A bastion used mostly to populate the database with the table

1. In the code editor, 
    - in the menu *Terminal / New Terminal*. 
    - then run:
    ```
    <copy>
    ./starter.sh
    </copy>
    ```
    - Choose **Build**
        ![Result](../public_compute/images/starter-starter-build.png)     
    - It will build all and at the end you will see:
    ```
    <copy>
    - User Interface : https://xxxx.apigateway.eu-xxxx.oci.customer-oci.com/starter/
    - Rest DB API : https://xxxx.apigateway.eu-xxxx.oci.customer-oci.com/starter/app/dept
    - Rest Info API : https://xxxx.apigateway.eu-xxxx.oci.customer-oci.com/starter/app/info
    </copy>
    ```
2. Click on the URL or go to the link to check that it works:
    - All running in a Container instance 
    - You have Angular pages doing REST calls 
    - To a .NET container image
    - That backend gets data from the Autonomous database. 
    ![Result](images/starter-container-instance-result.png)

## Task 4: More info

### Customize

Please also check the  "Lab 7 - How to Customize" to see how to customize this sample to your needs

### Cleanup

1. To clean up, run 
    ```
    <copy>
    ./starter.sh destroy
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
* Last Updated - June, 2nd 2025
