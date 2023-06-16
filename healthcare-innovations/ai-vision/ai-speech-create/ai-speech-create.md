# Lab 13: Create Speech Transcription Job

## Introduction

This lab walks you through organising an image library in OCI Object Storage. You will load images to Object Storage directly from your laptop using OCI CLI. There are other options to upload images to object storage, such as using OCI Cloud Shell.
 
Estimated time: 30 minutes

### About OCI Object Storage

OCI Object Storage service is an internet-scale, high-performance storage platform that offers reliable and cost-efficient data durability. The Object Storage service can store an unlimited amount of unstructured data of any content type, including analytic data and rich content, like images and videos.

### Objectives

In this lab, you will:
 
* Generate Audio File
* Upload Audio file to OCI Bucket 
* Create Speech Transcription Job
* View Transcription Output files

### Prerequisites

This lab assumes you have:

* Completed **Setup environment** and **Setup OCI CLI** lab and already logged into OCI console

## Task 1: Generate Audio File (.wav or .mp3 format)  

Use tools such as [Audacity](https://www.audacityteam.org/download/) or Apple QuickTime Player to convert your Audio into .wav or .mp3 files; alternatively, you can also download Audio files from any external sources. 

![Generate Audio file](images/audacity.png " ")
 
## Task 2: Upload Audio file to OCI Bucket

On cloud.oracle.com, Navigate to the bucket where you wish to upload the input audio files, select a folder under that bucket, and click the upload button.

![Upload Audio file](images/upload-file-001.png " ")

Browse and upload file from your local file system.

![Speech Transcription Job](images/upload-file-002.png " ")

## Task 3: Create Speech Transcription Job

On cloud.oracle.com, Navigate to Analytics & AI, and Select Speech under AI Services
 
![Speech Transcription Job](images/speech-transcription-000.png " ")

Review the overview tab, and go through the Oracle Documentation links. 

![Speech Transcription Job](images/speech-transcription-021.png " ")

Click on Jobs and provide basic information. 

![Speech Transcription Job](images/speech-transcription-023.png " ")

You can also provide a prefix to optional output folder under the selected Bucket.

![Speech Transcription Job](images/speech-transcription-024.png " ")

Choose OCI Bucket and then select the file which was uploaded. Click on the Submit button.

![Speech Transcription Job](images/speech-transcription-025.png " ")

The speech transcription job will change from creating status to active status within few seconds.
 
![Speech Transcription Job](images/speech-transcription-026.png " ")

![Speech Transcription Job](images/speech-transcription-022.png " ")

## Task 4: View Output files

Click on the Active Speech Job for more details.

![Speech Transcription Job](images/speech-transcription-027.png " ")

Click on Output Bucket

![Speech Transcription Job](images/speech-transcription-028.png " ")

Download the JSON Output Object

![Speech Transcription Job](images/speech-transcription-029.png " ")

Open the JSON file in a browser like Firefox or any notepad, review the JSON structure.

![Speech Transcription Job](images/speech-transcription-031.png " ")

Rename the .srt to .txt file and open it in any text editor.

![Speech Transcription Job](images/speech-transcription-030.png " ")
 

This concludes this lab. You can **proceed now to the next lab**.

## Learn More

[Speech Transcription Jobs](https://docs.oracle.com/en-us/iaas/Content/speech/using/create-trans-job.htm) 
 
## Acknowledgements

* **Author** - Madhusudhan Rao B M, Principal Product Manager, Oracle Database
* **Last Updated By/Date** - May 23rd, 2023.