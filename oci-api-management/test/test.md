
# Lab 2: Add APIs and Test

## Introduction

Estimated time: 20 min

### Objectives

- Add new APIs written with Cloud Native (Java/Node/Dotnet/Python/...)
- Add existing API from Oracle Integration:
    - Create Samples APIs in OIC 
    - Configure the security
    - Collect the APIs

### Prerequisites

## Task 1: Add new APIs written with Cloud Native

- Go to Oracle Cloud Home page
- Go to Cloud Shell.
- When the shell is started, clone the git repository in the shell:
  
```
<copy>
git clone https://github.com/mgueury/oci-api-portal.git
cd oci-api-portal/cloud-native-sample
vi group_common/env.sh
-> Change the compartment_OCID
-> Set the APIM_HOST to ##1##
./build_group.sh
</copy>
```

Wait that it builds. This will take quite a long time. 
It will first:
- Create a APIGW
- Then 5 different VMs with Java/Node/Dotnet/Go/Python with APIs
- And register them in the API Management Portal
- You can check for ex in api-java/bin/add_api.sh, the command used to add the entry in the Portal

```
...
curl -k "https://${APIM_HOST}/ords/apim/rest/add_api?git_repo_url=${TF_VAR_git_url}&impl_name=${FIRST_LETTER_UPPERCASE}&a_icon_url=${TF_VAR_language}&runtime_console=https://cloud.oracle.com/api-gateway/gateways/$TF_VAR_apigw_ocid/deployments/$APIGW_DEPLOYMENT_OCID&version=${GIT_BRANCH}&endpoint_url=${APIGW_URL}/app/dept&endpoint_git_path=src/terraform/apigw_existing.tf&spec_git_path=src/app/openapi_spec.yaml&a_spec_type=OpenAPI"
...
```


- Go back to the portal and check the result.




## Task 2: Add existing API from Oracle Integration

Let's create a Oracle Integration Installation with some samples:
- Menu Developer Services / Application Integration 

![Introduction Usecase](images/apim-intro.png)

- Click *Create Instance*
- Name *oic_apim*
- Choose Integration Cloud Gen 2 (not tested yet with Gen3)
- Choose your version and license type
- Click *Create*

- Choose your database
- Click the *Database actions* button.
- In the database action, choose the application "SQL"   

In the SQL, we will give some grant to our API user to allow him to make network call to OIC and OIC.

Parameters:
- ##OCI_USER##: is a federated username (IDCS user) that you use to log in OCI. Often an email ex: john.doe@domain.com  
- ##OCI_PASSWORD##: is the password of that user
- ##OIC_HOST##: ex: myoic-abcdefgh-fr.integration.ocp.oraclecloud.com
- ##USER_OCID##: ex:  ocid1.user.oc1..xxxxxxxxxxx
- ##TENANCY_OCID##: ex: ocid1.tenancy.oc1..xxxxxxxxxxx
- ##FINGERPRINT##: ex: 10:12:14:AB:10:12:14:AB:10:12:14:AB:10:12:14:AB
- ##PRIVATE_KEY##: ex: 
```
-----BEGIN RSA PRIVATE KEY-----
qsdqksjdkjsqlkjmLKQJMJLKSFlqkjmfkljdslk
...
qHKJFDkjdhj==
-----END RSA PRIVATE KEY-----
```

``` 
GRANT execute ON dbms_cloud_oci_ag_deployment_list_deployments_response_t TO WKSP_API;
GRANT execute ON dbms_cloud_oci_apigateway_deployment_collection_t TO WKSP_API;
GRANT execute ON dbms_cloud_oci_apigateway_deployment_summary_tbl TO WKSP_API;
GRANT execute ON dbms_cloud_oci_apigateway_deployment_summary_t TO WKSP_API;
GRANT execute ON DBMS_CLOUD_OCI_AG_DEPLOYMENT TO WKSP_API;
GRANT execute ON DBMS_CLOUD TO WKSP_API;
/
-- 
BEGIN
  ORDS.enable_schema(
    p_enabled             => TRUE,
    p_schema              => 'WKSP_API',
    p_url_mapping_type    => 'BASE_PATH',
    p_url_mapping_pattern => 'apim',
    p_auto_rest_auth      => FALSE
  );
  COMMIT;
end;
/
```


```
BEGIN
   DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACE(
       host => '##OIC_HOST##',
       ace => XS$ACE_TYPE( 
           privilege_list => XS$NAME_LIST('http'),
           principal_name => 'WKSP_API',
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

## Task 3: Add existing APIs from Oracle Integration

Let's add an OIC source to harvest. 
- Go in the Apex Application, start it.
- Go to tab Source
- Click *Create*
- For oic_host, put ##OIC_HOST##
- *Create*
- Then *Harvest* on the top

Go back to the Portal page. The OIC integration should be there.

## Task 4: Add new Cloud Native APIs 

.....


## Acknowledgements

- **Author**
    - Marc Gueury


Parsing Schema : WKSP_API