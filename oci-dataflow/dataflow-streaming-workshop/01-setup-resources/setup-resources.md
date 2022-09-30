# Setup required resources for manufacturing application

## Introduction

This workshop helps setup resources required for running manufacturing Apache Spark applications in OCI Data Flow.

Estimated time: 15 minutes

### Objectives

* Plan and Apply automated terraform scripts in OCI Resource Manager to provision required resources.
* Verify required resources are created.

### Prerequisites

* This lab requires an [Oracle Cloud account](https://www.oracle.com/cloud/free/). You may use your own cloud account, or a Free tier account, a cloud account that you obtained through a trial.
* This lab requires user with necessary access to CREATE,MODIFY,DELETE below OCI resources at tenancy level.
    * OCI Compartments
    * OCI UserGroup
    * OCI Policies
    * OCI Autonomous Databases
    * OCI Vault
    * OCI Object Storage Buckets & Objects
    * OCI Streampool & Streams
    * OCI Dataflow Application & Runs

## Task 1: Create manufacturing application stack 
1. Open profile on top right corner and click on username.
	![Oracle Cloud console Menu](images/user-info.png " ")
2. Click the link to create stack to provision all necessary resources [![Deploy to Manufacturing Application to Oracle Cloud](images/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/oracle-samples/oracle-dataflow-samples/raw/main/scala/manufacturing/src/resources/manufacturing.zip)
3. Review and accept ```Oracle terms to Use``` and click Next.
   ![Oracle Cloud console, Resource Manager Stack](images/resource-manager-stack.png " ")
4. Update ```user_ocid``` variable with value from step 1. other variables doesn't need any change and click Next.
   ![Oracle Cloud console, Resource Manager Stack](images/update-variables.png " ")
   ![Oracle Cloud console, Resource Manager Stack](images/update-variables-1.png " ")
5. Review the information provided and ensure ```Run apply``` checkbox is selected and click create.
   ![Oracle Cloud console, Resource Manager Stack](images/review.png " ")
6. Creating stack will auto create Apply job which start provisioning resources.
   ![Oracle Cloud console, Resource Manager Stack](images/resource-manager-job.png " ") 
   
## Task 2: Verify required resources provisioned
1. Wait for Resource Manager Apply job completes, you can watch the logs.
   ![Oracle Cloud console, Resource Manager Stack](images/resource-manager-job-log.png " ")
   ![Oracle Cloud console, Resource Manager Stack](images/end-of-log.png " ")
2. Verify Apply job status is SUCCEEDED.
   ![Oracle Cloud console, Resource Manager Stack](images/resource-manager-job-success.png " ")
3. Click on SUCCEEDED job to see job details and resources.
   ![Oracle Cloud console, Resource Manager Stack](images/job-details.png " ")
4. Click on the hamburger menu in top left corner , select Governance & Administration and then select Tenancy Explorer.
   ![Oracle Cloud console, Resource Manager Stack](images/tenancy-explorer.png " ")
5. Select dataflow-labs compartment and verify resources in the screenshot are available.
   ![Oracle Cloud console, Resource Manager Stack](images/resources.png " ")

You may now **proceed to the next lab**.

## Acknowledgements
- **Author** -  Sivanesh Selvanataraj, Software Engineer, OCI Data Flow
- **Contributors** - Sujoy Chowdhury, Product Manager, OCI Data Flow
- **Last Updated By/Date** - Sivanesh Selvanataraj, September 2022
