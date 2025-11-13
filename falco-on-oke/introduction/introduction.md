# Introduction

## About this Workshop

Falco is a Kubernetes-native runtime security tool developed by the open-source community and hosted under the CNCF. It continuously monitors system calls and Kubernetes audit logs to detect unexpected behavior, configuration changes, or potential threats in real time. By deploying Falco on OKE, you can:
- Enhance runtime security through behavioral detection.
- Identify and alert on anomalous container or node activities.
- Strengthen compliance and auditing with real-time event monitoring.

Estimated Workshop Time: 1 hour 30 minutes

### **Objectives**

By the end of this workshop, you will:

* Deploy an OKE cluster with Falco and Falco Sidekick using Terraform and Helm.
* Understand how Falco monitors system calls and Kubernetes events for suspicious activity.
* Simulate anomalous container behaviors to trigger Falco alerts.
* Visualize and analyze Falco security events through Falco Sidekick’s web UI.

### **Prerequisites**

This lab assumes you have:

* An Oracle Cloud account.
* Administrator privileges or sufficient access rights to create and manage OKE resources.
* Basic understanding of Kubernetes concepts (pods, Helm charts, namespaces).
* Access to a command-line environment such as **OCI Cloud Shell** (or a local setup) with:
  - `kubectl`
  - `helm`
  - `oci` CLI configured for your tenancy.

### Learn More

* [Falco Documentation](https://falco.org/)
* [Overview of Kubernetes Engine](https://docs.oracle.com/en-us/iaas/Content/ContEng/Concepts/contengoverview.htm)
* [Oracle Cloud Infrastructure](https://docs.oracle.com/en-us/iaas/Content/home.htm)

You may now proceed to the next lab.

## Acknowledgements

**Authors**

* **Adina Nicolescu**, Principal Cloud Architect, NACIE
* Last Updated - Adina Nicolescu, November 2025