# Connect and Run the Use Cases (Native)

## Introduction

In this lab, you will connect to the private **operator** host through the OCI Bastion and run the four Native-track use cases. The operator already has the sample jobs staged on it and authenticates to OCI with an instance principal, so you submit real Spark workloads without managing any keys on the box.

Estimated Time: 30 minutes

### Objectives

In this lab, you will:

- Open an OCI Bastion session and SSH into the operator (with agent forwarding)
- Run **Serverless ETL** with OCI Data Flow (Use case 01)
- Run **Hadoop cluster analytics** with `spark-submit` on YARN + HDFS (Use case 02)
- Run **Warm-pool low-latency** repeated jobs (Use case 03)
- Review the **Secure HA production** shape (Use case 04)

### Prerequisites

This lab assumes you have:

- Completed the deploy lab; the apply reached **Succeeded** and the BDS cluster is **ACTIVE**
- Your stack outputs (`operator_bastion_session_hint`, `operator_private_ip`, `bastion_id`)
- Your SSH **private** key at `~/.ssh/id_rsa` (matching the public key you deployed)

## Task 1: Load Your Key into the ssh-agent

Use cases **02** and **04** run `spark-submit` **on a Big Data Service node**, and the operator reaches those nodes using **your** key via **SSH agent forwarding** — never a private key stored on the operator. Agent forwarding forwards your **ssh-agent**, not the `-i` key, so the key must be loaded into the agent **before** you connect.

1. On your **workstation**, add your key to the agent and confirm it's listed:

    ```bash
    <copy>
    ssh-add ~/.ssh/id_rsa
    ssh-add -l
    </copy>
    ```

   - No agent running? Start one first: `eval "$(ssh-agent -s)"`, then `ssh-add`.
   - macOS: `ssh-add --apple-use-keychain ~/.ssh/id_rsa`.

   > **This is the #1 gotcha.** If you connect with `-A` but the agent is empty, you'll still log in to the operator, but the hop to the BDS nodes fails with `Permission denied (publickey)`. Use cases 01 and 03 (Data Flow) work without agent forwarding.

## Task 2: Open a Bastion Session and Connect to the Operator

The operator has **no public IP** — you reach it only through the managed Bastion, as a two-hop SSH: your workstation → Bastion → operator.

1. Get the ready-made session command from the stack outputs. Either copy `operator_bastion_session_hint` from the Console, or run (from the stack directory, if you have the CLI):

    ```bash
    <copy>
    oci bastion session create-managed-ssh \
      --bastion-id <bastion_id> \
      --target-resource-id <operator_instance_id> \
      --target-os-username opc \
      --target-private-ip <operator_private_ip> \
      --ssh-public-key-file ~/.ssh/id_rsa.pub \
      --session-ttl 10800 --wait-for-state SUCCEEDED
    </copy>
    ```

2. From the session details, copy the **SSH command** OCI provides, or connect **with `-A`** (agent forwarding). Use the session OCID as the ProxyCommand user:

    ```bash
    <copy>
    ssh -A \
      -o ProxyCommand="ssh -i ~/.ssh/id_rsa -W %h:%p -p 22 <SESSION_OCID>@host.bastion.<region>.oci.oraclecloud.com" \
      -i ~/.ssh/id_rsa opc@<OPERATOR_PRIVATE_IP>
    </copy>
    ```

3. Once on the operator, confirm your forwarded agent carries the key — this is what makes the BDS use cases work:

    ```bash
    <copy>
    ssh-add -l
    </copy>
    ```

    It should list the **same** key as on your workstation. If it says *"no identities"* or *"Could not open a connection to your authentication agent"*, go back to Task 1 on your workstation and reconnect with `-A`.

4. See what the stack deployed:

    ```bash
    <copy>
    cd use-cases
    cat deployment.env
    </copy>
    ```

   Each use-case script self-checks this descriptor first, so if a use case can't run on your configuration, the script tells you exactly which Resource Manager field to change instead of failing obscurely.

## Task 3: Use Case 01 — Serverless ETL with Data Flow

Read raw CSV from Object Storage, clean and partition it, and write Parquet to the warehouse bucket — **without standing up a single server**. You pay only for the seconds the job runs.

1. Run it on the operator:

    ```bash
    <copy>
    ./01-serverless-etl/run.sh
    </copy>
    ```

    The script uploads `customers_etl.py` and `sample_customers.csv`, ensures a Data Flow application `<prefix>-customers-etl` exists, and submits a run. It prints the **run OCID**.

2. Track the run to `SUCCEEDED` (usually 1–2 minutes cold):

    ```bash
    <copy>
    oci data-flow run get --run-id <run-ocid> --query 'data."lifecycle-state"'
    </copy>
    ```

3. Inspect the output — the 10-row sample is cleaned to **8 rows** and written as Parquet partitioned by country:

    ```bash
    <copy>
    oci os object list -bn <prefix>-dataflow-warehouse --prefix customers_clean/
    </copy>
    ```

   You can also watch the run and its driver logs in the Console under **Analytics & AI** → **Data Flow** → **Runs**.

## Task 4: Use Case 02 — Analytics on a Managed Hadoop Cluster

Run a Spark job with `spark-submit` against **YARN**, reading from and writing to **HDFS** on the managed Big Data Service cluster.

1. Make sure you connected to the operator **with `-A`** (Task 2) so your key reaches the BDS nodes. Then run:

    ```bash
    <copy>
    ./02-hadoop-cluster-analytics/submit.sh
    </copy>
    ```

    `submit.sh` does **not** run the job for you (Spark must run on a BDS node). It resolves the cluster's utility/master node IPs and prints the exact `scp` / `ssh` / `spark-submit` commands to run. If the cluster is still provisioning, it prints each cluster's state instead — wait for `ACTIVE` and retry.

2. Follow the printed commands. They copy the job and data to a node, load the CSV into HDFS, and submit on YARN in cluster mode. For a **non-secure** cluster they look like:

    ```bash
    <copy>
    scp ./02-hadoop-cluster-analytics/sales_report.py ./02-hadoop-cluster-analytics/sales.csv opc@<node-ip>:/home/opc/
    ssh opc@<node-ip> '
      hdfs dfs -mkdir -p /user/opc/sales &&
      hdfs dfs -put -f /home/opc/sales.csv /user/opc/sales/ &&
      spark-submit --master yarn --deploy-mode cluster \
        --num-executors 3 --executor-cores 4 --executor-memory 8g \
        /home/opc/sales_report.py \
        hdfs:///user/opc/sales/sales.csv hdfs:///user/opc/sales_report
    '
    </copy>
    ```

3. Read the report back from HDFS — revenue by region and product category, with each segment's share of total revenue:

    ```bash
    <copy>
    ssh opc@<node-ip> 'hdfs dfs -cat /user/opc/sales_report/part-*.csv'
    </copy>
    ```

   > **Secure clusters:** if you deployed with **Secure cluster = on** (the use case 04 shape), HDFS/YARN reject any command without a Kerberos ticket. `submit.sh` detects this and prints a `kinit`-first version of the steps. Web UIs (Ambari, Hue, YARN RM on port 8088, Spark History) are served from the utility node — tunnel to them over SSH.

## Task 5: Use Case 03 — Low-Latency Repeated Jobs (Warm Pool)

Run the same Spark job repeatedly without paying the cold-start tax. A Data Flow **warm pool** keeps executors hot so each run starts in **seconds**.

   > This use case is best with **Create a Data Flow warm pool** enabled at deploy time. The script still runs without a pool — it just warns that runs will cold-start.

1. Submit a run:

    ```bash
    <copy>
    ./03-warm-pool-low-latency/run.sh
    </copy>
    ```

    It stages `hourly_aggregate.py` + `events.csv`, ensures a `<prefix>-hourly-aggregate` application attached to the warm pool, and submits a run that writes a Parquet rollup (`event_count` + `unique_users` per hour per event type).

2. **Submit it back-to-back a few times**, then compare start latencies — subsequent runs land on hot executors:

    ```bash
    <copy>
    oci data-flow run list --compartment-id <compartment-ocid> \
      --query 'data[].{name:"display-name",state:"lifecycle-state",created:"time-created"}'
    </copy>
    ```

   Run use case 01 (no pool) for contrast to feel the cold-start difference.

## Task 6: Use Case 04 — Secure, Highly-Available Production

This is the enterprise shape: a **Kerberized, Ranger-secured, highly-available** cluster with elastic compute-only workers and cluster-wide tuning applied at provisioning via a bootstrap script.

   > To fully exercise this, redeploy the stack with **High availability = on**, **Secure cluster = on**, a **Compute-only worker count** (e.g. 3), and a **Bootstrap script URL** pointing at the `bootstrap.sh` from `04-secure-ha-production/` uploaded to Object Storage. HA and Secure must be enabled together. This is a large, always-billing footprint — size it down and destroy it when done.

1. From the operator (connected with `-A`), run the readiness check — it does not submit a job:

    ```bash
    <copy>
    ./04-secure-ha-production/check.sh
    </copy>
    ```

    `check.sh` confirms the cluster is secure + HA (warning, and naming the form field, if not), prints a table of every node (type / IP / state), and shows the steps to use the Kerberized cluster: SSH in, `kinit` a principal, then `spark-submit`.

2. Confirm the bootstrap tuning landed on a node:

    ```bash
    <copy>
    ssh opc@<utility-ip> 'grep -A3 "stack bootstrap" /etc/spark3/conf/spark-defaults.conf'
    </copy>
    ```

You have now exercised managed serverless Spark, a managed Hadoop cluster, warm-pool low latency, and the secure/HA production shape.

You may now **proceed to the next lab** to clean up.

## Learn More

- [OCI Data Flow — Runs](https://docs.oracle.com/en-us/iaas/data-flow/using/dfs_data_flow_library.htm)
- [OCI Big Data Service — Secure Clusters (Kerberos)](https://docs.oracle.com/en-us/iaas/Content/bigdata/enable-kerberos.htm)
- [OCI Bastion — Managed SSH Sessions](https://docs.oracle.com/en-us/iaas/Content/Bastion/Tasks/managingsessions.htm)

## Acknowledgements

* **Author** - Dragos Nicu, Cloud Infrastructure Engineer
* **Last Updated By/Date** - Dragos Nicu, July 2026
