# Introduction

## **What is OKE and Agones?**

### OKE Intro

Oracle Kubernetes Engine (OKE) is the runtime within OCI for the running and operations of enterprise-grade Kubernetes at scale. You can easily deploy and manage resource-intensive workloads such as dedicated game servers with automatic scaling, patching, and upgrades.

### Agones Intro

Agones is an open source platform, for deploying, hosting, scaling, and orchestrating dedicated game servers for large scale multiplayer games, built on top of the industry standard, distributed system platform Kubernetes.

Agones replaces bespoke or proprietary cluster management and game server scaling solutions with an open source solution that can be utilized and communally developed - so that you can focus on the important aspects of building a multiplayer game, rather than developing the infrastructure to support it.

### Workshop Lab Objectives

* Ensure you have installed the prerequisites
* Create the OCI infrastructure
* Setup OKE Autoscaling
* Setup Agones system pods with Helm
* Deploy an Agones Fleet (dedicated game servers)
* Scale a Agones Fleet and OKE nodes
* Teardown

### Labs

| Module | Est. Time |
| ------------- | :-----------: |
| [Workshop Introduction](?lab=0-workshop-introduction) | 5 minutes |
| [Get Started](?lab=1-get-started) | 15 minutes |
| [Creating OCI Resources With Terraform](?lab=2-create-infrastructure-with-terraform) | 30 minutes |
| [Installing the OKE Autoscaler Addon](?lab=3-install-oke-autoscaler-addon) | 20 minutes |
| [Create the Agones System Pods with Helm](?lab=4-create-agones-system) | 15 minutes |
| [Deploy an Agones Fleet and Autoscale OKE Nodes](?lab=5-create-scale-agones-fleet) | 25 minutes |
| [Teardown](?lab=6-teardown) | 10 minutes |

Total estimated time: 120 minutes

### **Let's Get Started!**

Use the left navigation on this page to begin the labs in this workshop.

You may now **proceed to the next lab**

## Learn More - *Useful Links*

- [Kubernetes](https://kubernetes.io/)
- [OKE](https://www.oracle.com/cloud/cloud-native/kubernetes-engine/)
- [OKE Terraform Module](https://github.com/oracle-terraform-modules/terraform-oci-oke)
- [Agones](https://agones.dev/site/docs/)

## **Acknowledgements**

 - **Author** - Marcellus Miles, Master Cloud Architect
 - **Last Updated By/Date** - Marcellus Miles, Dec 2024