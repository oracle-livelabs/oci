// Copyright 2024 Google LLC All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#
# Refer to variables.tf for explanations of each variable
#

# OCI provider
api_fingerprint      = "" # Example fingerpting of API Key - "78:3e:c8:be:...:8d"
api_private_key_path = "" # Example path to the downloaed API Key pem "~/.oci/mykey.pem"
region               = "us-ashburn-1"
home_region          = "us-ashburn-1"
tenancy_id           = "" # Example OCID "ocid1.tenancy.oc1..aaaaaaaag...ldq"
user_id              = "" # Example OCID "ocid1.tenancy.oc1..aaaaaaaag...ldq"
compartment_id       = "" # Example OCID "ocid1.tenancy.oc1..aaaaaaaag...ldq"

# SSH keys
ssh_private_key_path = "" # Example path "~/.ssh/id_rsa"
ssh_public_key_path  = "" # Example path "~/.ssh/id_rsa"

# OKE cluster
cluster_name       = "agones-cluster"
cluster_type       = "enhanced" # enchanced required for addons, autoscaler addon for example
kubernetes_version = "v1.30.1"
