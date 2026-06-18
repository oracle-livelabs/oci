# Introduction

## About this Workshop

Apache Iceberg is an open table format for large analytic tables. This workshop shows a practical migration pattern for moving an existing Iceberg table into OCI Object Storage and registering it so Spark can query it from OCI.

The automation uses a simulated AWS S3 source so you can run the complete flow without external AWS credentials. A helper script creates a real Iceberg table with Spark and MinIO, exports the generated `data/` and `metadata/` files, copies those files to OCI Object Storage, registers the copied table in an Iceberg JDBC catalog, and validates the result.

Estimated Workshop Time: 2 hours

### Objectives

By the end of this workshop, you will:

* Provision an OCI compute VM and Object Storage bucket with Terraform.
* Generate a real source Iceberg table using the provided VM script.
* Copy the Iceberg table files into OCI Object Storage.
* Register the copied table in an Iceberg JDBC catalog.
* Validate the migrated table with Spark and optionally Trino.
* Clean up the Terraform-managed OCI resources.

### Prerequisites

This workshop assumes you have:

* An Oracle Cloud account.
* Access to an OCI tenancy and compartment where you can create networking, compute, and Object Storage resources.
* Terraform installed on your local workstation.
* OCI API key credentials configured for Terraform.
* An SSH key pair for connecting to the compute VM.
* Permission to create customer secret keys for OCI Object Storage S3-compatible access.

### Architecture

The lab follows this flow:

```text
MinIO simulated AWS S3 -> real Iceberg table files  -> OCI Object Storage -> Iceberg JDBC catalog backed by PostgreSQL -> Spark validation -> optional Trino validation
```

The automation provisions the VM and installs Docker, Spark, PostgreSQL, Hive Metastore, OCI CLI, AWS CLI, and helper scripts under `/opt/iceberg`.

### Learn More

* [Oracle Cloud Infrastructure Documentation](https://docs.oracle.com/en-us/iaas/Content/home.htm)
* [OCI Object Storage Documentation](https://docs.oracle.com/en-us/iaas/Content/Object/home.htm)
* [Apache Iceberg Documentation](https://iceberg.apache.org/docs/latest/)
* [Terraform OCI Provider Documentation](https://registry.terraform.io/providers/oracle/oci/latest/docs)

You may now proceed to the next lab.

## Acknowledgements

* **Author** - Adina Nicolescu, Principal Cloud Architect, NACIE
* **Last Updated By/Date** - Adina Nicolescu, June 2026
