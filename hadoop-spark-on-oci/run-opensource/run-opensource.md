# Connect and Run the Demos (Open Source)

## Introduction

In this lab, you will connect to the private **operator** host through the OCI Bastion, confirm the platform finished installing, and run the three Open Source-track demos. Each demo submits a `SparkApplication` through the Spark Operator, waits for it to finish, and prints `PROOF:` / `RESULT:` evidence from the driver log.

Estimated Time: 30 minutes

### Objectives

In this lab, you will:

- Connect to the operator with the one-command Bastion helper
- Verify the platform is installed and healthy
- Run **Spark-only** on Kubernetes (Demo 01)
- Run **HDFS + Spark** with Kerberos (Demo 02)
- Run **Object Storage + Spark** over `oci://` with Workload Identity (Demo 03)

### Prerequisites

This lab assumes you have:

- Completed the deploy lab; the apply reached **Succeeded**
- Your stack outputs (`operator_access`, `bastion_id`, `operator_private_ip`, `namespace`)
- Your SSH **private** key at `~/.ssh/id_rsa` and the OCI CLI installed locally

## Task 1: Connect to the Operator

The operator sits inside the VCN with `kubectl`, `helm`, and a working kubeconfig, and the demos are staged on it at `~/use-cases`. Reach it through the Bastion with the bundled helper script (the `operator_access` output prints it filled in).

1. From the stack directory on your workstation, run the helper — it creates a port-forwarding Bastion session, waits for it to become active, and drops you into a shell on the operator:

    ```bash
    <copy>
    ./scripts/connect-operator.sh -b <bastion_id> -i <operator_private_ip>
    </copy>
    ```

   - Add `-k ~/.ssh/id_rsa` if your key isn't the default.
   - The session is deleted automatically when you exit.
   - Alternatively, just run `./scripts/connect-operator.sh` from the stack directory and it reads the Terraform outputs itself.

## Task 2: Wait for the Platform to Finish Installing

The operator installs HDFS, the KDC, and the Spark Operator asynchronously after apply. Confirm it's done before running the demos.

1. On the operator, wait for cloud-init to complete:

    ```bash
    <copy>
    cloud-init status --wait
    </copy>
    ```

2. Check the platform pods are Running (namespace = your cluster name):

    ```bash
    <copy>
    kubectl -n bigdata get pods
    </copy>
    ```

    You should see the `spark-operator`, and (if enabled) `namenode-0`, the `datanode-*` pods, and `kdc-0`, all `Running`/`Ready`.

3. Move into the staged demos:

    ```bash
    <copy>
    cd ~/use-cases
    </copy>
    ```

   > All demos take `NS` (the namespace = your `cluster_name`). Set it once per command, e.g. `NS=bigdata ./01-spark-only/run.sh`. A non-zero exit prints `[FAIL] …` and the driver log.

## Task 3: Demo 01 — Spark on Kubernetes

Prove Spark-on-Kubernetes works with no external storage: the Spark Operator schedules a driver + executors that generate data and run a distributed aggregation.

1. Run it:

    ```bash
    <copy>
    NS=bigdata ./01-spark-only/run.sh
    </copy>
    ```

    The script submits a `spark-only-demo` SparkApplication, waits for completion, and prints the proof from the driver log.


2. (Optional) Clean up just this demo:

    ```bash
    <copy>
    kubectl -n bigdata delete sparkapplication spark-only-demo configmap spark-only-demo-code
    </copy>
    ```

## Task 4: Demo 02 — HDFS + Spark with Kerberos

Prove the secured data path: authenticate to the KDC and write/read data in Kerberos-secured HDFS, then run a Spark job that reads HDFS with a keytab, aggregates, and writes back.

   > Requires **Deploy HDFS** and **Deploy Spark** at deploy time. The `SPARK_IMAGE` must include PySpark (the default `apache/spark:3.5.x` does).

1. Run it:

    ```bash
    <copy>
    NS=bigdata ./02-hdfs-spark/run.sh
    </copy>
    ```

   - **Part A** (core proof) generates a synthetic CSV, `kinit`s as the `hadoop@<realm>` principal, and writes/reads it in HDFS directly from the NameNode pod.
   - **Part B** (integration) exports a keytab, submits a Spark job that reads from HDFS with `spark.kerberos.keytab`, aggregates, and writes results back to HDFS. The script then prints the output listing.

   > Part B wires Kerberos into the Spark pods — a real production pattern that can be image-sensitive. If Part B needs tuning for your image, Part A still proves the secured HDFS data path.

## Task 5: Demo 03 — Object Storage + Spark (Workload Identity)

Prove the object-store round-trip: a Spark job generates data, writes it to the OCI Object Storage bucket over `oci://`, reads it back, aggregates, and writes results — authenticating with **OKE Workload Identity**, no API keys.

   > Requires **Deploy OCI Object Storage** and **Deploy Spark**. The job pulls the `oci-hdfs-connector` from Maven Central via `--packages`, which needs internet egress (available through the NAT gateway).

1. Set the Object Storage namespace and region, then run (the namespace is the `<OS_NAMESPACE>` from the `object_storage_path` output):

    ```bash
    <copy>
    NS=bigdata REGION=<your-region> OS_NAMESPACE=<your-os-namespace> ./03-objstore-spark/run.sh
    </copy>
    ```

   The script auto-detects the Object Storage namespace when it can; set `OS_NAMESPACE` explicitly if it can't. It submits `objstore-spark-demo`, waits, and prints the proof.

   > The connector **version** (`CONNECTOR_VERSION`) and **authenticator class** (`AUTHENTICATOR`) are version-sensitive; override them if your connector differs. The namespace ships a default-deny-egress NetworkPolicy that is inert until Calico is installed — if you installed Calico, allow Maven egress or pre-bake the connector into a custom image.

You have now proven Spark on Kubernetes, secured HDFS + Spark, and the Object Storage round-trip.

You may now **proceed to the next lab** to clean up.

## Learn More

- [Apache Spark on Kubernetes](https://spark.apache.org/docs/latest/running-on-kubernetes.html)
- [Hadoop in Secure Mode (Kerberos)](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SecureMode.html)
- [HDFS Connector for Object Storage](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/hdfsconnector.htm)

## Acknowledgements

* **Author** - Dragos Nicu, Cloud Infrastructure Engineer
* **Last Updated By/Date** - Dragos Nicu, July 2026
