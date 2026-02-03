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

1. using *git* you will clone the repository that contains the Terraform code to deloy the OCI resources

- Run the command below to clone the repo

```
git clone git@github.com:franciscvass/oci-token-exchange-resources.git
```

- The above command should download the repo in _oci-token-exchange-resources_ folder

- Run the command below to check:
```
ls oci-token-exchange-resources
```
- It should returns :
```
LICENSE         provider.tf     variables.auto.example
main.tf         README.md       variables.tf
outputs.tf      terraform.auto.tfvars   versions.tf
```

2. Update the variables in file _variables.auto.example_

- To understand the variables please open and read the README.md file
- For your reference here is the variable description

**conf_file_prof_reg**

This is the profile name in your OCI CLI config _(~/.oci/config)_ that points to the region where you will deploy the resources

**conf_file_prof_reg_home**

This is the profile name in your OCI CLI config that points to the home region of your tenancy

**tenancy_ocid**

The ocid of your tenancy

**compartment_ocid**

The ocid of the compartment where the Service User will have the privileges to manage VCN resources. Please mind this is a demo that evetually will use Github Action to create a VCN in your tenancy.

**display_name**

The name of Integrated Application you will deploy

**idcs_endpoint**

The API endpoint of your Domain. Go to Identity and security/Domains. Choose Default Domain and Domain URL will give you the API endpoint

**actor**

This is the owner of the gitrepo(your Github account) from where you will run the Github Action. This actor (the owner of the Github repo) will be impersonate as an OCI service user.

**user_name**

The Service User name

**user_display_name**

The Service User display name

**proptrust_name**

A Propagation Trust will be created which will map your Github repo owner with Service User. This is the name of that Propagation Trust

**group_name**

A Group will be created and SErvice User will be attached to it. This is the name of that group


3. Once all of these variables are configured you can apply the configuration

- go to _oci-token-exchange-resources_ folder

- rename the _variables.auto.example_ to _variables.auto.tfvars_
```
mv variables.auto.example variables.auto.tfvars
```
- run the commands below:

```
terraform init
terraform plan
```

- you should see someting like 

```
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

- after you run _terraform plan_ you should see something like:
```
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

- Review the output of _terraform plan_ command and if you happy with the output then continue with the next step

4. Run _terraform apply_ from the same folder and answer with _yes_

```
terraform apply
```

5. After succesfully apply you will see an Output

- These output contains info that will be used in out next Lab to set the Github Action

You may now **proceed to the next lab**.

## Acknowledgements

**Authors**

* **Francisc Vass**, Principal Cloud Architect, NACIE
* Last Updated - Francisc Vass, January 2026
