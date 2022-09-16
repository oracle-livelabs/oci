
# Intergration of Landing Zone with Mushop Service

In this lab exercise, you will walk through the process of integration of Landing Zone with the third party microservices. MuShop represents a showcase of many OCI Cloud Native services as a unified reference application. Mushop is a set of micro services which implement e-commerce platforms on the OCI solution, and its resources will be used to integrate with the OCI Landing Zone.

Estimated time: 20 minutes

Objectives

In this lab, you will:

    Learn the process of intergration of thrid party app with the Landing Zone.

Prerequisites

    An Oracle Free Tier(Trial), Paid or LiveLabs Cloud Account
    User that belongs to the Administrator group or has granted privileges to manage multiple OCI resources (IAM, ORM, Network, etc) and Database Service.

## Task 1: Installation

Landing Zone Topology Details

![Topology](.//images/mushop-topology.png)

*	Download the application files from the location https://github.com/oracle-quickstart/oci-cloudnative/releases/latest/download/mushop-basic-stack-latest.zip. 
*  Login to Oracle Cloud Infrastructure.
* Create a New Stack under the Resource Manager. 
    Hamburger > Developer Services > Resource Manager > Stacks > Create Stack
* Upload the mushop-basic-stack-latest.zip file that was downloaded earlier, and provide a name and description for the stack

![Stack Definition](.//images/mushop-install-1.png)

* Configure the Varibles for the Stack.
    *	Database Name - You can choose to provide a database name (optional
    *	SSH Public Key - (Optional) Provide a public SSH key if you wish to establish SSH access to the compute node(s).

![Stack Varible Definition](.//images/mushop-install-2.png)

* Deploy the Stack.

![Stack Deployment](.//images/mushop-install-3.png)

* Deployment Logs.

![Stack Deployment](.//images/mushop-log.png)

* Verify the Mushop Application Deployment.

![Mushop Application Info](.//images/mushop-application.png)

* Verify the Mushop Application Dashboard.

![Mushop DashBoard](.//images/mushop-application-url.png)

## Task 2: Deployment Resource Management

* VCN Details
Hamburger > Networking > Virtual Cloud Networks
![VCN Info](.//images/mushop-vcn-info.png)

* Load Balancer Details
Hamburger > Networking > Load Balancers
![Load Balancer Info](.//images/mushop-lb.png)

* Compute Node

![Load Balancer BackEnd](.//images/mushop-lb-backend.png)

* Note: in case of quota/service limit/permission issues, Apply job will fail and partial resources will be provisioned. Click on Destroy button will trigger the job to remove provisioned resources.

## Task 3: Cleanup

With the use of Terraform, the Resource Manager stack is also responsible for terminating the application.

Follow these steps to completely remove all provisioned resources:

* Return to the Oracle Cloud Infrastructure Console
    Home > Developer Services > Resource Manager > Stacks
* Select the stack created previously to open the Stack Details view
* From the Stack Details, select Terraform Actions > Destroy

![MuShop Delete](.//images/mushop-delete.png)

* Confirm the Destroy job when prompted

The job status will be In Progress while resources are terminated
Once the destroy job has succeeded, return to the Stack Details page
Click Delete Stack and confirm when prompted

## Task 4: Known Issue 

* In case of quota/service limit/permission issues, Apply job will fail and partial resources will be provisioned. Click on Destroy button will trigger the job to remove provisioned resources.
* Sometimes DB provisioning is not allowed in the tenanacy , in this case Job will fail. Click on Destroy button will trigger the job to remove provisioned resources.

## Acknowledgements

* **Author** - LiveLabs Team
* **Contributors** - LiveLabs Team, Arabella Yao
* **Last Updated By/Date** - Arabella Yao, September 2022
