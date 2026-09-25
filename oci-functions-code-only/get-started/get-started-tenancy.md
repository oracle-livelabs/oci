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

## Task 1: Deploy the foundation in your own tenancy

**Complete this before the scheduled hands-on session if possible.** An administrator can deploy the foundation for you; you do not need administrator access for the lab activities.

1. Ask your administrator to prepare an **isolated, existing lab compartment** and the learner permissions in the [administrator setup guide](../author/ADMINISTRATOR-SETUP.md). Confirm service limits, the tenancy's **home region**, and code-only Functions availability in Chicago. Do not use production resources or a shared learner compartment.

2. Download [functions-foundation.zip](files/functions-foundation.zip). This is a **Terraform configuration package**, not a function deployment ZIP. Do not upload it to Functions.

3. In the OCI Console, select **US Midwest (Chicago)**. Open **Developer Services > Resource Manager > Stacks**, choose the lab compartment, and select **Create stack**. Select **My configuration** (upload a ZIP configuration) and upload the foundation ZIP. No local Terraform installation or API key is required for this Console workflow.

4. Name the stack for your lab. Keep a supported Terraform version compatible with the package (1.5 or later, below 2.0). Review the variables:

   | Variable | Value |
   | --- | --- |
   | Existing learner compartment | Your assigned lab compartment, not the tenancy root |
   | Workload region | us-chicago-1 |
   | Tenancy home region | Your actual home region; it may not be Chicago |
   | Lab name prefix | A short lowercase label, such as inventory |
   | Create runtime IAM | Administrator decision below |

   **Create runtime IAM is off by default.** An authorized administrator may enable it after reviewing the dynamic-group rule and three policy statements. Otherwise the administrator must establish those permissions separately using the stack's **administrator_runtime_iam** output before learner handoff. The stack never grants its operator new permissions or creates learner user/group policies.

5. Review the configuration and run **Plan** first (clear **Run apply** at creation if offered). Confirm that it contains only a new VCN, service gateway, route table, security list, private subnet, and log group, plus a dynamic group and scoped runtime policy only when explicitly selected. The VCN also has OCI-created default network resources. No buckets, application, Compute instance, function, Events rule, or service log should be provisioned.

6. With administrator approval of the plan, run **Apply**. Wait for **Succeeded** and open **Outputs**. Record **resource_sheet** and have your administrator complete/verify IAM. Allow for IAM propagation before testing access. Do not treat an Apply success as proof that learner permissions or event delivery work.

7. Continue to Task 2. If Apply fails, inspect the job log and ask the administrator to correct the cause; do not create duplicate stacks or grant broad tenancy-wide access as a workaround.

The same configuration will back a **Deploy to Oracle Cloud** shortcut once its ZIP is hosted at an approved public URL. The ZIP-upload workflow above works without depending on an unpublished GitHub path. This Resource Manager shortcut is separate from a LiveLabs sandbox reservation.

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
