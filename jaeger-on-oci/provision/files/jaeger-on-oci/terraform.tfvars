# Copyright (c) 2024, 2026, Oracle and/or its affiliates. All rights reserved.
# The Universal Permissive License (UPL), Version 1.0 as shown at https://oss.oracle.com/licenses/upl/

########################### NETWORK #################################

vcn_params = {
  jaeger_vcn = {
    compartment_name = "target"
    display_name     = "jaeger-vcn"
    vcn_cidr         = "10.20.0.0/16"
    dns_label        = "jaeger"
  }
}

subnet_params = {
  jaeger_public = {
    display_name      = "jaeger-public"
    cidr_block        = "10.20.1.0/24"
    dns_label         = "jaegerpub"
    is_subnet_private = false
    sl_name           = "jaeger_sl"
    rt_name           = "jaeger_public"
    vcn_name          = "jaeger_vcn"
  }
}

igw_params = {
  jaeger_igw = {
    display_name = "jaeger-igw"
    vcn_name     = "jaeger_vcn"
  },
}

ngw_params = {}

rt_params = {
  jaeger_public = {
    display_name = "jaeger-public-rt"
    vcn_name     = "jaeger_vcn"

    route_rules = [
      {
        destination = "0.0.0.0/0"
        use_igw     = true
        igw_name    = "jaeger_igw"
        ngw_name    = null
      },
    ]
  }
}

sl_params = {
  jaeger_sl = {
    vcn_name     = "jaeger_vcn"
    display_name = "jaeger-security-list"

    egress_rules = [
      {
        stateless   = "false"
        protocol    = "all"
        destination = "0.0.0.0/0"
      },
    ]

    ingress_rules = [
      {
        stateless   = "false"
        protocol    = "6"
        source      = "0.0.0.0/0"
        source_type = "CIDR_BLOCK"
        tcp_options = [
          {
            min = 22
            max = 22
          }
        ]
        udp_options = []
      },
      {
        stateless   = "false"
        protocol    = "6"
        source      = "0.0.0.0/0"
        source_type = "CIDR_BLOCK"
        tcp_options = [
          {
            min = 16686
            max = 16686
          }
        ]
        udp_options = []
      },
      {
        stateless   = "false"
        protocol    = "6"
        source      = "0.0.0.0/0"
        source_type = "CIDR_BLOCK"
        tcp_options = [
          {
            min = 4317
            max = 4318
          }
        ]
        udp_options = []
      },
      {
        stateless   = "false"
        protocol    = "6"
        source      = "0.0.0.0/0"
        source_type = "CIDR_BLOCK"
        tcp_options = [
          {
            min = 8080
            max = 8080
          }
        ]
        udp_options = []
      },
    ]
  }
}

############################## COMPUTE ##################################

linux_images = {
  eu-frankfurt-1 = {
    oel9 = "ocid1.image.oc1.eu-frankfurt-1.example" # CHANGE-ME: Oracle Linux 9 image OCID for this region
  }
  us-ashburn-1 = {
    oel9 = "ocid1.image.oc1.iad.example" # CHANGE-ME: Oracle Linux 9 image OCID for this region
  }
}

instance_params = {
  jaeger_vm = {
    ad                   = 2
    shape                = "VM.Standard.E5.Flex"
    hostname             = "jaeger-vm"
    boot_volume_size     = 50
    preserve_boot_volume = false
    assign_public_ip     = true
    compartment_name     = "target"
    subnet_name          = "jaeger-public"
    freeform_tags = {
      "app" : "jaeger",
      "managed-by" : "terraform"
    }
    block_vol_att_type = "iscsi"
    encrypt_in_transit = true
    fd                 = 1
    image_version      = "oel9"
    ssh_private_key    = "/path/to/ssh_private_key" ## CHANGE-ME
    script_tf_string   = ""
    ocpus              = 1
    memory_in_gbs      = 16
  }
}

ssh_public_key = "/path/to/ssh_public_key.pub" ## CHANGE-ME

jaeger_config = {
  jaeger_image      = "cr.jaegertracing.io/jaegertracing/jaeger:2.19.0"
  hotrod_image      = "cr.jaegertracing.io/jaegertracing/example-hotrod:latest"
  enable_hotrod     = true
  generate_traces   = true
  trace_burst_count = 20
  trace_burst_delay = 1
  otlp_grpc_port    = 4317
  otlp_http_port    = 4318
  jaeger_ui_port    = 16686
  hotrod_port       = 8080
  zipkin_port       = 9411
  sampling_port     = 5778
}
