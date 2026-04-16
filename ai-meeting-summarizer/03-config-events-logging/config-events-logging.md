# Configure Events, Function Configuration, Logging, and Email Notifications

## Introduction

This lab connects your deployment components. You will configure application and function variables, attach Events rules so uploads trigger the Transcribe Function and, in turn, the Summary Function, create a Notifications topic and email subscription, and enable function logs for troubleshooting.

Estimated Time: 20–30 minutes

### Objectives

In this lab, you will:

- Set application and function configuration keys (region, namespace, buckets, model OCID, topic OCID)
- Create a Notifications topic and email subscription
- Create Events rules to trigger the Transcribe and Summary Functions on object creation
- Enable a Log Group and function logs

### Prerequisites

This lab assumes you have:

- Permissions to access Functions, Generative AI, and Notifications services

## Task 1: Create a Notifications topic and email subscription

You will publish summaries to this topic; subscribers will receive an email.

1. Navigate to **Developer Services → Application Integration → Notifications → Topics → Create Topic**

   - Name: ai-ms-topic
   - Compartment: ai-meeting-summarizer

2. Click **Create**

![Topic Creation](images/topic.png)

3. Click the topic you just created → **Subscriptions → Create Subscription**

   - Protocol: Email
   - Email: &lt;your\_email@domain&gt;

4. Click **Create**

![Email Subscription](images/sub.png)

5. Check your inbox and click **Confirm subscription**

6. Copy the Topic OCID from the topic’s **Details** page. You will use it later in the lab.

## Task 2: Attach Events rules to the Transcribe Function

Ensure new uploads trigger the Transcribe Function.

1. Navigate to **Observability & Management → Events Service → Rules → Create Rule**

   - Name: on-object-create
   - Description: Trigger transcription function
   - Rule conditions:
     - Condition: Event Type  
       Service Name: Object Storage  
       Event Type: Object - Create
     - Click **+ Another Condition**
       - Condition: Attribute  
       - Attribute Name: bucketName  
       - Attribute Values: uploads
   - Actions:
     - Action Type: Functions  
     - Function Compartment: ai-meeting-summarizer  
     - Function Application: ai-ms-app  
     - Function: transcriber

2. Click **Create Rule**

![Creating Event Rules](images/rule.png)

3. Create a second rule with the following information:

   - Name: summarize
   - Description: Trigger summarization function
   - Rule conditions:
     - Condition: Event Type  
       Service Name: Object Storage  
       Event Type: Object - Create
     - Click **+ Another Condition**
       - Condition: Attribute  
       - Attribute Name: bucketName  
       - Attribute Values: transcripts
   - Actions:
     - Action Type: Functions  
     - Function Compartment: ai-meeting-summarizer  
     - Function Application: ai-ms-app  
     - Function: summarizer

![Creating Event Rule for Summarizer Function](images/summarize.png)

## Task 3: Configure application-level variables

1. Navigate to **Analytics & AI → AI Services → Generative AI → Playground → Chat → View model details**

2. Select the **xai.grok-3** model, copy the OCID, and save it for later use

![Selecting Grok Model](images/grok.png)

3. Navigate to **Developer Services → Functions → Applications → ai-ms-app → Configuration → Manage configuration**

4. Click **Add configuration** for each key-value pair below:

   - Key: GENAI\_MODEL\_ID, Value: &lt;your-text&gt;
   - Key: UPLOAD\_BUCKET, Value: uploads
   - Key: OBJECT\_NS, Value: &lt;object\_storage\_namespace&gt;
   - Key: SUMMARY\_BUCKET, Value: results
   - Key: OCI\_REGION, Value: us-ashburn-1
   - Key: ONS\_TOPIC\_OCID, Value: &lt;topic\_OCID&gt;
   - Key: RESULT\_BUCKET, Value: transcripts
   - Key: COMPARTMENT\_OCID, Value: &lt;ai-meeting-summarizer-OCID&gt;

![Populating Application Config](images/config.png)

5. Click **Save changes**

## Task 4: Enable logging for both functions

Create a Log Group and enable function logs for observability.

1. Navigate to **Observability & Management → Logging → Log Groups → Create Log Group**

   - Name: ai-ms-log-group
   - Compartment: ai-meeting-summarizer

2. Click **Create**

![Creating Log Group](images/log_group.png)

3. Navigate to **Developer Services → Functions → Applications → ai-ms-app → Monitoring**

4. Under **Logs**, in the **Function Invocation Logs** row, click the three dots and select **Enable log**

![Monitoring Tab in Function](images/monitoring.png)

   - Compartment: ai-meeting-summarizer
   - Log group: ai-ms-log-group
   - Log name: ai-ms-logs

![Enabling Logs](images/logs.png)

You may now **proceed to the next lab**.

## Learn More

- Notifications: https://docs.oracle.com/iaas/Content/Notification/home.htm  
- Events: https://docs.oracle.com/iaas/Content/Events/Concepts/eventsoverview.htm  
- Logging: https://docs.oracle.com/iaas/Content/Logging/Concepts/loggingoverview.htm  

## Acknowledgements

- **Author** - **Josiah Oriendo**, Cloud Architect  
- **Last Updated By/Date** - Josiah Oriendo, February 2026