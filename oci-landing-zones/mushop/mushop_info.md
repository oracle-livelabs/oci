
# Intergration of Landing Zone with Mushop Service

In this lab exercise, you will walk through the process of integration of Landing Zone with the third party microservices. MuShop represents a showcase of many OCI Cloud Native services as a unified reference application. Mushop is a set of micro services which implement e-commerce platforms on the OCI solution, and its resources will be used to integrate with the OCI Landing Zone.

Estimated time: 20 minutes

Watch the video below for a quick walk-through of the lab. 
[DLanding Zone Integration with Mushop](videohub:1_5wzjars7)

Objectives

In this lab, you will:

    Learn the process of intergration of thrid party app with the Landing Zone.

Prerequisites

    An Oracle Free Tier(Trial), Paid or LiveLabs Cloud Account
    User that belongs to the Administrator group or has granted privileges to manage multiple OCI resources (IAM, ORM, Network, etc) and Database Service.

## Task 1: Installation

This is a Terraform configuration that deploys the MuShop basic sample application on [Oracle Cloud Infrastructure][oci] and is designed to run using only the Always Free tier resources.

Mushop Topology Details
![Topology](.//images/mushop-topology.png)

The repository contains the application code as well as the [Terraform][tf] code to create a [Resource Manager][orm] stack, that creates all the required resources and configures the application on the created resources. To simplify getting started, the Resource Manager Stack is created as part of each [release](https://github.com/oracle-quickstart/oci-cloudnative/releases)

The steps below guide you through deploying the application on your tenancy using the OCI Resource Manager.

1. Download the latest [`mushop-basic-stack-latest.zip`](https://github.com/oracle-quickstart/oci-cloudnative/releases/latest/download/mushop-basic-stack-latest.zip) file.
2. [Login](https://cloud.oracle.com/resourcemanager/stacks/create) to Oracle Cloud Infrastructure to import the stack
    > `Home > Developer Services > Resource Manager > Stacks > Create Stack`
    ![mushop_stack](.//images/mushop-create-stack.png)
3. Upload the `mushop-basic-stack-latest.zip` file that was downloaded earlier, and provide a name and description for the stack
    ![mushop_stack_zip](.//images/mushop-upload-zip-file.png)
    ![mushop_stack_var](.//images/mushop-upload-zip-var-name.png)
5. Configure the stack
   1. **Database Name** - You can choose to provide a database name (optional)
   2. **Node Count** - Select if you want to deploy one or two application instances.
   3. **SSH Public Key** - (Optional) Provide a public SSH key if you wish to establish SSH access to the compute node(s).
   ![mushop_configure_stack](.//images/mushop-configure-stack.png)
6. Review the information and click Create button.
   ![mushop_stack_review](.//images/mushop-stack-review.png)
   > The upload can take a few seconds, after which you will be taken to the newly created stack
   ![mushop_stack_info](.//images/mushop-stack-info.png)


## Task 2: Verify Mushop Application Resources Deployment.
1) Go to `Home > Developer Services > Resource Manager > Stacks` and click on the newly created stack and make sure its state is Active.
   ![mushop_stack_state_info](.//images/mushop-stack-state-info.png)
2) Click on the newly created mushop stack
   ![mushop_stack_state_get_info](.//images/mushop-stack-get-information.png)
   ![mushop_stack_app_info](.//images/mushop-app-information.png)


* VCN Details
Hamburger > Networking > Virtual Cloud Networks
![VCN Info](.//images/mushop-vcn-info.png)

* Load Balancer Details
Hamburger > Networking > Load Balancers
![Load Balancer Info](.//images/mushop-lb.png)

* Compute Node

![Load Balancer BackEnd](.//images/mushop-lb-backend.png)

* Note: in case of quota/service limit/permission issues, Apply job will fail and partial resources will be provisioned. Click on Destroy button will trigger the job to remove provisioned resources.

## Task 3: Delete Mushop Application 

With the use of Terraform, the Resource Manager stack is also responsible for terminating the application.

Follow these steps to completely remove all provisioned resources:

* Return to the Oracle Cloud Infrastructure Console and go to `Home > Developer Services > Resource Manager > Stacks`. Select the Mushop Stack.
* From the Stack Details, select Terraform Actions > Destroy
    ![mushop_delete_stack](.//images/mushop-delete-stack.png)
* Confirm the Destroy job when prompted
    ![mushop_destroy_confirm](.//images/mushop-destroy-confirm)
* The job status will be In Progress while resources are terminated. 
    ![mushop_destroy_in_progress](.//images/mushop-destroy-in-progress)
    ![mushop_destroy_in_progress_check](.//images/mushop-destroy-in-progress-check)
* Once the destroy job has succeeded, return to the Stack Details page and Click Delete Stack and confirm when prompted
    ![mushop_destroy_complete](.//images/mushop-destroy-complete)
    ![mushop_stack_delete](.//images/mushop-stack-delete)
    ![mushop_stack_delete_confirm](.//images/mushop-stack-delete-confrim)




## Task 4: Known Issue 

* In case of quota/service limit/permission issues, Apply job will fail and partial resources will be provisioned. Click on Destroy button will trigger the job to remove provisioned resources.
* Sometimes DB provisioning is not allowed in the tenanacy , in this case Job will fail. Click on Destroy button will trigger the job to remove provisioned resources.

## Acknowledgements

* **Author** - LiveLabs Team
* **Contributors** - LiveLabs Team, Arabella Yao
* **Last Updated By/Date** - Arabella Yao, September 2022
