# Lab 3: Apply OKE Best Practices and Karpenter Provider for OCI

## Introduction

This lab applies reusable-module, compartment, availability, and node-pool practices. It also includes an executable bonus use case for Karpenter Provider for OCI (KPO).

Estimated Time: 45 minutes

### Objectives

* Apply modular, least-privilege, availability, and node-cycling practices.
* Configure specialized node pools.
* Provision workload-driven capacity with KPO and clean it up safely.

### Prerequisites

* An OKE cluster from Lab 1 or Lab 2 and kubeconfig access.
* For the bonus task: a managed or self-managed baseline node pool for the KPO controller, KPO and Kubernetes versions supported together, supported networking, and scoped OCI IAM policies.

## Task 3.1: Apply Modular and Compartment Practices

1. Keep VCN, OKE, and bastion concerns in separate modules and expose only the outputs required by dependent modules.
2. Use a network compartment for VCN resources and an OKE compartment for cluster and node-pool resources when separation of duties applies. Grant least-privilege policies to each administration group.
3. Run `terraform plan` before applying changes and confirm module outputs do not expose sensitive values.

## Task 3.2: Configure Availability, Node Cycling, and Specialized Pools

1. In multi-AD regions, spread workers across availability domains; in single-AD regions, distribute them across fault domains. Use replicas, topology spread constraints, and PodDisruptionBudgets for critical workloads.
2. Enable controlled cycling only after confirming workload capacity and quota.

    ```hcl
    node_cycling_enabled = true
    maximum_surge        = 1
    maximum_unavailable  = 0
    cycle_modes          = ["INSTANCE_REPLACE"]
    ```

3. Create separate node pools for general and specialized workloads. Assign labels, taints, and independent scaling limits; use node selectors, affinity, and tolerations to target workloads.

## Task 3.3: Run the Karpenter Provider for OCI Bonus Use Case

1. Confirm the KPO chart version and its Kubernetes, networking, and IAM requirements in the [current Oracle KPO documentation](https://docs.oracle.com/en-us/iaas/Content/ContEng/Tasks/contengkarpenter.htm). Install the controller on the baseline node pool according to that version's instructions.
2. Create an `OCINodeClass` with placeholder OCI identifiers. Replace only the placeholders appropriate to your tenancy; do not put real OCIDs in this workshop or public source.

    ```yaml
    apiVersion: karpenter.oci.oraclecloud.com/v1beta1
    kind: OCINodeClass
    metadata:
      name: workload-class
    spec:
      compartmentId: <workload-compartment-ocid>
      subnetId: <worker-subnet-ocid>
      imageId: <supported-image-ocid>
    ```

3. Create a `NodePool` that references the `OCINodeClass`, with requirements compatible with the selected shape and availability domain. Use the chart-version-specific API fields documented by Oracle.

4. Deploy a targeted workload with a selector for the KPO pool. KPO should create a `NodeClaim`, which results in a KPO-launched worker node.

    ```bash
    kubectl get nodepools
    kubectl get ocinodeclasses
    kubectl get nodeclaims
    kubectl get nodes -l karpenter.sh/nodepool
    ```

5. Verify that the workload is scheduled and the created node has the expected `karpenter.sh/nodepool` label. Inspect controller events before changing requirements or capacity limits.

6. Clean up in order: delete the targeted workload, wait for its KPO-created node and `NodeClaim` to drain and terminate, delete the `NodePool`, delete the `OCINodeClass`, then remove the KPO controller only if no other KPO workloads remain.

## Summary

You applied OKE best practices and verified the KPO flow from `OCINodeClass` to `NodePool`, `NodeClaim`, and a KPO-launched worker node. Destroy the Lab 1 or Lab 2 infrastructure when no longer needed.

## Acknowledgements

* **Authors** - Mahamat H. Guiagoussou, Payal Sharma, Matthew McDaniel, and John Adewumi
* **Last Updated** - August 2026
