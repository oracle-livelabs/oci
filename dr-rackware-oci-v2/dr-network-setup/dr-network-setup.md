# Disaster Recovery Network and Connectivity Setup
## Introduction
This solution provides a Network Architecture deployment to demonstrate Disaster Recovery scenario across 2 regions [ examples are geared towards region Montreal & Toronto and can be used for any OCI regions].

Estimated Lab Time 45-60 minutes


### Objectives
- Deploy Terraform to setup necessary architechture for DR

### Prerequisites
1. Download & unzip the [Terraform zip file](https://c4u04.objectstorage.us-ashburn-1.oci.customer-oci.com/p/EcTjWk2IuZPZeNnD_fYMcgUhdNDIDA6rt9gaFj_WZMiL7VvxPBNMY60837hu5hga/n/c4u04/b/livelabsfiles/o/solutions-library/DR-ORDS-RW.zip) to your local machine.

2.  Create your own private/public key pair on your local system.
3.  Zip up all of the files in to a zip folder. The zip file name is not important.
    Just make sure it has the follow structure.
    
        rackware/
        ├── data_sources.tf
        ├── dr-ords-schema.yaml
        ├── main.tf
        ├── modules
        │ ├── bastion_instance
        │ │ ├── main.tf
        │ │ ├── outputs.tf
        │ │ └── variables.tf
        │ ├── dbaas
        │ │ ├── main.tf
        │ │ ├── outputs.tf
        │ │ └── variables.tf
        │ ├── network
        │ │ ├── main.tf
        │ │ ├── outputs.tf
        │ │ └── variables.tf
        │ └── ords
        │     ├── main.tf
        │     ├── outputs.tf
        │       ├── README.md
        │       ├── remote-exec.tf
        │       └── variables.tf
        ├── outputs.tf
        ├── providers.tf
        ├── terraform.tfvars
        ├── userdata
        │   ├── bootstrap.sh
        │   ├── files_init
        │   │   └── config_init.sh
        │   ├── files_init.zip
        │   ├── files_jetty
        │   │   ├── apex_add_db.sh
        │   │   ├── apex_inst_check.sql
        │   │   ├── apex_setup_base.exp
        │   │   ├── config_apex1.sql
        │   │   ├── config_apex2.sql
        │   │   ├── config_cert.sh
        │   │   ├── config_jetty_apex.sh
        │   │   ├── config_jetty_ca-ssl.sh
        │   │   ├── config_jetty_init.sh
        │   │   ├── config_jetty_ords.sh
        │   │   ├── dns_ocidns.sh
        │   │   ├── ords_add_db.sh
        │   │   ├── ords_pu_check.sql
        │   │   ├── ords_setup_base.exp
        │   │   ├── ords_validate_base.exp
        │   │   ├── pw_prof_chk.sql
        │   │   ├── pw_verify_base.sql
        │   │   ├── pw_verify_null.sql
        │   │   ├── start_ords.sh
        │   │   └── stop_ords.sh
        │   └── files_jetty.zip
        └── variables.tf

4. Make sure to create a public bucket in object storage. Then upload apex.zip and the ords.war file to the bucket.
    The apex.zip file can be downloaded using the following link [apex](https://www.oracle.com/tools/downloads/apex-downloads.html). 
    The ords.war file can be downloaded using the following link [ords](https://www.oracle.com/database/technologies/appdev/rest-data-services-downloads.html)
        ![](rackwaresaleplay/Objectstorage.PNG)
    
## Task 1: Create Stack    
1. Navigate to the resource manager tab in OCI. Then create a new stack to import the zip file.

2. Import the zip file into the stack 
    ![](./images/ResourceManager.PNG)

3. Input the configuration for the instances.
    ![](./images/ResourceManager-Input-Basic.PNG)

4. Input the configuration for the vcn.
    ![](./images/ResourceManager-Network.PNG)

5. Copy your public and private key. Make sure you are using the correct format.
    ![](./images/ResourceManager-Keys.PNG)

6. Input the configuration for the object storage.
    ![](./images/ResourceManager-ObjectStorage.PNG)

7. Review 
    ![](./images/ResourceManager-Review.PNG)

## Task 2: Plans

1.  Select plan from the dropdown menu.
    ![](./images/ResourceManager-Plan-2.PNG)

2.  Make sure everything looks okay and then proceed
    ![](./images/ResourceManager-Plan-3.PNG)

3.  Wait until the icon to turn green.
    ![](./images/ResourceManager-Plan-4.PNG)

## Task 3: Apply

1.  Select plan from the dropdown menu.
    ![](./images/ResourceManager-Apply-1.PNG)

2.  Wait unitl the icon to turn green.
    ![](./images/ResourceManager-Apply-2.PNG)

## Task 4: Destroy
1.  First navigate to OCI Console and terminate the Standby database and once the termination is successfull then run the following command

2.  Select destroy from the dropdown menu.
    ![](./images/ResourceManager-Destroy.PNG)

3.  Wait unitl the icon to turn green.
    ![](./images/ResourceManager-Destroy-2.PNG)

You may now **proceed to the next lab.**

## Troubleshooting
   A possible issue you make face is not having enough resources. Test to make sure 
   that you can create a drg manual in both regions you want to deploy the resources
   in.

## Acknowledgements
- **Author** - Saul Chavez
- **Last Updated by/date** Will Bullock, October 2020

