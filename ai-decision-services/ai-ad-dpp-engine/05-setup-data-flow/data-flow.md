Lab 5: Configure OCI DataFlow
===

OCI Data Flow is a cloud based serverless Apache Spark Service (PaaS). This workshop will mainly rely on Data Flow to pre-process data and execute post processing steps.

The DPF Driver is essentially an Apache Spark *Application* which runs the data transformations on individual OCI Data Flow *Executor* nodes. Users can choose the appropriate shape (VM) for the driver and executor nodes based on data size. Increasing the number of *Executors* will speed up the processing for large data sets. For small data sets such as the ones used in this workshop, most of the options can be left at their default values.

Refer to the screenshot below and update values accordingly.

![](./images/Set-DF1.png)
![](./images/Set-DF2.png)

*   For the **Language** section, choose **Python**.
*   Select df_driver.py from the driver bucket.
*   For **Arguments**, simply input `--response ${response} --phase ${phase}`, and enter **placeholder** as the default value. This will be overriden later
*   For **Archive URI**, enter the fully qualified path to archive.zip in Object Storage. The structure of path is `oci://<bucket-name>@<namespace>/<path-to-archive.zip>`. Same below.
*   For **Application log location**, enter the path to logs-bucket. This is very useful for debugging failed application runs.

## Useful Resources
Refer to the documentation (links below) to learn more about OCI Data Flow and Apache Spark

- [Apache Spark 3.3.0](https://spark.apache.org/docs/latest/)
- [OCI Data Flow](https://docs.oracle.com/en-us/iaas/data-flow/using/dfs_getting_started.htm)
