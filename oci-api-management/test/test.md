
# Create a Function to parse the documents

## Introduction

Estimated time: 10 min

### Objectives

- Deploy a Java Serverless function to parse documents like Excel, Word, PDF and extract their content in a text format.

### Prerequisites

## Task 1: Security 

Go back the database actions:
- Menu Oracle Database / Autonomous database 
- Choose your database
- Click the *Database actions* button.
- In the database action, choose the application "SQL"   

In the SQL, we will give some grant to our API user to allow him to make network call to OIC and OIC.

##OCI_USER##: is a federated username (IDCS user) that you use to log in OCI. Often an email ex: john.doe@domain.com  
##OCI_PASSWORD##: is the password of that user

##USER_OCID##: ex:  ocid1.user.oc1..xxxxxxxxxxx
##TENANCY_OCID##: ex: ocid1.tenancy.oc1..xxxxxxxxxxx
##PRIVATE_KEY##: ex: 
##OIC_HOST##: ex: myoic-abcdefgh-fr.integration.ocp.oraclecloud.com

```
-----BEGIN RSA PRIVATE KEY-----
qsdqksjdkjsqlkjmLKQJMJLKSFlqkjmfkljdslk
...
qHKJFDkjdhj==
-----END RSA PRIVATE KEY-----
```
##FINGERPRINT##: ex: 10:12:14:AB:10:12:14:AB:10:12:14:AB:10:12:14:AB

``` 
GRANT execute ON dbms_cloud_oci_ag_deployment_list_deployments_response_t TO API;
GRANT execute ON dbms_cloud_oci_apigateway_deployment_collection_t TO API;
GRANT execute ON dbms_cloud_oci_apigateway_deployment_summary_tbl TO API;
GRANT execute ON dbms_cloud_oci_apigateway_deployment_summary_t TO API;
GRANT execute ON DBMS_CLOUD_OCI_AG_DEPLOYMENT TO API;
GRANT execute ON DBMS_CLOUD TO API;
/
-- 
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
BEGIN
   DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACE(
       host => '##OIC_HOST##',
       ace => XS$ACE_TYPE( 
           privilege_list => XS$NAME_LIST('http'),
           principal_name => 'OCI_API_PORTAL',
           principal_type => XS_ACL.ptype_db));
END;
```

## Task 2: Configuration in APEX

Go in the memu SQL/SQL Commands: 
Then run:

```
BEGIN
    DBMS_CLOUD.CREATE_CREDENTIAL (
    credential_name => 'OIC_CRED',
    username        => '##OCI_USER##',
    password        => '##OCI_PASSWORD##);
END;
/
BEGIN
DBMS_CLOUD.CREATE_CREDENTIAL (
  credential_name => 'OCI_CRED',
  user_ocid => '##USER_OCID##',
  tenancy_ocid => '##TENANCY_OCID##',
  private_key => '##PRIVATE_KEY##',
  fingerprint => '##FINGERPRINT##');
END;
``` 

## Task 3: Add a Oracle Integration source

Let's add an OIC source to harvest. 
- Go in the Apex Application, start it.
- Go to tab Source
- Click *Create*
- For oic_host, put ##OIC_HOST##
- *Create*
- Then *Harvest* on the top

Go back to the Portal page. The OIC integration should be there.

## Task 4: Add some Cloud Native APIs 

.....


## Acknowledgements

- **Author**
    - Marc Gueury
