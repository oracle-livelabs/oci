# Provision of the necessary resources

## Introduction

In this lab, you will provision a complete Oracle Cloud Infrastructure (OCI) environment used to demonstrate **container image reuse and startup performance** using shared storage.

A pre-built Terraform stack deploys all required resources and prepares a Linux compute instance to benchmark Podman cold vs warm image pulls and container starts using:

- OCI File Storage Service (FSS)
- OCI Lustre File Storage

The environment is provisioned using **Terraform from the command line**, and the compute instance is configured automatically using cloud-init.

Estimated Time: 45 minutes

### Objectives

By the end of this lab, you will:
- Deploy a full OCI environment using Terraform CLI
- Provision networking, storage (FSS and Lustre), and a compute instance
- Automatically prepare the instance via cloud-init for image reuse testing
- Understand the deployment flow and post-provisioning steps before benchmarking

### **Prerequisites**

This lab assumes you have:

- An Oracle Cloud account with permissions to create:
  - Networking resources
  - Compute instances
  - File Storage Service (FSS)
  - Lustre File Storage
- Terraform installed locally or available in OCI Cloud Shell
- (Optional) OCI CLI configured for credential verification
- An SSH key pair
- SSH access from your local machine or Cloud Shell

## Task 1: Provision resources using Terraform CLI

1. Download the [Terraform code](files/oci-vm-container-cache-fss-lustre-main.zip) provided for this workshop to your local environment or OCI Cloud Shell and unzip it.

2. In the Terraform directory, rename the provider template file:
    ```
    provider.auto.tfvars.tpl → provider.auto.tfvars
    ```

3. Edit `provider.auto.tfvars` and populate all required values:
    - `tenancy_ocid`
    - `user_ocid`
    - `fingerprint`
    - `private_key_path`
    - `region`
    - Compartment OCIDs

4. Review and adjust terraform.tfvars if needed (for example: SSH key paths, CIDRs, compute shape, image, or storage sizes).

    Run Terraform:

5. Open a terminal for this code, make sure to **cd** to the Terraform folder and initialize the Terraform configuration:

    ```
    terraform init
    ```

6. Review the execution plan:
   
    ```
    terraform plan
    ```

7. Provision the infrastructure:

    ```
    terraform apply
    ```

8. Review the execution plan and type **yes** to confirm.


## Task 2: Monitor deployment
  
After running `terraform apply`, the infrastructure provisioning phase completes first, followed by extended instance configuration performed via cloud-init.

This entire process can take 30 minutes or more, primarily due to OS updates, kernel changes, and the Lustre client build that happen through the cloud-init script.

### Deployment Behavior

- Terraform completes creation of networking, storage, and compute resources.
- The compute instance continues configuration via cloud-init, which includes:
    - Mounting FSS exports
    - Installing Podman and required dependencies
    - Building and installing the Lustre client
    - Rebooting the instance to activate the correct kernel
    - Mounting the Lustre filesystem
    - Preparing directories for Podman image reuse

### Monitor progress

1. Wait for the Terraform deployment to complete. The public IP address of the VM is displayed in the Terraform output.

2. SSH into the instance:
    
    ```
    ssh opc@<instance_public_ip>
    ```

3. Monitor the initial cloud-init execution:
    
    ```
    sudo tail -f /var/log/cloud-init-output.log
    sudo tail -f /var/log/cloud-init.log
    ```

    During this phase, you will observe system updates, package installation, and FSS mounting. 
    A reboot is expected once the kernel is updated.

4. After the reboot, the remaining configuration steps (including Lustre client build and mount) continue via a systemd service.
Monitor post-reboot progress using:

    ```
    sudo journalctl -u post-reboot.service -f
    ```

    Once all steps complete successfully, the instance is fully prepared and ready for manual benchmarking.

You may now **proceed to the next lab**.

## Acknowledgements

**Authors**

* **Adina Nicolescu**, Principal Cloud Architect, NACIE
* Last Updated - Adina Nicolescu, March 2026
