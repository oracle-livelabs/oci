# Introduction

## About this Workshop

In this hands-on workshop, you will build a meeting summarization workflow using Oracle Cloud services. You’ll upload media to Object Storage, trigger Functions via Events, create AI Speech transcription jobs, summarize content with the OCI Generative AI service using on-demand model OCIDs, and deliver results to users via Notifications. Along the way, you’ll apply least-privilege IAM principles and learn how OCI’s packaged AI services and partner models enable fast, secure outcomes without lock-in.

Estimated Workshop Time: 1 hour 30 minutes

[](youtube:H-C5dH3w1Dg)

### Objectives

In this workshop, you will learn how to:

* Build an event-driven pipeline: Object Storage → Events → Functions → AI Speech → Generative AI → Notifications
* Configure least-privilege IAM and enable AI Speech to write to the results bucket
* Deploy and test the Transcribe Function (creates Speech jobs) and Summary Function (Generative AI via model OCID)
* Save transcripts and summaries to Object Storage and send results via OCI Notifications

### Prerequisites (Optional)

This lab assumes you have:

* An Oracle account
* Administrator privileges or sufficient access rights to create and manage resources
* Access to a command-line environment such as **OCI Cloud Shell** (or a local setup) with the `oci` CLI configured for your tenancy

## Learn More

* [Overview of Functions](https://docs.oracle.com/en-us/iaas/Content/Functions/Concepts/functionsoverview.htm)
* [OCI Speech Documentation](https://docs.oracle.com/en-us/iaas/Content/speech/home.htm)
* [OCI Generative AI Documentation](https://docs.oracle.com/en-us/iaas/Content/generative-ai/home.htm)

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - **Josiah Oriendo**, Cloud Architect
* **Last Updated By/Date** - **Josiah Oriendo**, March 2026
