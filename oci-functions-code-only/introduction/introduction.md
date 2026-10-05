# Introduction

## Introduction

Welcome to **From Code to Cloud in Minutes with OCI Functions**.

A supplier sends an inventory CSV file. Your operations team needs to know which products need restocking. In this workshop, you deploy a Python function and connect it to an Object Storage upload event. Upload a file, and the function writes two reports: products below the stock threshold and records that need correction.

**Estimated Workshop Time:** 60–90 minutes.

Setting up a new tenancy, obtaining administrator permissions, or waiting for additional service capacity can take extra time.

### Objectives

- Explain how an application, a function, and an event work together.
- Review Python logic using a supplied AI prompt or the tested reference implementation.
- Deploy a code-only function from a ZIP archive.
- Connect an Object Storage event and verify the resulting reports.
- Optionally, change the threshold and diagnose an invalid input record.

### Prerequisites

- Access to an OCI tenancy with administrator assistance, or an active LiveLabs sandbox reservation for this workshop.
- A browser with file uploads and downloads available, and access to OCI Cloud Shell.
- No previous OCI Functions experience is required. Familiarity with basic cloud terms and Python is helpful, but not required.
- Optional: an AI coding assistant you already have access to. You can complete every exercise with the supplied reference code.

## Task 1: Understand the workflow

1. Review the services you will use. **OCI Functions** runs code when invoked, without requiring you to administer a server. An **application** groups functions that share networking and configuration. A **function** contains the code for a task. With a **code-only function**, you supply an archive of code and dependencies; you do not build and publish a container image yourself.

2. **Object Storage** holds files as objects inside containers called buckets. **OCI Events** matches changes in cloud resources against rules. Your rule will invoke the function when a new object is created in the incoming bucket.

    ```text
    Upload inventory CSV -> Incoming bucket -> OCI Events -> Python function -> Output bucket
    ```

3. The function reads the CSV, normalizes product codes, checks quantities, and writes reports into a separate output bucket. The output prefix is named after the input file. For example, `inventory-run1.csv` produces `inventory-run1/restock-report.csv` and `inventory-run1/rejected-records.csv`. A prefix looks like a folder in the Console.

4. In **Get Started**, prepare or locate your network, log group, and permissions. In **Lab 1**, create the buckets and application, check the Python code, deploy the function, and connect the event. In optional **Lab 2**, change a configuration value and troubleshoot a rejected record using OCI Logging.

    The AI assistant is optional and is used only while preparing code. No AI service is called when the deployed function runs.

You may now **proceed to the next lab**.

## Learn More

- [OCI Functions overview](https://docs.oracle.com/en-us/iaas/Content/Functions/Concepts/functionsoverview.htm)
- [Creating functions from archives (code-only functions)](https://docs.oracle.com/en-us/iaas/Content/Functions/Tasks/functions_creating-code-only.htm)
- [Creating an Events rule](https://docs.oracle.com/en-us/iaas/Content/Events/Task/create-events-rule.htm)
- [Function logging](https://docs.oracle.com/en-us/iaas/Content/Logging/Reference/details_for_functions.htm)

## Acknowledgements

- **Author** - Graham Shroyer
- **Last Updated By/Date** - Graham Shroyer, September 2026
