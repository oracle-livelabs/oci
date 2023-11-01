# Release resources created through the workshop

## Introduction

Congratulations, you complete the workshop. You may want to release the cloud resources created through this workshop. We first delete all resources created manually and then, we use ORM to delete resources managed through Infrastructure As Code/Terraform.

---

Estimated Lab time: 20 minutes

### Objectives

In this lab, you will:

* Release Infrastructure Resources

### Prerequisites

* An Oracle Free Tier(Trial), Paid or LiveLabs Cloud Account
* GitHub account


## Task 1: Delete DevOps Pipeline


### Delete DevOps Pipeline Stages

1. In the Console, open the navigation menu, click Developer Services, and then under DevOps, click Projects.

1. Select the project we deployed during this workshop (it should starts with `hello`) and click the View all Deployment Pipelines link.

1. Click on the `deploy-fulfillment-to-dev` Deployment Pipeline name to open up the Pipeline page.

1. Delete all stages from the pipeline. Click the Menu icon (3 dots) in the top-right corner of the stage that you want to delete.
        ![Delete Stage](./images/oci-devops-delete-stage.png)

1. Select Delete and confirm to permanently delete the stage from the pipeline.

1. Confirm the deletion of the stage.


### Delete DevOps Pipeline Parameters

1. In the DevOps Pipeline page, click on the `Parameters` tab.

1. Click on the trash button to delete the `mushop_fulfillment_version` parameter.

    ![Delete Parameter ](./images/devops-parameter-created.png) 


### Delete DevOps Pipeline

1. After deleting all Stages and Parameter. You can click the Menu icon for the pipeline (3 dots besides `Run pipeline` button), then select `Delete`.
        ![Delete pipeline](./images/oci-devops-delete-pipeline.png)

1. Confirm the deletion of the pipeline.



## Task 2: Delete DevOps Artifacts

1. Go back to the project page.

1. In the `Latest artifacts` section in the bottom of the page, click on the name of each Artifact.

1. In the Artifact details page, click `Remove`.

1. Confirm the deletion of the Artifact.

1. Repeat the operation for all Artifacts created during the workshop.


## Task 3: Release ORM Stack Resources

All resources provisioned during this workshop that were managed exclusively via Resource Manager can be destroyed running a `Destroy` job associated with your Stack `infrastructure-onboard`.

1. Open the navigation menu and click Developer Services. Under Resource Manager, click Stacks.

1. Choose the `cicd` compartment if you haven't selected before. The page updates to display only the resources in that compartment. 

1. Click the name of the stack `infrastructure-onboard`.

1. The Stack Details page is displayed.

1. Click Destroy.
    ![Destroy Stack](./images/oci-orm-destroy-stack.png)

1. In the Destroy panel, you can enter a name for the job and click Destroy again to confirm your action.
    ![Confirm Destroy Stack](./images/oci-orm-destroy-confirm.png)

    You can monitor the status and review the results of a destroy job by viewing the state or the logs.
        ![Destroy Stack Logs](./images/oci-orm-logs-destroy.png)

    To view the Terraform state file (shows the state of your resources after running the job), click the name of the job to display the Job Details page, then click View State under Resources.

    To view the logs for the job, click the name of the job to display the Job Details page, then click Logs under Resources.

1. At the end, the Destroy job succeeds and your resources were released.
    ![Destroy Completed](./images/oci-orm-destroy-done.png)

1. You can go back to the Stack Details page, and delete the Stack by clicking on `More Actions -> Delete Stack` and click again to confirm your action. 
    ![Delete Stack](./images/oci-orm-delete-stack.png)  



## Task 4: Delete ORM Configuration Source Provider

The next step is to delete the GitHub Configuration Source Provider in the Oracle Resource Manager.

1. In the left hand side menu, under Resource Manager, click `Configuration Source Providers`.
    
1. Click the name of the configuration source provider that you want to delete - `GitHub`.
    ![List of CSP](./images/oci-orm-csp.png)  

1. Click Delete Configuration Source Provider and then confirm the action.
    ![Delete GitHub CSP](./images/oci-orm-delete-github-csp.png)  


You may now [proceed to the next lab](#next).