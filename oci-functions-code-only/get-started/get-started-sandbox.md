# Get Started

## Introduction

**Description**

A supplier sends an inventory CSV. Your operations team needs to know which products need restocking. In this lab, you create a Python function and connect it to an Object Storage upload event. Upload a file and the function writes two reports: products below the stock threshold and records that need correction.

**Lab Objectives**

- Explain how an application, a function, and an event work together.
- Review Python logic, using a supplied AI prompt or the tested reference implementation.
- Deploy a function and connect an Object Storage event to it.
- Upload a CSV and verify the resulting reports.

**Intended Audience**

Beginner technical learners. No previous OCI Functions experience is required.

**Estimated Workshop Time**

Plan 60-80 minutes including the optional exercises, with the remainder of the 90-minute session available for questions and troubleshooting. Own-tenancy foundation deployment is pre-work and may take additional time. These estimates still need a beginner dry run.

**Prerequisites**

- Access to the prepared lab compartment and OCI Console.
- A prepared foundation: isolated compartment, private network, log group, and permissions. You create the buckets, application, and invocation log during Lab 1.
- A browser and access to OCI Cloud Shell for checking the supplied Python code.
- Optional: an AI coding assistant you already have access to. The reference code lets you complete the lab without one.

**What OCI Functions does**

OCI Functions runs your code when it is invoked, without requiring you to administer a server. An **application** groups functions that share networking and configuration. A **function** contains the code for one task. An **event rule** decides when a change in another OCI service should invoke that function.

In this lab, an upload creates an object in the incoming bucket. OCI Events matches that event and invokes your function. The function reads the CSV and writes reports to a separate output bucket.

```text
Upload inventory CSV -> Incoming bucket -> OCI Events -> Python function -> Output bucket
```

The reports are stored under a prefix named after the input file. For example, `inventory-run1.csv` produces `inventory-run1/restock-report.csv` and `inventory-run1/rejected-records.csv`.

**Resources**

- [OCI Functions overview](https://docs.oracle.com/en-us/iaas/Content/Functions/Concepts/functionsoverview.htm)
- [Creating Functions using Code Editor](https://docs.oracle.com/en-us/iaas/Content/Functions/Tasks/functionscreatingfunctions-usingcodeeditor.htm)
- [Creating an Events rule](https://docs.oracle.com/en-us/iaas/Content/Events/Task/create-events-rule.htm)
- [Function logging](https://docs.oracle.com/en-us/iaas/Content/Logging/Reference/details_for_functions.htm)

**Contact us**

For help during the workshop, contact your instructor or lab facilitator.

> **Author review edition:** The original function workflow and Cloud Shell checks were cloud-tested. The new Terraform foundation and learner-created resource steps require a fresh end-to-end dry run before publication; LiveLabs green-button integration is not yet deployed.

## Task 1: Access your reserved sandbox

1. Open your LiveLabs reservation and sign in using its sandbox credentials, not your own tenancy credentials.

2. Wait for the reservation's foundation provisioning to complete. Select the assigned region and compartment; this workshop's validated workload region is **US Midwest (Chicago)**.

3. Open the reservation's resource sheet, or obtain it from your facilitator. The foundation provides the private network, log group, and runtime permissions. It does **not** create the resources you will build in Lab 1.

4. If preparation failed, the resource sheet is missing, or permissions are not ready, contact your facilitator before continuing. Do not run the own-tenancy stack in your sandbox or create a second foundation.

The reservation integration must pass the assigned compartment, tenancy, region, and naming inputs to the [shared foundation](../foundation/README.md). An administrator establishes the runtime and learner IAM before handoff; participants do not create or modify IAM policies.

## Task 2: Record your resource sheet

Your facilitator or the Resource Manager stack supplies the **resource_sheet** output. Keep it open throughout the workshop. Uppercase resource-name placeholders in the instructions mean the values below; do not type the placeholders literally.

| Instruction placeholder | Resource sheet field |
| --- | --- |
| LAB_COMPARTMENT | compartment_ocid (select the matching compartment) |
| VCN_NAME | vcn_name |
| SUBNET_NAME | subnet_name |
| LOG_GROUP_NAME | log_group_name |
| INCOMING_BUCKET_NAME | incoming_bucket_name |
| OUTPUT_BUCKET_NAME | output_bucket_name |
| APPLICATION_NAME | application_name |
| EVENT_RULE_NAME | event_rule_name |
| Object Storage namespace | object_storage_namespace |

1. In Networking, find the supplied VCN and private regional subnet. You will select them for the application; do not create or change network rules.

2. In Logging, find the supplied log group. The application's invocation log does not exist yet; you will enable it after creating the application.

3. Open **Cloud Shell** from **Developer tools** and confirm that it starts. The supplied Python checks require no package installation.

4. Confirm with your facilitator or administrator that the function runtime permissions and your learner permissions are ready. A successful Terraform Apply with **create_runtime_iam=false** does not establish runtime permissions.

> **Checkpoint:** You have a compartment, private network, log group, exact resource names, and access. The two buckets, application, function, invocation log, and Events rule are deliberately left for you to create in Lab 1.

Use only your assigned environment. The reference screenshots show the author's earlier names; substitute your resource sheet values.

You may now **proceed to Lab 1** using the workshop navigation.
