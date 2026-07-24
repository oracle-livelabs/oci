# Cleanup

## Introduction

Once the workshop is complete, you should remove the resources to avoid unnecessary costs. Because the Jaeger environment was provisioned from the terminal using Terraform, you will also clean it up from the terminal using `terraform destroy`.

Estimated Time: 10 minutes

### Objectives

* Destroy the OCI resources created by the Terraform configuration.
* Remove the Jaeger compute VM, VCN, subnet, internet gateway, route table, and security list.
* Confirm that the Terraform destroy operation completes successfully.

### Prerequisites

This lab assumes you have:

* Completed the provisioning lab.
* Access to the same extracted `jaeger-on-oci` Terraform folder used during provisioning.
* Access to a command-line environment where Terraform is installed.
* The same OCI API credentials and key files used to provision the resources.

## Task 1: Destroy the resources

1. Open a terminal where Terraform is installed.

2. Navigate to the extracted `jaeger-on-oci` folder that contains the Terraform files.

3. Confirm that Terraform can still read the current state:

    ```
    terraform plan
    ```

4. Destroy the provisioned resources:

    ```
    terraform destroy
    ```

5. When prompted, type `yes` to confirm the destroy operation.

6. Wait for Terraform to finish deleting the resources.

7. Confirm that the destroy operation completed successfully.

    Terraform should report that the resources were destroyed. You can also verify in the OCI Console that the Jaeger compute instance and related networking resources are no longer present in the target compartment.

End of LiveLab - You have successfully deployed Jaeger on OCI, explored HotROD traces, and cleaned up the resources.

## Acknowledgements

**Authors**

* **Adina Nicolescu**, Principal Cloud Architect, NACIE
* Last Updated - Adina Nicolescu, July 2026
