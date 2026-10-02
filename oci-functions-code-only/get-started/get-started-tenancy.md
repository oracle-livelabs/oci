# Get Started

## Introduction

Prepare the resources that your function will use in your own OCI tenancy. A small Terraform package creates the private network and log group, and can create the function's runtime permissions with administrator approval. OCI Resource Manager runs this package for you; you do not need Terraform installed on your computer.

**Estimated Time:** 15–20 minutes with administrator access already arranged. If your administrator has provided a completed foundation and resource sheet, start at Task 2.

### Objectives

- Deploy or locate the foundation in an isolated lab compartment.
- Record the exact resource names used throughout the workshop.
- Verify access to the network, log group, and Cloud Shell.

### Prerequisites

- An OCI account and access to **US Midwest (Chicago)** (`us-chicago-1`).
- An existing, isolated lab **compartment**: a container used to organize resources and control access. Do not use production resources or share the compartment with another learner.
- Administrator assistance to confirm service limits and configure permissions. Give your administrator the [administrator setup guide](../author/administrator-setup.md). The foundation does not grant your user account additional access.
- Your tenancy's **home region**, which is where tenancy-wide identity resources are managed. It may differ from Chicago, where you will run this lab.

## Task 1: Deploy the foundation in your own tenancy

Your administrator can perform this task for you. A successful deployment is not a substitute for configuring your learner permissions.

1. Sign in to the [OCI Console](https://cloud.oracle.com/) with your tenancy credentials. Select **US Midwest (Chicago)** in the region selector. Confirm your lab compartment and home region with your administrator.

2. Download [functions-foundation.zip](files/functions-foundation.zip). This is a **Terraform configuration package**, not a function deployment archive. Do not upload it to Functions.

3. Open **Developer Services > Resource Manager > Stacks** from the navigation menu. Under **Applied filters**, select your lab compartment. Select **Create stack**.

4. Select **My configuration**, then **.Zip file** instead of **Folder**. Select **Browse** and attach `functions-foundation.zip`. Name the stack for your lab, keep Terraform **1.5.x** or a supported version below 2.0, and select **Next**.

5. Review the variables:

    | Variable | Value |
    | --- | --- |
    | Existing learner compartment | Your assigned compartment, not the tenancy root |
    | Workload region | `us-chicago-1` |
    | Tenancy home region | Your actual home region; it may not be Chicago |
    | Lab name prefix | A short lowercase label, such as `inventory` |
    | Create runtime IAM | Administrator decision below |

    **Create runtime IAM** is off by default. IAM means Identity and Access Management. An authorized administrator may enable this option after reviewing the dynamic group and three policy statements in the setup guide. A dynamic group identifies the lab's functions; the policy permits them to read the incoming bucket and create or overwrite reports, and permits the Functions service to use the lab network.

    If this option remains off, the administrator must establish those permissions separately using the `administrator_runtime_iam` output. Neither choice creates learner user/group policies.

6. Continue to the review page. Clear **Run apply** if selected, and create the stack. On the stack details page, select **Actions > Plan**, then **Plan** in the side panel. Wait for **Succeeded** and review the job's **Logs**.

    Expect six additions: a VCN, service gateway, route table, security list, private subnet, and log group. If runtime IAM is enabled, expect eight additions including the dynamic group and policy. The VCN also has OCI-created default network resources. The plan must not change or delete existing resources or create the buckets, application, function, Events rule, or invocation log.

7. After your administrator approves the plan, return to **Stack details > Actions > Apply**. Under **Apply job plan resolution**, select the successful saved plan instead of **Automatically approved**. Select **Apply** and wait for **Succeeded**.

8. Open the successful Apply job's **Logs**. Near the end, find `resource_sheet`. Copy its values into a local note for Task 2. If runtime IAM was left off, also give `administrator_runtime_iam` to your administrator. Allow time for new permissions to take effect.

    If a job fails, read its log and ask the administrator to correct the cause. Do not create duplicate stacks or grant broad tenancy-wide access as a workaround. For workshop assistance, use **Need Help?** in the workshop menu.

## Task 2: Record and verify your resources

1. Keep your `resource_sheet` output or the equivalent sheet from your administrator open throughout the workshop. Replace the uppercase placeholders in the instructions with these values; do not type the placeholders themselves.

    | Instruction placeholder | Resource sheet field |
    | --- | --- |
    | `LAB_COMPARTMENT` | `compartment_ocid` (select the matching compartment) |
    | `VCN_NAME` | `vcn_name` |
    | `SUBNET_NAME` | `subnet_name` |
    | `LOG_GROUP_NAME` | `log_group_name` |
    | `INCOMING_BUCKET_NAME` | `incoming_bucket_name` |
    | `OUTPUT_BUCKET_NAME` | `output_bucket_name` |
    | `APPLICATION_NAME` | `application_name` |
    | `EVENT_RULE_NAME` | `event_rule_name` |
    | Object Storage namespace | `object_storage_namespace` |

    An **OCID** uniquely identifies an OCI resource. The Object Storage **namespace** identifies the tenancy's Object Storage space; it is not a bucket or compartment name.

2. Open **Networking > Virtual cloud networks**. Select `LAB_COMPARTMENT` in the compartment filter and open `VCN_NAME`. Under **Subnets**, confirm `SUBNET_NAME` exists and is a private regional subnet. Do not change its network rules.

3. Search for **Logging** in the Console and select **Logs** under **Logging**. Expand the service navigation and select **Log Groups**. Select `LAB_COMPARTMENT` and confirm `LOG_GROUP_NAME` exists. You will enable the application's invocation log in Lab 1.

4. Open **Developer tools > Cloud Shell** in the Console header. On first use, close any informational notice and enter `N` if asked whether to run the introductory tutorial. Wait for the terminal prompt. The welcome message may identify the tenancy's home region; keep the Console workload region set to Chicago.

5. Confirm with your administrator that both your learner permissions and the function's runtime permissions are ready. An Apply with `create_runtime_iam=false` does not establish runtime permissions.

    **Checkpoint:** You have a compartment, private network, log group, resource sheet, and access. You will create the two buckets, application, function, invocation log, and Events rule in Lab 1.

You may now **proceed to the next lab**.

## Acknowledgements

- **Author** - Graham Shroyer
- **Last Updated By/Date** - Graham Shroyer, September 2026
