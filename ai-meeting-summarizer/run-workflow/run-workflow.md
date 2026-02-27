# Run the Workflow: Upload, Transcribe, Summarize, and Notify

## Introduction

In this final lab, you’ll kick off the end-to-end pipeline by uploading a media file to the uploads bucket. You’ll then verify the Functions logs, track the AI Speech transcription job, retrieve the transcript from Object Storage, confirm the summary file, and verify the email notification.

Estimated Time: 10–20 minutes

### Objectives

In this lab, you will:

- Upload a media file in a supported format to the upload bucket
- Verify the Transcribe Function invocation in Logs
- Check the AI Speech job status
- Retrieve the transcript from the transcripts bucket
- Verify the Summary Function ran, view the summary file, and confirm the email notification

### Prerequisites

This lab assumes you have:

- A small media file in one of the supported formats:
  - AAC, AC3, AMR, AU, FLAC, M4A, MKV, MP3, MP4, OGA, OGG, OPUS, WAV, WEBM
- All resources in the same region

## Task 1: Upload a media file to the upload bucket

1. Console → Storage → Object Storage & Archive Storage → Buckets.
2. Select the ai-meeting-summarizer compartment and open the upload bucket.
3. Click Upload and select a small media file in a supported format (see list above).
4. Click Upload.

## Task 2: Verify the Transcribe Function invocation

1. Console → Developer Services → Functions → Applications → ai-ms-app → Logs (or Monitoring → Function Invocation Logs link).
2. Open your transcriber-log (or the log you enabled) and look for entries like:
   - “Inside Transcribe Function”
   - “Transcription job created successfully” with a job OCID
3. If you don’t see logs immediately, refresh after a few seconds.

## Task 3: Check the AI Speech job status

1. Console → Analytics & AI → AI Services → Speech → Transcription Jobs.
2. Filter by your compartment and region.
3. Locate a job with display name similar to “Transcription_<sanitized-filename>”.
4. Confirm status transitions from ACCEPTED/IN_PROGRESS to SUCCEEDED.
   - If FAILED, open the job to read lifecycle_details or failure_details for troubleshooting.

> Common issues: missing service-principal policy for AI Speech to write to the transcripts bucket, region mismatch, or unsupported audio codec.

## Task 4: Retrieve the transcript from Object Storage

1. Console → Storage → Buckets → transcripts bucket (or your configured RESULT_BUCKET).
2. Navigate to the prefix:
   - transcriptions/<sanitized-filename>/
3. Locate a .json transcript file (and optionally .srt if enabled).
4. Download the .json to view all recognized spoken words and metadata.

> Note: If you don’t see the transcript immediately after SUCCEEDED, wait 30–90 seconds and refresh (eventual consistency).

## Task 5: Verify the Summary Function and view the summary

1. Console → Developer Services → Functions → Applications → ai-ms-app → Logs.
2. Open summarizer-log and look for:
   - “Summary generated successfully”
   - “Summary saved to: summaries/<base>_summary.txt”
3. Console → Storage → Buckets → summary (or your configured SUMMARY_BUCKET).
4. Navigate to:
   - summaries/<base>_summary.txt
5. Download and open the file to review the plain-text summary and action items.

## Task 6: Confirm email notification

1. Check your inbox for an email from OCI Notifications with a subject like:
   - “Meeting Summary: <base>”
2. Open the email and review the summary content (truncated if very long) and the storage location reference.

> If you don’t see the email, verify that your subscription is CONFIRMED and that the function has permission to use ons-topics.

## Validation

- Transcribe Function logs show a job created with a job OCID
- AI Speech job shows SUCCEEDED
- Transcript .json exists under transcripts/transcriptions/<sanitized-filename>/
- Summary .txt exists under summary/summaries/<base>_summary.txt
- Email notification received

## Troubleshooting quick tips

- No Transcribe Function logs:
  - Ensure Events rule is Enabled and filters bucketName=upload; verify function/application/compartment selections.
- AI Speech job FAILED:
  - Open job details for lifecycle_details/failure_details; confirm the tenancy-level policy allowing the ai_speech service to manage objects in the transcripts bucket (and KMS permissions if using a CMK).
- Transcript missing after SUCCEEDED:
  - Wait and refresh (eventual consistency), confirm RESULT_BUCKET name and region.
- Summary missing:
  - Check summarizer logs for configuration issues (GENAI_MODEL_ID, SUMMARY_BUCKET, OCI_REGION, OBJECT_NS, ONS_TOPIC_OCID).
  - Ensure Generative AI client is using the correct regional endpoint.
- Email missing:
  - Confirm the Notifications subscription status is CONFIRMED; check function logs for publish_message success.

## Learn More

- AI Speech: https://docs.oracle.com/iaas/Content/speech/home.htm
- Generative AI: https://docs.oracle.com/iaas/Content/generative-ai/home.htm
- Notifications: https://docs.oracle.com/iaas/Content/Notification/home.htm
- Events: https://docs.oracle.com/iaas/Content/Events/Concepts/eventsoverview.htm
- Logging: https://docs.oracle.com/iaas/Content/Logging/Concepts/loggingoverview.htm

## Acknowledgements

- **Author** - **Josiah Oriendo**, Cloud Architect
- **Last Updated By/Date** - Josiah Oriendo, February 2026