
# Lab 2: Add Existing APIs

## Introduction

In this lab, we will add existing APIs in the Portal. We will first create samples of APIs. Then import all of them in one shoot in the API Portal.

Estimated time: 20 min
 
### Objectives

- Add existing API from Oracle Integration:
    - Create Samples APIs in OIC 
    - Configure the security
    - Collect the APIs
- Add existing API from Oracle API Gateway

### Prerequisites

- Follow previous labs.

## Task 1: User and Tenancy details

1. First, we need data about your tenancy.
    - On the top, right, click *Tenancy: name*
    - Copy the tenancy OCID *##TENANCY\_OCID##*

        ![Tenancy](images/opensearch-tenancy.png)

2. Then, we need data about the user
    - On the top, right, click *Your username*
    - Copy the username *##USERNAME##* (without oracleidentitycloudservice )
    - Copy the user OCID *##USER\_OCID##*
    - Click on *API Keys*

        ![User](images/opensearch-user.png)

    - Click *Add API Key*
    - Generate one
    - Download it *##PRIVATE_KEY##*
    - Copy the *##FINGERPRINT##*

        ![User API Keys](images/opensearch-user2.png)

    In your computer (NOT in cloud shell), you need to convert the PEM key to RSA format:
    - Run the below command 
    - And keep the ##PRIVATE\_KEY\_RSA\_FORMAT##

    ```
    <copy>
    openssl rsa -in ##PRIVATE_KEY## -out ##PRIVATE_KEY_RSA_FORMAT##
    </copy>
    ex: openssl rsa -in private_key.pem -out private_key_rsa_format.pem
    ````

    Double-check that the private\_key\_rsa_format.pem is really in RSA format like this:

    ```
    <copy>
    -----BEGIN RSA PRIVATE KEY-----
    ...
    -----END RSA PRIVATE KEY-----
    </copy>
    ```

## Task 2: Add existing APIs from Oracle Integration

1. Create an Oracle Integration installation
    - Menu Developer Services / Application Integration 

        ![Oracle Integration](images/apim-oic1.png)

    - Click *Create Instance*
    - Name *oic\_apim*
    - Choose Integration Cloud Gen 2 
    - Choose your version and license type
    - Click *Create*
    - When the instance is green, click *Service Console*
2. Install Samples
    - In the Oracle Integration menu, choose *Integrations* / *Integrations* again
    - Remove the filter with your username
    - You will see some preinstalled sample. 
    
        ![Oracle Integration - Samples](images/apim-oic2.png)

    - Hover your mouse on the first line (Echo) and activate the integration
    - In the dialog, click *Activate* again
    - Do the same for several other integrations

        ![Oracle Integration - Samples](images/apim-oic3.png)

3. Note the host name of OIC from the URL (##OIC\_HOST##): ex: oic-apim-xxxxx-fr.integration.ocp.oraclecloud.com
4. Go back the APEX API Portal (##PORTAL\_URL##)
    - Click on the menu 
    - Then *Discover Source*
5. Click *Oracle Integration Credentials* 
    - For OCI Username, enter ##USERNAME##
    - For Password, enter ##PASSWORD##

        ![Oracle Integration - Samples](images/apim-oic-cred.png)

It will allow the database to call the OIC URLs

### 3. Create OIC Source

1. Still in the Source screen.
    - Click *Create Source*
    - Source Type *Oracle Integration*
    - Oracle Integration Host: ##OIC\_HOST##
    - Click *Create*

        ![Oracle Integration - Credentials](images/apim-source-oic.png)

## Task 3: Add existing API from API Gateway

1. Get APIW OCID
    - Please find back the Compartment OCID that was used to create the API Gateway in Lab 2 (Cloud Native). (##COMPARTMENT\_OCID##)
2. Go back the APEX API Portal (##PORTAL\_URL##)
    - Click on the menu 
    - Then *Discover Source*
3.  Create APIGW Source. 
    - Still in the Source screen.
    - Click *Create*
    - Source Type *OCI API Gateway*
    - Compartment OCID: ##COMPARTMENT\_OCID##
    - Click *Create*

        ![Oracle Integration - Credentials](images/apim-source-apigw.png)

## Task 4: Discover and Test

1. Still in the Source screen.
    - Click *Discover All*
    - Go and check the result in the Portal 

        ![Oracle Integration - Credentials](images/apim-oic-test.png)

## Troubleshooting

- If there are issue with the discovering, 
    - Go on the Discover page 
    - Click the Discover Log button. 
    - You may also run this query in SQL

    ```
    <copy>
    select * from api.discover_log
    </copy>
    ```

- To clean up the repository and discover all again

    ```
    <copy>
    truncate table api.TAG_IMPL
    /
    truncate table api.TAG
    /
    truncate table api.ENDPOINT
    /
    truncate table api.SPECIFICATION
    /
    truncate table api.IMPLEMENTATION
    /
    truncate table api.discover_log
    /
    begin
    api.api_discover.discover_all;
    end;
    /
    select * from api.discover_log
    /
    </copy>
    ```

- The sample has the following limitation:
    - It does not contain a logic to remove the duplicate entries in the API Portal
    - The APIGW discovery requires Tags to be set up on the API Deployment:
        - api\_icon: icon name (java/rest/soap/dotnet/go/python/...)
        - api\_git\_url: base URL to see the git project source 
        - api\_git\_spec_path: relative url for the specification (openapi file for ex)
        - api\_git\_spec_type: OpenAPI/WSDL/...
        - api\_git\_endpoint_path: relative url for the specification (Terraform file for ex)
        - api\_endpoint\_url: path to add the endpoint url (sometimes a API Gateway URL is containing variable path)

- The right to call OCI API could probably be improved with OCI policies instead of encoding the user ocid, ...


## Acknowledgements

- **Authors**
    - Marc Gueury / Phil Wilkins /  Robert Wunderlich  / Shyam Suchak / Tom Bailiu / Valeria Chiran

