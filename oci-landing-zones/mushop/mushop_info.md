
# Intergration of Landing Zone with Mushop Service

In this lab exercise, you will walk through the with the intergation of Landing Zone with the third party microservice. Mushop is set of micro services which implement e-commerce platforms on the OCI cloud solution and its resources will be used to integrate with the OCI Landing Zone.


Estimated time: 20 minutes

Objectives

In this lab, you will:

    Inspect the resources created by the Landing Zone.
    Learn the simple intergration of thrid party app with the Landing Zone.

Prerequisites

    An Oracle Free Tier(Trial), Paid or LiveLabs Cloud Account
    User that belongs to the Administrator group or has granted privileges to manage multiple OCI resources (IAM, ORM, Network, etc) and Database        Service.

## Task 1: Installation

Landing Zone Topology Details

![Topology](.//images/Mushop_Topo.png)

*	Download the application files from the location https://github.com/oracle-quickstart/oci-cloudnative/releases/latest/download/mushop-basic-stack-latest.zip. 
*  Login to Oracle Cloud Infrastructure.
* Create a New Stack under the Resource Manager. 
    Hamburger > Developer Services > Resource Manager > Stacks > Create Stack
* Upload the mushop-basic-stack-latest.zip file that was downloaded earlier, and provide a name and description for the stack
![Stack Definition](.//images/Mushop_install_1.png)
*	Configure the stack
    *	Database Name - You can choose to provide a database name (optional
    *	SSH Public Key - (Optional) Provide a public SSH key if you wish to establish SSH access to the compute node(s).
* Configure the Varibles for the Stack.
![Stack Varible Definition](.//images/Mushop_install_2.png)
* Deploy the Stack.
![Stack Deployment](.//images/Mushop_install_3.png)


## Task 2: Deployment Resource Management


## Task 3: Cleanup

With the use of Terraform, the Resource Manager stack is also responsible for terminating the application.

Follow these steps to completely remove all provisioned resources:

1) Return to the Oracle Cloud Infrastructure Console
    Home > Developer Services > Resource Manager > Stacks
2) Select the stack created previously to open the Stack Details view
3) From the Stack Details, select Terraform Actions > Destroy
4) Confirm the Destroy job when prompted

The job status will be In Progress while resources are terminated
Once the destroy job has succeeded, return to the Stack Details page
Click Delete Stack and confirm when prompted
