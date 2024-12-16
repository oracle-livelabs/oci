# Introduction

## **What is OKE and Agones?**

#### OKE Intro

Oracle Kubernetes Engine (OKE) is the runtime within OCI for the running and operations of enterprise-grade Kubernetes at scale. You can easily deploy and manage resource-intensive workloads such as dedicated game servers with automatic scaling, patching, and upgrades.

#### Agones Intro

Agones is an open source platform, for deploying, hosting, scaling, and orchestrating dedicated game servers for large scale multiplayer games, built on top of the industry standard, distributed system platform Kubernetes.

Agones replaces bespoke or proprietary cluster management and game server scaling solutions with an open source solution that can be utilized and communally developed - so that you can focus on the important aspects of building a multiplayer game, rather than developing the infrastructure to support it.

Estimated Time: 45 minutes

### Objectives

* Ensure you have installed the pre-requisites
* Create the OCI infrastructure
* Setup OKE Autoscaling
* Setup Agones
* Deploy an Agones Fleet (dedicated game servers)
* Scale a Agones Fleet and OKE nodes
* Teardown

### Labs

| Module | Est. Time |
| --- | --- |
| [Workshop Introduction](?lab=0-workshop-introduction) | 5 minutes |
| [Install Prerequisites](?lab=1-install-prerequisites) | 5 minutes |
| [Create Infrastructure With Terraform](?lab=2-create-infrastructure-with-terraform) | 5 minutes |
| [Install OKE Autoscaler Addon](?lab=3-install-oke-autoscaler-addon) | 5 minutes |
| [Create Agones System and Test](?lab=4-create-agones-system) | 5 minutes |
| [Create and Scale an Agones Fleet](?lab=5-create-scale-agones-fleet) | 5 minutes |
| [teardown](?lab=6-teardown) | 5 minutes |

Total estimated time: 45 minutes

### **Let's Get Started!**

If the menu is not displayed, you can open by clicking the menu button (![Menu icon](./images/menu-button.png)) at the upper-left corner of the page.

## Learn More - *Useful Links*

- [Kubernetes]()
- [OKE]()
- [OKE Terraform]()
- [OKE Autoscaler]()
- [Agones](https://agones.dev/site/docs/)

## **Acknowledgements**

 - **Author** - Marcellus Miles, Master Cloud Architect
 - **Last Updated By/Date** - Marcellus Miles, Dec 2024