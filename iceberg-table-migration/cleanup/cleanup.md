# Cleanup

## Introduction

In this lab, you will destroy the Terraform-managed resources created for the Iceberg migration demo.

Estimated Time: 20 minutes

### Objectives

By the end of this lab, you will:

* Destroy the OCI compute, network, and Object Storage resources created by Terraform.
* Empty the demo Object Storage bucket before destroying it.
* Confirm the Terraform destroy completed successfully.
* Verify that no lab resources remain in the compartment.

### Prerequisites

This lab assumes you have:

* Completed the previous labs or no longer need the demo environment.
* Access to the local workstation where Terraform was run.
* Permission to delete the resources created for this workshop.

## Task 1: Empty the Object Storage bucket

Before running Terraform destroy, delete the objects from the demo bucket. OCI Object Storage buckets must be empty before they can be deleted.

1. Open the OCI Console.

2. Open the navigation menu and select **Storage**.

3. Under **Object Storage & Archive Storage**, select **Buckets**.

4. Make sure you are in the compartment used for this workshop.

5. Open the `iceberg-table-demo` bucket.

6. Delete all objects from the bucket.

7. Confirm the bucket no longer contains objects.

## Task 2: Destroy the Terraform environment

1. On your local workstation, change to the Terraform automation folder **icebergtables**, if not already in it:

    ```bash
    cd icebergtables
    ```

2. Run Terraform destroy:

    ```bash
    terraform destroy
    ```

3. Review the planned destruction.

4. When prompted, enter:

    ```text
    yes
    ```

5. Wait for Terraform to finish.

If Terraform reports that the bucket is not empty, rerun Task 1 and then run `terraform destroy` again.

## Task 3: Verify cleanup

1. Confirm Terraform no longer reports managed resources:

    ```bash
    terraform show
    ```

2. In the OCI Console, open the compartment used for the workshop.

3. Confirm the following demo resources were removed:

    * Compute instance
    * VCN and related network resources
    * Object Storage bucket

## Task 4: Remove local Terraform files if needed

If you no longer need the local Terraform working files, you can remove local state and cached provider files from your workstation according to your organization policy.

Do not delete shared state files unless you are certain they are only used for this demo.

## Finish

You have completed the Iceberg table migration workshop and cleaned up the demo resources.

## Acknowledgements

* **Author** - Adina Nicolescu, Principal Cloud Architect, NACIE
* **Last Updated By/Date** - Adina Nicolescu, June 2026
