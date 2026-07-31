# Cleanup

## Introduction

In this lab, you will remove everything you created. The clusters, operator, Bastion, and (for the Native track) the Big Data Service nodes and any Data Flow warm pool all bill continuously while they exist, so tear them down when you're done. Because both tracks were deployed with a Resource Manager stack, the reliable way to remove everything is to **destroy the stack** — after emptying the state Terraform doesn't track.

Estimated Time: 15 minutes

### Objectives

In this lab, you will:

- Empty the resources Terraform doesn't manage (buckets, warm pool, Spark jobs)
- Destroy the Resource Manager stack
- Verify no billable resources remain

### Prerequisites

This lab assumes you have:

- Completed one or both tracks
- Access to the OCI Console (Resource Manager)

## Task 1: Empty Untracked State (Before Destroying)

`terraform destroy` can fail if buckets are non-empty or a warm pool is still running, because those hold state Terraform didn't create. Run the pre-cleanup for the track you deployed **first**.

### If you ran the Native track

The stack tries to clean this up automatically on destroy, but that relies on the destroy host having OCI CLI auth (not guaranteed on a Resource Manager runner). The reliable path is to empty things from the **operator**, which always has instance-principal auth. Connect to the operator (see the native run lab), then:

```bash
<copy>
./use-cases/cleanup.sh
</copy>
```

This stops the Data Flow warm pool and empties the scripts / logs / warehouse buckets (uploaded scripts, run logs, job output).

### If you ran the Open Source track

The demos leave `SparkApplication` objects and, for Demo 03, objects in the data-lake bucket. From the operator (see the open source run lab):

```bash
<copy>
# Remove any demo Spark applications and their code ConfigMaps
kubectl -n bigdata delete sparkapplication --all
kubectl -n bigdata get configmap -o name | grep -- -code | xargs -r kubectl -n bigdata delete

# Empty the data-lake bucket so the stack can delete it (instance principal auth)
OCI_CLI_AUTH=instance_principal oci os object bulk-delete -bn bigdata-data --force || true
</copy>
```

(Replace `bigdata` with your `cluster_name` if you changed it.)

## Task 2: Destroy the Stack

1. In the OCI Console, go to **Developer Services** → **Resource Manager** → **Stacks**.

2. Open your stack (`hadoop-spark-native` or `hadoop-spark-opensource`).

3. Click **Destroy**, review the resources to be removed, and confirm.

4. Monitor the destroy job:
    - It removes the OKE / Big Data Service cluster, node pools/nodes, Data Flow apps and pool, operator, Bastion, buckets, VCN, and IAM resources.
    - For the Native track this includes the ~30-minute BDS teardown. Wait for the job to reach **Succeeded**.

5. (Optional) After the destroy completes, delete the stack itself: **More actions** → **Delete stack**.

## Task 3: Verify Complete Cleanup

Confirm nothing billable is left behind. In the OCI Console (or with the CLI), check each area for resources with your prefix / cluster name:

1. **Compute → Instances** — the operator and any BDS/OKE nodes should be gone.

    ```bash
    <copy>
    oci compute instance list --compartment-id <compartment-ocid> --all \
      --query 'data[?contains("display-name", `bigdata`)].{name:"display-name",state:"lifecycle-state"}'
    </copy>
    ```

2. **Analytics & AI → Data Flow** (Native) — no leftover applications or pool.

3. **Analytics & AI → Big Data Service** (Native) / **Developer Services → Kubernetes Clusters (OKE)** (Open Source) — no clusters remain.

4. **Storage → Buckets** — the scripts / logs / warehouse / data-lake buckets are gone.

5. **Networking → Virtual Cloud Networks** and **Identity → Bastion** — the VCN and Bastion are gone.

6. **Identity & Security → Dynamic Groups / Policies** — remove any tenancy-level dynamic groups or policies the stack created if the destroy left them behind (they carry your prefix and a random suffix).

## Summary

Congratulations! You have:

- Deployed a complete Hadoop & Spark platform on OCI from a single Resource Manager stack
- Connected to a private operator host through the OCI Bastion
- Run real Spark workloads — serverless ETL, cluster analytics, low-latency jobs, secured HDFS, and Object Storage round-trips
- Torn everything down cleanly

## Learn More

- [OCI Resource Manager — Destroying Stacks](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Tasks/destroy-job.htm)
- [OCI Big Data Service — Managing Clusters](https://docs.oracle.com/en-us/iaas/Content/bigdata/manage-cluster.htm)
- [OCI Cost Management](https://docs.oracle.com/en-us/iaas/Content/Billing/Concepts/costanalysisoverview.htm)

## Acknowledgements

* **Author** - Dragos Nicu, Cloud Infrastructure Engineer
* **Last Updated By/Date** - Dragos Nicu, July 2026
