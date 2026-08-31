# Lab 1: Deploy OKE with Simple Terraform Modules

## Introduction

Use the simple Terraform source to create an OKE environment. Choose one path: local Terraform CLI or managed OCI Resource Manager. Each path has its own source package and lifecycle.

### Who This Lab Is For

This lab is for learners with Terraform fundamentals and basic OKE knowledge. It provides a practical starting point for deploying a complete OKE environment through a simpler, flat Terraform design.

Estimated Time: 60 minutes

### Objectives

* Collect required OCI and networking inputs and perform a non-destructive preflight.
* Deploy, verify, and destroy the simple configuration through CLI or ORM.

### Prerequisites

* Complete the introduction and have permissions for the selected compartment.
* Install Terraform and OCI CLI, or use Cloud Shell, for the CLI path.
* Create an SSH key pair. Keep private keys and `*.tfstate` files out of source control and ORM archives.

## Task 1.0: Collect OCI Inputs and Prepare Terraform Configuration

1. Record the region, tenancy OCID, user OCID, OKE and network compartment OCIDs, availability domains, node shape, supported Kubernetes version, non-overlapping CIDRs, and SSH public-key path. Store sensitive values locally, not in version control.
2. Create or identify an OCI API signing key and configure a named profile. The private-key path is local-only.

    ```bash
    oci setup config --profile-name OKE_LIVE_LAB
    export OCI_CLI_PROFILE=OKE_LIVE_LAB
    ```

3. Confirm read access without changing resources.

    ```bash
    oci ce cluster list --compartment-id "<oke-compartment-ocid>"
    oci network vcn list --compartment-id "<network-compartment-ocid>"
    oci resource-manager stack list --compartment-id "<stack-compartment-ocid>"
    ```

4. Download the path-specific source package. For CLI, initialize, validate, and review a plan after supplying only your local input values.

    ```bash
    terraform init
    terraform validate
    terraform plan
    ```

5. A successful read check or Terraform plan confirms configuration and some read access only. It does not guarantee quota, write permission, or regional shape capacity. For ORM, the equivalent preflight is a successful **Plan** job after creating the stack.

## Task 1.1 (CLI): Download and Configure the Simple Source

1. Download and extract the [Lab 1 CLI source](https://docs.oracle.com/en/learn/oke-clstr-trfm/files/oke_terraform_for_beginners.zip).
2. Review the source README and copy its sample variable file if provided. Enter compartment OCIDs, region, CIDRs, Kubernetes version, node shape, and the path to your public SSH key.
3. Keep the API signing-key location and all private values in a local ignored file. Confirm the configured CIDRs do not overlap networks that must connect to the VCN.

## Task 1.2 (CLI): Plan, Apply, Verify, and Destroy

1. From the extracted source root, run `terraform init`, `terraform validate`, and `terraform plan -out oke.plan`. Resolve unexpected changes before continuing.
2. Provision the environment.

    ```bash
    terraform apply oke.plan
    ```

3. Verify the cluster and its node pool in **Developer Services > Kubernetes Clusters (OKE)**, then obtain kubeconfig according to the source README.

    ```bash
    kubectl get nodes
    kubectl get pods -A
    ```

4. Remove billable test resources when finished.

    ```bash
    terraform plan -destroy
    terraform destroy
    ```

## Task 1.1 (ORM): Prepare the ORM Source Archive

1. Download and extract the [Lab 1 ORM source](https://docs.oracle.com/en/learn/oke-cluster-automation/files/oke_advanced_module_orm.zip). This is an ORM delivery package; do not substitute the CLI archive.
2. Set stack variables or permitted input files for region, compartments, CIDRs, node shape, Kubernetes version, and SSH public key. Never include credentials, private keys, `.terraform`, or Terraform state.
3. If you need to create an archive, do so from the configuration root and inspect it before upload.

    ```bash
    zip -r ../stackconfig.zip . -x "*.terraform/*" "*.tfstate*"
    unzip -l ../stackconfig.zip
    ```

## Task 1.2 (ORM): Plan, Apply, Verify, and Destroy

1. In **Developer Services > Resource Manager > Stacks**, create a stack with **My configuration**, upload the ORM source archive, select the stack compartment, and set required variables.
2. Run a **Plan** job and inspect the CIDRs, compartment assignments, creation flags, and node shape. Do not apply until the plan succeeds and is expected.
3. Run an **Apply** job. Monitor logs to completion, then verify the cluster and nodes as in the CLI path.
4. Run a **Destroy** job when testing is complete; verify that cluster, node pools, load balancers, and other billable resources are removed.

## Summary

You deployed the simple OKE configuration using one independent execution path. Choose Lab 2 only if your use case needs an advanced modular design.

## Acknowledgements

* **Authors** - Mahamat H. Guiagoussou, Payal Sharma, Matthew McDaniel, and John Adewumi
* **Last Updated** - August 2026
