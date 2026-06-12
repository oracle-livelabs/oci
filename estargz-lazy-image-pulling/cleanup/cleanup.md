# Cleanup

## Introduction

Once the workshop is complete, destroy the OCI resources you provisioned to avoid ongoing costs.

This lab also explains the optional step of removing any test images from OCIR if they are no longer needed.

Estimated Time: 15 minutes

### Objectives

* Destroy the Terraform-managed OCI environment.
* Confirm the VM and networking resources are removed.
* Optionally delete the regular and eStargz images from OCIR if you own them and no longer need them.

### *Prerequisite

This lab assumes you have:

* An Oracle Cloud account
* Access to the OCI tenancy and compartment used for the lab
* A local terminal with Terraform configured in the lab repository
* Optional: OCI CLI configured if you plan to delete images from OCIR


## Task 1: Destroy the Terraform environment

1. Open a terminal in the lab repository where the Terraform files are located.
2. Run:

    ```bash
    terraform destroy
    ```

3. Review the planned destruction and confirm with `yes` when prompted.
4. Wait for Terraform to finish destroying the VM, network, and associated resources.
5. Verify completion by checking the command output or by using the OCI Console to confirm the resources are gone.


## Task 2: Optional OCIR image cleanup

The lab automation does not delete images from OCIR. If you created or imported test images that are no longer needed, remove them manually.

### Delete private OCIR images from the Console

1. Open the OCI Console.
2. Navigate to Registry -> Repositories.
3. Select the repository that contains the test image.
4. Delete the image tag or repository if it is no longer needed.

### Delete private OCIR images with OCI CLI

If you prefer CLI cleanup and you own the images, use the OCI CLI to delete the image or repository. Example:

```bash
oci artifacts container image delete --image-id <image-id> --force
```

or delete the repository once all images are removed:

```bash
oci artifacts container repository delete --repository-id <repository-id> --force
```

## Finish

After destroying the Terraform environment and optionally cleaning OCIR images, you have completed the lab cleanup.

## Acknowledgements

* **Author** - **Adina Nicolescu**, Senior Cloud Engineer, NACIE
* **Last Updated By/Date** - Adina Nicolescu, June 2026
