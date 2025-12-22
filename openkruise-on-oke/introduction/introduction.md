# Introduction

## About this Workshop

OpenKruise is a Kubernetes-based workload automation engine developed by the community and hosted under CNCF. It extends Kubernetes controllers to provide advanced deployment and management capabilities beyond what native Kubernetes workloads (like Deployment, StatefulSet, DaemonSet) can do. By deploying OpenKruise on OKE, you can:
- Optimize rolling updates with minimal disruption.
- Simplify sidecar management.
- Run production-grade, stateful applications with safer upgrades.

Estimated Workshop Time: 1 hour 30 minutes

### **Objectives**

By the end of this workshop, you will:

* Deploy an OKE cluster with OpenKruise installed.
* Use OpenKruise for sidecar injection.
* Perform an in-place update using CloneSet.
* Deploy and manage workloads using the Enhanced StatefulSet.

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

* [OpenKruise Documentation](https://openkruise.io/docs/)
* [Overview of Kubernetes Engine](https://docs.oracle.com/en-us/iaas/Content/ContEng/Concepts/contengoverview.htm)
* [Oracle Cloud Infrastructure](https://docs.oracle.com/en-us/iaas/Content/home.htm)

You may now proceed to the next lab.

### Acknowledgements

**Authors**

* **Dragos Nicu**, Senior Cloud Engineer, NACIE
* Last Updated By/Date - Dragos Nicu, September 2025