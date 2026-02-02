# Cleanup

## Introduction

In this lab, you will clean up all the resources created during this workshop. This includes the sample applications, storage classes, and the complete OKE infrastructure.

Estimated Time: 10 minutes

### Objectives

In this lab, you will:

- Delete sample applications and their storage
- Remove Rook-Ceph components
- Destroy the OKE cluster and associated resources
- Verify cleanup completion

### Prerequisites

This lab assumes you have:

- Completed the previous labs
- Access to the OCI Console or Terraform CLI

## Task 1: Delete Sample Applications

First, remove the sample applications deployed in the previous lab.

1. Delete the WordPress application:

    ```bash
    <copy>
    kubectl delete namespace wordpress
    </copy>
    ```

2. Delete the shared web application:

    ```bash
    <copy>
    kubectl delete namespace shared-web
    </copy>
    ```

3. Verify namespaces are deleted:

    ```bash
    <copy>
    kubectl get namespaces
    </copy>
    ```

   The `wordpress` and `shared-web` namespaces should no longer appear.

## Task 2: Delete Rook-Ceph Storage Components

Remove the Ceph storage pools and storage classes.

> **Note:** The order of deletion is important. Delete applications first, then storage classes, then the Ceph cluster.

1. Delete the CephObjectStore:

    ```bash
    <copy>
    kubectl delete cephobjectstoreuser my-user -n rook-ceph
    kubectl delete cephobjectstore my-store -n rook-ceph
    </copy>
    ```

2. Delete the CephFilesystem:

    ```bash
    <copy>
    kubectl delete cephfilesystem myfs -n rook-ceph
    </copy>
    ```

3. Wait for MDS pods to terminate:

    ```bash
    <copy>
    kubectl wait --for=delete pod -l app=rook-ceph-mds -n rook-ceph --timeout=120s
    </copy>
    ```

4. Delete the CephBlockPool:

    ```bash
    <copy>
    kubectl delete cephblockpool replicapool -n rook-ceph
    </copy>
    ```

5. Delete the storage classes:

    ```bash
    <copy>
    kubectl delete storageclass rook-ceph-block rook-cephfs rook-ceph-bucket
    </copy>
    ```

6. Verify storage classes are removed:

    ```bash
    <copy>
    kubectl get storageclass | grep rook
    </copy>
    ```

   This should return no results.

## Task 3: Delete Rook Toolbox

Remove the Rook toolbox deployment:

```bash
<copy>
kubectl delete deployment rook-ceph-tools -n rook-ceph
</copy>
```

## Task 4: Destroy Infrastructure Using Resource Manager

1. Navigate to **Developer Services** → **Resource Manager** → **Stacks**

2. Click on your stack (e.g., `rook-on-oke-stack`)

3. Click **Destroy**

4. Review the resources to be destroyed

5. Click **Destroy** to confirm

6. Monitor the job progress:
   - The job will delete all Terraform-managed resources
   - This includes the OKE cluster, node pools, VCN, and block volumes
   - Wait for the job status to show **Succeeded**

7. Optionally, delete the stack:
   - After the destroy job completes, click **More Actions** → **Delete Stack**
   - Confirm deletion

### Check for Remaining OKE Clusters

1. Navigate to **Developer Services** → **Kubernetes Clusters (OKE)**
2. Delete any remaining clusters from this workshop

### Check for Block Volumes

1. Navigate to **Storage** → **Block Volumes**
2. Check for volumes with names containing `rook` or your workshop prefix
3. Delete any orphaned volumes

### Check for VCN

1. Navigate to **Networking** → **Virtual Cloud Networks**
2. Look for VCNs created for this workshop
3. Delete associated resources (subnets, route tables, security lists) first
4. Then delete the VCN

### Check for Load Balancers

1. Navigate to **Networking** → **Load Balancers**
2. Delete any load balancers created by Kubernetes services

## Task  5: Verify Complete Cleanup

Perform a final verification:

1. **OKE Clusters:**

    ```bash
    <copy>
    oci ce cluster list --compartment-id <your-compartment-ocid> --all
    </copy>
    ```

2. **Block Volumes:**

    ```bash
    <copy>
    oci bv volume list --compartment-id <your-compartment-ocid> --all | grep -i rook
    </copy>
    ```

3. **VCNs:**

    ```bash
    <copy>
    oci network vcn list --compartment-id <your-compartment-ocid> --all
    </copy>
    ```

All commands should show no resources related to this workshop.

## Summary

Congratulations! You have successfully:

- Deployed an OKE cluster with Rook-Ceph storage
- Configured block, file, and object storage classes
- Deployed sample applications using Ceph storage
- Cleaned up all workshop resources

## Learn More

- [Rook Production Best Practices](https://rook.io/docs/rook/latest/Troubleshooting/disaster-recovery/)
- [Ceph Operations Guide](https://docs.ceph.com/en/latest/rados/operations/)
- [OKE Best Practices](https://docs.oracle.com/en-us/iaas/Content/ContEng/Concepts/contengbestpractices.htm)
- [GitHub Repository](https://github.com/dranicu/rook-on-oke)

## Acknowledgements

* **Author** - Dragos Nicu, Cloud Infrastructure Engineer
* **Last Updated By/Date** - Dragos Nicu, January 2026
