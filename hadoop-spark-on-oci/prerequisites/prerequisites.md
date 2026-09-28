# Prerequisites and Setup

## Introduction

In this lab, you will set up your environment for deploying Hadoop & Spark on OCI. This includes verifying your tenancy access, understanding the required IAM permissions, generating an SSH key pair, and finding the client IP address you will lock the deployment down to. These steps apply to **both** the Native and Open Source tracks.

Estimated Time: 15 minutes

### Objectives

In this lab, you will:

- Verify OCI tenancy access and permissions
- Generate an SSH key pair for the operator and cluster nodes
- Find your public IP for the Bastion / API allow-list
- (Optional) Install and configure the OCI CLI on your workstation

### Prerequisites

This lab assumes you have:

- An Oracle Cloud Infrastructure (OCI) tenancy
- Administrative access, or the IAM permissions listed below

## Task 1: Verify OCI Access and Permissions

1. Log in to the [Oracle Cloud Console](https://cloud.oracle.com).

2. Confirm you can access **Developer Services** → **Resource Manager**, which both tracks use to deploy.

3. **Required IAM permissions.** If you are a tenancy administrator, you already have everything you need. Otherwise, ensure your group has the policies for the track(s) you plan to run.

    Both stacks create **tenancy-level** IAM resources (dynamic groups and policies) so the operator and services can authenticate without static keys. Creating those requires `manage dynamic-groups` and `manage policies` in the tenancy.

    **Native track (Big Data Service + Data Flow):**

    ```text
    <copy>
    Allow group <your-group> to manage bds-family in compartment <compartment-name>
    Allow group <your-group> to manage dataflow-family in compartment <compartment-name>
    Allow group <your-group> to manage object-family in compartment <compartment-name>
    Allow group <your-group> to manage virtual-network-family in compartment <compartment-name>
    Allow group <your-group> to manage instance-family in compartment <compartment-name>
    Allow group <your-group> to manage bastion-family in compartment <compartment-name>
    Allow group <your-group> to manage orm-stacks in compartment <compartment-name>
    Allow group <your-group> to manage orm-jobs in compartment <compartment-name>
    Allow group <your-group> to manage dynamic-groups in tenancy
    Allow group <your-group> to manage policies in tenancy
    </copy>
    ```

    **Open Source track (OKE + Spark on Kubernetes):**

    ```text
    <copy>
    Allow group <your-group> to manage cluster-family in compartment <compartment-name>
    Allow group <your-group> to manage instance-family in compartment <compartment-name>
    Allow group <your-group> to manage volume-family in compartment <compartment-name>
    Allow group <your-group> to manage object-family in compartment <compartment-name>
    Allow group <your-group> to manage virtual-network-family in compartment <compartment-name>
    Allow group <your-group> to manage bastion-family in compartment <compartment-name>
    Allow group <your-group> to manage orm-stacks in compartment <compartment-name>
    Allow group <your-group> to manage orm-jobs in compartment <compartment-name>
    Allow group <your-group> to manage dynamic-groups in tenancy
    Allow group <your-group> to manage policies in tenancy
    </copy>
    ```

   > **Note:** If you cannot create tenancy-level IAM resources, ask an administrator to pre-create the dynamic group and policy, and untick the "Create tenancy-level IAM policies" option in the stack form (Native track). See the stack's README for the exact statements.

## Task 2: Generate an SSH Key Pair

Both tracks install an SSH **public** key on the operator host (and, for the Native track, on the Big Data Service nodes). You open Bastion sessions and log in with the matching **private** key, so generate a pair now if you don't already have one.

1. On macOS or Linux, generate a key pair:

    ```bash
    <copy>
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
    </copy>
    ```

2. Print the **public** key — you will paste this into the stack form:

    ```bash
    <copy>
    cat ~/.ssh/id_rsa.pub
    </copy>
    ```

   > On Windows, use PowerShell's `ssh-keygen`, or generate a key with PuTTYgen. Keep the private key safe — you never upload it anywhere.

## Task 3: Find Your Public IP Address

Both stacks lock access down to a specific client IP: the Native track's **Bastion client allow-list** and the Open Source track's **Admin CIDR** both expect your workstation's public IP as a `/32`.

1. Find your current public IP:

    ```bash
    <copy>
    curl ifconfig.me
    </copy>
    ```

2. Note the result and append `/32`. For example, if the command prints `203.0.113.4`, you will enter `203.0.113.4/32` in the deploy form.

   > **Important:** Do not use `0.0.0.0/0` or wide ranges — the stacks reject them. If your IP changes (e.g. you're on a dynamic connection or VPN), you can update the allow-list later.

## Task 4: (Optional) Install the OCI CLI

You will run the sample jobs **on the operator host**, which already has the OCI CLI, `kubectl` and `helm` installed with instance-principal authentication — so you don't strictly need the CLI locally. However, the CLI on your workstation makes it easier to open Bastion sessions (the Native track prints a ready-to-run `oci bastion session create-managed-ssh ...` command).

1. Install the OCI CLI by following the [official installation guide](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm).

2. Configure it with your API credentials:

    ```bash
    <copy>
    oci setup config
    </copy>
    ```

You are now ready to deploy. Continue to the deploy lab for your chosen track.

You may now **proceed to the next lab**.

## Learn More

- [OCI IAM Policies](https://docs.oracle.com/en-us/iaas/Content/Identity/Concepts/overview.htm)
- [OCI Bastion Service](https://docs.oracle.com/en-us/iaas/Content/Bastion/home.htm)
- [OCI Resource Manager](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/home.htm)
- [Managing SSH keys on OCI](https://docs.oracle.com/en-us/iaas/Content/GSG/Tasks/creatingkeys.htm)

## Acknowledgements

* **Author** - Dragos Nicu, Cloud Infrastructure Engineer
* **Last Updated By/Date** - Dragos Nicu, January 2026
