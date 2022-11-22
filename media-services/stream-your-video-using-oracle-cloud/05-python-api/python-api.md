# Python API

## Introduction

This lab will use the Python based Media Services APIs to transcode, stream the video.

Estimated Time: 30 minutes

### Objective 

In this lab, you will

* learning the OCI Media Services API calls with parameters samples
* Transcode & Stream your video using Python programming language. 


### Prerequisites

- Familiarity with Media Flow and Media Streams using OCI Console.
- Some familiarity of Python programming language.
- Make sure you have installed the latest OCI SDK for [Python](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/pythonsdk.htm#SDK_for_Python) and set up a virtual env as best practice. 


## Task 1: Instantiate the Media Services Client

```
<copy># Media Client for all operations instantiated
def ConnectMediaService():
  try:
    signer = oci.auth.signers.InstancePrincipalsSecurityTokenSigner()
    media_client = oci.media_services.MediaServicesClient(config={}, signer=signer)
  except:
    print ("Media Client Instantiation Problem")

  finally:
    print("Successfully instantiated Media Client")
  
  return media_client</copy>
````

The code shows how to use instance principal, however supported, like other OCI services, to have user principal or resource principal.


## Task 2: Create Tasks


```
<copy># Define Tasks 
def CreateTasks():
  getobject_parameters = {
        "taskParameters": [
          {
            "storageType": "objectStorage",
            "target": "getFiles/${/input/objectName}",
            "namespaceName": "${/input/namespaceName}",
            "bucketName": "${/input/bucketName}",
            "objectName": "${/input/objectName}"
          }
        ]
  }
  media_workflow_getobject = oci.media_services.models.MediaWorkflowTask(type="getFiles",version=1,key="getFiles",prerequisites=[],parameters=getobject_parameters)
  transcode_parameters1 = {
        "transcodeType": "standardTranscode",
        "standardTranscode": {
          "input": "${/getFiles/taskParameters/0/target}",
          "outputPrefix": "${/transcode/outputPrefix}",
          "videoCodec": "h264",
          "audioCodec": "aac",
          "packaging": {
            "packageType": "hls",
            "segmentLength": 6
          },
          "ladder": [
            {
              "size": {
                "height": 360,
                "resizeMethod": "scale"
              }
            }
          ]
        }
    }
  media_workflow_transcode1 = oci.media_services.models.MediaWorkflowTask(type="transcode",version=1,key="transcode",prerequisites=["getFiles"],parameters=transcode_parameters1)
  thumbnail_parameters = {
        "thumbnails": {
          "input": "${/getFiles/taskParameters/0/target}",
          "frameSelectors": [
            {
              "namePrefix": "thumb",
              "format": "jpg",
              "sizes": [
                {
                  "width": 390
                },
                {
                  "width": 196
                }
              ],
              "clipImagePicker": {
                "percentList": {
                  "pickList": [
                    10,
                    20,
                    30
                  ]
                }
              }
            }
          ]
        }
      }
  media_workflow_thumbnail = oci.media_services.models.MediaWorkflowTask(type="thumbnail",version=1,key="thumbnail",prerequisites=["visionDetection"],parameters=thumbnail_parameters)
  finaltask_parameters1 = {
        "taskParameters": [
          {
            "namespaceName": "${/output/namespaceName}",
            "bucketName": "${/output/bucketName}",
            "source": "${/transcode/outputPrefix}*.m3u8",
            "objectName": "${/output/objectNamePath}${/transcode/outputPrefix}",
            "assetCompartmentId": "${/output/assetCompartmentId}",
            "registerMetadata": True
          },
          {
            "namespaceName": "${/output/namespaceName}",
            "bucketName": "${/output/bucketName}",
            "source": "master.m3u8",
            "objectName": "${/output/objectNamePath}${/transcode/outputPrefix}-master.m3u8",
            "assetCompartmentId": "${/output/assetCompartmentId}",
            "registerMetadata": True
          },
          {
            "namespaceName": "${/output/namespaceName}",
            "bucketName": "${/output/bucketName}",
            "source": "*.fmp4",
            "objectName": "${/output/objectNamePath}",
            "assetCompartmentId": "${/output/assetCompartmentId}",
            "registerMetadata": True
          },
          {
            "namespaceName": "${/output/namespaceName}",
            "bucketName": "${/output/bucketName}",
            "source": "*.${/thumbnail/thumbnails/frameSelectors/0/format}",
            "objectName": "${/output/objectNamePath}${/transcode/outputPrefix}-",
            "assetCompartmentId": "${/output/assetCompartmentId}",
            "registerMetadata": True
          }
        ]
      }
  media_workflow_finaltask1 = oci.media_services.models.MediaWorkflowTask(type="putFiles",version=1,key="putFiles",prerequisites=["thumbnail"],parameters=finaltask_parameters1)
  transcribe_task_parmeters = {
        "inputVideo": "${/getFiles/taskParameters/0/target}",
        "outputAudio": "${/output/basePrefix}transcribe/${/input/objectName}.wav",
        "outputTranscriptionPrefix": "${/output/basePrefix}transcribe/",
        "outputNamespaceName": "${/output/namespaceName}",
        "outputBucketName": "${/output/bucketName}",
        "transcriptionJobCompartment": "${/output/assetCompartmentId}",
        "waitForCompletion": False,
        "language": "en"
      }
  transcribe_task = oci.media_services.models.MediaWorkflowTask(type="transcribe",version=1,key="transcribe",prerequisites=["transcode"],parameters=transcribe_task_parmeters)

  vision_task_parameters = {
        "inputObject": "${/getFiles/taskParameters/0/target}",
        "outputPrefix": "${/output/basePrefix}vision/",
        "minClipLen": "6s",
        "sceneSensitivity": 10,
        "sceneImageNamespace": "${/output/namespaceName}",
        "sceneImageBucket": "${/output/bucketName}",
        "visionTaskCompartmentId": "${/output/assetCompartmentId}",
        "cleanupImagesEnabled": False,
        "textDetectionLanguage": "ENG",
        "featureType": "OBJECT_DETECTION"
      }

  vision_task = oci.media_services.models.MediaWorkflowTask(type="visionDetection",version=1,key="visionDetection",prerequisites=["transcribe"],parameters=vision_task_parameters)
  return media_workflow_getobject,media_workflow_transcode1,media_workflow_finaltask1,transcribe_task,media_workflow_thumbnail,vision_task</copy>
```

The tasks are the essential part of the program, which determines how a video needs to be processed.

## Task 3: Create Media Workflow

```
<copy>#def CreateMediaWorkflow(media_client,media_workflow_getobject,media_workflow_transcode1,media_workflow_finaltask1,transcribe_task,media_workflow_thumbnail,vision_task):
  media_workflow_parameters = {
    "input": {
      "objectName": "${/video/srcVideo}",
      "bucketName": "${/video/srcBucket}",
      "namespaceName": "${/video/namespace}"
    },
    "output": {
      "basePrefix": "${/video/outputPrefixName}",
      "bucketName": "${/video/dstBucket}",
      "namespaceName": "${/video/namespace}",
      "assetCompartmentId": "${/video/compartmentID}",
      "objectNamePath": "sdk_test/${/input/objectName}/"   
    },
    "transcode": {
        "outputPrefix": "${/video/outputPrefixName}"
    }
  }
  # Create the workflow
  response_create_media_workflow = media_client.create_media_workflow(oci.media_services.models.CreateMediaWorkflowDetails(display_name="sdk-demo",compartment_id=ubx_compartment_id,tasks=[media_workflow_getobject,media_workflow_transcode1,media_workflow_finaltask1,transcribe_task,media_workflow_thumbnail,vision_task],parameters=media_workflow_parameters))
  return response_create_media_workflow.data.id</copy>
```

The above creates a Media Workflow in the Media Flow product and is ready for jobs to be submitted against this workflow.

## Task 4. Create Media Workflow Job

Submit jobs at this stage to run the video processing through the defined workflow.

```
<copy>#def CreateWorkflowJob(media_client,media_workflow_id,prefix_input):
  media_flow_job_json= {
    "video": {
            "srcBucket": src_bucket,
            "dstBucket": dst_bucket,
            "namespace": namespace,
            "compartmentID": ubx_compartment_id,
            "srcVideo": src_video,
            "outputPrefixName" : prefix_input
      }
  }
  response_create_media_workflow_job= media_client.create_media_workflow_job(oci.media_services.models.CreateMediaWorkflowJobByIdDetails(media_workflow_id=media_workflow_id, compartment_id=ubx_compartment_id, display_name="test_Demo-Job", parameters=media_flow_job_json))
  job_id=response_create_media_workflow_job.data.id
  status=response_create_media_workflow_job.data.lifecycle_state
  
  return job_id,status</copy>
```

## Task 5: Update the variables 

Let's pull this code together with the main function and imports.Update the variables {} with values. 

```
<copy>import oci
import json
import time
import sys
import argparse

# Define the variable before running the program

global ubx_compartment_id,namespace,src_bucket,dst_bucket,src_video
ubx_compartment_id="{compartmentOCID}"
namespace="{namespace}"
src_bucket = "{input bucket where source files are located}"
dst_bucket = "{destination bucket where the processed content to be stored}"
src_video = "{source video file}"


global media_client,media_workflow_getobject,media_workflow_transcode1
global media_workflow_finaltask1,transcribe_task,run_or_build,prefix_input,media_workflow_id,media_workflow_thumbnail



# Get user Input
def GetInput():
    run_or_build = str(input("do you want to (run) job or (build) workflow: "))
    if run_or_build.lower() == "run":
        prefix_input = str(input("Enter prefix name for output files: "))
        media_workflow_id = str(input("Enter mediaflow ID: "))
    elif run_or_build.lower() == "build":
        prefix_input = ""
        media_workflow_id = ""
        print("Building the workflow Configuration")
    else: 
        print ("Program accepts input 'run' or 'build' ")

    return media_workflow_id,run_or_build,prefix_input

def main():
  media_workflow_id,run_or_build, prefix_input = GetInput()
  media_client = ConnectMediaService()
  if run_or_build == "run":
      job_id,status = CreateWorkflowJob(media_client,media_workflow_id,prefix_input)
      print(job_id,status)
  elif run_or_build == "build":
      media_workflow_getobject,media_workflow_transcode1,media_workflow_finaltask1,transcribe_task,media_workflow_thumbnail,vision_task = CreateTasks()
      media_workflow_id = CreateMediaWorkflow(media_client,media_workflow_getobject,media_workflow_transcode1,media_workflow_finaltask1,transcribe_task,media_workflow_thumbnail,vision_task)
      print("Workflow ID: ",media_workflow_id)
  else: 
      print("Wrong Path.")
  

if __name__ == "__main__":
    main()</copy>
```

### Media Streams

Sample Code Walk-through

## Task 6: Instantiate Media Streams client

```
<copy># Media Client for all operations instantiated
def ConnectMediaService():
  try:
    signer = oci.auth.signers.InstancePrincipalsSecurityTokenSigner()
    media_client = oci.media_services.MediaServicesClient(config={}, signer=signer)
  except:
    print ("Media Client Instantiation Problem")

  finally:
    print("Step : Successfully instantiated Media Client")
  
  return media_client

# Instantiate the media streams client 
def ConnectMediaStreamsService(distribution_channel_domain_name):
  try:
    signer = oci.auth.signers.InstancePrincipalsSecurityTokenSigner()
    # This client takes the distribution channel domain name as the service endpoint.
    media_streams_client = oci.media_services.MediaStreamClient(config={}, signer=signer, service_endpoint=distribution_channel_domain_name)
  except:
    print ("Media Streaming Client Instantiation Problem")

  finally:
    print("Step : Successfully instantiated Media Streaming Client")
  
  return media_streams_client</copy>
```

## Task 7: Create Distribution Channel

```
<copy>#def CreateDistributionChannel(media_client):
  response_create_distribution_channel = media_client.create_stream_distribution_channel(oci.media_services.models.CreateStreamDistributionChannelDetails(compartment_id=ubx_compartment_id,display_name="test_sdk"))
  print("Step : Created Distribution Channel")
  return response_create_distribution_channel.data.id</copy>
```

## Task 8:  Configure the CDN (OCI Edge)

OCI Edge is origination directly from OCI. There is no CDN involved.


```
<copy># Create the CDN configuration, for now, this will be using OCI Edge
def CreateStreamCDN(media_client,distribution_channel_id):
  response_create_stream_cdn = media_client.create_stream_cdn_config(oci.media_services.models.CreateStreamCdnConfigDetails(display_name="test_sdk",distribution_channel_id=distribution_channel_id,is_enabled=True,config=oci.media_services.models.StreamCdnConfigSection(type ="EDGE")))
  print("Step: Created Stream CDN")
  return response_create_stream_cdn.data.id</copy>
```

## Task 9: Setup Packaging, configure HLS packaging with no encryption

```
<copy># Create the configuration for packaging the stream data.
def CreateStreamPackage(media_client,distribution_channel_id):
  # If you need Encrypted Stream, you can enable the below line and comment the other line below it.
  #response_create_stream_package = media_client.create_stream_packaging_config(oci.media_services.models.CreateStreamPackagingConfigDetails(distribution_channel_id=distribution_channel_id,display_name="test_sdk",stream_packaging_format="HLS",segment_time_in_seconds=20,encryption=oci.media_services.models.StreamPackagingConfigEncryption(algorithm="AES128")))
  response_create_stream_package = media_client.create_stream_packaging_config(oci.media_services.models.CreateStreamPackagingConfigDetails(distribution_channel_id=distribution_channel_id,display_name="test_sdk",stream_packaging_format="HLS",segment_time_in_seconds=20,encryption=oci.media_services.models.StreamPackagingConfigEncryption(algorithm="NONE")))
  print("Step : Created Stream Packaging")
  return response_create_stream_package.data.id</copy>

```

## Task 10:  Create an Asset ID for the master playlist that needs to be streamed

```
<copy># Create asset OCID from the provided master playlist
def CreateMediaAsset(media_client,bucket_name,asset_name):
  response_create_media_asset = media_client.create_media_asset(oci.media_services.models.CreateMediaAssetDetails(bucket_name=bucket_name,compartment_id=ubx_compartment_id,display_name="test_sdk",namespace_name=namespace,object_name=asset_name,type="PLAYLIST"))
  print("Step : Created Asset ID for Object in Bucket")
  return response_create_media_asset.data.id</copy>
```

## Task 11: Ingest master playlist asset from Media Flow generated HLS output

```
<copy># Ingest the Asset OCID into distribution channel
def IngestAssetStream(media_client,distribution_channel_id,media_asset_id):
  response_ingest_asset_stream = media_client.ingest_stream_distribution_channel(stream_distribution_channel_id=distribution_channel_id,ingest_stream_distribution_channel_details=oci.media_services.models.AssetMetadataEntryDetails(ingest_payload_type="ASSET_METADATA_MEDIA_ASSET",media_asset_id=media_asset_id,compartment_id=ubx_compartment_id))
  print("Step: Ingesting Asset to Distribution Channel")
  return response_ingest_asset_stream.data.media_workflow_job_id</copy>
```

Wait for Ingest job to complete and can be checked for the ingest status.

```
<copy># Status on the Ingest Job
def CheckIngestJobStatus(media_client,ingest_job_id):
  ingest_job_check=media_client.get_media_workflow_job(media_workflow_job_id=ingest_job_id)
  return ingest_job_check.data.lifecycle_state</copy>
```

## Task 12: Generate the Session Token

```
<copy># Generate session token 
def GenerateSessionToken(media_streams_client,stream_package_id,media_asset_id):
  session_token= media_streams_client.generate_session_token(generate_session_token_details=oci.media_services.models.GenerateSessionTokenDetails(packaging_config_id=stream_package_id,scopes=["PLAYLIST","EDGE"],asset_ids=[media_asset_id]))
  return session_token.data.token</copy>
```

## Task 13: Code together with the main function and imports

Update the variable ubx_compartment_id and namespace

```
<copy>import oci
import json
import time
import sys

##variables to be updated
global ubx_compartment_id,namespace
ubx_compartment_id="{Compartment OCID}"
namespace="{Namespace}"

global media_client,media_streams_client,run_or_build,distribution_channel_id,stream_package_id,media_asset_id,input_bucket_name

def GetInput():
    print("All the parameters are required for the program to work")
    run_or_build = str(input("do you want to (build) mediastreams configurations or (ingest) existing master playlist or generate session token (session) for ingested master playlist?: "))
    if run_or_build.lower() == "ingest":
        input_bucket_name = str(input("Provide Bucket Name where the playlist is located: "))
        input_object_name = str(input("Enter Playlist Name: "))
        distribution_channel_id = str(input("Enter Channel OCID: "))
        stream_package_id = ""
        media_asset_id = ""
    elif run_or_build.lower() == "build":
        input_bucket_name = ""
        input_object_name = ""
        distribution_channel_id = ""
        stream_package_id = ""
        media_asset_id = ""
        print("Building the Media Streams Configuration")
    else:
        input_bucket_name = ""
        input_object_name = ""
        media_asset_id = str(input("Provide the asset OCID of the ingested master playlist: "))
        stream_package_id = str(input("Enter Package Configuration OCID: "))
        distribution_channel_id = str(input("Enter distribution Channel OCID: "))
    return input_bucket_name,run_or_build,input_object_name,distribution_channel_id,stream_package_id,media_asset_id

# Find the Distribution channel name from the OCID
def ListDistributionChannel(media_client,distribution_channel_id):
  distribution_channel_response=media_client.get_stream_distribution_channel(stream_distribution_channel_id=distribution_channel_id)
  return distribution_channel_response.data.domain_name

def main():
  input_bucket_name,run_or_build,input_playlist,distribution_channel_id,stream_package_id,media_asset_id = GetInput()
  media_client = ConnectMediaService()
  if run_or_build == "build":
      distribution_channel_id = CreateDistributionChannel(media_client)
      stream_cdn_id = CreateStreamCDN(media_client,distribution_channel_id)
      stream_package_id = CreateStreamPackage(media_client,distribution_channel_id)
      print("Channel OCID: ", distribution_channel_id)
      print("Stream Configuration OCID: ", stream_package_id)
  elif run_or_build == "ingest":
    create_media_asset_id = CreateMediaAsset(media_client,input_bucket_name,input_playlist)
    ingest_asset_stream_id = IngestAssetStream(media_client,distribution_channel_id,create_media_asset_id)
    print("Waiting for Ingest Job to Complete")
    spinner = spinning_cursor()
    while True:
        sys.stdout.write(next(spinner))
        sys.stdout.flush()
        time.sleep(0.1)
        sys.stdout.write('\b')
        check_ingest_job_status = CheckIngestJobStatus(media_client,ingest_asset_stream_id)
        if check_ingest_job_status == "SUCCEEDED":
            break
        else:
            continue
    print("Ingest Completed.")
    print("Media Asset OCID: ", create_media_asset_id)
  else:
    distribution_channel_domain_name = "https://"+str(ListDistributionChannel(media_client,distribution_channel_id))
    media_streams_client = ConnectMediaStreamsService(distribution_channel_domain_name)
    session_token_id = GenerateSessionToken(media_streams_client,stream_package_id,media_asset_id)
    print("Stream URL with your player:\n",distribution_channel_domain_name+"/20211101/actions/generatePlaylist?mediaAssetId="+media_asset_id+"&streamPackagingConfigId="+stream_package_id+"&token="+str(session_token_id))

if __name__ == "__main__":
    main()</copy>
```


## Acknowledgements
- **Author** - Sathya Velir - OCI Media Services
- **Last Updated By/Date** - Sathya Velir, November 2022
