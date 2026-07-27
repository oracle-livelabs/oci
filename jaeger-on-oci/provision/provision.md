# Provision of the necessary resources

## Introduction

In this lab, we will provision the required resources: a compute virtual machine running Jaeger and the HotROD sample application.
We'll use the provided Terraform code to automate the setup from the terminal - creating the OCI networking and compute resources, configuring access, and installing Jaeger with HotROD so you can generate and explore distributed traces.

Estimated Time: 30 minutes

### Objectives

* Provision the infrastructure from the terminal using the provided Terraform code.
* Create a new VCN and compute virtual machine for the Jaeger environment.
* Configure the VM to run Jaeger and the HotROD sample application.
* Prepare the environment for generating and exploring distributed traces.

### Prerequisites

This lab assumes you have:

* An Oracle Cloud account.
* Administrator privileges or sufficient access rights to create and manage OCI networking and compute resources.
* Basic understanding of Terraform and cloud compute concepts.
* Access to a command-line environment such as **OCI Cloud Shell** or a local terminal with:
  - `terraform`
  - `oci` CLI configured for your tenancy
  - an SSH key pair available for connecting to the compute instance

## Task 1: Provision resources

1. Download the provided archive of the code: [jaeger-on-oci.zip](files/jaeger-on-oci.zip)

2. Extract the archive and open a terminal where Terraform is installed, then navigate to the extracted `jaeger-on-oci` folder.

3. Update `provider.auto.tfvars` with your OCI provider and compartment details:

    - **tenancy_ocid**: Your tenancy OCID.
    - **user_ocid**: Your user OCID for API key authentication.
    - **fingerprint**: Your API key fingerprint.
    - **private_key_path**: Local path to your OCI API private key.
    - **private_key_password**: Private key password, or an empty string if the key has no password.
    - **region**: Target OCI region.
    - **compartment_ids.target**: Compartment OCID where the resources will be deployed.

4. Update `terraform.tfvars` with the deployment values:

    - **linux_images**: Oracle Linux image OCID for your selected region.
    - **instance_params.jaeger_vm.ad**: Availability domain number valid in the selected region.
    - **instance_params.jaeger_vm.shape**: Compute shape for the VM.
    - **instance_params.jaeger_vm.ocpus** and **memory_in_gbs**: Shape sizing for flexible shapes.
    - **instance_params.jaeger_vm.ssh_private_key**: Local path to the SSH private key used by the output SSH command.
    - **ssh_public_key**: Local path to the SSH public key injected into the VM.
    - **sl_params.jaeger_sl.ingress_rules[*].source**: Replace `0.0.0.0/0` with trusted CIDR ranges where appropriate.

5. Initialize Terraform:

    ```
    terraform init
    ```

6. Validate the configuration:

    ```
    terraform validate
    ```

7. Review the planned OCI resources:

    ```
    terraform plan
    ```

    The plan should create a VCN, public subnet, internet gateway, route table, security list, and one compute instance.

8. Apply the configuration:

    ```
    terraform apply
    ```

9. When Terraform completes, review the output values:

    - **jaeger_ui_urls**: URL for the Jaeger UI.
    - **hotrod_urls**: URL for the HotROD demo application.
    - **otlp_grpc_endpoints**: OTLP gRPC endpoint.
    - **otlp_http_endpoints**: OTLP HTTP endpoint.
    - **ssh_commands**: SSH command for connecting to the VM.
    - **next_steps**: Generated validation steps.

10. Wait a few minutes for cloud-init to finish installing Docker and starting the Jaeger and HotROD containers. If the URLs do not respond immediately, wait 2-5 minutes and retry.

You may now **proceed to the next lab**.

## Acknowledgements

**Authors**

* **Adina Nicolescu**, Principal Cloud Architect, NACIE
* Last Updated - Adina Nicolescu, July 2026
