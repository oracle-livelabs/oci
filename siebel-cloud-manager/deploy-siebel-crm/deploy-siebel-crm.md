# Deploy Siebel CRM

## Introduction

In this lab, we will deploy the Siebel CRM. We shall prepare a JSON payload containing required environment details and send a **POST** request to the Siebel Cloud Manager API.

Estimated Time: 1 hour

### Objectives

In this lab, you will:
*   Generate an Oracle Cloud Infrastructure user Auth Token
*   Prepare a payload to deploy Siebel CRM
*   Install and set up Postman
*   Execute the payload
*   Monitor the deployment
*   Launch the Siebel Application

### Prerequisites

* GitLab and Siebel Cloud Manager Instance
* GitLab Access Token

## Task 1: Generate an Oracle Cloud Infrastructure user Auth Token

We need to log in to the Oracle Cloud Infrastructure Tenancy and generate an auth token for our user. This token will be used as the **registry_password** in the payload.

1. Log in to the OCI tenancy. On the console, click the ***Profile Icon***

2. Click the first option that has the user id mentioned to reach the **User Details** page.

   ![OCI Profile Icon](./images/oci-prof-icon.png)

3. On the left side panel, in the **Resources** section, click ***Auth Tokens***

4. Click ***Generate Token*** and give the **Description** as below.

   ```
   <copy>Token for SiebelCM</copy>
   ```

   ![OCI Generate Token for User](./images/click-gen-token.png)

5. Copy the auth token that got generated before closing the window as it will not be shown again.

   ![OCI User Token Displayed](./images/oci-user-token-display.png)

## Task 2: Prepare a payload to deploy Siebel CRM

After we have completed all the prior tasks, we can use Siebel Cloud Manager to deploy Siebel CRM
on Oracle Cloud Infrastructure. To do this, we shall first prepare a suitable JSON payload and then execute this payload on Siebel Cloud
Manager.

1. Consider a sample payload below. Substitute parameter values inside **{}** as required.

   ```
   <copy>{
   "name": "SiebelLab",
   "siebel": {
   "registry_url": "iad.ocir.io",
   "registry_user": "{User_Id_To_Connect_To_Container_Registry}",
   "registry_password": "{User_Auth_Token}",
   "database_type": "Vanilla",
   "industry": "Sales"
   },
   "infrastructure": {
   "gitlab_url": "https://{Public IP of Gitlab Instance}",
   "gitlab_accesstoken": "{Gitlab_Access_Token}",
   "gitlab_user": "root",
   "gitlab_selfsigned_cacert": "/home/opc/certs/rootCA.crt"
   },
   "database": {
   "atp_admin_password": "WElcome123###",
   "atp_storage_in_tbs": 1,
   "atp_cpu_cores": 2
   },
   "size": {
   "kubernetes_node_shape": "VM.Standard2.4",
   "kubernetes_node_count": 3,
   "ses_resource_limits": {
   "cpu": 2,
   "memory": "4Gi"
   },
   "cgw_resource_limits": {
   "cpu": 2,
   "memory": "4Gi"
   },
   "sai_resource_limits": {
   "cpu": 1,
   "memory": "4Gi"
   }
   }
   }</copy>
   ```

   The below table describes certain important payload parameters. For the latest list of parameters, their description, and an example payload, please follow the Siebel Cloud Manager documentation attached to this Oracle Support article - **Using Siebel Cloud Manager to Deploy Siebel CRM on OCI (Doc ID 2828904.1).**   

| Payload Parameter | Description |
|---|---|
| registry_url | Specifies the URL of the Docker container registry. If you are using the OCI registry in your tenancy, then use the container registry from the same region as the Siebel Cloud Manager instance. For example, for the Ashburn region, you might use iad.ocir.io. For other regions, see [https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryprerequisites.htm](https://docs.oracle.com/en-us/iaas/Content/Registry/Concepts/registryprerequisites.htm). |
| registry_user | Specifies the OCI user ID in this format - OCITenancyName/UserName. |

## Task 3: Install and set up Postman

Postman is an API platform for building and using APIs. Postman can be either downloaded and installed in the local or we can also use its web version. For this lab, we shall use the web version.

1. Go to this website - [https://www.postman.com/downloads/](https://www.postman.com/downloads/)

2. In the **Postman on the web** section, click ***Try the web version***

   ![Try the Web version](./images/try-web-version-postman.png)

3. Create a Postman account by following one of the methods mentioned on that page.

   ![Create New Account](./images/create-new-account.png)

4. Once the account has been successfully created, we will be directed to  [https://web.postman.co/home](https://web.postman.co/home)

5. Click ***Create New Workspace*** under the **Workspaces** menu. 

6. Specify a **Name** of your choice and Choose **Personal** under **Visibility**. Click ***Create Workspace***.

   ![Create New Workspace](./images/create-workspace.png)

## Task 4: Execute the payload

1. Click ***New*** button and choose **HTTP Request**.

   ![Create New Request](./images/create-new-req.png)   

2. In the horizontal menu, navigate to **Authorization**. Choose the Type **Basic Auth** from the drop-down. Give the **Username** and **Password** as below.

    **Username**

        <copy>admin</copy>

    **Password**

        <copy>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</copy>

   ![Give Authorization and credentials](./images/req_auth.png)   

3. Navigate to **Body** menu and select the **raw** radio button. Change the format from **Text** to **JSON**.

   ![Choose Body and Format](./images/msg-body.png) 

4. Paste the Payload in the body section.

5. Set the following attributes for the request.

   **Method**

        <copy>PUT</copy>

   **Request URL**

        <copy>http://{Public IP of the Siebel Cloud Manager Instance}:16690/api/v1/environments/</copy>

6. Click ***Send***

7. Save the response to a file as this has vital information on the Siebel environment that we are creating.

8. Note the value of **env_id** from the response.

   ![Env ID from the log](./images/env-id.png)

## Task 5: Monitor the deployment

After sending a post request with our payload, the Siebel Cloud Manager will prepare and deploy the Siebel CRM environment stack.

1. With the **env_id** that we noted earlier, send a **GET** request to Siebel Cloud Manager from Postman as below.

   **Method**

        <copy>GET</copy>

   **Request URL**

        <copy>http://{Public IP of the Siebel Cloud Manager Instance}:16690/api/v1/environments/{env_id}</copy>

    The log file will be returned as a response.

    ![Deployment status log](./images/deploy-status-log.png) 

    The response body will have a section named **stages** that indicates the particular stage of deployment. The **status** parameter in each stage can have values such as **passed, in-progress, failed**, etc.

    We can also monitor the **Oracle Resource Manager (ORM)** stack logs from the Oracle Cloud console to see the progress of the stack deployment.

2. In the Oracle Cloud console, navigate to **Developer Services > Stacks**.

3. In the list scope section on the left side panel, choose the compartment **scm-siebel-cm**.

4. Drill down on the stack name and then drill down on the job name.

      Monitor the logs here as it will be mentioning the resources' creation status.

      The ORM stack deployment is just one of the many **stages** of the overall Siebel CRM deployment. To check the other stages and their status regularly, send a **GET** request to the Siebel Cloud Manager API as mentioned earlier.

      Each stage has its log and the path to it can be found in the respective section itself. In case required, login to the Siebel Cloud Manager instance using its public IP address and view the required log.

5. (Optional) If the ORM stack deployment fails due to any of the following types of errors, then send a **PUT** request to rerun the job.

      ```
      Error: 400-InvalidParameter

      Provider version: 4.20.0, released on 2021-03-31. This provider is 36 updates behind to current.

      Service: FileStorageFileSystem
      Error Message: Ocid
      'ocid1.compartment.oc1..aaaaaaaabwvdshyuwbyfpx72m4lq6yni673m2ewf7qrou7ha5dvaxrjeogfa' not found in Compartment Tree!

      OPC request ID: a42cd5b1927359f403a56e8eabb378b8/47793109B015FB5F54CE70BC905ACF70/968A739323FC3A76967AD9E94862A1E2
      Suggestion: Please update the parameter(s) in the Terraform config as per error message Ocid
      'ocid1.compartment.oc1..aaaaaaaabwvdshyuwbyfpx72m4lq6yni673m2ewf7qrou7ha5dvaxrjeogfa' not found in Compartment Tree!

      on modules/storage/main.tf line 1, in resource "oci_file_storage_file_system" "siebelCM_Fss"
      1: resource "oci_file_storage_file_system" "siebelCM_Fss" {
      ```

6. (Optional) Send a **Put** request to rerun the stack as below in case any of the above errors were encountered.

   **Method**

        <copy>PUT</copy>

   **Request URL**

        <copy>http://{Public IP of the Siebel Cloud Manager Instance}:16690/api/v1/environments/{env_id}?rerun=true</copy>

7. After all the **stages** have been completed successfully as **passed**, the list of relevant application URLs will be mentioned towards the end of the log as shown below.

   ![All Stages Passed](./images/appln-urls.png)


## Task 6: Launch the Siebel Application

1. Launch the application URL in a new browser session and enter the below credentials.

   **User Id**

        <copy>sadmin</copy>

   **Password**

        <copy>SiebelAdmin123</copy>

    This password can be found in the log that was retrieved with the **GET** request and this can be found against the **userpassword** parameter under the **database** section.

   ![Siebel Login](./images/sbl-login.png)

## Summary

We have successfully deployed a new Siebel CRM environment using the Siebel Cloud Manager. Please follow the Siebel Cloud Manager documentation to understand the different payload parameters that can be customized while deploying the Siebel CRM.
In the next lab, you can view and manage the Siebel's Kubernetes Cluster to connect to the Siebel pods and perform administration and management.

## Acknowledgements

* **Author:** Shyam Mohandas, Principal Cloud Architect, Cloud Engineering
* **Contributors** - Vinodh Kolluri, Raj Aggarwal, Mark Farrier, Sandeep Kumar
* **Last Updated By/Date** - Shyam Mohandas, Principal Cloud Architect, Cloud Engineering