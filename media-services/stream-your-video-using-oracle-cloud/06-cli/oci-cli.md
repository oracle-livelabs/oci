# CLI 

## Prerequisites

- Familiarity with [Oracle Cloud Infrastructure CLI](https://docs.oracle.com/en-us/iaas/tools/oci-cli/3.19.0/oci_cli_docs/oci.html)
- Download the JSON files to local execution directory.


## Media Flow

1. Set the comparment id as environment variable on the execution terminal
   
   ```
   <copy>$export compartment_id="your compartment ocid"</copy>
   ```

2. Create Media Workflow with parameters and tasks from pre-created json file.
   If you need full command output, please remove the filter "| jq '.data.id'" from below command.

   ```
   <copy>oci  media-services media-workflow create --display-name cliworkflow --compartment-id $compartment_id --tasks file://create-media-workflow-tasks.json --parameters file://create-media-workflow-parameters.json  --query data.id --raw-output</copy>
   ```
    
   output will be the media workflow id:
    **"id": "ocid1.mediaworkflow.oc1.phx.removedforsecurityreasons",**

3. Create Media Workflow Job. Update the required parameters [create-media-workflow-job.json](cli-json/create-media-workflow-job.json)

   ```
   <copy>oci  media-services media-workflow-job create-media-workflow-job-by-id --media-workflow-id ocid1.mediaworkflow.oc1.phx.yourmediaworkflowid --compartment-id $compartment_id  --parameters file://create-media-workflow-job.json --query data.id --raw-output</copy>
   ```
   
   output will be the media workflow Job ID  **ocid1.mediaworkflowjob.oc1.phx.yourmediaworkflowjobid**

4. Monitor Status of the job with above job id.
   
   ```
   <copy>oci  media-services media-workflow-job get  --media-workflow-job-id ocid1.mediaworkflowjob.oc1.phx.yourmediaworkflowjobid --query 'data."lifecycle-state"' --raw-output</copy>
   ```

5. Once Job is succeeded, you can take the output of the job information like Asset ID to ingest into Media Streams distribution channel.

    ```
    <copy>oci  media-services media-workflow-job get  --media-workflow-job-id ocid1.mediaworkflowjob.oc1.phx.yourmediaworkflowjobid  --query data.outputs</copy>
    ```

## Media Streams

1. Create Distribution Channel
   
   ```
   <copy>oci  media-services stream-distribution-channel create --compartment-id $compartment_id --display-name 'test-distribution-channel' --query data.id --raw-output</copy>
   ```

2. Capture the distribution channel domain name with output of the distribution channel id from previous command.

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

   If you already have an media asset id, then skip this step.
   If not, first generate the asset id for the master playlist with below command.

   ```
   <copy>oci  media-services media-asset create  --compartment-id $compartment_id --type PLAYLIST --bucket-name yourbuckethavingplaylist --namespace-name yournamespace --object-name yourfolder/yourmaster.m3u8 --query data.id --raw-output</copy>
   ```

    If you already have the asset id, then ingest it directly.

    ```
    <copy>oci  media-services stream-distribution-channel ingest-stream-distribution-channel-asset-metadata-entry-details  --compartment-id $compartment_id --media-asset-id ocid1.mediaasset.oc1.iad.yourmediaassetid --stream-distribution-channel-id ocid1.streamdistributionchannel.oc1.iad.yourdistributionchannelid --query 'data."media-workflow-job-id"' --raw-output</copy>
    ```

6. Generate Session Token. Remeber this one requires the domain name of the distribution channel along with packaging ID , asset ID against which we need to generate the session token.Also, update the [generate-token.json](cli-json/generate_token.json) with packaging ID and asset ID 

   ```
   <copy>oci  media-services media-stream stream-distribution-channel generate-session-token --endpoint https://yourdistributionchannel.domain.mediaservices.us-ashburn-1.oci.com --from-json file://generate_token.json --query data.token --raw-output</copy>
   ```

7. Generate Playlist. This will download the playlist locally based on --file details in the command. 
   
   ```
   <copy>oci  media-services media-stream stream-distribution-channel generate-playlist --endpoint https://yourdistributionchannel.domainname.us-ashburn-1.oci.com --stream-packaging-config-id ocid1.streampackagingconfig.oc1.iad.yourstreamingpackage.id --media-asset-id ocid1.mediaasset.oc1.iad.yourmediaasset.id --token abovetokengenerated --file last_playlist.m3u8</copy>
   ```

## Acknowledgements
- **Author** - Sathya Velir - OCI Media Services
- **Last Updated By/Date** - Sathya Velir, November 2022
