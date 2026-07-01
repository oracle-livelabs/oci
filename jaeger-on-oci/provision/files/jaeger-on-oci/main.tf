# Copyright (c) 2024, 2026, Oracle and/or its affiliates. All rights reserved.
# The Universal Permissive License (UPL), Version 1.0 as shown at https://oss.oracle.com/licenses/upl/

terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

provider "oci" {
  tenancy_ocid     = var.provider_oci.tenancy_ocid
  user_ocid        = var.provider_oci.user_ocid
  fingerprint      = var.provider_oci.fingerprint
  private_key_path = var.provider_oci.private_key_path
  region           = var.provider_oci.region
}

module "network" {
  source          = "./modules/network"
  vcn_params      = var.vcn_params
  compartment_ids = var.compartment_ids
  igw_params      = var.igw_params
  ngw_params      = var.ngw_params
  rt_params       = var.rt_params
  sl_params       = var.sl_params
  subnet_params   = var.subnet_params
}

module "compute" {
  source          = "./modules/instances"
  compartment_ids = var.compartment_ids
  subnet_ids      = module.network.subnets_ids
  instance_params = var.instance_params
  region          = var.provider_oci.region
  linux_images    = var.linux_images
  ssh_public_key  = var.ssh_public_key
  jaeger_config   = var.jaeger_config
}
