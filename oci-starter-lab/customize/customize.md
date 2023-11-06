
# How to customize

## Introduction

How to customize it a *Starter Application* ?

All the files to change are in the *src* directory.
- Let's look how this works. 
- And how you can modify an OCI Starter sample to include your own code.  

## Task 1 - Example - Compute, Java, SpringBoot, Database

The principle is identical for all deployments type, (compute, kubernetes,...), language (Java/Node/...), user interface, ...

Let's say that we deploy a Java / SpringBoot on a Compute with an Database.

1. Run this command in the OCI Cloud Shell
    ````
    <copy>
    curl "https://www.ocistarter.com/app/zip?prefix=starter&deploy=compute&ui=html&language=java&database=atp" --output starter.zip
    unzip starter.zip
    cd starter
    cat README.md
    # ./build.sh
    </copy>
    ````
2. When you run the build.sh script, the program will:
    1. Create resources (compute/database/....) with "Terraform" (src/terraform)
    2. Create tables in the database (src/db)
    3. Compile the "Backend Application (app)" (src/app) 
        - script: src/app/build_app.sh
        - output directory: target/compute/app
    4. Compile the "User Interface (ui)" (src/ui)
        - script: src/ui/build_ui.sh 
        - output directory: target/compute/ui
    5. Deploy the "app" and "ui" to the compute:
        - the target/app and target/ui are copied to the compute 
        - and started as Linux services

In the next task, we will go inside each directory to see what it contains.

## Task 2 - Check Directory: src 

1. Check the directory *src*
    - The files to modify are all in the *src* directory. 
    - The src directory contains all the source code. 
2. The other directories *bin* and *target* contains helper scripts or compiled/generated files. Not interesting here.

## Task 3 - Check Terraform Directory: src/terraform 

1. Check the "src/terraform" directory by running these commands
    ````
    <copy>
    cd src/terraform/
    ls
    </copy>
    ````
    ````
    <copy>    
    apply.sh  atp.tf  bastion.tf  compute.tf  datasource.tf  destroy.sh  network.tf  output.tf  plan.sh  terraform_local.tf  variable.tf
    </copy>
    ````
2. We see 2 type of files:
    1. *.sh :  scripts to run terraform (normal or resource manager): 
        - plan.sh: test the terraform resources to see if apply will work. But it does nothing.
        - apply.sh: create the terraform resources
        - destroy.sh: destroy the terrraform resources
    2. *.tf : terraform files to create resources
        - compute.tf : create the compute
        - atp.tf: create an autonomous database
        - network.tf: create the network (VCN, subnets, security list)
        - bastion.tf: create the bastion (mostly used to populate the database)
        - variables.tf, output.tf, datasource.tf: files that are common to all applications types. They contain the input / output of the scripts.
3. Take a look at the documentation to see how they work:
    - Documentation: https://registry.terraform.io/providers/oracle/oci/latest/docs
    - Examples: https://github.com/oracle/terraform-provider-oci/tree/master/examples
4. You may customize all these Terraform files to your needs. 

## Task 5 - Check Database: src/db

1. Check the "src/db" directory by running these commands
    ````
    <copy>
    cd src/db/
    ls
    </copy>
    ````
    ````
    <copy>
    db_init.sh  oracle.sql
    </copy>
    ````
2. There are 2 files. 
    - db_init.sh: run SQL*Plus in the database 
    - oracle.sql: SQL commands to create tables.
3. You may customize all these files to your needs. For example, create another tables....

## Task 6 - Check Application Directory: src/app

1. Check the "src/app" directory by running these commands
    ````
    <copy>
    cd src/app/
    ls
    </copy>
    ````
    ````
    <copy>
    app.yaml  build_app.sh  Dockerfile  openapi_spec.yaml  pom.xml  src  start.sh  target
    </copy>
    ````
2. There are 2 types of files:
    1. The files to build the application
        - build_app.sh : script to build the application (output target/compute/app)
        - Dockerfile : file to build docker image (Kubernetes and Container Instance deployment)
        - app.yaml : kubernetes deployment file for the application
        - openapi_spec.yaml : OpenAPI specification of the Application (documentation only) 
    2. The application source files (here SpringBoot using Maven)
        - pom.xml: java maven file
        - src: java source files
        - start.sh: script used on the compute to start the application (typically: java -jar app.jar)
3. You may customize all these files to your needs. For example, to use your own SpringBoot Application.
    - overwrite the pom.xml and src directory with your files.
    - change the start.sh
    - and rerun $STARTER_HOME/build.sh

## Task 5 - Check User Interface Directory: src/ui

1. Check the "src/ui" directory by running these commands
    ````
    <copy>
    cd src/ui/
    ls
    </copy>
    ````
    ````
    <copy>
    build_ui.sh  Dockerfile  ui  ui.yaml
    </copy>
    ````
2. We see 2 types of files:
    1. The files to build the User Interface
        - build_ui.sh : script to build the user interface (output target/compute/ui)
        - Dockerfile : file to build docker image (Kubernetes and Container Instance deployment)
        - ui.yaml : kubernetes deployment file for the user interface
    2. The application source files 
        - directory ui: containing static HTML files
3. You may customize all these files to your needs. For example, to use your own HTML files
   - overwrite the HTML files in the ui directory with your files.
   - Then rerun $STARTER_HOME/build.sh to update the server

## Acknowledgements 

* Author - Marc Gueury
* Contributors - Ewan Slater 
* Last Updated - Nov, 2th 2023