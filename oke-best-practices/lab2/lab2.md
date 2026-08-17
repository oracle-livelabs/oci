# Lab 2: Deploy OKE with Advanced Terraform Modules

## Introduction

The advanced source separates VCN, OKE, and bastion responsibilities into reusable modules. Select one complete path: Terraform CLI or OCI Resource Manager (ORM).

Estimated Time: 60 minutes

### Objectives

* Configure an advanced modular OKE deployment.
* Independently plan, apply, verify, and destroy through CLI or ORM.

### Prerequisites

* Complete Lab 1 Task 1.0 or collect equivalent OCI inputs.
* Have supported Kubernetes versions, a regionally available node shape, and non-overlapping network CIDRs.

## Task 2.1 (CLI): Download and Configure the Advanced Source

1. Download and extract the [Lab 2 CLI source](https://docs.oracle.com/en/learn/oke-cluster-automation/files/oke_advanced_module.zip).
2. Review the source README, then configure the tenancy, region, OKE and network compartment OCIDs, availability domains, CIDRs, node-pool shape, Kubernetes version, and SSH public key.
3. Enable only the resources required for your deployment and use separate network and OKE compartments where your operating model requires it. Do not commit `terraform.tfvars`, state, or private keys.

## Task 2.2 (CLI): Plan, Apply, Verify, and Destroy

1. Initialize, validate, and produce an output plan.

    ```bash
    terraform init
    terraform validate
    terraform plan -out oke.plan
    ```

2. Inspect planned IAM-sensitive network rules, resource compartments, CIDR blocks, and node-pool placement. Apply only after review.

    ```bash
    terraform apply oke.plan
    ```

3. Verify the OKE cluster and node pools in the OCI Console and from kubeconfig.

    ```bash
    kubectl get nodes
    kubectl get pods -A
    ```

4. Destroy test resources in the same working directory when complete.

    ```bash
    terraform plan -destroy
    terraform destroy
    ```

## Task 2.1 (ORM): Prepare the Advanced ORM Source

1. Download and extract the [Lab 2 ORM source](https://docs.oracle.com/en/learn/oke-cluster-automation/files/oke_advanced_module_orm.zip). It is a separate delivery mechanism from the CLI source.
2. Supply approved stack variables for the region, compartments, CIDRs, Kubernetes version, node-pool configuration, and public SSH key. Exclude credentials and local Terraform state.
3. Upload the supplied archive, or create a clean source archive and inspect its contents before upload.

    ```bash
    zip -r ../advanced-stackconfig.zip . -x "*.terraform/*" "*.tfstate*"
    unzip -l ../advanced-stackconfig.zip
    ```

## Task 2.2 (ORM): Create a Stack and Run a Plan Job

1. Open **Developer Services > Resource Manager > Stacks** and create a stack from the advanced ORM configuration. Select the correct stack compartment and configure variables.
2. Start a **Plan** job. Review the job output for modules, compartments, CIDRs, node shape, and creation flags.
3. A successful plan does not reserve capacity or prove write permission; resolve any quota, policy, or availability issue before applying.

## Task 2.3 (ORM): Apply, Verify, and Destroy

1. From the approved plan, start an **Apply** job and monitor logs until it succeeds.
2. Verify the cluster and node pools in OKE, then run `kubectl get nodes` and `kubectl get pods -A` with the generated kubeconfig.
3. Start a **Destroy** job when the lab is complete. Confirm the job succeeds and that billable OKE and associated networking resources are removed.

## Summary

You used the advanced OKE module source through an independent CLI or ORM workflow. Continue to Lab 3 for operational practices and the KPO bonus use case.
