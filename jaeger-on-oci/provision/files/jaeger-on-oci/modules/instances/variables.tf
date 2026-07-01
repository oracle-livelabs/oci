# Copyright (c) 2024, 2026, Oracle and/or its affiliates. All rights reserved.
# The Universal Permissive License (UPL), Version 1.0 as shown at https://oss.oracle.com/licenses/upl/

variable "compartment_ids" {
  type = map(string)
}

variable "subnet_ids" {
  type = map(string)
}

variable "region" {
  type = string
}

variable "linux_images" {
  type = map(map(string))
}

variable "instance_params" {
  description = "Placeholder for the parameters of the instances"
  type = map(object({
    ad                   = number
    shape                = string
    hostname             = string
    boot_volume_size     = number
    assign_public_ip     = bool
    preserve_boot_volume = bool
    compartment_name     = string
    subnet_name          = string
    freeform_tags        = map(string)
    block_vol_att_type   = string
    encrypt_in_transit   = bool
    fd                   = number
    image_version        = string
    ssh_private_key      = string
    script_tf_string     = string
    ocpus                = optional(number)
    memory_in_gbs        = optional(number)
  }))
}

variable "ssh_public_key" {
  type = string
}

variable "jaeger_config" {
  type = object({
    jaeger_image      = string
    hotrod_image      = string
    enable_hotrod     = bool
    generate_traces   = bool
    trace_burst_count = number
    trace_burst_delay = number
    otlp_grpc_port    = number
    otlp_http_port    = number
    jaeger_ui_port    = number
    hotrod_port       = number
    zipkin_port       = number
    sampling_port     = number
  })
}
