
# How to customize

How to customize it a *Starter Application*?

## Directory: src 

The files to modify are all in the *src* directory. The src directory contains all the source code. 

The other directories *bin* and *target* contains helper scripts or compiled/generated files. Not interesting here.

### Example - Compute - Java - SpringBoot - Database
The principle is identical for all deployments type, (compute, kubernetes, container instance, ...), language (Java/Node/...), user interface, ...

Let's say that we deploy a Java / SpringBoot on a Compute with an Database.

````
curl "https://www.ocistarter.com/app/zip?prefix=starter&deploy=compute&ui=html&language=java&database=atp" --output starter.zip
unzip starter.zip
cd starter
cat README.md
# ./build.sh
````

When you run the build.sh script, the program will:
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
5. This is all !

Let's go inside each directory to see what it contains.

## Terraform Directory: src/terraform 

````
> cd src/terraform/
> ls
apply.sh  atp.tf  bastion.tf  compute.tf  datasource.tf  destroy.sh  network.tf  output.tf  plan.sh  terraform_local.tf  variable.tf
````

We see 2 type of files:
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

You may customize all these Terraform files to your needs. 

Take a look at the documentation to see how they work:
- Documentation: https://registry.terraform.io/providers/oracle/oci/latest/docs
- Examples: https://github.com/oracle/terraform-provider-oci/tree/master/examples


## Database: src/db

````
> cd src/db/
> ls
db_init.sh  oracle.sql
````

There are 2 files. 
- db_init.sh: run SQL*Plus in the database 
- oracle.sql: SQL commands to create tables.

You may customize all these files to your needs. For example, create another tables....

## Application Directory: src/app

````
> cd src/app/
> ls
app.yaml  build_app.sh  Dockerfile  openapi_spec.yaml  pom.xml  src  start.sh  target
````
We see 2 types of files:
1. The files to build the application
    - build_app.sh : script to build the application (output target/compute/app)
    - Dockerfile : file to build docker image (Kubernetes and Container Instance deployment)
    - app.yaml : kubernetes deployment file for the application
    - openapi_spec.yaml : OpenAPI specification of the Application (documentation only) 
2. The application source files (here SpringBoot using Maven)
    - pom.xml: java maven file
    - src: java source files
    - start.sh: script used on the compute to start the application (typically: java -jar app.jar)

That is all.
You may customize all these files to your needs. For example, to use your own SpringBoot Application.
- overwrite the pom.xml and src directory with your files.
- change the start.sh
- and rerun $STARTER_HOME/build.sh

## User Interface Directory: src/ui

````
> cd src/ui/
> ls
build_ui.sh  Dockerfile  ui  ui.yaml
````

We see 2 types of files:
1. The files to build the User Interface
    - build_ui.sh : script to build the user interface (output target/compute/ui)
    - Dockerfile : file to build docker image (Kubernetes and Container Instance deployment)
    - ui.yaml : kubernetes deployment file for the user interface
2. The application source files 
    - directory ui: containing static HTML files

That is all.
You may customize all these files to your needs. For example, to use your own HTML files
- overwrite the HTML files in the ui directory with your files.
- and rerun $STARTER_HOME/build.sh

## Acknowledgements 
- **Author**
    - Marc Gueury
    - Ewan Slater 

- **History** - Creation - 10 feb 2023