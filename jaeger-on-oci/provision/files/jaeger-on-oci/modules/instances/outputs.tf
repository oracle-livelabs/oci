# Copyright (c) 2024, 2026, Oracle and/or its affiliates. All rights reserved.
# The Universal Permissive License (UPL), Version 1.0 as shown at https://oss.oracle.com/licenses/upl/

locals {
  linux_instances = {
    for instance in oci_core_instance.this :
    instance.display_name => { "id" : instance.id, "ip" : instance.public_ip != "" ? instance.public_ip : instance.private_ip }
  }
  linux_ids = {
    for instance in oci_core_instance.this :
    instance.display_name => instance.id
  }

  linux_private_ips = {
    for instance in oci_core_instance.this :
    instance.display_name => instance.private_ip
  }


  all_instances   = merge(local.linux_ids /*,local.windows_ids*/)
  all_private_ips = merge(local.linux_private_ips /*, local.windows_private_ips*/)
}

output "linux_instances" {
  value = local.linux_instances
}

output "all_instances" {
  value = local.all_instances
}

output "all_private_ips" {
  value = local.all_private_ips
}

output "jaeger_ui_urls" {
  value = {
    for name, instance in oci_core_instance.this :
    name => format("http://%s:%s", instance.public_ip != "" ? instance.public_ip : instance.private_ip, var.jaeger_config.jaeger_ui_port)
  }
}

output "otlp_grpc_endpoints" {
  value = {
    for name, instance in oci_core_instance.this :
    name => format("%s:%s", instance.public_ip != "" ? instance.public_ip : instance.private_ip, var.jaeger_config.otlp_grpc_port)
  }
}

output "otlp_http_endpoints" {
  value = {
    for name, instance in oci_core_instance.this :
    name => format("http://%s:%s", instance.public_ip != "" ? instance.public_ip : instance.private_ip, var.jaeger_config.otlp_http_port)
  }
}

output "hotrod_urls" {
  value = {
    for name, instance in oci_core_instance.this :
    name => format("http://%s:%s", instance.public_ip != "" ? instance.public_ip : instance.private_ip, var.jaeger_config.hotrod_port)
  }
}

output "ssh_commands" {
  value = {
    for name, instance in oci_core_instance.this :
    name => format("ssh -i %s opc@%s", var.instance_params[name].ssh_private_key, instance.public_ip != "" ? instance.public_ip : instance.private_ip)
  }
}

output "next_steps" {
  value = {
    for name, instance in oci_core_instance.this :
    name => <<-EOT
      Jaeger deployment next steps for ${name}

      1. Wait 2-5 minutes for cloud-init to finish installing Docker and starting the containers.

      2. Open the Jaeger UI:
         http://${instance.public_ip != "" ? instance.public_ip : instance.private_ip}:${var.jaeger_config.jaeger_ui_port}

      3. Open the HotROD demo app:
         http://${instance.public_ip != "" ? instance.public_ip : instance.private_ip}:${var.jaeger_config.hotrod_port}

      4. In HotROD, generate a few demo requests from the browser.

      5. In Jaeger UI, select service "frontend" and click "Find Traces".

      6. To generate traces from the VM instead:
         ssh -i ${var.instance_params[name].ssh_private_key} opc@${instance.public_ip != "" ? instance.public_ip : instance.private_ip}
         jaeger-status
         jaeger-generate-traces 20 1

      7. OTLP endpoints for external trace senders:
         gRPC: ${instance.public_ip != "" ? instance.public_ip : instance.private_ip}:${var.jaeger_config.otlp_grpc_port}
         HTTP: http://${instance.public_ip != "" ? instance.public_ip : instance.private_ip}:${var.jaeger_config.otlp_http_port}
    EOT
  }
}
