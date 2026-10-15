# Get Started

## Introduction

Use the environment supplied with your LiveLabs sandbox reservation. Your compartment, VCN, public and private subnets, and required permissions are already provided. In this lab, locate those resources, find your Object Storage namespace, and create a log group. In Lab 1, you will create the buckets, application, function, invocation log, and Events rule.

**Estimated Time:** 10–15 minutes after your reservation is ready.

### Objectives

- Sign in to your reserved environment.
- Record your assigned region, compartment, network, and Object Storage namespace.
- Choose your own resource names and create a log group.

### Prerequisites

- An active, ready LiveLabs sandbox reservation for this workshop.
- The sign-in and tenancy information supplied with that reservation.
- A browser with file uploads and downloads available.

## Task 1: Access your reserved sandbox

1. Open your LiveLabs reservation and follow its sign-in instructions. Use the sandbox credentials provided with the reservation, not your own tenancy credentials.

2. Wait until the reservation is ready. Find your assigned region and compartment in the reservation's **Tenancy Information**. In the OCI Console, select that region. This workshop does not require Chicago: keep all your lab resources in the region assigned to your reservation. A **compartment** organizes resources and controls access; use your assigned compartment whenever a page or form asks for one.

3. Open a text editor or notes application on your computer. Copy the table below into your notes and fill it in as you proceed. No resource sheet is supplied with the sandbox. Uppercase placeholders in later instructions mean the values in your notes; do not type the placeholders literally.

    | Value to record | Where to get it |
    | --- | --- |
    | Region | Assigned region in Tenancy Information |
    | `LAB_COMPARTMENT` | Assigned compartment in Tenancy Information |
    | `VCN_NAME` | Existing VCN; find it in Task 2 |
    | `SUBNET_NAME` | Existing **private** subnet; find it in Task 2 |
    | `OBJECT_STORAGE_NAMESPACE` | Cloud Shell command in Task 3 |
    | `LOG_GROUP_NAME` | Name you choose when creating the log group in Task 4 |
    | `INCOMING_BUCKET_NAME` | Name you choose when creating the input bucket in Lab 1, Task 1 |
    | `OUTPUT_BUCKET_NAME` | Name you choose when creating the output bucket in Lab 1, Task 1 |
    | `APPLICATION_NAME` | Name you choose in Lab 1, Task 2 |
    | `EVENT_RULE_NAME` | Name you choose in Lab 1, Task 6 |

4. Choose a short personal suffix using lowercase letters and digits, such as your initials followed by six random digits. For example, `jd482731` would produce `inventory-jd482731-incoming`. Choose your own suffix rather than copying this example. Record it in your notes and reuse it for your resource names. Avoid personal or confidential information in names.

5. If the reservation is not ready or its assigned region or compartment is unclear, use **Need Help?** in the workshop menu. Do not deploy the own-tenancy stack or create another compartment, VCN, or subnet in the sandbox. The required policies are already applied; do not create or modify IAM policies yourself.

## Task 2: Find your VCN and private subnet

1. Open **Networking > Virtual cloud networks**. Select your assigned compartment in the compartment filter. Open the VCN provided for your reservation and record its name as `VCN_NAME`. If multiple VCNs are listed and your reservation does not identify which to use, ask for assistance through **Need Help?** rather than choosing another learner's network.

2. Open **Subnets**. Your reservation provides a public and a private subnet. Open the private subnet and confirm that its **Subnet access** is **Private**; do not rely only on the name. Record its name as `SUBNET_NAME`. Select this private subnet when creating the Functions application in Lab 1, not the public subnet.

3. Keep the supplied network settings unchanged. If the VCN or private subnet is missing or inaccessible, use **Need Help?** before continuing.

## Task 3: Find your Object Storage namespace

1. Open **Developer tools > Cloud Shell** in the Console header. On first use, close any informational notice and enter `N` if asked whether to run the introductory tutorial. Wait for the terminal prompt.

2. Run this command in Cloud Shell. It uses your signed-in sandbox identity; you do not need to create an API key or open the tenancy details page.

    ```bash
    oci os ns get --query data --raw-output
    ```

3. Copy the single value returned into your notes as `OBJECT_STORAGE_NAMESPACE`. The **namespace** identifies this tenancy's Object Storage space; it is not a compartment name, bucket name, or resource OCID. Do not include quotes or extra spaces when you paste it into the application's configuration later.

    The namespace name is the same across regions. Cloud Shell may show a different home region in its welcome message; keep the Console region selector on your reservation's assigned region for the lab resources.

4. If Cloud Shell is unavailable or the command returns an error instead of a namespace, use **Need Help?**. Do not guess a namespace or copy one from a screenshot.

## Task 4: Create your log group

1. Search for **Logging** in the Console and select **Logs** under **Logging**. Expand the service navigation and select **Log Groups**. Select your assigned compartment.

2. Select **Create log group**. Confirm the compartment is your assigned compartment. Choose a name using your suffix, such as `inventory-jd482731-logs`, and enter a description such as `Inventory function lab logs`. Select **Create**.

3. Confirm the new log group's details page opens and record its exact name as `LOG_GROUP_NAME`. A **log group** is a container for logs. You will enable the application's invocation log inside this group in Lab 1; no log entries are expected yet.

4. Keep your notes available for Lab 1. Check that you have recorded the region, compartment, VCN, private subnet, namespace, and log group. Fill in the remaining names as you create the buckets, application, and Events rule. If you cannot create the log group, use **Need Help?** for assistance with your sandbox permissions.

    **Checkpoint:** You located your assigned network, retrieved the namespace, and created your log group. Your notes identify the resources you will use in Lab 1.

You may now **proceed to the next lab**.

## Acknowledgements

- **Author** - Graham Shroyer
- **Last Updated By/Date** - Graham Shroyer, October 2026
