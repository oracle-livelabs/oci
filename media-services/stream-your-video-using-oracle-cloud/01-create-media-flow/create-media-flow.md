# Lab 1: Create Media Flow

Now that we have taken care of the IAM policy, we are ready to create our first Media Flow.

Create an OCI Object storage bucket and upload a video to be used for processing.
Ensure the bucket is in the same compartment as the Media Services IAM policies defined.
An error will be faced if no buckets are available in the compartment during  Media Flow creation.
    ![Create Bucket and Upload Video](images/bucket-error.png " ")

|**Supported Input Content**|
|---|
|**Input formats** |
|3GP,ARF,ASF,AVI,P4V,FLV,M1V,M4V,MKV,MP4,MPG,MXF,OGG,OGM,OGV,QT,RM,RMVB,WAV,WEBM,WMA,WMV|
|**Input Video Codecs**|
|H263,H264,H265,MP43,DivX,Xvid,AVC,VP6,FLV1,FLV4,VP8,MPEG-1/2,AVC/MJPG,MPEG-4,Theora,WMV2|
|**Input Audio Codecs**|
|AAC,AAC/FLAC,MP3,EAC3,MP4A,PCM,Vorbis,RAW,WMA6/7,WMA8|


1. From OCI Console main menu, Select "Analytics & AI" and then "Media Flows".
   ![mediaflows 00](images/navigate-mediaflow.png " ")
   Above is the landing page for Media Flows.
2. Create the Media Flow. Remember to choose the correct compartment where the IAM policy is defined.
  ![mediaflows 01](images/create-media-workflow.png " ")
In this section, we can perform customization to Media Flow. 

3. Task list is generated. Select the input bucket from the list where Media Flow Job can pull the video for processing. 
   ![mediaflows 02](images/task-list.png " ") 
Leave the other fields in transcode task as default for now.
4. optionally, enable the transcribe task, and it does not require additional input.
   ![mediaflows 03](images/transcribe-task.png " ") 
5. The thumbnail task can also be left in default configuration or disabled.
   ![mediaflows 04](images/thumbnail-task.png " ") 
6. Finally, select the output bucket where the transcoded video and audio files should be stored.
   ![mediaflows 05](images/output-bucket.png " ") 
7. Leave the last task streaming disabled for now, and we will discuss this usage in the next section.
8. Save the media flow and provide a name for the same.
    ![mediaflows 06](images/save-media-workflow.png " ") 
    ![mediaflows 07](images/save-media-workflow-name.png " ") 
9. Once saved, the confirmation is shown above and also prompt to run the job.
    ![mediaflows 08](images/run-job.png " ") 
10. Click "Run Job" and select the video you want to transcode; hit Run job.
    ![mediaflows 09](images/select-video-and-run-job.png " ") 
11. Once the job is submitted, watch the progress and wait for it to complete. Notice that the tasks will indicate the Media Flow job's status as it progresses. 
    ![mediaflows 10](images/job-submitted.png " ") 
    ![mediaflows 11](images/job-progress-tasks.png " ") 
12. After the job completes, see the output files under the destination bucket.
    ![mediaflows 12](images/media-workflow-job-complete.png " ") 

## Acknowledgements
- **Author** - Sathya Velir - OCI Media Services
- **Last Updated By/Date** - Sathya Velir, November 2022
