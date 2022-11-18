resource "oci_media_services_media_workflow" "demo_media_workflow" {
  #Required
  compartment_id = var.compartment_id
  display_name   = "demo_media_workflow"
  parameters = "{  \"input\": {    \"bucketName\": \"Demo_source\",    \"namespaceName\": \"${data.oci_objectstorage_namespace.tenancy_namespace.namespace}\"  },  \"output\": {    \"basePrefix\": \"$${/output/objectNamePath}\",    \"objectName\": \"output/fileprefix\",    \"objectNamePath\": \"output/\",    \"objectNameFilename\": \"fileprefix\",    \"bucketName\": \"Demo_destination\",    \"namespaceName\": \"${data.oci_objectstorage_namespace.tenancy_namespace.namespace}\",    \"assetCompartmentId\": \"${data.oci_identity_compartment.compartment.id}\"  },  \"taskOutput\": {    \"transcode\": \"\", \"thumbnail\": \"\"  }}"
  tasks {
    key           = "getFiles"
    parameters    = file("${path.module}/JSON/getfiles.json")
    type          = "getFiles"
    version       = "1"
  }
  tasks {
    #Required
    key           = "transcode"
    parameters    = file("${path.module}/JSON/transcode.json")
    type          = "transcode"
    version       = "1"
    prerequisites = ["getFiles"]
  }
  tasks {
    #Required
    key           = "transcribe"
    parameters    = file("${path.module}/JSON/transcribe.json")
    type          = "transcribe"
    version       = "1"
    prerequisites = ["transcode"]
  }
  tasks {
    #Required
    key           = "thumbnail"
    parameters    = file("${path.module}/JSON/thumbnails.json")
    type          = "thumbnail"
    version       = "1"
    prerequisites = ["visionDetection"]
  }
  tasks {
    #Required
    key           = "visionDetection"
    parameters    = file("${path.module}/JSON/visiondetection.json")
    type          = "visionDetection"
    version       = "1"
    prerequisites = ["transcribe"]
  }
  tasks {
    #Required
    key           = "putFiles"
    parameters    = file("${path.module}/JSON/putfiles.json")
    type          = "putFiles"
    version       = "1"
    prerequisites = ["thumbnail"]
  }
  tasks {
    #Required
    key           = "ingest"
    parameters    = "{\"distributionChannelId\":\"${oci_media_services_stream_distribution_channel.demo_stream_distribution_channel.id}\",\"masterPlaylistName\":\"master.m3u8\"}"
    type          = "ingest"
    version       = "1"
    prerequisites = ["putFiles"]
  }
  
}
