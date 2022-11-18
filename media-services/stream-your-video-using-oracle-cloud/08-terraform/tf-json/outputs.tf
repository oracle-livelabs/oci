output "comment" {
  value = "You can either use the PAR URL to upload your content directly or use OCI Console to upload the video object"
}

output "upload_objects_to" {
  value = join("", ["https://console.", var.region, ".oraclecloud.com/object-storage/buckets/", data.oci_objectstorage_namespace.tenancy_namespace.namespace, "/", oci_objectstorage_bucket.source_bucket.name, "/objects"])
}

output "post_direct_url_to_upload" {
  value = "https://objectstorage.${var.region}.oraclecloud.com${oci_objectstorage_preauthrequest.source_par.access_uri}"
}

output "using_par_document_reference" {
  value = "https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/usingpreauthenticatedrequests.htm"
}

output "media_workflow_id"{
  value = oci_media_services_media_workflow.demo_media_workflow.id
}