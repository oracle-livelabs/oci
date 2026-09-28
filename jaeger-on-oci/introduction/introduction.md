# Introduction

## About this Workshop

Jaeger is an open-source distributed tracing platform originally created by Uber and now part of the Cloud Native Computing Foundation (CNCF). It helps you monitor and troubleshoot requests as they move across services, making it easier to understand latency, dependencies, and failures in distributed applications.

In this workshop, you will deploy Jaeger on an Oracle Cloud Infrastructure (OCI) Compute virtual machine and use the HotROD demo application to generate sample traces. The environment is provisioned with Terraform from a terminal, so you can inspect the infrastructure automation and then use the Jaeger UI to explore real trace data.

Estimated Workshop Time: 1 hour

### Objectives

By the end of this workshop, you will:

* Provision OCI networking and a compute VM using Terraform.
* Deploy Jaeger and the HotROD sample application on the VM.
* Access the Jaeger UI and HotROD demo from your browser.
* Generate sample distributed traces from HotROD.
* Search for traces by service and inspect spans, timings, dependencies, and errors.
* Clean up the OCI resources using Terraform.

### Prerequisites

This lab assumes you have:

* An Oracle Cloud account.
* Administrator privileges or sufficient access rights to create and manage OCI networking and compute resources.
* Basic understanding of Terraform and cloud compute concepts.
* Access to a command-line environment such as **OCI Cloud Shell** or a local terminal with:
  - `terraform`
  - `oci` CLI configured for your tenancy
  - an SSH key pair available for connecting to the compute instance

### Learn More

* [Jaeger Documentation](https://www.jaegertracing.io/docs/)
* [Jaeger Getting Started](https://www.jaegertracing.io/docs/latest/getting-started/)
* [OpenTelemetry Documentation](https://opentelemetry.io/docs/)
* [Oracle Cloud Infrastructure Compute](https://docs.oracle.com/en-us/iaas/Content/Compute/home.htm)
* [Oracle Cloud Infrastructure](https://docs.oracle.com/en-us/iaas/Content/home.htm)

You may now **proceed to the next lab**.

## Acknowledgements

**Authors**

* **Adina Nicolescu**, Principal Cloud Architect, NACIE
* Last Updated - Adina Nicolescu, July 2026
