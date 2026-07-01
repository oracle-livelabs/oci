# Copyright (c) 2024, 2026, Oracle and/or its affiliates. All rights reserved.
# The Universal Permissive License (UPL), Version 1.0 as shown at https://oss.oracle.com/licenses/upl/

provider_oci = {
  tenancy_ocid         = "ocid1.tenancy.oc1..example" ## CHANGE-ME ##
  user_ocid            = "ocid1.user.oc1..example"    ## CHANGE-ME ##
  private_key_path     = "/path/to/oci_api_key.pem"   ## CHANGE-ME ##
  private_key_password = ""
  fingerprint          = "<api-key-fingerprint>" ## CHANGE-ME ##
  region               = "eu-frankfurt-1"        ## CHANGE-ME ##
}

compartment_ids = {
  target = "ocid1.compartment.oc1..example" ## CHANGE-ME ##
}
