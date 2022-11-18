resource "oci_objectstorage_bucket" "source_bucket" {
  compartment_id        = var.compartment_id
  name                  = var.source_bucket_name
  namespace             = data.oci_objectstorage_namespace.tenancy_namespace.namespace
  access_type           = "NoPublicAccess"
  object_events_enabled = "false"
  storage_tier          = "Standard"
  versioning            = "Disabled"
}

resource "oci_objectstorage_bucket" "destination_bucket" {
  compartment_id        = var.compartment_id
  name                  = var.destination_bucket_name
  namespace             = data.oci_objectstorage_namespace.tenancy_namespace.namespace
  access_type           = "NoPublicAccess"
  object_events_enabled = "false"
  storage_tier          = "Standard"
  versioning            = "Disabled"
}

resource "oci_objectstorage_preauthrequest" "source_par" {
    access_type = "AnyObjectReadWrite"
    bucket = oci_objectstorage_bucket.source_bucket.name
    name = "source_par"
    namespace = data.oci_objectstorage_namespace.tenancy_namespace.namespace
    time_expires = timeadd(timestamp(),"60m")
    bucket_listing_action = "ListObjects"
}
