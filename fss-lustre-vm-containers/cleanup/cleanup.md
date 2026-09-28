# Cleanup

## Introduction

Once the workshop is complete, remove all created resources to avoid unnecessary costs.

Estimated Time: 30 minutes

### Objectives

Delete the VM and shared file system resources (FSS and/or Lustre) created by Terraform.

### **Prerequisites**

This lab assumes you have:

- An Oracle Cloud account
- Sufficient privileges to manage OCI compute, networking, and storage resources
- Terraform installed and configured with OCI credentials

## Task 1: Cleanup the resources

1. From the same terminal directory where the infrastructure was deployed, run:

    ```
    terraform destroy
    ```

2. Review the resources scheduled for deletion and type **yes** to confirm.


End of LiveLab – You have successfully deployed and cleaned up an automation using FSS and Lustre on an OCI VM, and validated cold/warm container image pulls and startups.

## Acknowledgements

**Authors**

* **Adina Nicolescu**, Principal Cloud Architect, NACIE
* Last Updated - Adina Nicolescu, March 2026
