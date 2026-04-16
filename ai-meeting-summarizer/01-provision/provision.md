# Provision Necessary Resources

## Introduction

In this lab, you’ll prepare the foundation for the AI Meeting Summarizer workflow. You will create a dedicated compartment, three Object Storage buckets (uploads, transcripts, and results), networking dependencies, and policies. These components establish the foundation that the rest of the lab builds on.

Estimated Time: 20 minutes

### Objectives

In this lab, you will:

* Create a compartment for the workshop resources
* Create private Object Storage buckets for uploads, transcripts, and results
* Create networking dependencies (VCN, subnets, etc.)
* Create policies to grant instance principals access to resources

### Prerequisites

This lab assumes you have:

* An Oracle Cloud account with permissions to create compartments, buckets, and Events
* Familiarity with the OCI Console (helpful but not required)
* A region selected for all resources (keep everything in the same region)

## Task 1: Create a compartment

1. In the OCI Console, open the navigation menu and go to **Identity & Security → Identity → Compartments**

2. Click **Create compartment**

3. Enter:

   * Name: ai-meeting-summarizer
   * Description: Workshop resources for AI Meeting Summarizer
   * Parent compartment: Your tenancy root or a suitable parent

4. Click **Create compartment**

    ![Compartment Creation](images/compartment.png){:style="max-width: 100%; height: auto;"}


> Save the OCID of the compartment, which can be found on the details page after clicking into the compartment. It will be used in later steps.

## Task 2: Create Object Storage buckets and enable events

Navigate to **Storage → Object Storage & Archive Storage → Buckets**, where you will create three private buckets in the same region and namespace.

### A. Upload bucket

1. Ensure you are in the ai-meeting-summarizer compartment you just created

2. Click **Create bucket**

3. Enter:

   * Name: upload
   * Default storage tier: Standard
   * Emit object events: Toggle it on
   * Encryption: Use Oracle-managed keys (or choose a customer-managed key if required)

4. Click **Create**

    ![Bucket Creation](images/upload.png)

> If you cannot find the compartment, wait a few minutes and refresh, as it may take time to provision.

### B. Transcripts bucket

1. Follow the same steps as the upload bucket, but set the name to **transcripts**

### C. Results bucket

1. Follow the same steps as the previous buckets, but set the name to **results** and keep **Emit object events** turned off

> Note: Record your Object Storage namespace (visible at the top of the Buckets page). You’ll use it in later labs.

## Task 3: Establish Networking

1. Navigate to **Networking → Virtual Cloud Networks → Actions → Start VCN Wizard**

   * Connection Type: Create VCN with Internet Connectivity

2. Click **Start VCN Wizard**

    ![VCN Connectivity Selection](images/vcn_wizard.png)

3. Enter:

   * Name: ai-ms-vcn
   * IPv4 CIDR block: 10.0.0.0/16
   * Compartment: ai-meeting-summarizer
   * Configure public subnet IPv4 CIDR block: 10.0.0.0/24
   * Configure private subnet IPv4 CIDR block: 10.0.1.0/24

    ![VCN Configuration](images/pub_priv_sub.png)

4. Click **Next → Create**

## Task 4: Create Dynamic Group

1. Navigate to **Identity & Security → Identity → Domains**

2. Change the compartment to your root compartment

    ![Root Domain](images/domain.png)

3. Click **Default → Dynamic Groups → Create dynamic group**

   * Name: ai\_summary\_dg
   * Matching rules: Match all rules defined below
   * Rule 1: All {{resource.type = 'fnfunc', resource.compartment.id = '&lt;ai\_summary\_compartment\_OCID&gt;'}}

4. Click **Create**

    ![Dynamic Group Creation](images/create_dg.png)

## Task 5: Create Policies

1. Navigate to **Identity & Security → Identity → Policies**

2. Change the compartment to your AI Meeting Summarizer compartment using the **Applied filters** button

3. Click **Create Policy**

   * Name: Events\_policy
   * Description: Allow events to trigger Functions
   * Compartment: ai-meeting-summarizer
   * Policy Builder (Show manual editor):
     Allow service cloudEvents to use functions-family in compartment ai-meeting-summarizer

4. Click **Create**

    ![Policy Creation](images/events_policy.png)

5. Create another policy:

   * Name: Functions\_policy
   * Description: Grant Functions access to Object Storage, AI Speech, Logs, Topics, and Generative AI services
   * Compartment: ai-meeting-summarizer
   * Policy Builder (Show manual editor):

     * Allow dynamic-group ai\_summary\_dg to manage object-family in compartment ai-meeting-summarizer
     * Allow dynamic-group ai\_summary\_dg to manage ai-service-speech-family in compartment ai-meeting-summarizer
     * Allow dynamic-group ai\_summary\_dg to manage generative-ai-family in compartment ai-meeting-summarizer
     * Allow dynamic-group ai\_summary\_dg to manage logs in compartment ai-meeting-summarizer
     * Allow dynamic-group ai\_summary\_dg to use ons-topics in compartment ai-meeting-summarizer

6. Click **Create**

    ![Policies to Enable Functions](images/funcs.png)

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - **Josiah Oriendo**, Cloud Architect
* **Last Updated By/Date** - **Josiah Oriendo**, March 2026
