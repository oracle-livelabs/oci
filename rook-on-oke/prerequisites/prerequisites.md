# Prerequisites and Setup

## Introduction

In this lab, you will set up your environment for deploying Rook-Ceph on Oracle Kubernetes Engine (OKE). This includes verifying your OCI tenancy access, understanding the required permissions, and preparing for the deployment.

Estimated Time: 15 minutes

### Objectives

In this lab, you will:

- Verify OCI tenancy access and permissions
- Understand resource requirements
- Choose your deployment method (Resource Manager or Terraform CLI)
- Gather required information

### Prerequisites

This lab assumes you have:

- An Oracle Cloud Infrastructure (OCI) tenancy
- Administrative access or the following IAM permissions

## Task 1: Verify OCI Access and Permissions

Before proceeding, ensure you have the required permissions in your OCI tenancy.

1. Log in to the [Oracle Cloud Console](https://cloud.oracle.com)

2. Verify you can access the following services:
   - **Container Engine for Kubernetes (OKE)**
   - **Compute**
   - **Block Storage**
   - **Virtual Cloud Networks**
   - **Resource Manager**

3. Required IAM Permissions:

   If you're not an administrator, ensure your user group has the following policies:

    ```text
    <copy>
    Allow group <your-group> to manage cluster-family in compartment <compartment-name>
    Allow group <your-group> to manage virtual-network-family in compartment <compartment-name>
    Allow group <your-group> to manage instance-family in compartment <compartment-name>
    Allow group <your-group> to manage volume-family in compartment <compartment-name>
    Allow group <your-group> to manage orm-stacks in compartment <compartment-name>
    Allow group <your-group> to manage orm-jobs in compartment <compartment-name>
    </copy>
    ```

## Task 2: Understand Resource Requirements

The Rook-Ceph deployment requires specific resources to function correctly.

### Minimum Requirements

| Resource | Minimum | Recommended |
|----------|---------|-------------|
| Worker Nodes | 3 | 5 |
| Node Shape | VM.Standard.E4.Flex (2 OCPU, 16GB) | VM.Standard.E4.Flex (4 OCPU, 32GB) |
| Block Volumes per Node | 1 x 50GB | 2 x 100GB |
| Kubernetes Version | 1.27+ | Latest supported |

### Why These Requirements?

- **3 Worker Nodes**: Ceph requires at least 3 nodes for proper replication (replica count of 3)
- **Block Volumes**: Raw block devices are used by Ceph OSDs to store data
- **Memory**: Ceph OSDs require significant memory for caching and operations

## Task 3: Gather Required Information

Collect the following information before deployment:

1. **Tenancy OCID**: 
   - Navigate to **Profile** → **Tenancy: &lt;your-tenancy&gt;**
   - Copy the OCID

2. **Compartment OCID** (where you'll deploy):
   - Navigate to **Identity & Security** → **Compartments**
   - Select your target compartment
   - Copy the OCID

3. **Region**: Note your home region (e.g., `us-ashburn-1`, `eu-frankfurt-1`)

4. **SSH Public Key** (optional, for node access):

    ```bash
    <copy>
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/oke_key
    cat ~/.ssh/oke_key.pub
    </copy>
    ```

## Task 4: Understanding OCI Resource Manager

This lab uses a one-click deployment demonstration using the pre-configured Terraform stack:

**Advantages:**
- No local tools required
- Guided configuration through UI
- Automatic state management
- Easy cleanup

**Best for:**
- First-time users
- Quick demonstrations
- Users without local Terraform setup


You may now **proceed to the next lab**.

## Learn More

- [OCI IAM Policies](https://docs.oracle.com/en-us/iaas/Content/Identity/Concepts/overview.htm)
- [OKE Prerequisites](https://docs.oracle.com/en-us/iaas/Content/ContEng/Concepts/contengprerequisites.htm)
- [Terraform on OCI](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformgetstarted.htm)

## Acknowledgements

* **Author** - Dragos Nicu, Cloud Infrastructure Engineer
* **Last Updated By/Date** - Dragos Nicu, January 2026
