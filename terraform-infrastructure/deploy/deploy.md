# Setting up Highly Available and Secure Infrastructure with Terraform

## Introduction

This lab will go through deploying your terraform code and watch its creation from the console.

Estimated Time: 60 minutes

### Objectives

In this lab, you will:
* Learn how to use/setup Terraform
* Learn how to provision OCI resources through Terraform

### Prerequisites

This lab assumes you have:
* An Oracle account
* Familiarity with Networking is desirable, but not required
* Some understanding of cloud, networking, and Terraform
* Familiarity with Oracle Cloud Infrastructure is helpful


## Task 1: Deploy your Terraform

**Terraform Initialize**

On your local terminal, navigate to your directory where the tf-provider is located in. Once in the directory run the init command.
```
<copy>
terraform init
</copy>
```

Example output:

![terraform-init](images/terraform-init.png)

**Terraform Plan**

Next we will create an execution plan to check whether the changes shown in the execution plan match your expectations, without changing the real resources. Run the Terraform plan command

```
<copy>
terraform plan
</copy>
```
This will provide you the plan. 

Example output:

![terraform-plan](images/terraform-plan.png)
  
**Terraform Apply** 

Finally we will apply the plan, Run the terraform apply command. This command will take a couple of minutes to run. 

```
<copy>
terraform apply
</copy>
```

Terraform will prompt you to enter yes when applying.

![terraform-apply-yes](images/terraform-apply-yes.png)

After running you will recieve outputs from the output.tf files. 

Example output:

![terraform-apply](images/terraform-apply.png)

In Addition if you have your console open you can see your resources get provisioned!

![instances-console](images/instances-console.png)

![loadbalancer-console](images/loadbalncer-console.png)

## Task 2: Destroy your Terraform

**Terraform Destroy**

On your local terminal, in the same directory as your tf-provider, we can tear down our infrastructure. Run the the terraform destroy command.

```
<copy>
terraform destroy
</copy>
```

Terraform will prompt you to enter yes when destroying.

![terraform-destroy-yes](images/terraform-destroy-yes.png)

Example output:

![terraform-destroy](images/terraform-destroy.png)

Just like when you apply you can also watch your resources get destroyed on the console!

![instances-console-destry](images/instances-console-destroy.png)

Congratulations on finsihing this Livelab! Now you have a terraform template to use when provisioning resources on OCI!

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [CLI + Terraform](https://developer.hashicorp.com/terraform/tutorials/cli)

## Acknowledgements
* **Author** - Germain Vargas, Cloud Engineer
* **Contributors** -  David Ortega, Cloud Engineer
* **Last Updated By/Date** - Germain Vargas, August 2023
