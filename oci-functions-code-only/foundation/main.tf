locals {
  suffix             = substr(sha1(var.compartment_ocid), 0, 8)
  prefix             = "${var.name_prefix}-${local.suffix}"
  incoming_bucket    = "${local.prefix}-incoming"
  output_bucket      = "${local.prefix}-output"
  application_name   = "${local.prefix}-app"
  dynamic_group_name = "${local.prefix}-functions"
  dynamic_group_rule = "ALL {resource.type = 'fnfunc', resource.compartment.id = '${var.compartment_ocid}'}"
  runtime_policy_statements = [
    "Allow dynamic-group ${local.dynamic_group_name} to read objects in compartment id ${var.compartment_ocid} where target.bucket.name = '${local.incoming_bucket}'",
    "Allow dynamic-group ${local.dynamic_group_name} to manage objects in compartment id ${var.compartment_ocid} where all {target.bucket.name = '${local.output_bucket}', any {request.permission = 'OBJECT_CREATE', request.permission = 'OBJECT_OVERWRITE'}}",
    "Allow service faas to use virtual-network-family in compartment id ${var.compartment_ocid}"
  ]
  tags = {
    Workshop  = "oci-functions-code-only"
    ManagedBy = "Terraform"
    Lab       = local.prefix
  }
}
data "oci_core_services" "regional" {
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
}
data "oci_objectstorage_namespace" "tenancy" {
  compartment_id = var.tenancy_ocid
}
resource "oci_core_vcn" "lab" {
  compartment_id = var.compartment_ocid
  cidr_blocks    = ["10.42.0.0/16"]
  display_name   = "${local.prefix}-vcn"
  dns_label      = "fnlab"
  freeform_tags  = local.tags
}
resource "oci_core_service_gateway" "lab" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.lab.id
  display_name   = "${local.prefix}-service-gateway"
  services {
    service_id = one(data.oci_core_services.regional.services).id
  }
  freeform_tags = local.tags
}
resource "oci_core_route_table" "lab" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.lab.id
  display_name   = "${local.prefix}-routes"
  route_rules {
    destination       = one(data.oci_core_services.regional.services).cidr_block
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = oci_core_service_gateway.lab.id
  }
  freeform_tags = local.tags
}
resource "oci_core_security_list" "lab" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.lab.id
  display_name   = "${local.prefix}-https-egress"
  # No ingress_security_rules blocks: this dedicated list allows no ingress.
  egress_security_rules {
    protocol         = "6"
    destination      = one(data.oci_core_services.regional.services).cidr_block
    destination_type = "SERVICE_CIDR_BLOCK"
    stateless        = false
    tcp_options {
      min = 443
      max = 443
    }
  }
  freeform_tags = local.tags
}
resource "oci_core_subnet" "lab" {
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_vcn.lab.id
  cidr_block                 = "10.42.1.0/24"
  display_name               = "${local.prefix}-private-subnet"
  dns_label                  = "functions"
  prohibit_public_ip_on_vnic = true
  route_table_id             = oci_core_route_table.lab.id
  security_list_ids          = [oci_core_security_list.lab.id]
  freeform_tags              = local.tags
}
resource "oci_logging_log_group" "lab" {
  compartment_id = var.compartment_ocid
  display_name   = "${local.prefix}-logs"
  description    = "Learners enable the application invoke log in this group."
  freeform_tags  = local.tags
}
resource "oci_identity_dynamic_group" "functions" {
  count          = var.create_runtime_iam ? 1 : 0
  provider       = oci.home
  compartment_id = var.tenancy_ocid
  name           = local.dynamic_group_name
  description    = "Functions only in the isolated learner compartment."
  matching_rule  = local.dynamic_group_rule
  freeform_tags  = local.tags
}
resource "oci_identity_policy" "runtime" {
  count          = var.create_runtime_iam ? 1 : 0
  provider       = oci.home
  compartment_id = var.compartment_ocid
  name           = "${local.prefix}-runtime"
  description    = "Read lab inputs, create/overwrite lab outputs, use lab networks."
  statements     = local.runtime_policy_statements
  freeform_tags  = local.tags
  depends_on     = [oci_identity_dynamic_group.functions]
}
