# Deploy Secure Hadoop & Spark on OKE (Open Source)

## Introduction

In this lab, you will deploy the **Open Source track** stack with OCI Resource Manager. The stack provisions a security-hardened **Oracle Kubernetes Engine (OKE)** cluster and installs an open-source big-data platform on it: **Apache Hadoop (HDFS)** as Kerberos-secured StatefulSets, an in-cluster **MIT Kerberos KDC**, the **Apache Spark Operator**, and an optional **OCI Object Storage** data lake wired to Spark through **Workload Identity**. A private **operator** host installs the platform via cloud-init and is where you run the demos.

Estimated Time: 30 minutes

### Objectives

In this lab, you will:

- Obtain the Terraform stack and create it in OCI Resource Manager
- Configure the OKE cluster, storage backends, and Spark options
- Run **Plan** and **Apply** to provision the platform
- Review the stack outputs you'll use to connect and run jobs

### Prerequisites

This lab assumes you have:

- Completed the Prerequisites lab (SSH key, public IP, IAM permissions)
- Your SSH **public** key and your workstation's public IP (`x.x.x.x/32`) ready

### How the deployment works

Because the Kubernetes API endpoint is not reachable from the Resource Manager runner, a small **operator** VM inside the VCN performs the in-cluster installation using its instance principal (cluster-admin). The `terraform apply` completes once the operator exists; the platform (HDFS, KDC, Spark Operator, NetworkPolicies) then installs **asynchronously** on the operator via cloud-init. You'll wait for that to finish in the next lab.

## Task 1: Get the Terraform Stack

The stack ships as a release asset on the [automation-hub releases page](https://github.com/dranicu/oci-automation-hub/releases). The release archive bundles both tracks (`native/` and `opensource/`), and Resource Manager creates a stack from a `.zip` with the Terraform files **at its root**, so you unpack the release and re-zip just the `opensource` folder.

1. Download the release archive, then zip the `opensource` folder so its Terraform is at the zip root:

    ```bash
    <copy>
    cd ~
    curl -L -o hadoop-spark-oci-sample.zip https://github.com/dranicu/oci-automation-hub/releases/download/hadoop-spark-oci-sample/hadoop-spark-oci-sample.zip
    unzip -q hadoop-spark-oci-sample.zip
    cd hadoop-spark-oci-sample/opensource
    zip -r ~/hadoop-spark-opensource.zip . -x '.terraform/*' '*.tfstate*' '.git/*'
    echo "Stack zip created at: ~/hadoop-spark-opensource.zip"
    </copy>
    ```

   You now have `~/hadoop-spark-opensource.zip` ready to upload.

## Task 2: Create the Stack in Resource Manager

1. In the OCI Console, go to **Developer Services** → **Resource Manager** → **Stacks**.

2. Select your compartment and click **Create stack**.

3. Under **Origin of the Terraform configuration**, select **My configuration** → **.Zip file**, and upload `~/hadoop-spark-opensource.zip`.

    ![Create stack from a zip file](images/create-stack.png)

4. Give the stack a **Name** (e.g. `hadoop-spark-opensource`), confirm the compartment, and click **Next**.

## Task 3: Configure the Deployment

The form is rendered from the stack's `schema.yaml`.

1. **General**
    - **Cluster name**: e.g. `bigdata` (lower-case; becomes the resource prefix **and** the Kubernetes namespace)
    - **Admin CIDR**: your public IP as `x.x.x.x/32` — the only network allowed to reach the Kubernetes API and open Bastion sessions (must not be `0.0.0.0/0`)
    - **SSH public key**: paste the contents of `~/.ssh/id_rsa.pub`

2. **OKE cluster**
    - **Kubernetes version**: use the full `vMAJOR.MINOR.PATCH` form (e.g. `v1.35.2`). A partial version like `v1.36` has no matching worker image.
    - **Public (NSG-locked) API endpoint**: leave **on**. The endpoint is public but restricted to your Admin CIDR, which lets the platform install in one run. Turn off for a fully private endpoint reached only via Bastion.

3. **Worker node pool** — accept the defaults (3 × `VM.Standard.E5.Flex`, 4 OCPU / 64 GB), or size to your budget.

4. **Storage backends** — choose what Spark can read/write. You can enable either or both:
    - **Deploy HDFS**: Kerberos-secured HDFS (NameNode + DataNodes) on the cluster
    - **Deploy OCI Object Storage**: a private bucket as a data lake, wired to Spark via Workload Identity

    To run all three demos in the next lab, keep **both** enabled.

5. **Spark** — leave **Deploy Apache Spark (Spark Operator)** checked.

6. **Container images** — leave **Container image source** = `upstream` (public Apache images) for a one-click deployment. Choose `ocir` only if you have your own hardened images in OCI Registry.


7. Click **Next**, review, and click **Create**.

## Task 4: Run Plan and Apply

1. On the stack detail page, click **Plan** and wait for **Succeeded**. Review the planned resources.

2. Click **Apply** and monitor the job. The apply provisions the VCN, OKE cluster, private node pool, Bastion, IAM, and the operator VM. It completes in roughly 15–20 minutes.


   > The apply finishing does **not** mean the platform is ready. The operator installs HDFS, the KDC, and the Spark Operator asynchronously — you'll wait for cloud-init to finish in the next lab.

## Task 5: Review the Outputs

1. Open the stack's **Application information** tab (or the job's **Outputs**). Note these values:

    | Output | What it's for |
    |--------|---------------|
    | `operator_access` | A ready-to-run `./scripts/connect-operator.sh -b ... -i ...` command |
    | `bastion_id` | The OCI Bastion you connect through |
    | `operator_private_ip` | The operator host's private IP |
    | `namespace` | The Kubernetes namespace the platform runs in (= your cluster name) |
    | `hdfs_url` | HDFS default filesystem (`fs.defaultFS`), if HDFS is deployed |
    | `kdc_host` | In-cluster DNS name of the Kerberos KDC |
    | `object_storage_bucket` / `object_storage_path` | Data-lake bucket and its `oci://` path, if deployed |
    | `spark_smoke_test` | A command to run the SparkPi example |
    | `cluster_summary` | Human-readable summary of everything deployed |


You may now **proceed to the next lab** to connect to the operator and run the demos.

## Troubleshooting

- **Apply fails on IAM**: your user can't create tenancy-level dynamic groups/policies. Have an administrator grant `manage dynamic-groups`/`manage policies` in the tenancy, or pre-create them.
- **No matching worker image**: you entered a partial or preview Kubernetes version. Use a full GA version like `v1.35.2`. List valid versions with `oci ce cluster-options get --cluster-option-id all`.
- **Admin CIDR rejected**: use your exact IP as `/32` (find it with `curl ifconfig.me`), not `0.0.0.0/0`.

## Learn More

- [OCI Container Engine for Kubernetes (OKE)](https://docs.oracle.com/en-us/iaas/Content/ContEng/home.htm)
- [Kubeflow Spark Operator](https://www.kubeflow.org/docs/components/spark-operator/)
- [OKE Workload Identity](https://docs.oracle.com/en-us/iaas/Content/ContEng/Tasks/contenggrantingworkloadaccesstoresources.htm)

## Acknowledgements

* **Author** - Dragos Nicu, Cloud Infrastructure Engineer
* **Last Updated By/Date** - Dragos Nicu, July 2026
