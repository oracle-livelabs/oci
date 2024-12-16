# Creating OCI Resources With Terraform

In this lab you will create the OCI Network, Bastion, Operator and OKE cluster using Terraform and the OKE Terraform module.  It's important to read through the [OKE Module documentation](https://oracle-terraform-modules.github.io/terraform-oci-oke/) as there are numerous options that can apply to your specific OCI deployment.

## Introduction

This Terraform deployment creates the following resources

- Private OKE Control plane
- Private Operator (with kubectl installed)
- Public bastion (for SSH tunneling to Operator)
- Three node pools (one public for game servers, and two private for the Autoscaler and Agones system pods respectively)
- Security Group Rules for UDP access (game server to game client connectivity)
- VCN Logs for logging traffic

Estimated Time: 30 minutes

Objectives
In this lab, you will:
 - Configure your Terraform variables
 - Run a Terraform plan and apply changes

Prerequisites
 - Completed Lab 1 which walked through sourcing the Terraform files

## **Task 1**: Update Terraform Variables

1. You will want to edit `infrastructe/terraform.tfvars` with relevant information to match your account OCID's and API Keys.  For a full description of each variable in that file refer to `infrascturure/vvariables.tf`.

2. You can (optional) edit `infrastructure/module.tf` to tweak the OKE settings as needed for your deployment.  The current settings will work as is for the purpose of this lab. Its a good idea to have a look at these settings since the OKE Terraform module does a lot and is very customizable.

## **Task 2**: Create a Terraform Plan

 Get a Terraform plan and check the output of that plan to make sure its what you expect.  After you validate the plan you can move onto the next task.

   ```bash
   cd infrastructure
   terraform plan
   ```

## **Task 3**: Apply the Terraform Plan

You can now apply the plan and the infrastructure will get created. Wait some time for the apply to complete.

```bash
terraform apply
```

## **Task 4**: Connect to the bastion

1. Get the terraform output. It will give an example command that you can use to SSH to the bastion and jump to the operator.

   ```bash
   terraform output
   ```

2. The operator has kubectl installed with connectivity to the OKE control plane.  **An example of that output is below**. You should test this command and make sure it works before proceeding to the next section of this workshop.

    ```bash
    ssh -J opc@<bastion public IP> opc@<operator private ip>
    ```

## **Summary**

You have now deployed the necessary infrastructure and connected to the Bastion and jumped to the Operator.  You are ready to begin installing the autoscaler and more.

## Learn More - *Useful Links*

- [OKE Terraform Module](https://oracle-terraform-modules.github.io/terraform-oci-oke/)
- [Terraform Variables](https://developer.hashicorp.com/terraform/language/values/variables)

## **Acknowledgements**

 - **Author** - Marcellus Miles, Master Cloud Architect
 - **Last Updated By/Date** - Marcellus Miles, Dec 2024