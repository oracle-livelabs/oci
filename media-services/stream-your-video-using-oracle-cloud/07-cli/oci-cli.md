# OCI CLI 

## Introduction

This lab will use the OCI command line tool Media Services APIs to transcode, stream the video.

Estimated Time: 30 minutes

### Objective 

In this lab, you will

* learning the OCI Media Services OCI CLI commands with parameters samples
* Transcode & Stream your video using OCI CLI. 
* Playback the video with Safari or VLC or other HLS players.



### Prerequisites

- Familiarity with [Oracle Cloud Infrastructure CLI](https://docs.oracle.com/en-us/iaas/tools/oci-cli/3.19.0/oci_cli_docs/oci.html)
- Download the JSON files to the local execution directory.


## Task 1: Configure Media Workflow & run job.

1. Set the compartment id as an environment variable on the execution terminal
   
   ```
   <copy>$export compartment_id="your compartment ocid"</copy>
   ```

2. Create Media Workflow with parameters and tasks from a pre-created JSON file.
   Media Workflow tasks file [create-media-workflow-tasks.json](cli-json/create-media-workflow-tasks.json)
   Media Workflow parameters file [create-media-workflow-parameters.json](cli-json/create-media-workflow-parameters.json)
   If you need total command output, please remove the filter "| jq '.data.id'" from below command.

   ```
   <copy>oci  media-services media-workflow create --display-name cliworkflow --compartment-id $compartment_id --tasks file://create-media-workflow-tasks.json --parameters file://create-media-workflow-parameters.json  --query data.id --raw-output</copy>
   ```
    
   output will be the media workflow id:
    **"id": "ocid1.mediaworkflow.oc1.phx.removedforsecurityreasons",**

3. Create Media Workflow Job. Update the required parameters [create-media-workflow-job.json](cli-json/create-media-workflow-job.json)

   ```
   <copy>oci  media-services media-workflow-job create-media-workflow-job-by-id --media-workflow-id ocid1.mediaworkflow.oc1.phx.yourmediaworkflowid --compartment-id $compartment_id  --parameters file://create-media-workflow-job.json --query data.id --raw-output</copy>
   ```
   
   The output will be the media workflow Job ID  **ocid1.mediaworkflowjob.oc1.phx.yourmediaworkflowjobid**

4. Monitor the Status of the job with the above job id.
   
   ```
   <copy>oci  media-services media-workflow-job get  --media-workflow-job-id ocid1.mediaworkflowjob.oc1.phx.yourmediaworkflowjobid --query 'data."lifecycle-state"' --raw-output</copy>
   ```

5. Once the job is succeeded, you can take the output of the job information like Asset ID to ingest into Media Streams distribution channel.

    ```
    <copy>oci  media-services media-workflow-job get  --media-workflow-job-id ocid1.mediaworkflowjob.oc1.phx.yourmediaworkflowjobid  --query data.outputs</copy>
    ```

## Task 2: Configure Media Streams & playback the video.

1. Create Distribution Channel
   
   ```
   <copy>oci  media-services stream-distribution-channel create --compartment-id $compartment_id --display-name 'test-distribution-channel' --query data.id --raw-output</copy>
   ```

2. Capture the distribution channel domain name with an output of the distribution channel id from the previous command.

   ```
   <copy>oci  media-services stream-distribution-channel list --compartment-id $compartment_id --id ocid1.streamdistributionchannel.oc1.phx.yourdistributionchannelid --query 'data.items[0]."domain-name"' --raw-output</copy>
   ```

3. Setup CDN configuration

   ```
   <copy>oci  media-services stream-cdn-config create-edge-stream-cdn-config --display-name 'test-cdn-edge' --distribution-channel-id ocid1.streamdistributionchannel.oc1.phx.yourdistributionchannelid --query data.id --raw-output</copy>
   ``` 

4. Create Packaging configuration with no encryption

   ```
   <copy>oci  media-services stream-packaging-config create-stream-packaging-config-encryption-none --display-name 'test-packaging' --distribution-channel-id ocid1.streamdistributionchannel.oc1.iad.yourdistributionchannelid --segment-time-in-seconds 6 --stream-packaging-format HLS --query data.id --raw-output</copy>
   ```
   If encryption is needed,

   ```
   <copy>oci  media-services stream-packaging-config create-stream-packaging-config-encryption-aes128 --display-name 'test-encrypted-packaging' --distribution-channel-id ocid1.streamdistributionchannel.oc1.phx.yourdistributionchannelid  --segment-time-in-seconds 6 --stream-packaging-format HLS --query data.id --raw-output</copy>
   ```

5. Ingest the asset (master playlist) from the media flow job output

   If you already have a media asset id, then skip this step.
   If not, generate the asset id for the master playlist with the below command.

   ```
   <copy>oci  media-services media-asset create  --compartment-id $compartment_id --type PLAYLIST --bucket-name yourbuckethavingplaylist --namespace-name yournamespace --object-name yourfolder/yourmaster.m3u8 --query data.id --raw-output</copy>
   ```

    If you already have the asset id, then ingest it directly.

    ```
    <copy>oci  media-services stream-distribution-channel ingest-stream-distribution-channel-asset-metadata-entry-details  --compartment-id $compartment_id --media-asset-id ocid1.mediaasset.oc1.iad.yourmediaassetid --stream-distribution-channel-id ocid1.streamdistributionchannel.oc1.iad.yourdistributionchannelid --query 'data."media-workflow-job-id"' --raw-output</copy>
    ```

6. Generate Session Token. Remember, this one requires the distribution channel's domain name, packaging ID, and asset ID, against which we need to generate the session token.Also, update the [generate-token.json](cli-json/generate_token.json) with packaging ID and asset ID 

   ```
   <copy>oci  media-services media-stream stream-distribution-channel generate-session-token --endpoint https://yourdistributionchannel.domain.mediaservices.us-ashburn-1.oci.com --from-json file://generate_token.json --query data.token --raw-output</copy>
   ```

7. Generate playlist will download the playlist locally based on --file details in the command. 
   
   ```
   <copy>oci  media-services media-stream stream-distribution-channel generate-playlist --endpoint https://yourdistributionchannel.domainname.us-ashburn-1.oci.com --stream-packaging-config-id ocid1.streampackagingconfig.oc1.iad.yourstreamingpackage.id --media-asset-id ocid1.mediaasset.oc1.iad.yourmediaasset.id --token abovetokengenerated --file last_playlist.m3u8</copy>
   ```

## Acknowledgements
- **Author** - Sathya Velir - OCI Media Services
- **Last Updated By/Date** - Sathya Velir, November 2022
