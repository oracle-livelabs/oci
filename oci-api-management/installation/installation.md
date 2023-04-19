
# Integrate to the Components together

## Introduction

Estimated time: 20 min

### Objectives

- Install an Autonomous Database
- Install the API Portal (APEX application) in it

### Prerequisites

- Open the Oracle Cloud Shell and clone this repository on your laptop first.

    ```
    <copy>git clone https://github.com/mgueury/oci-api-portal.git</copy>
    ```

- Create a file on your Laptop to take your notes

    ````
    <copy>
    ##PORTAL_URL##    : Portal URL ex: https://xxxxx-apidb.adb.eu-frankfurt-1.oraclecloudapps.com/ords/r/api/apimgt/portal

    // Autonomous Database / APEX 
    ##DB_PASSWORD##   : DB Password    : (ex LiveLab__123)
    ##APEX_HOST##     : APEX Host Name : (ex: abcdefghijk-db123.adb.eu-frankfurt-1.oraclecloudapps.com)

    // OIC Discovery
    ##USERNAME##      : Federated user (IDCS user) that you use to log in OIC. Often an email ex: john.doe@domain.com
    ##PASSWORD##      : is the password of that user
    ##OIC_HOST##      : ex: myoic-abcdefgh-fr.integration.ocp.oraclecloud.com

    // APIGW Discovery
    ##COMPARTMENT_OCID## : Compartment OCID where APIGW is installed. Ex: ocid1.compartment.oc1..xxxxxx
    ##USER_OCID##     : ex: ocid1.user.oc1..xxxxxxxxxxx
    ##TENANCY_OCID##  : ex: ocid1.tenancy.oc1..xxxxxxxxxxx
    ##FINGERPRINT##   : ex: 10:12:14:AB:10:12:14:AB:10:12:14:AB:10:12:14:AB
    ##PRIVATE_KEY##   : ex (notice the RSA PRIVATE KEY):

    -----BEGIN RSA PRIVATE KEY-----
    qsdqksjdkjsqlkjmLKQJMJLKSFlqkjmfkljdslk
    ...
    qHKJFDkjdhj==
    -----END RSA PRIVATE KEY-----
    </copy>
    ````

## Task 1: Create an Autonomous database

First, let's create an Autonomous database.

1. Go the menu
    - Oracle Database
    - Autonomous Database

        ![ATP1](images/apim-atp.png)

2. Click *Create Autonomous Database*
    - Compartment : *Your Favorite Compartment*
    - Display Name: *APIDB*
    - Database Name: *APIDB* 
    - Workload: *Transaction Processing*
    - Deployment: *Shared Infrastructure*
    - Password: ex: *LiveLab\_\_123* (Take note of it: ##DB\_PASSWORD##)
    - Network: Keep *Secure Access from Everywhere*
    - Licence: *BYOL or Licence Included*
    - Then *Create Autonomous Database*

        ![ATP2](images/apim-atp2.png)

## Task 2: Create the Database User

1. Go to the SQL interface
    In the page of the Autonomous Database,
    - Click on *Database Actions*
    - If you get a prompt asking for an user/password, enter ADMIN/##DB\_PASSWORD##
    - Then *SQL*

        ![Database Actions](images/apim-sql0.png)

2. Run the following SQL to create the user API.
    - Replace the password in the schema creation to your own (to make it easy, let's use the same than ADMIN ##DB_PASSWORD##) 

        ```
        <copy>
        grant connect, resource, unlimited tablespace, create view to API identified by ##DB_PASSWORD##
        /
        GRANT execute ON dbms_cloud_oci_ag_deployment_list_deployments_response_t TO API;
        GRANT execute ON dbms_cloud_oci_apigateway_deployment_collection_t TO API;
        GRANT execute ON dbms_cloud_oci_apigateway_deployment_summary_tbl TO API;
        GRANT execute ON dbms_cloud_oci_apigateway_deployment_summary_t TO API;
        GRANT execute ON DBMS_CLOUD_OCI_AG_DEPLOYMENT TO API;
        GRANT execute ON DBMS_CLOUD TO API;
        GRANT execute on DBMS_NETWORK_ACL_ADMIN to API;
        /
        BEGIN
        ORDS.enable_schema(
            p_enabled             => TRUE,
            p_schema              => 'API',
            p_url_mapping_type    => 'BASE_PATH',
            p_url_mapping_pattern => 'apim',
            p_auto_rest_auth      => FALSE
        );
        COMMIT;
        end;
        /
        </copy>
        ```

        ![APEX Installation](images/apim-sql1.png)


## Task 3: Install the APEX program

Back to page of the Autonomous Database,
1. Go to APEX. Click again on *Database Actions*

    ![APEX Installation](images/apim-apex0.png)

    - Click *APEX*
2. Note the URL of APEX, we need the Apex Host Name (##APEX_HOST##) later in the lab (Ex: abcdefghijk-db123.adb.eu-frankfurt-1.oraclecloudapps.com) 
3. In Administration Service, enter the DB password (##DB_PASSWORD##)
    - Click *Sign In to Administration*

        ![APEX Installation](images/apim-apex1.png)

    - Click *Create Workspace*

        ![APEX Installation](images/apim-apex2.png)

    - Click *Existing Schema*

        ![APEX Create Workspace](images/apim-apex3.png)

    - Database User *API*
    - Workspace Name *API*
    - Workspace Username *API*
    - Workspace Password ex: *LiveLab\_\_123* (##DB\_PASSWORD##)
    - Click *Create Workspace*

        ![APEX Create Workspace](images/apim-apex4.png)

    - Click on your top right icon. Then *Sign-out*

4. In the APEX login page
        - Workspace: *API*
        - Database User: *API*
        - Password: See ##DB\_PASSWORD##
        - Click *Sign In*
    - In Apex, 
        - Click Menu *App Builder*
        - *Import*
 
    ![APEX Installation](images/apim-apex5.png)

    - Go in the files that you have downloaded from Git
    - Choose *apex/apex_apim.sql*
    - Click *Next*
    - Click *Next*
    - Click *Install Application*
    - In Install Application, Click *Next*
    - Click *Install*

We have now a running API Management Portal but it is empty.
- Click *Run Application*

## Task 4: Test the empty installation

We have now a running API Management Portal but it is empty.
1. Login *API* / Password - See ##DB_PASSWORD##

    ![Login](images/apim-apex-login.png)

    Note the URL ##PORTAL_URL##. Ex: https://xxxxx-apidb.adb.eu-frankfurt-1.oraclecloudapps.com/ords/r/api/apimgt/portal

2. In the next Lab, we will populate the Portal with APIs.

    ![Empty](images/apim-apex-empty.png)

## Acknowledgements

- **Authors**
    - Marc Gueury / Robert Wunderlich  / Shyam Suchak / Tom Bailiu / Valeria Chiran
