# Lab 2: Create Media Streams

The Media Flow Job completion will bring below type of files:
- Master Playlist (master.m3u8)
- Individual playlist (other m3u8)
- Thumbnail images (jpg)
- Transcription in JSON format if enabled. (folder transcription)
![mediastreams 01](images/master-playlist.png " ") 

1. Navigate to Media Streams from OCI Main Menu 
   ![mediastreams 02](images/navigate-media-streams.png " ") 
2. Create Distribution Channel
   ![mediastreams 03](images/create-distribution-channel.png " ")
3. Choose EDGE as CDN and provide a name to create the distribution channel.
   ![mediastreams 04](images/select-cdn.png " ")
4. Upon creation, the distribution channel information is displayed.
   ![mediastreams 05](images/confirm-distribution-channel.png " ")
   The domain name will be the streaming hostname.
5. Ingest the Master Playlist into the distribution channel
   ![mediastreams 06](images/ingest.png " ")
6. Select the destination bucket and output folder to choose the Master Playlist.
   Note: Selecting other playlist will result in error.
   ![mediastreams 07](images/select-master-playlist.png " ")
   Notice the ingest job confirmation and status. 
   ![mediastreams 08](images/ingest-job-completion.png " ")
7. Now, we will work on the streaming packaging configuration
   ![mediastreams 09](images/create-streaming-package.png " ")
   Select HLS with 6 second as segment time and NONE for encryption. 
   ![mediastreams 10](images/configure-streaming-package.png " ")

**Note:**  After creating the distribution channel, the distribution channel is available to be selected in the Media Flow streaming task.
Go back to the same Media Flow and enable the streaming task to notice the distribution channel. After selecting, save the Media Flow. 
![mediastreams 14](images/media-flow-streaming-task.png " ")

## Acknowledgements
- **Author** - Sathya Velir - OCI Media Services
- **Last Updated By/Date** - Sathya Velir, November 2022
