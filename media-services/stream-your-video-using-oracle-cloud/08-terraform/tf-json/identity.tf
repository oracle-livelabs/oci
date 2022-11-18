

resource "oci_identity_policy" "media_services_policy" {
  provider       = oci.home
  name           = "media_services_policy"
  description    = "media_services_policy"
  compartment_id = var.tenancy_ocid
  statements = [
    "Allow service mediaservices to use object-family in compartment id ${var.compartment_id}",
    "Allow service mediaservices to read media-family in compartment id ${var.compartment_id}",
    "Allow service objectstorage-${var.region} to manage object-family in compartment id ${var.compartment_id}"
  ]
}
