# Get Started

## Introduction

Use the environment supplied with your LiveLabs sandbox reservation. Its foundation provides the private network, log group, and permissions. You will create the buckets, application, function, invocation log, and Events rule in Lab 1.

**Estimated Time:** 5–10 minutes after your reservation is ready.

### Objectives

- Sign in to your reserved environment.
- Record your assigned compartment and resource names.
- Verify access to the network, log group, and Cloud Shell.

### Prerequisites

- An active, ready LiveLabs sandbox reservation for this workshop.
- The sign-in information and resource sheet supplied with that reservation.
- A browser with file uploads and downloads available.

## Task 1: Access your reserved sandbox

1. Open your LiveLabs reservation and follow its sign-in instructions. Use the sandbox credentials provided with the reservation, not your own tenancy credentials.

2. Wait until the reservation is ready. In the OCI Console, select the assigned **US Midwest (Chicago)** region and your assigned compartment. A **compartment** organizes resources and controls access; use only the one assigned to you.

3. Open the reservation's resource sheet. Keep it available throughout the workshop. It lists the foundation resources and the exact names you will use when creating resources in Lab 1.

4. If the reservation is not ready, the sheet is missing, or access fails, use **Need Help?** in the workshop menu to request reservation assistance. Do not deploy the own-tenancy stack or create a second foundation in the sandbox.

## Task 2: Record and verify your resources

1. Replace uppercase placeholders in the lab instructions with the corresponding resource-sheet values. Do not type the placeholders literally.

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

5. If a resource is missing or you cannot open Cloud Shell, use **Need Help?** before continuing. Do not create or modify IAM policies yourself.

    **Checkpoint:** You have the assigned compartment, private network, log group, resource sheet, and access. The application-facing resources are left for you to create in Lab 1.

You may now **proceed to the next lab**.

## Acknowledgements

- **Author** - Graham Shroyer
- **Last Updated By/Date** - Graham Shroyer, September 2026
