# Introduction

## About this Workshop

ArgoCD is an open source declarative GitOps tool for Kubernetes and is part of the Cloud Native Computing Foundation ecosystem.
It enables automated application deployment by syncing the desired state from a Git repository to a Kubernetes cluster.
It continuously monitors Git repositories and compares the actual cluster state to the declared configuration. When differences are detected, it can alert users or automatically apply changes to bring the system into the desired state.
It doesn't have OCI CLI (Oracle Cloud Infrastructure Command Line Interface) which is required to generate the access token for OKE.

Estimated Workshop Time: 2 hours

### Objectives

In this workshop, you will learn to:

- Create ArgoCD custom image with oci cli installed.
- Create a reserved public ip.
- Create a Confidential Application.
- Deploy Terraform code via Resource Manager.
- Add an OKE Cluster to ArgoCD cluster list.
- Deploy an app on the target OKE Cluster via ArgoCD.

### Resources created by Terraform

- VCN
- Bastion Instance
- Enhanced OKE Cluster
- Flexible Load Balancer
- Policy with workload identity for ArgoCD

### Prerequisites

- Podman or Docker installed to create the custom ArgoCD image.
- Auth token for your OCI User(from the OCI console > your user profile > Auth tokens) - it can take up to 5 min to activate.
- Permission for your OCI User to create repos in OCI Container Registry:
  <copy>

  ```
  Allow group your_group to manage repos in tenancy
  ```

  </copy>

- Deployment depends on use of [Instance Principals](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/callingservicesfrominstances.htm) for the Bastion Instance to generate kubeconfig via oci cli. You should create a [dynamic group](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/managingdynamicgroups.htm) for the compartment where you want to deploy the Infrastructure.
  <copy>

  ```
  instance.compartment.id='ocid.comp....'
  ```

  </copy>

- After creating the group, you should set specific [IAM policies](https://docs.oracle.com/en-us/iaas/Content/Identity/Reference/policyreference.htm) for OCI service interaction:
  <copy>

  ```
  Allow dynamic-group Argocd to manage cluster-family in compartment Argocd
  Allow dynamic-group Argocd to manage virtual-network-family in compartment Argocd
  ```

  </copy>

- OKE Cluster to be managed by ArgoCD.

Proceed to the next section

### Acknowledgements

**Author**

- **Gabriel Feodorov**, Principal Cloud Architect.
