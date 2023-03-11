# Provisioning Media Services using Terraform

## Prerequisites

- Familiarity with Media Services components

- Working knowledge of terraform

## Deployment Steps

1. Update the [variable](tf-json/variables.tf) file with required information for the terraform execution.
2. make sure you have the latest terraform. These were executed in below environment:

   ```
    <copy>Terraform v1.3.1
    provider registry.terraform.io/hashicorp/oci v4.98.0</copy>
   ```

3. Download the files (both \*.tf and JSON/\*.json)
4. Initiate the Terraform

   ```
    <copy>$ terraform init</copy>
   ```
5. Validate the content
   ```
   <copy>$ terraform validate</copy>
   ``` 
6. Make sure the Plan works 
   ```
   <copy>$ terraform plan</copy>
   ```
7. Apply the Terraform 
   ```
   <copy>$ terraform apply</copy>
   ``` 
8. After apply the output should get you the direct URL to upload the video file.
   ```
   <copy>Apply complete! Resources: 8 added, 0 changed, 0 destroyed.

    Outputs:

    comment = "You can either use the PAR URL to upload your content directly or use OCI Console to upload the video object"
    media_workflow_id = "ocid1.mediaworkflow.oc1.phx.yourworkflowid"
    upload_objects_to = "https://console.us-phoenix-1.oraclecloud.com/object-storage/buckets/yournamespace/Demo_source/objects"
    using_par_document_reference = "https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/usingpreauthenticatedrequests.htm"</copy>
   ```
9.  Upload your video to the bucket
    
10. Navigate to the console & Run the Media Workflow Job.
    ![Run job from console](images/run_job_console.png " ")
11. Select the video that you uploaded and submit job.
    ![Select video and submit job](images/select_video_submit_job.png " ")
12. Once the Job is complete, you can navigate to the Distribution Channel and gather the preview URL for playback.

## Acknowledgements
- **Author** - Sathya Velir - OCI Media Services
- **Last Updated By/Date** - Sathya Velir, November 2022