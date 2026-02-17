# Provision of the necessary resources

## Introduction

In this lab, we will provision the required OCI resources. These resources will be used by the Github Action to exchange token with OCI.
We’ll use a pre-built Terraform configuration that automates the entire setup

Estimated Time: 20 minutes

### **Objectives**

* Provision the infrastructure using Terraform.    
* Prepare the environment for Github Action.

### **Prerequisites**

This lab assumes you have:

* An Oracle Cloud account.
* Administrator privileges or sufficient access rights to create and manage Integrated App, Service User, Group, IAM Policies in your tenancy.
* git installed
* terraform installed
* OCI CLI installed and configured

## Task 1: Provision OCI resources

1. Using *git* you will clone the repository that contains the Terraform code to deloy the OCI resources
    - run the command below to clone the repo
     ```
     <copy>
     git clone git@github.com:franciscvass/oci-token-exchange-resources.git
     </copy>
     ```

    - the above command should download the repo in *oci-token-exchange-resources* folder
    - run the command below to check:
     ```
     <copy>
     ls oci-token-exchange-resources
     </copy>
     ```
    - it should returns :
     ```text
     LICENSE         provider.tf     variables.auto.example
     main.tf         README.md       variables.tf
     outputs.tf      terraform.auto.tfvars   versions.tf
     ```

2. Update the variables in file *variables.auto.example*
    - to understand the variables please open and read the README.md file
    - for your reference here are the variables description

     ```text
     - conf_file_prof_reg
     
     This is the profile name in your OCI CLI config _(~/.oci/config)_ that points to the region where you will deploy the resources
     
     - conf_file_prof_reg_home
     
     This is the profile name in your OCI CLI config that points to the home region of your tenancy
     
     - tenancy_ocid
     
     The ocid of your tenancy
     
     - compartment_ocid
     
     The ocid of the compartment where the Service User will have the privileges to manage VCN resources. Please mind this is a demo that evetually will use Github Action to create a VCN in      your tenancy.
     
     - display_name
     
     The name of Integrated Application you will deploy
     
     - idcs_endpoint
     
     The API endpoint of your Domain. Go to Identity and security/Domains. Choose Default Domain and Domain URL will give you the API endpoint
     
     - actor
     
     This is the owner of the gitrepo(your Github account) from where you will run the Github Action. This actor (the owner of the Github repo) will be impersonate as an OCI service user.
     
     - user_name
     
     The Service User name
     
     - user_display_name
     
     The Service User display name
     
     - proptrust_name
     
     A Propagation Trust will be created which will map your Github repo owner with Service User. This is the name of that Propagation Trust
     
     - group_name
     
     A Group will be created and SErvice User will be attached to it. This is the name of that group
     ```

3. Once all of these variables are configured you can apply the configuration
    - go to *oci-token-exchange-resources* folder
    - rename the *variables.auto.example* to *variables.auto.tfvars*
     ```
     <copy>
     mv variables.auto.example variables.auto.tfvars
     </copy>
     ```
    - run the commands below:
     ```
     <copy>
     terraform init
     terraform plan
     </copy>
     ```
    - you should see someting like 
     ```text
     terraform init
     Initializing the backend...
     Initializing provider plugins...
     - Finding oracle/oci versions matching "7.24.0"...
     - Installing oracle/oci v7.24.0...
     - Installed oracle/oci v7.24.0 (signed by a HashiCorp partner, key ID 1533A49284137CEB)
     Partner and community providers are signed by their developers.
     If you'd like to know more about provider signing, you can read about it here:
     https://developer.hashicorp.com/terraform/cli/plugins/signing
     Terraform has created a lock file .terraform.lock.hcl to record the provider
     selections it made above. Include this file in your version control repository
     so that Terraform can guarantee to make the same selections by default when
     you run "terraform init" in the future.
     
     Terraform has been successfully initialized!
     
     You may now begin working with Terraform. Try running "terraform plan" to see
     any changes that are required for your infrastructure. All Terraform commands
     should now work.
     
     If you ever set or change modules or backend configuration for Terraform,
     rerun this command to reinitialize your working directory. If you forget, other
     commands will detect it and remind you to do so if necessary.
     ```
    - after you run *terraform plan* you should see something like:
     ```text
     Plan: 6 to add, 0 to change, 0 to destroy.
     
     Changes to Outputs:
       + app_name      = "TokenExDemoApp"
       + app_ocid      = (known after apply)
       + client_id     = (known after apply)
       + client_secret = (known after apply)
       + group_name    = "TokenExDemoGrp"
       + idcs_endpoint = "https://idcs-xxxxxxxx.identity.oraclecloud.com:443"
       + user_id       = (known after apply)
       + user_name     = "TokenExDemoUsr"
       + user_ocid     = (known after apply)
     ```
    - Review the output of *terraform plan* command and if you happy with the output then continue with the next step

4. Run *terraform apply* from the same folder and answer with _yes_
       ```
       <copy>
       terraform apply
       </copy>
       ```

5. After succesfully apply the code you will see an Output.
    - these output contains info that will be used in out next Lab to set the Github Action
    - make sure you have ths output available for the next Lab
    - you can get this output anytime if you run the command below:

     ```
     <copy>
     terraform output
     </copy>
     ```

You may now **proceed to the next lab**.

## Acknowledgements

**Authors**

* **Francisc Vass**, Principal Cloud Architect, NACIE
* Last Updated - Francisc Vass, January 2026
