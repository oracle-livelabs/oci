# Python & JAVA SDK

In this lab we will explore some of the common API that can be provisioned using Python & Java SDK.

## Prerequisites

- Familiarity with Media Flow and Media Streams using OCI Console.
- Download the required json files in your development environment.
- Understand in setting up SDK for [Java](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/javasdk.htm#SDK_for_Java) or [Python](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/pythonsdk.htm#SDK_for_Python)

## Python

Make sure you have installed the latest OCI SDK for python and setup a virtual env as best practise. 


### Media Flow

Sample Code Walk-through

1. Instantiate the Media Services Client

```
<copy># Media Client for all operations instatiated
# endpoint defines which client launched region 
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

The code shows how to use instance principal , however supported like other OCI services to have user principal or resource principal

1. Create Tasks

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

The tasks are the essential part of the program which determines how a video needs to be processed

3. Create Media Workflow

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

This creates a Media Workflow in the Media Flow product and ready for jobs to be submitted against this Workflow.

4. Create Media Workflow Job

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

Update the variables corresponding value { }
Lets pull this code together with main function and imports

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

1. Authenticate Clients, here shown with Instance Principal

```
<copy># Media Client for all operations instantiated
# endpoint defines which client launched region 
def ConnectMediaService():
  try:
    signer = oci.auth.signers.InstancePrincipalsSecurityTokenSigner()
    media_client = oci.media_services.MediaServicesClient(config={}, signer=signer)
  except:
    print ("Media Client Instantiation Problem")

  finally:
    print("Step : Successfully instantiated Media Client")
  
  return media_client

# Instantiate the mediastreams client 
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

2. Create Distribution Channel

```
<copy>#def CreateDistributionChannel(media_client):
  response_create_distribution_channel = media_client.create_stream_distribution_channel(oci.media_services.models.CreateStreamDistributionChannelDetails(compartment_id=ubx_compartment_id,display_name="test_sdk"))
  print("Step : Created Distribution Channel")
  return response_create_distribution_channel.data.id</copy>
```

3. Configure the CDN , shown is the OCI Edge

```
<copy># Create the CDN configuration , for now this will be using OCI Edge
def CreateStreamCDN(media_client,distribution_channel_id):
  response_create_stream_cdn = media_client.create_stream_cdn_config(oci.media_services.models.CreateStreamCdnConfigDetails(display_name="test_sdk",distribution_channel_id=distribution_channel_id,is_enabled=True,config=oci.media_services.models.StreamCdnConfigSection(type ="EDGE")))
  print("Step: Created Stream CDN")
  return response_create_stream_cdn.data.id</copy>
```

4. Setup Packaging , configure HLS packaging with no encryption

```
<copy># Create the configuration for packaging the stream data.
def CreateStreamPackage(media_client,distribution_channel_id):
  # If you need Encrypted Stream, you can enable the below line and comment the other line below it.
  #response_create_stream_package = media_client.create_stream_packaging_config(oci.media_services.models.CreateStreamPackagingConfigDetails(distribution_channel_id=distribution_channel_id,display_name="test_sdk",stream_packaging_format="HLS",segment_time_in_seconds=20,encryption=oci.media_services.models.StreamPackagingConfigEncryption(algorithm="AES128")))
  response_create_stream_package = media_client.create_stream_packaging_config(oci.media_services.models.CreateStreamPackagingConfigDetails(distribution_channel_id=distribution_channel_id,display_name="test_sdk",stream_packaging_format="HLS",segment_time_in_seconds=20,encryption=oci.media_services.models.StreamPackagingConfigEncryption(algorithm="NONE")))
  print("Step : Created Stream Packaging")
  return response_create_stream_package.data.id</copy>

```

5. Create Asset ID for the master playlist that needs to be streamed

```
<copy># Create asset OCID from the provided master playlist
def CreateMediaAsset(media_client,bucket_name,asset_name):
  response_create_media_asset = media_client.create_media_asset(oci.media_services.models.CreateMediaAssetDetails(bucket_name=bucket_name,compartment_id=ubx_compartment_id,display_name="test_sdk",namespace_name=namespace,object_name=asset_name,type="PLAYLIST"))
  print("Step : Created Asset ID for Object in Bucket")
  return response_create_media_asset.data.id</copy>
```

5. Ingest master playlist asset from Media Flow generated HLS output

```
<copy># Ingest the Asset OCID into distribution channel
def IngestAssetStream(media_client,distribution_channel_id,media_asset_id):
  response_ingest_asset_stream = media_client.ingest_stream_distribution_channel(stream_distribution_channel_id=distribution_channel_id,ingest_stream_distribution_channel_details=oci.media_services.models.AssetMetadataEntryDetails(ingest_payload_type="ASSET_METADATA_MEDIA_ASSET",media_asset_id=media_asset_id,compartment_id=ubx_compartment_id))
  print("Step: Ingesting Asset to Distribution Channel")
  return response_ingest_asset_stream.data.media_workflow_job_id</copy>
```

Wait for Ingest job to complete and can be checked for the ingest status

```
<copy># Status on the Ingest Job
def CheckIngestJobStatus(media_client,ingest_job_id):
  ingest_job_check=media_client.get_media_workflow_job(media_workflow_job_id=ingest_job_id)
  return ingest_job_check.data.lifecycle_state</copy>
```

6. Generate the Session Token

```
<copy># Generate session token 
def GenerateSessionToken(media_streams_client,stream_package_id,media_asset_id):
  session_token= media_streams_client.generate_session_token(generate_session_token_details=oci.media_services.models.GenerateSessionTokenDetails(packaging_config_id=stream_package_id,scopes=["PLAYLIST","EDGE"],asset_ids=[media_asset_id]))
  return session_token.data.token</copy>
```

Update the variable ubx_compartment_id and namespace
Lets pull the code together with main function and imports

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

## Java code

Ensure you have the latest Java OCI SDK and setup the required Classpath to perform the below test program.

### Media Flow

1. Create the Media Client

```
<copy>// Create Media Service Client.
    public static MediaServicesClient connectMediaService(){
        InstancePrincipalsAuthenticationDetailsProvider provider = InstancePrincipalsAuthenticationDetailsProvider.builder().build();
        MediaServicesClient mediaClient =  new MediaServicesClient(provider);
        // User Principal
        // Read config from the profile DEFAULT in the file "~/.oci/config". You can switch to different profile.
        // AuthenticationDetailsProvider authenticationDetailsProvider = new ConfigFileAuthenticationDetailsProvider(PROFILE_DEFAULT);
        // MediaServicesClient mediaClient = MediaServicesClient.builder().build(authenticationDetailsProvider);
        MediaflowDemoApp.printString("Media Client Instantiated");
        return mediaClient;
    }
    // Close Media Service Client
    public static void closeMediaService(MediaServicesClient mc){
        mc.close();
        MediaflowDemoApp.printString("Media Client Closed");
    }</copy>
```

2. Create the tasks

```
<copy>// Create Tasks 
    // Tasks are discrete steps in the workflow.
    public static List<MediaWorkflowTask> createTasks(JSONObject arg0,JSONObject arg1,JSONObject arg2,JSONObject arg3,JSONObject arg4){
        long version = 1;
        List<MediaWorkflowTask> task = new ArrayList<MediaWorkflowTask>();
        List<String> typeGetFiles = new ArrayList<String>();
        List<String> typeTranscode = new ArrayList<String>();
        List<String> typeThumbnail = new ArrayList<String>();
        typeGetFiles.add("getFiles");
        typeTranscode.add("transcode1");
        typeThumbnail.add("thumbnail");
        task.add(MediaWorkflowTask.builder().type("getFiles").version(version).key("getFiles").prerequisites(Collections.emptyList()).parameters(arg0).build());
        task.add(MediaWorkflowTask.builder().type("transcribe").version(version).key("transcribe").prerequisites(typeGetFiles).parameters(arg4).build());
        task.add(MediaWorkflowTask.builder().type("transcode").version(version).key("transcode1").prerequisites(typeGetFiles).parameters(arg1).build());
        task.add(MediaWorkflowTask.builder().type("thumbnail").version(version).key("thumbnail").prerequisites(typeTranscode).parameters(arg2).build());
        task.add(MediaWorkflowTask.builder().type("putFiles").version(version).key("PutFiles1").prerequisites(typeThumbnail).parameters(arg3).build());
        return task;
    }</copy>
```

3. Create the Media Workflow

```
<copy>// Create Media Workflow.
    public static MediaWorkflow createMediaWorkflow(MediaServicesClient mc, List<MediaWorkflowTask> tasks, JSONObject parameters,String compartment_id){
        CreateMediaWorkflowRequest  request = CreateMediaWorkflowRequest.builder().createMediaWorkflowDetails(CreateMediaWorkflowDetails.builder().displayName("test-java-sdk").compartmentId(compartment_id).tasks(tasks).parameters(parameters).build()).build();
        CreateMediaWorkflowResponse response = mc.createMediaWorkflow(request);
        MediaWorkflow mediaflow = response.getMediaWorkflow();
        return mediaflow;
    }</copy>
```

4. Create the Media Workflow Job

```
<copy>// Create Media Workflow Job
    public static MediaWorkflowJob createWorkflowJob(MediaServicesClient mc, MediaWorkflow mediaflow, String prefixInput, JSONObject parameters, String compartment_id){
        String mediaWorkflowId = mediaflow.getId();
        CreateMediaWorkflowJobRequest request = CreateMediaWorkflowJobRequest.builder().createMediaWorkflowJobDetails(CreateMediaWorkflowJobByIdDetails.builder().displayName("test-java-sdk-job").compartmentId(compartment_id).mediaWorkflowId(mediaWorkflowId).parameters(parameters).build()).build();
        CreateMediaWorkflowJobResponse response = mc.createMediaWorkflowJob(request);
        MediaWorkflowJob mediaflowJob = response.getMediaWorkflowJob();
        return mediaflowJob;
    }</copy>
```

5. Other required function

```
<copy>// Get User Input
    public static String getUserInput(){
        MediaflowDemoApp.printString("Enter a name for the prefix of files:");
        Scanner input = new Scanner(System.in);
        String prefixInput = input.nextLine();
        input.close();
        return prefixInput;
    }
    // Json String to Json Object
    public static JSONObject createJSONObject(String jsonString){
        JSONObject  jsonObject=new JSONObject();
        JSONParser jsonParser=new  JSONParser();
        if ((jsonString != null) && !(jsonString.isEmpty())) {
            try {
                jsonObject=(JSONObject) jsonParser.parse(jsonString);
            } catch (org.json.simple.parser.ParseException e) {
                e.printStackTrace();
            }
        }
        return jsonObject;
    }
    // Print Function
    public static void printString(Object stringtoPrint){
        System.out.println(stringtoPrint);
    }</copy>
```

6. Imports required

```

<copy>import com.oracle.bmc.auth.InstancePrincipalsAuthenticationDetailsProvider;
import com.oracle.bmc.auth.AuthenticationDetailsProvider;
import com.oracle.bmc.auth.ConfigFileAuthenticationDetailsProvider;
import com.oracle.bmc.mediaservices.MediaServicesClient;
import com.oracle.bmc.mediaservices.*;
import com.oracle.bmc.mediaservices.model.MediaWorkflowTask;
import com.oracle.bmc.mediaservices.model.CreateMediaWorkflowDetails;
import com.oracle.bmc.mediaservices.responses.CreateMediaWorkflowResponse;
import com.oracle.bmc.mediaservices.model.MediaWorkflow;
import com.oracle.bmc.mediaservices.requests.*;
import com.oracle.bmc.mediaservices.model.CreateMediaWorkflowJobDetails;
import com.oracle.bmc.mediaservices.model.CreateMediaWorkflowJobByIdDetails;
import com.oracle.bmc.mediaservices.responses.CreateMediaWorkflowJobResponse;
import com.oracle.bmc.mediaservices.model.MediaWorkflowJob;
import org.json.simple.*; 
import org.json.simple.parser.*;
import java.util.Collections;
import java.util.*;
import java.util.Scanner;</copy>

```

7. Update the variables and main function.

```
    <copy>public static void main(String[] args) {
        // **Variable Declarations** //
        String compartment_id = "ocid1.compartment.oc1..aaaaaaaabhuut4zoztxlfneotrwuauqt5wjhmj4kxaka6ajme4ipxqlcwv6a";
        String src_bucket = "test";
        String dst_bucket = "test";
        String namespace = "test";
        String src_video = "test";
        String prefix_input = "test";

        //* Task Parameters *//
        String getobjectParameters = "{\"taskParameters\": [{\"storageType\": \"objectStorage\",\"target\": \"getFiles/${/input/objectName}\",\"namespaceName\": \"${/input/namespaceName}\",\"bucketName\": \"${/input/bucketName}\",\"objectName\": \"${/input/objectName}\"}]}";
        String transcodeParameters = "{ \"transcodeType\": \"standardTranscode\", \"standardTranscode\": { \"input\": \"${/getFiles/taskParameters/0/target}\", \"outputPrefix\": \"${/transcode/outputPrefix}\", \"videoCodec\": \"h264\", \"audioCodec\": \"aac\", \"packaging\": { \"packageType\": \"hls\", \"segmentLength\": 6 }, \"ladder\": [ { \"size\": { \"height\": 1080, \"resizeMethod\": \"scale\" } }, { \"size\": { \"height\": 720, \"resizeMethod\": \"scale\" } }, { \"size\": { \"height\": 480, \"resizeMethod\": \"scale\" } }, { \"size\": { \"height\": 360, \"resizeMethod\": \"scale\" } } ] } }";
        String thumbnailParameters = "{ \"thumbnails\": { \"input\": \"${/getFiles/taskParameters/0/target}\", \"frameSelectors\": [ { \"namePrefix\": \"thumb\", \"format\": \"jpg\", \"sizes\": [ { \"width\": 390 }, { \"width\": 196 } ], \"clipImagePicker\": { \"percentList\": { \"pickList\": [ 10, 20, 30 ] } } } ] } }";
        String finaltaskParameters = "{ \"taskParameters\": [ { \"namespaceName\": \"${/output/namespaceName}\", \"bucketName\": \"${/output/bucketName}\", \"source\": \"${/transcode/outputPrefix}*.m3u8\", \"objectName\": \"${/output/objectNamePath}${/transcode/outputPrefix}\", \"assetCompartmentId\": \"${/output/assetCompartmentId}\", \"registerMetadata\": true }, { \"namespaceName\": \"${/output/namespaceName}\", \"bucketName\": \"${/output/bucketName}\", \"source\": \"master.m3u8\", \"objectName\": \"${/output/objectNamePath}${/transcode/outputPrefix}-master.m3u8\", \"assetCompartmentId\": \"${/output/assetCompartmentId}\", \"registerMetadata\": true }, { \"namespaceName\": \"${/output/namespaceName}\", \"bucketName\": \"${/output/bucketName}\", \"source\": \"*.fmp4\", \"objectName\": \"${/output/objectNamePath}\", \"assetCompartmentId\": \"${/output/assetCompartmentId}\", \"registerMetadata\": true }, { \"namespaceName\": \"${/output/namespaceName}\", \"bucketName\": \"${/output/bucketName}\", \"source\": \"*.${/thumbnail/thumbnails/frameSelectors/0/format}\", \"objectName\": \"${/output/objectNamePath}${/transcode/outputPrefix}-\", \"assetCompartmentId\": \"${/output/assetCompartmentId}\", \"registerMetadata\": true } ] }";
        String transcibeParmeters = "{ \"inputVideo\": \"${/getFiles/taskParameters/0/target}\", \"outputAudio\": \"${/output/objectNamePath}${/transcode/outputPrefix}.wav\", \"outputBucketName\": \"${/output/bucketName}\", \"outputNamespaceName\": \"${/output/namespaceName}\", \"outputTranscriptionPrefix\": \"${/output/objectNamePath}${/transcode/outputPrefix}\", \"transcriptionJobCompartment\": \"${/output/assetCompartmentId}\", \"waitForCompletion\" : true }";
        String mediaworkflowParameters = "{ \"input\": { \"objectName\": \"${/video/srcVideo}\", \"bucketName\": \"${/video/srcBucket}\", \"namespaceName\": \"${/video/namespace}\" }, \"output\": { \"bucketName\": \"${/video/dstBucket}\", \"namespaceName\": \"${/video/namespace}\", \"assetCompartmentId\": \"${/video/compartmentID}\", \"objectNamePath\": \"sdk_test/${/input/objectName}/\" }, \"transcode\": { \"outputPrefix\": \"${/video/outputPrefixName}\" } }";
        String mediaflowjobParameters = "{ \"video\": { \"srcBucket\": \"" + src_bucket+ "\", \"dstBucket\": \"" +dst_bucket+ "\", \"namespace\": \"" +namespace+ "\", \"compartmentID\": \""+compartment_id+"\", \"srcVideo\": \""+src_video+"\", \"outputPrefixName\" : \""+prefix_input+"\" } }";
        //* Json Objects of the task parameters *//
        JSONObject getobjectParametersJson = MediaflowDemoApp.createJSONObject(getobjectParameters);
        JSONObject transcodeParametersJson = MediaflowDemoApp.createJSONObject(transcodeParameters);
        JSONObject thumbnailParametersJson = MediaflowDemoApp.createJSONObject(thumbnailParameters);
        JSONObject finaltaskParametersJson = MediaflowDemoApp.createJSONObject(finaltaskParameters);
        JSONObject transcibeParmetersJson = MediaflowDemoApp.createJSONObject(transcibeParmeters);
        JSONObject mediaworkflowParametersJson = MediaflowDemoApp.createJSONObject(mediaworkflowParameters);
        JSONObject mediaflowjobParametersJson = MediaflowDemoApp.createJSONObject(mediaflowjobParameters);
        
        /* Debug JSON Prints
        MediaflowDemoApp.printString(getobjectParametersJson);
        MediaflowDemoApp.printString(transcodeParametersJson);
        MediaflowDemoApp.printString(thumbnailParametersJson);
        MediaflowDemoApp.printString(finaltaskParametersJson);
        MediaflowDemoApp.printString(transcibeParmetersJson);
        MediaflowDemoApp.printString(mediaworkflowParametersJson);
        MediaflowDemoApp.printString(mediaflowjobParametersJson);*/
        
        // Get User Input
        String prefixInput = MediaflowDemoApp.getUserInput();
        // Create the tasks for mediaflow
        List<MediaWorkflowTask> tasks = MediaflowDemoApp.createTasks(getobjectParametersJson,transcodeParametersJson,thumbnailParametersJson,finaltaskParametersJson,transcibeParmetersJson);
        // Connect to media services 
        MediaServicesClient mediaClient = MediaflowDemoApp.connectMediaService();
        // Create MediaWorkFlow 
        MediaWorkflow mediaflow = MediaflowDemoApp.createMediaWorkflow(mediaClient, tasks, mediaworkflowParametersJson, compartment_id);
        // Prints MediaWorkflow OCID
        MediaflowDemoApp.printString(mediaflow.getId());
        // Create the Workflow Job
        MediaWorkflowJob mediaflowJob = MediaflowDemoApp.createWorkflowJob(mediaClient, mediaflow, prefixInput, mediaflowjobParametersJson, compartment_id);
        // Print Workflow Job ID
        MediaflowDemoApp.printString(mediaflowJob.getId());
        // Finally Close the Media Client
        MediaflowDemoApp.closeMediaService(mediaClient);
    }</copy>
```

Code is also available at OCI Media Flow [landing page.](https://www.oracle.com/cloud/media-flow/)

### Media Streams

1. Create Media Clients required to interact with the service.

```
<copy>// Media Client Creation by default with Instance Principal.
    // Toggle the other java lines in this code for User Principal.
    public static MediaServicesClient connectMediaService(){
        InstancePrincipalsAuthenticationDetailsProvider provider = InstancePrincipalsAuthenticationDetailsProvider.builder().build();
        MediaServicesClient mediaClient =  new MediaServicesClient(provider);
        // User Principal
        // Read config from the profile DEFAULT in the file "~/.oci/config". You can switch to different profile.
        // AuthenticationDetailsProvider authenticationDetailsProvider = new ConfigFileAuthenticationDetailsProvider(PROFILE_DEFAULT);
        // MediaServicesClient mediaClient = MediaServicesClient.builder().build(authenticationDetailsProvider);
        return mediaClient;
    }
    // Closing Media Client
    public static void closeMediaService(MediaServicesClient mc,MediaStreamClient ms){
        mc.close();
        ms.close();
        MediastreamsDemoApp.printString("\n", "Media Clients are Closed");
    }
    // Create Media Streams Client 
    // Default this program creates using Instance Principal
    public static MediaStreamClient connectMediaStreams(StreamDistributionChannel dc){
        String endpoint = dc.getDomainName();
        InstancePrincipalsAuthenticationDetailsProvider provider = InstancePrincipalsAuthenticationDetailsProvider.builder().build();
        MediaStreamClient mediaStreamsClient =  new MediaStreamClient(provider);
        // User Principal
        // Read config from the profile DEFAULT in the file "~/.oci/config". You can switch to different profile.
        // AuthenticationDetailsProvider authenticationDetailsProvider = new ConfigFileAuthenticationDetailsProvider(PROFILE_DEFAULT);
        // MediaStreamClient mediaStreamsClient = MediaStreamClient.builder().build(authenticationDetailsProvider);
        mediaStreamsClient.setEndpoint("https://"+endpoint);
        MediastreamsDemoApp.printString("\n" ,"Media Streams Client Instatiated Successfully");
        return mediaStreamsClient;
    }</copy>
```

2. Create Distribution Channel

```
<copy>// Create Distribution Channel 
    public static StreamDistributionChannel createDistributionChannel(MediaServicesClient mc, String compartment_id){
        CreateStreamDistributionChannelRequest  request = CreateStreamDistributionChannelRequest.builder().createStreamDistributionChannelDetails(CreateStreamDistributionChannelDetails.builder().displayName("test-java-sdk").compartmentId(compartment_id).build()).build();
        CreateStreamDistributionChannelResponse response = mc.createStreamDistributionChannel(request);
        StreamDistributionChannel dc = response.getStreamDistributionChannel();
        return dc;
    }</copy>
```

3. Create CDN Configuration, in this example, we use OCI Edge

```
<copy>//Create CDN - In this case, its OCI Edge.
    public static void createCDN(MediaServicesClient mc, String compartment_id, StreamDistributionChannel dc){
        String channelId = dc.getId();
        CreateStreamCdnConfigRequest  request = CreateStreamCdnConfigRequest.builder().createStreamCdnConfigDetails(
                                                                        CreateStreamCdnConfigDetails.builder().displayName("test-java-sdk").isEnabled(true).distributionChannelId(channelId).config(EdgeStreamCdnConfig.builder().build()).build()).build();
        CreateStreamCdnConfigResponse response = mc.createStreamCdnConfig(request);
        StreamCdnConfig cdnConfig = response.getStreamCdnConfig();
    }</copy>
```

4. Create Stream Packaging configuration to specify if the streams need encryption, length of the stream segment.

```
<copy>// Create Streaming Package Configuration 
    // By default Unencrypted in this code. 
    public static StreamPackagingConfig createStreamPackage(MediaServicesClient mc, StreamDistributionChannel dc){
        String channelId = dc.getId();
        // Unencrypted Stream
        CreateStreamPackagingConfigRequest  request = CreateStreamPackagingConfigRequest.builder().createStreamPackagingConfigDetails(CreateStreamPackagingConfigDetails.builder().displayName("test-java-sdk").distributionChannelId(channelId).streamPackagingFormat(CreateStreamPackagingConfigDetails.StreamPackagingFormat.valueOf("Hls")).segmentTimeInSeconds(6).encryption(StreamPackagingConfigEncryptionNone.builder().build()).build()).build();
        // AES 128 encrypted stream
        //CreateStreamPackagingConfigRequest  request = CreateStreamPackagingConfigRequest.builder().createStreamPackagingConfigDetails(CreateStreamPackagingConfigDetails.builder().displayName("test-java-sdk").distributionChannelId(channelId).streamPackagingFormat(CreateStreamPackagingConfigDetails.StreamPackagingFormat.valueOf("Hls")).segmentTimeInSeconds(6).encryption(StreamPackagingConfigEncryptionAes128.builder().build()).build()).build();
        CreateStreamPackagingConfigResponse response = mc.createStreamPackagingConfig(request);
        StreamPackagingConfig packageConfig = response.getStreamPackagingConfig();
        return packageConfig;
    }</copy>
```

5. Create Asset ID for the master playlist that is to be ingested.
This is needed only if the master playlist was not registered to asset db as part of the media flow.

```
<copy>// Create Media Asset ID for given master playlist 
    public static MediaAsset createAsset(MediaServicesClient mc, String inputBucket,String masterPlayList, String namespace, String compartmentId){
        CreateMediaAssetRequest  request = CreateMediaAssetRequest.builder().createMediaAssetDetails(CreateMediaAssetDetails.builder().bucketName(inputBucket).displayName("test-java-sdk").objectName(masterPlayList).namespaceName(namespace).type(AssetType.valueOf("Playlist")).compartmentId(compartmentId).build()).build();
        CreateMediaAssetResponse response = mc.createMediaAsset(request);
        MediaAsset mediaAsset = response.getMediaAsset();
        return mediaAsset;
    }</copy>
```

6. Ingest the master playlist with the asset id from previous step.

```
<copy>// Ingest the Master Playlist to Distribution Channel 
    public static IngestStreamDistributionChannelResult ingestAsset(MediaServicesClient mc, MediaAsset ma, StreamDistributionChannel dc, String compartmentId){
        String assetId = ma.getId();
        String channelId = dc.getId();
        IngestStreamDistributionChannelRequest request = IngestStreamDistributionChannelRequest.builder().ingestStreamDistributionChannelDetails(AssetMetadataEntryDetails.builder().mediaAssetId(assetId).compartmentId(compartmentId).build()).streamDistributionChannelId(channelId).build();
        IngestStreamDistributionChannelResponse response = mc.ingestStreamDistributionChannel(request);
        IngestStreamDistributionChannelResult ingestResult = response.getIngestStreamDistributionChannelResult();
        return ingestResult;
    }</copy>
```

7. we can monitor the ingest with help of ingest media flow job id.

```
<copy>// Get the Media WorkflowJob ID for the Ingest Job
    public static MediaWorkflowJob checkIngestJobStatus(MediaServicesClient mc, IngestStreamDistributionChannelResult ingestStatus) {
        String mediaWorkflowId = ingestStatus.getMediaWorkflowJobId(); 
        GetMediaWorkflowJobRequest request = GetMediaWorkflowJobRequest.builder().mediaWorkflowJobId(mediaWorkflowId).build();
        GetMediaWorkflowJobResponse response = mc.getMediaWorkflowJob(request);
        MediaWorkflowJob mediaWorkflowJob = response.getMediaWorkflowJob();
        return mediaWorkflowJob;
    }
// Check the status of the Ingest Job using above Media Workflow Job ID
    public static String jobLifecycleState(MediaServicesClient mediaClient,IngestStreamDistributionChannelResult ingestStatus){
        MediaWorkflowJob mediaWorkflowJob = MediastreamsDemoApp.checkIngestJobStatus(mediaClient,ingestStatus);
        MediaWorkflowJob.LifecycleState lifestate = mediaWorkflowJob.getLifecycleState();
        String ingestCurrentStatus = lifestate.getValue();
        return ingestCurrentStatus;
    }</copy>
```

8. Create session token for playback.

```
<copy>// Create Session Token 
    // Defaults to 24 hour validity 
    public static SessionToken generateSessionToken(MediaStreamClient ms, StreamPackagingConfig sp, MediaAsset ma){
        String streamPackagingId = sp.getId();
        String mediaAssetId = ma.getId();
        List<GenerateSessionTokenDetails.Scopes> scopes = new ArrayList<GenerateSessionTokenDetails.Scopes>();
        scopes.add(GenerateSessionTokenDetails.Scopes.valueOf("Edge")); 
        scopes.add(GenerateSessionTokenDetails.Scopes.valueOf("Playlist"));
        List<String> assetIds = new ArrayList<String>();
        assetIds.add(mediaAssetId);
        GenerateSessionTokenRequest request = GenerateSessionTokenRequest.builder().generateSessionTokenDetails(GenerateSessionTokenDetails.builder().packagingConfigId(streamPackagingId).scopes(scopes).assetIds(assetIds).build()).build();
        GenerateSessionTokenResponse response = ms.generateSessionToken(request);
        SessionToken sessionToken = response.getSessionToken();
        return sessionToken;

    }</copy>
```

9. Other required  accessr=ory functions for the program to run.

```
<copy>// User Input 
    public static String[] getUserInput(){
        String[] inputs = new String[2];
        MediastreamsDemoApp.printString("\n", "Enter name of bucket where master playlist is located:");
        Scanner input = new Scanner(System.in);
        String inputBucketName = input.nextLine();
        MediastreamsDemoApp.printString("\n","Enter name of master playlist to be ingested:");
        String inputPlaylistName = input.nextLine();
        input.close();
        inputs[0] = inputBucketName;
        inputs[1] = inputPlaylistName;
        return inputs;
    }
    // Print Function
    public static void printString(Object stringtoPrint , Object stringtoPrint2){
        System.out.println(stringtoPrint);
        System.out.println(stringtoPrint2);
    }

    public static void spinningWheel() throws InterruptedException{
        String a = "|/-\\";
        while (true) {
            for (int i = 0; i < 4; i++) {
                System.out.print("\033[0;0H");   // place cursor at top left corner
                for (int j = 0; j < 80; j++) {   // 80 character terminal width, say
                    System.out.print(a.charAt(i));
                }
                Thread.sleep(250);
            }
        }
    }</copy>
```

10. Imports required for the program

```
<copy>import com.oracle.bmc.auth.InstancePrincipalsAuthenticationDetailsProvider;
import com.oracle.bmc.auth.AuthenticationDetailsProvider;
import com.oracle.bmc.auth.ConfigFileAuthenticationDetailsProvider;
import com.oracle.bmc.mediaservices.MediaServicesClient;
import com.oracle.bmc.mediaservices.*;
import com.oracle.bmc.mediaservices.requests.*;
import com.oracle.bmc.mediaservices.responses.*;
import com.oracle.bmc.mediaservices.model.*;
import com.oracle.bmc.mediaservices.requests.CreateStreamCdnConfigRequest;
import com.oracle.bmc.mediaservices.requests.CreateStreamDistributionChannelRequest;
import com.oracle.bmc.mediaservices.requests.CreateMediaAssetRequest;
import com.oracle.bmc.mediaservices.requests.CreateStreamPackagingConfigRequest;
import com.oracle.bmc.mediaservices.requests.IngestStreamDistributionChannelRequest;
import com.oracle.bmc.mediaservices.responses.CreateMediaAssetResponse;
import com.oracle.bmc.mediaservices.responses.CreateStreamCdnConfigResponse;
import com.oracle.bmc.mediaservices.responses.CreateStreamDistributionChannelResponse;
import com.oracle.bmc.mediaservices.responses.CreateStreamPackagingConfigResponse;
import com.oracle.bmc.mediaservices.responses.IngestStreamDistributionChannelResponse;
import com.oracle.bmc.mediaservices.model.IngestStreamDistributionChannelResult;
import com.oracle.bmc.mediaservices.model.MediaAsset;
import com.oracle.bmc.mediaservices.model.StreamCdnConfig;
import com.oracle.bmc.mediaservices.model.StreamDistributionChannel;
import com.oracle.bmc.mediaservices.model.StreamPackagingConfig;
import com.oracle.bmc.mediaservices.MediaStreamClient;
import com.oracle.bmc.mediaservices.model.CreateStreamDistributionChannelDetails;
import com.oracle.bmc.mediaservices.model.CreateStreamCdnConfigDetails;
import com.oracle.bmc.mediaservices.model.IngestStreamDistributionChannelDetails;
import com.oracle.bmc.mediaservices.requests.CreateStreamDistributionChannelRequest;
import com.oracle.bmc.mediaservices.model.EdgeStreamCdnConfig;
import com.oracle.bmc.mediaservices.model.StreamCdnConfigSection;
import com.oracle.bmc.mediaservices.model.CreateStreamPackagingConfigDetails.StreamPackagingFormat;
import com.oracle.bmc.mediaservices.model.StreamPackagingConfigEncryptionNone;
import com.oracle.bmc.mediaservices.model.AssetType;
import com.oracle.bmc.mediaservices.requests.GenerateSessionTokenRequest;
import com.oracle.bmc.mediaservices.model.GenerateSessionTokenDetails;
import com.oracle.bmc.mediaservices.requests.GetMediaWorkflowJobRequest;
import com.oracle.bmc.mediaservices.responses.GetMediaWorkflowJobResponse;
import com.oracle.bmc.mediaservices.model.MediaWorkflowJob.LifecycleState;

import org.json.simple.*; 
import org.json.simple.parser.*;
import java.util.Collections;
import java.util.*;
import java.util.Scanner;</copy>

```

11. Main Function that needs to be updated with the variable values.

```

    <copy>public static void main(String[] args) throws InterruptedException{

        // **Variable Declarations** //
        String compartment_id = "{ Compartment ID}";
        String namespace = "{namespace}";
        
        String [] inputs = MediastreamsDemoApp.getUserInput();
        String inputBucket = inputs[0];
        String masterPlayList = inputs[1];
        // Connect to media services 
        MediaServicesClient mediaClient = MediastreamsDemoApp.connectMediaService();
        MediastreamsDemoApp.printString("\n", "Media Client Instatiated Successfully");
        // Create Distribution Channel
        StreamDistributionChannel distributionChannel = MediastreamsDemoApp.createDistributionChannel(mediaClient, compartment_id);
        MediastreamsDemoApp.printString("\n Distribution Channel Created Successfully",distributionChannel.getId());
        // Configure CDN for the distribution channel
        MediastreamsDemoApp.createCDN(mediaClient, compartment_id, distributionChannel);
        // Create stream packaging Configuration
        StreamPackagingConfig streamPackageConfig = MediastreamsDemoApp.createStreamPackage(mediaClient, distributionChannel);
        MediastreamsDemoApp.printString("\n Streaming Packaging Configuration Created Successfully", streamPackageConfig.getId());
        // Create Media Asset for provided master playlist
        MediaAsset mediaAsset = MediastreamsDemoApp.createAsset(mediaClient, inputBucket, masterPlayList, namespace, compartment_id);
        MediastreamsDemoApp.printString("\n Media Asset Registered Successfully" , mediaAsset.getId());
        // Initiate Ingest of the master playlist into the Distribution channel
        IngestStreamDistributionChannelResult ingestStatus = MediastreamsDemoApp.ingestAsset(mediaClient, mediaAsset, distributionChannel, compartment_id);
        MediastreamsDemoApp.printString("\n Ingest of Asset Initiated with Job", ingestStatus.getMediaWorkflowJobId());
        // Run Loop for ingest job to complete.      
        boolean status = false;
        System.out.print("Ingesting");
        while (!status){
            String ingestValue = MediastreamsDemoApp.jobLifecycleState(mediaClient,ingestStatus);
            System.out.print(".");
            Thread.sleep(3000);
            //System.out.println(ingestCurrentStatus);
            if ((ingestValue == "SUCCEEDED") || (ingestValue == "FAILED")){
                break;
            }
        }
        String ingestOutcome = MediastreamsDemoApp.jobLifecycleState(mediaClient,ingestStatus);
        MediastreamsDemoApp.printString("\nIngest Completed with status", ingestOutcome);

        if (ingestOutcome == "SUCCEEDED") {
            // Create media Streams Client with distribution cahnnel 
            MediaStreamClient mediaStreamsClient = MediastreamsDemoApp.connectMediaStreams(distributionChannel);
            // Generate session token for the master playlist.
            SessionToken sessionToken = MediastreamsDemoApp.generateSessionToken(mediaStreamsClient, streamPackageConfig, mediaAsset);
            //MediastreamsDemoApp.printString(sessionToken.getToken());
            MediastreamsDemoApp.printString("\n\nStream Media with your player:\n\n","https://"+distributionChannel.getDomainName()+"/20211101/actions/generatePlaylist?mediaAssetId="+mediaAsset.getId()+"&streamPackagingConfigId="+streamPackageConfig.getId()+"&token="+sessionToken.getToken());
            // Close the Media Clients
            MediastreamsDemoApp.closeMediaService(mediaClient,mediaStreamsClient);
        }
        else {
            mediaClient.close();
        }

    }
}</copy>
```

Code is also available at OCI Media Streams [landing page.](https://www.oracle.com/cloud/media-streams/)

## Acknowledgements
- **Author** - Sathya Velir - OCI Media Services
- **Last Updated By/Date** - Sathya Velir, November 2022
