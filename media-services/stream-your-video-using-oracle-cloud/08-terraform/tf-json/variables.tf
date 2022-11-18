variable tenancy_ocid {
    default = "ocid1.tenancy.oc1..yourtenancyocid"
}

variable user_ocid {
    default = "ocid1.user.oc1..youruserocid"
}

variable fingerprint {
    default = "your:finger:print"
}

variable private_key_path {
    default = "your-key-path-08-16-19-42.pem"
}

variable region {
    default = "your-oci-region"
}

variable compartment_id{
    default = "ocid1.compartment.oc1..yourcompartment.id"
}


//Object Storage Parameters

variable "source_bucket_name" {
  type    = string
  default = "Demo_source"
}
variable "destination_bucket_name" {
  type    = string
  default = "Demo_destination"
}
