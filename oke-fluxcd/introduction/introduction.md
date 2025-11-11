# Introduction

## About this Workshop

FluxCD is a GitOps tool designed to automate the deployment and lifecycle management of Kubernetes applications. It continuously monitors a Git repository for configuration changes and ensures that the cluster state matches the desired state defined in that repository. By doing so, FluxCD brings version-controlled, declarative infrastructure and application management to Kubernetes environments, providing consistency, traceability, and easy rollback capabilities. It supports Helm, Kustomize, and plain YAML manifests, enabling flexible deployment workflows.

In Oracle Kubernetes Engine (OKE), FluxCD integrates seamlessly by connecting to a Git repository containing your OKE manifests or Helm charts and automatically applying updates to the cluster whenever changes are committed. It can manage both system components (like monitoring or networking add-ons) and application workloads across namespaces.

Estimated Workshop Time: 1 hour

### **Objectives**

By the end of this workshop, you will:

* Deploy an OKE cluster
* Use FluxCD to deploy pods in OKE cluster.

### **Prerequisites**

This lab assumes you have:

* An Oracle Cloud account
* Administrator privileges or access rights to the OCI tenancy
* Basic Kubernetes knowledge (kubectl, Helm, manifests).
* Local setup with:
    - kubectl
    - helm
    - oci CLI configured

### Learn More

* [FluxCD Documentation](https://fluxcd.io/flux)
* [Overview of Kubernetes Engine](https://docs.oracle.com/en-us/iaas/Content/ContEng/Concepts/contengoverview.htm)
* [Oracle Cloud Infrastructure](https://docs.oracle.com/en-us/iaas/Content/home.htm)

You may now proceed to the next lab.

## Task

## Acknowledgements

**Authors**

* **Cristian Vlad**, Principal Cloud Engineer, NACIE
* Last Updated By/Date - Cristian Vlad, October 2025