# JAVA API

## Introduction

This lab will use the Java based Media Services APIs to transcode, stream the video.

Estimated Time: 30 minutes

### Objective

In this lab, you will

* learning the OCI Media Services API calls with parameters samples
* Transcode & Stream your video either using Java programming language. 


### Prerequisites

- Familiarity with Media Flow and Media Streams using OCI Console.
- Download the required JSON files in your development environment.
- Make sure you have installed the latest OCI SDK for [Java](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/javasdk.htm#SDK_for_Java).


## Task 1: Create the Media Client

```
<copy>// Create Media Service Client.
    public static MediaServicesClient connectMediaService(){
        InstancePrincipalsAuthenticationDetailsProvider provider = InstancePrincipalsAuthenticationDetailsProvider.builder().build();
        MediaServicesClient mediaClient =  new MediaServicesClient(provider);
        // User Principal
        // Read config from the profile DEFAULT in the file "~/.oci/config". You can switch to a different profile.
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

## Task 2: Create the tasks & Media Workflow

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

Once the tasks are defined, we can create the Media Workflow.

```
<copy>// Create Media Workflow.
    public static MediaWorkflow createMediaWorkflow(MediaServicesClient mc, List<MediaWorkflowTask> tasks, JSONObject parameters,String compartment_id){
        CreateMediaWorkflowRequest  request = CreateMediaWorkflowRequest.builder().createMediaWorkflowDetails(CreateMediaWorkflowDetails.builder().displayName("test-java-sdk").compartmentId(compartment_id).tasks(tasks).parameters(parameters).build()).build();
        CreateMediaWorkflowResponse response = mc.createMediaWorkflow(request);
        MediaWorkflow mediaflow = response.getMediaWorkflow();
        return mediaflow;
    }</copy>
```

## Task 3: Create the Media Workflow Job

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

## Task 4: Other required function & libraries required to import.

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

Imports required for the code to run.

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

Update the variables and the main function.

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

## Task 5: Create Media Clients required to interact with the service.

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
    //default this program creates using Instance Principal
    public static MediaStreamClient connectMediaStreams(StreamDistributionChannel dc){
        String endpoint = dc.getDomainName();
        InstancePrincipalsAuthenticationDetailsProvider provider = InstancePrincipalsAuthenticationDetailsProvider.builder().build();
        MediaStreamClient mediaStreamsClient =  new MediaStreamClient(provider);
        // User Principal
        // Read config from the profile DEFAULT in the file "~/.oci/config". You can switch to different profile.
        // AuthenticationDetailsProvider authenticationDetailsProvider = new ConfigFileAuthenticationDetailsProvider(PROFILE_DEFAULT);
        // MediaStreamClient mediaStreamsClient = MediaStreamClient.builder().build(authenticationDetailsProvider);
        mediaStreamsClient.setEndpoint("https://"+endpoint);
        MediastreamsDemoApp.printString("\n" ,"Media Streams Client Instantiated Successfully");
        return mediaStreamsClient;
    }</copy>
```

## Task 6: Create Distribution Channel

```
<copy>// Create Distribution Channel 
    public static StreamDistributionChannel createDistributionChannel(MediaServicesClient mc, String compartment_id){
        CreateStreamDistributionChannelRequest  request = CreateStreamDistributionChannelRequest.builder().createStreamDistributionChannelDetails(CreateStreamDistributionChannelDetails.builder().displayName("test-java-sdk").compartmentId(compartment_id).build()).build();
        CreateStreamDistributionChannelResponse response = mc.createStreamDistributionChannel(request);
        StreamDistributionChannel dc = response.getStreamDistributionChannel();
        return dc;
    }</copy>
```

## Task 7: Create CDN Configuration(OCI Edge)

OCI Edge is origination directly from OCI. There is no CDN involved.

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

## Task 8: Create Stream Packaging configuration 

Specify if the streams need encryption & length of the stream segment.

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

## Task 9: Create an Asset ID for the master playlist to be ingested.

This is needed only if the master playlist was not registered to asset database as part of the media flow.

```
<copy>// Create Media Asset ID for given master playlist 
    public static MediaAsset createAsset(MediaServicesClient mc, String inputBucket,String masterPlayList, String namespace, String compartmentId){
        CreateMediaAssetRequest  request = CreateMediaAssetRequest.builder().createMediaAssetDetails(CreateMediaAssetDetails.builder().bucketName(inputBucket).displayName("test-java-sdk").objectName(masterPlayList).namespaceName(namespace).type(AssetType.valueOf("Playlist")).compartmentId(compartmentId).build()).build();
        CreateMediaAssetResponse response = mc.createMediaAsset(request);
        MediaAsset mediaAsset = response.getMediaAsset();
        return mediaAsset;
    }</copy>
```

## Task 10: Ingest the master playlist with the asset id from previous step .

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

Monitor the ingest with the help of ingest media flow job id.

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

## Task 11: Create a session token for playback.

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

## Task 12: Other essential accessory functions for the program to run & libraries involved.

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

Imports required for the program.

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

Main Function that needs to be updated with the variable values.

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
