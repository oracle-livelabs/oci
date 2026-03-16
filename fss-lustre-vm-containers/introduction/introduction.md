# Introduction

## About this Workshop

This workshop demonstrates how shared file systems on Oracle Cloud Infrastructure (OCI) can be used to reduce container image pull and startup times on virtual machines.

Using OCI File Storage Service (FSS) and OCI Lustre File System, you will deploy an automated environment where previously pulled container image layers located on shared storage can be reused across runs by Podman using additionalimagestores. By comparing cold vs warm container pulls and starts, you will observe the impact of shared image reuse on performance.

The infrastructure is provisioned using Terraform and configured via cloud-init, with all actions performed from the command line.

Estimated Workshop Time: 1 hour 30 minutes

### **Objectives**

By the end of this workshop, you will:

- Deploy an OCI VM and shared file system (FSS and/or Lustre) using Terraform
- Configure the VM to use shared storage with Podman additionalimagestores
- Run container workloads and reuse previously pulled image layers
- Measure and compare cold vs warm container image pulls and startups
- Understand when shared image reuse is effective for large-scale VM deployments

### **Prerequisites**

This lab assumes you have:

- An Oracle Cloud account
- Sufficient privileges to manage OCI compute, networking, and storage resources
- Basic familiarity with Linux and container concepts
- Access to a command-line environment (local terminal or OCI Cloud Shell) with:
  - terraform
  - OCI CLI configured for your tenancy
  - SSH access to the VM

### Learn More

* [OCI File Storage Service](https://docs.oracle.com/en-us/iaas/Content/File/Concepts/filestorageoverview.htm)
* [OCI Lustre File System](https://docs.oracle.com/en-us/iaas/Content/lustre/home.htm)
* [Podman Documentation](https://podman.io/docs)

You may now **proceed to the next lab**.

## Acknowledgements

**Authors**

* **Adina Nicolescu**, Principal Cloud Architect, NACIE
* Last Updated - Adina Nicolescu, March 2026