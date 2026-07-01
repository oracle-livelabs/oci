# Copyright (c) 2024, 2026, Oracle and/or its affiliates. All rights reserved.
# The Universal Permissive License (UPL), Version 1.0 as shown at https://oss.oracle.com/licenses/upl/

terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

locals {
  linux_boot_volumes = [for instance in var.instance_params : instance.boot_volume_size >= 50 ? null : file(format("\n\nERROR: The boot volume size for linux instance %s is less than 50GB which is not permitted. Please add a boot volume size of 50GB or more", instance.hostname))]
  block_performance = {
    Low      = "0"
    Balanced = "10"
    High     = "20"
  }
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ids[var.instance_params[keys(var.instance_params)[0]].compartment_name]
}


resource "oci_core_instance" "this" {
  for_each            = var.instance_params
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[each.value.ad - 1].name
  compartment_id      = var.compartment_ids[each.value.compartment_name]
  shape               = each.value.shape
  shape_config {
    memory_in_gbs = each.value.memory_in_gbs
    ocpus         = each.value.ocpus
  }
  display_name                        = each.value.hostname
  preserve_boot_volume                = each.value.preserve_boot_volume
  freeform_tags                       = each.value.freeform_tags
  is_pv_encryption_in_transit_enabled = each.value.encrypt_in_transit
  fault_domain                        = format("FAULT-DOMAIN-%s", each.value.fd)


  create_vnic_details {
    assign_public_ip = each.value.assign_public_ip
    subnet_id        = var.subnet_ids[each.value.subnet_name]
    hostname_label   = replace(lower(each.value.hostname), "_", "-")
  }

  source_details {
    boot_volume_size_in_gbs = each.value.boot_volume_size
    source_type             = "image"
    source_id               = var.linux_images[var.region][each.value.image_version]
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key)
    user_data = base64encode(templatefile("${path.module}/../../userdata/cloudinit.sh.tftpl", {
      region            = var.region
      jaeger_image      = var.jaeger_config.jaeger_image
      hotrod_image      = var.jaeger_config.hotrod_image
      enable_hotrod     = var.jaeger_config.enable_hotrod
      generate_traces   = var.jaeger_config.generate_traces
      trace_burst_count = var.jaeger_config.trace_burst_count
      trace_burst_delay = var.jaeger_config.trace_burst_delay
      otlp_grpc_port    = var.jaeger_config.otlp_grpc_port
      otlp_http_port    = var.jaeger_config.otlp_http_port
      jaeger_ui_port    = var.jaeger_config.jaeger_ui_port
      hotrod_port       = var.jaeger_config.hotrod_port
      zipkin_port       = var.jaeger_config.zipkin_port
      sampling_port     = var.jaeger_config.sampling_port
    }))
  }
}
