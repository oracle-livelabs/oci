
# Lab 2: Add New Cloud Native APIs

## Introduction

Estimated time: 20 min

### Objectives

- Create several Cloiud Native (Java/Node/Dotnet/Python/...) APIs with the help of Terraform
- Add the APIs in the Portal 

### Prerequisites

- Follow previous labs.

## Task 1: Add new APIs written with Cloud Native

### 1. Download Source
- Go to Oracle Cloud Home page
- Go to Cloud Shell.
- When the shell is started, clone the git repository in the shell:
  
    ```
    <copy>
    git clone https://github.com/mgueury/oci-api-portal.git
    cd oci-api-portal/cloud-native-sample
    vi group_common/env.sh
    </copy>
    ```

    ![Cloud Shell](images/apim-cloudshell.png)

### 2. Build
In the file group_common/env.sh, you have to set: 
- TF\_VAR\_compartment\_ocid in a compartment where the APIGW and VM with the APIs will be created. If no compartment is given and you are Admin of the OCI Tenant, an compartment oci-starter will be created. To get your compartment:
    - Go to OCI Menu/Identity & Security/Compartments.
    - Choose your comparment 
    - And copy the OCID
    - Take a note ##COMPARTMENT_OCID##
- APIM\_HOST to the APEX Host Name: ##APEX\_HOST##
- Then run the build. This will take about 15 mins. 

    ```
    <copy>
    ./build_group.sh
    </copy>
    ```

    ![Introduction Usecase](images/apim-test-edit-env.png)

It will build with Terraform:
- An API Gateway
- 5 VMs with Java/Node/Dotnet/Go/Python with APIs
- And register the APIs in the API Management Portal with curl.

## Task 2: Curl command

You can check the curl command used in api-java/bin/add_api.sh.

    ```
    <copy>
    curl -k "https://${APIM_HOST}/ords/apim/rest/add_api?git_repo_url=${TF_VAR_git_url}&impl_name=${FIRST_LETTER_UPPERCASE}&a_icon_url=${TF_VAR_language}&runtime_console=https://cloud.oracle.com/api-gateway/gateways/$TF_VAR_apigw_ocid/deployments/$APIGW_DEPLOYMENT_OCID&version=${GIT_BRANCH}&endpoint_url=${APIGW_URL}/app/dept&endpoint_git_path=src/terraform/apigw_existing.tf&spec_git_path=src/app/openapi_spec.yaml&a_spec_type=OpenAPI"
    </copy>
    ```

Where:
- impl\_name: name of the API
- icon\_url: icon name (java/rest/soap/dotnet/go/python/...)
- version: version
- spec\_type: OpenAPI/WSDL/...
- endpoint\_url: URL of the api that is deployed
- git\_repo\_url: base URL to see the git project source 
- spec\_git\_path: relative url for the specification (openapi file for ex)
- endpoint\_git_path: relative url for the specification (Terraform file for ex)
- runtime\_console: url to the console that allow to see the state of the API

## Task 3: Test

When the Task 1 build is done.

- Go back to the APEX portal (##PORTAL_URL##) and check the result.

![Cloud Native Test](images/apim-cloud-native-test.png)

## Acknowledgements

- **Authors**
    - Marc Gueury / Robert Wunderlich  / Shyam Suchak / Tom Bailiu / Valeria Chiran
