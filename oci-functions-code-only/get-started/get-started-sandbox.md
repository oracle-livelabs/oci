# Get Started

## Introduction

Sign in to your LiveLabs sandbox and prepare a place to record your lab values. Your compartment, VCN, public and private subnets, and required permissions are already provided. You will select or create the resources you need as you work through Lab 1.

**Estimated Time:** 5 minutes after your reservation is ready.

### Objectives

- Sign in to your reserved environment.
- Identify your assigned region and compartment.
- Prepare a notes table to fill in during Lab 1.

### Prerequisites

- An active, ready LiveLabs sandbox reservation for this workshop.
- The sign-in and tenancy information supplied with that reservation.
- A browser with file uploads and downloads available.

## Task 1: Access your reserved sandbox

1. Open your LiveLabs reservation and follow its sign-in instructions. Use the sandbox credentials provided with the reservation, not your own tenancy credentials.

2. Wait until the reservation is ready. Find your assigned region and compartment in the reservation's **Tenancy Information**. In the OCI Console, select that region. This workshop does not require Chicago: keep all your lab resources in the region assigned to your reservation. A **compartment** organizes resources and controls access; use your assigned compartment whenever a page or form asks for one.

3. If the reservation is not ready or its assigned region or compartment is unclear, use **Need Help?** in the workshop menu. Do not deploy the own-tenancy stack or create another compartment, VCN, or subnet in the sandbox. The required policies are already applied; do not create or modify IAM policies yourself.

## Task 2: Prepare your lab notes

1. Copy this table into a text editor or notes application on your computer. Record only your assigned region and compartment now. Leave the remaining values blank: Lab 1 will tell you when to find or choose each one.

    | Value to record | When to fill it in | Your value |
    | --- | --- | --- |
    | Region | Now: Tenancy Information | |
    | `LAB_COMPARTMENT` | Now: assigned compartment in Tenancy Information | |
    | `INCOMING_BUCKET_NAME` | Lab 1, Task 1: create input bucket | |
    | `OUTPUT_BUCKET_NAME` | Lab 1, Task 1: create output bucket | |
    | `APPLICATION_NAME` | Lab 1, Task 2: create application | |
    | `OBJECT_STORAGE_NAMESPACE` | Lab 1, Task 2: retrieve in Cloud Shell | |
    | `LOG_GROUP_NAME` | Lab 1, Task 3: create log group | |
    | `EVENT_RULE_NAME` | Lab 1, Task 6: create Events rule | |

2. Keep your notes available throughout the workshop. Uppercase placeholders in the instructions refer to your recorded values; do not type the placeholders literally. You do not need to find or record network names. When you create the application, you will select the available VCN and its private subnet.

    **Checkpoint:** You are signed in to the assigned region and have your compartment recorded. The rest of your notes table is ready to fill in during Lab 1.

You may now **proceed to the next lab**.

## Acknowledgements

- **Author** - Graham Shroyer
- **Last Updated By/Date** - Graham Shroyer, October 2026
