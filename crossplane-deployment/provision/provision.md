# Deploy OCI Crossplane provider on OCI using Resource Manager

## Introduction

This lab will take you through the steps needed to provision the infrastructure using Resource manager and deploy OCI Crossplane provider.

Estimated Time: 90 minutes

### Objectives

In this lab, you will:
* Learn how to upload the code to Resource Manager
* How to configure the automation variables
* How to deploy the automation that will create the infrastructure and install OCI Crossplane provider

### Prerequisites

This lab assumes you have:
* An Oracle account
* Administrator permissions or permissions to use the OCI tenancy



## Task 1: Gathering data to complete variables in Resource Manager

Before running the automation in Resource Manager, you will need to gather details about your OCI tenanacy like: Tenanacy Namespace, OCI Registry Auth Token, OCI Registry username and prepare your OCI auth private key content.

1. Tenanacy Namespace
- Navigate to Tenancy details and under Object storage settings, there is Object storage namespace. 
- You will need the tenanacy namespace in order to create an OCI Registry that will be used to start the crossplane and to be able to have a correct OCI Registry user.


2. Auth Token
- In order to run the automation you will need to obtain an Auth token with at least 5 minutes before running it. 
- To obtain the Auth Token navigate to OCI console to your user. Click on Auth token on the left side collumn and generate token. 
- You will need to provide the token to configure the `ocir_auth_token` variable. More details can be found [here].(https://docs.oracle.com/en-us/iaas/Content/Registry/Tasks/registrygettingauthtoken.htm)



3. OCI Registry user
- Enter your username in the format <tenancy-namespace>/<username>, where <tenancy-namespace> is the auto-generated Object Storage namespace string of your tenancy (as shown on the Tenancy Information page). For example, ansh81vru1zp/jdoe@acme.com. If your tenancy is federated with Oracle Identity Cloud Service, use the format <tenancy-namespace>/oracleidentitycloudservice/<username>.
- More details about how to correct get your OCI Registry user can be found [here](https://docs.oracle.com/en-us/iaas/Content/Registry/Tasks/registrypushingimagesusingthedockercli.htm)
- You will need to create this user to configure the `ocir_username` variable.


4. OCI API Keys
- If you do not already have an existing API public and private key pair, you can setup them by following the [RSA key pair in PEM format (minimum 2048 bits)](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm?utm_source=chatgpt.com)
- Once, you generate the keys, you can login to OCI console -> Click on your Profile(Top right corner) -> your user -> API Keys -> Add API Key.
- Copy the fingerprint, you will need it later to complete the `fingerprint` variable

5. OCI Private key content
- Run the following command on the environment where you have the OCI private key:
```
awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}' <same path to key file as your OCI CLI config>
```
- Copy the resulted content that will be required to configure the `private_key_content` variable.
- This is used for the crossplane provider login to OCI.


## Task 2: Provision resources

1. Go to Resource manager -> Stacks -> Create Stack. Choose My configuration and upload the provided zip file, select the compartment in which you want to create the stack and click Next: [orm-stack-oke-crossplane-deployment.zip](https://github.com/ionut-sturzu/orm-stack-oke-crossplane-deployment/archive/refs/heads/main.zip).

    ![Resource Manager](images/resource_manager.png)

    Or you could use a single click deployment button shown below:

    [![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/ionut-sturzu/orm-stack-oke-crossplane-deployment/archive/refs/heads/main.zip)

2. Provide the information for **Compartment**, **Kubernetes Cluster Name (Any suitable name)** , **Check Create new VCN**, **VCN Name (Any suitable name)**, **Leave other Networking information as default**.

3. Configure the **Kubernetes nodepool configuration** according to your cluster needs.

4. Choose either to create a public endpoint for OKE cluster, or a private one by checking **Create public OKE API?** checkbox and follow the bellow steps to complete all the variables.
    ![Complete variables](images/complete_variables.png)

5. Now is time to configure the OCI Crossplane provider deployment via helm by having the checkbox **Helm | Deploy Crossplane** checked.

6. Optional: If  you need to override the OCI Crossplane provider values you can create a file with the desired variables and upload it under **Helm | Crossplane helm chart values override**. Details about the values that are supported by the helm chart can be found [here](https://github.com/crossplane/crossplane/blob/main/cluster/charts/crossplane/values.yaml?utm_source=chatgpt.com).

7. Next, put the values obtained in Task 1 to their variables: `fingerprint`, `ocir_username`, `ocir_auth_token`, `private_key_content`.

8. (Optional) If you have a password setup for your private key complete the `private_key_password` variable.

9. Next, setup the OCI Registry repository name value by completing the `registry_display_name`. This needs to be unique name accross the tenanacy.

10. Click Next, check the **Run Apply** and click Create in order to create and deploy the Resource Manager stack.
    ![Run Apply](images/apply_stack.png)

11. Wait for the Job to succeed. It may take 15-20 minutes for it to be successful as we are deploying OKE Cluster and setup all the required dependecies for OCI Crossplane provider.

12. Once the job succeeded go to Outputs and copy the `ssh_to_operator` to access the instance that manages the OKE cluster.
    ![SSH to Operator](images/output.png)

Next, we will guide you on how you can deploy resources in OCI using your recently deployed OCI Crossplane provider. You may now proceed to the next lab.

## Acknowledgements

**Authors**

* **Ionut Sturzu**, Principal Cloud Architect, NACIE
