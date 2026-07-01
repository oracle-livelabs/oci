# Copyright (c) 2024, 2026, Oracle and/or its affiliates. All rights reserved.
# The Universal Permissive License (UPL), Version 1.0 as shown at https://oss.oracle.com/licenses/upl/

# output "vcns" {
#   value = module.network.vcns
# }

# output "subnets" {
#   value = module.network.subnets
# }

output "linux_instances" {
  value = module.compute.linux_instances
}

output "jaeger_ui_urls" {
  value = module.compute.jaeger_ui_urls
}

output "otlp_grpc_endpoints" {
  value = module.compute.otlp_grpc_endpoints
}

output "otlp_http_endpoints" {
  value = module.compute.otlp_http_endpoints
}

output "hotrod_urls" {
  value = module.compute.hotrod_urls
}

output "ssh_commands" {
  value = module.compute.ssh_commands
}

output "next_steps" {
  description = "Exact post-deployment demo and validation steps for each Jaeger VM."
  value       = module.compute.next_steps
}
