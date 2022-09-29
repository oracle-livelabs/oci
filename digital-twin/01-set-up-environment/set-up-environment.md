# Set Up Digital Twin Running Environment


## Introduction
In this session, we will configure an Oracle Cloud Infrastructure (OCI) Tenancy with required IAM resources (Compartment, Policy, and Dynamic Group), create OCI services like OKE, OCI Streaming, Object Storage, and OCI Notification service.



### Services will be provisioned in this Lab:
- **Identity and Access Management (IAM)**:
    - **Compartment**: Logical container for resources, used to manage access to resources as a function of Identity and Access Management (IAM). 
    - **Policy**: An arrangement of statements used to manage access to resources as a function of Identity and Access Management (IAM). 
    - **Dynamic Group**: An arrangement of matching rules used to manage permissions to enable specific resources to access other specified resources.
- **Oracle Data Science Platform**: Serverless platform that lets developers create, run, and scale applications without managing any infrastructure. 
- **Oracle Kubernetes Engine (OKE)**: Oracle-managed container orchestration service that can reduce the time and cost to build modern cloud native applications.
- **Oracle Anomaly Detection Service**: AI service that enables developers to more easily build business-specific anomaly detection models that flag critical incidents, resulting in faster time to detection and resolution. Specialized APIs and automated model selection simplify training and deploying anomaly detection models to applications and operations - all without data science expertise.
- **Oracle Object Storage**: Securely store any type of data in its native format, with built-in redundancy.
- **Streaming**: Real-time, serverless, Apache Kafka-compatible event streaming platform for developers and data scientists.
- **Virtual Cloud Network (VCN)**: Customizable and private cloud network.


*Estimated Time*: 30 minutes



### Objectives
1. Create the OCI services needed to run digital twin model and anomaly detection solution
2. Understand the OCI services

### Prerequisites
1. Fully-privileged access to an OCI Tenancy (account).
2. Sufficient availability of resources in your OCI Tenancy. You can check resource availability [here](https://cloud.oracle.com/limits?region=home), and learn more about resource availability [here](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/servicelimits.htm#Viewing).



## Task 1 Create Resource Manager Stack

Resource Manager automates deployment and operations for all Oracle Cloud Infrastructure resources. Using the infrastructure-as-code (IaC) model, the service is based on Terraform, an open source industry standard software tool that enables DevOps engineers to develop and deploy their infrastructure anywhere.

1. Log into your Oracle Cloud Tenancy. You can access the log-in page [here](https://www.oracle.com/cloud/sign-in.html). 

2. Click the `Deploy to Oracle Cloud` button below, opening the link into a new browser tab.

In Chrome, Firefox and Safari, you can do this with `CTRL`+`Click` > Select `Open Link in New Tab`.

[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?region=home&zipUrl=https://objectstorage.us-ashburn-1.oraclecloud.com/p/op-o9z8k0z6u7bKmrkNmUW0Jo7IHatSRBaos0jUgFntsDgTA6C5TAqTG96MgmZ-t/n/orasenatdpltintegration03/b/digitaltwin/o/oci-digital-twin-pipeline-main.zip)

3. In the `Stack Information` section, select the checkbox to confirm that you accept the [Oracle Terms of Use](https://cloudmarketplace.oracle.com/marketplace/content?contentId=50511634&render=inline).

![create stack 1](./images/create_stack1.png)

The `OCI Digital Twin Pipeline` will pop up under `Stack Information`. Click **Next** to proceed to the `Configure Variables` section.

![create stack 2](./images/create_stack2.png)

4. In the `Configuration variables` section, supply the following input:

    In the `Name Your Resources` field, enter your name or initials, which will be used to provide uniqueness to resource names where required, in order to avoid naming collisions with other users' resources within the Tenancy.

    For example, if you enter `JohnDoe`, the resulting Compartment name will appear similar to: `AD_workshop_JohnDoe_wise_duck`. The `wise_duck` suffix is a pseudorandomly-generated petname, which contributes additional uniqueness to the resource name.

    Additionally, select your `Parent Compartment` and `Region` to choose where you wish to deploy the infrastructure stack.

![create stack config variable](./images/create_stack3.png)

For each resource that you wish to deploy, verify that the corresponding checkbox is selected in the `Select Resources` tile. Optionally, you can customize the attributes of each selected resource once an additional tile that presents configuration options for its respective resource appears below.

In this workshop, we will leave all of the resources checked, so that they will all deploy as part of our stack.

![create stack config var](./images/create_stack4.png)

On `Configure Variables` page, scroll to **Oracle Notifications Service (ONS)** section and fill in `ONS Subscription Endpoint` with your email address. This is to ensure that you receive a notification upon detection of anomalous data, enter an email address in the `ONS Subscription Endpoint` where you wish to receive these notifications from ONS (Oracle Notifications Service).

![create stack ons endpoint](./images/ons_endpoint.png)

When you are finished editing your variables in the `Configure Variables` section, click **Next** to proceed to the `Review` section.

5. Select the checkbox for **Run Apply**, and click **Create**. OCI Resource Manager then will start running the Job.

![create stack review](./images/create_stack_review.png)

You can monitor the deployment by monitoring the `Logs` window.

![create stack log](./images/resource_manager_log.png)

The Job will take approximately 25 minutes to run.

## Task 2 Review Stack Job Resources

1. Once the Job state turns to `SUCCEEDED`, you can view all the resources provisioned by the stack by click **Job resources**. 

![job succeed](./images/job_succeed.png)

![job resource view](./images/job_resource_show.png)



## Task 3 Verify OCI Object Storage

Oracle Cloud Infrastructure Object Storage service is an Internet-scale, high-performance storage platform that offers reliable and cost-efficient data durability. You can check and verify the Object Storage Bucket that created by the Resource Manager Job.

1. Click the Navigation Menu in the upper left, navigate to **Storage**, and select **Buckets**.

![os navigation](./images/bucket_navigation.png)

2. Select the new Compartment where your resources provisioned, whose name will start with **AD_workshop**. You can identify your compartment by the unique suffix that has been added to its name.

![os console](./images/os_console.png)

3. Open the bucket, whose name will start with **AD_bucket**, which was deployed as part of your stack.


## Acknowledgements

- **Authors**
      - Samuel Cacela, Staff Cloud Engineer 
      - Jiayuan Yang - Senior Cloud Engineer 
- **Contributors** 
      - Tony Zhang - Master Principal Cloud Architect
      - Adrian Alba - Staff Cloud Engineer
- **Last Updated By/Date** - 2022 September
