output "resource_sheet" {
  description = "Give these exact names/IDs to the learner. Buckets and application are NOT created by this stack."
  value = {
    region                   = var.region
    compartment_ocid         = var.compartment_ocid
    name_prefix              = local.prefix
    vcn_name                 = oci_core_vcn.lab.display_name
    vcn_ocid                 = oci_core_vcn.lab.id
    subnet_name              = oci_core_subnet.lab.display_name
    subnet_ocid              = oci_core_subnet.lab.id
    log_group_name           = oci_logging_log_group.lab.display_name
    log_group_ocid           = oci_logging_log_group.lab.id
    incoming_bucket_name     = local.incoming_bucket
    output_bucket_name       = local.output_bucket
    application_name         = local.application_name
    function_name            = "inventory-reporter"
    event_rule_name          = "${local.prefix}-upload"
    invocation_log_name      = "inventory-invocations"
    application_shape        = "GENERIC_X86"
    object_storage_namespace = data.oci_objectstorage_namespace.tenancy.namespace
    runtime_iam_managed      = var.create_runtime_iam
    application_configuration = {
      INPUT_BUCKET             = local.incoming_bucket
      OUTPUT_BUCKET            = local.output_bucket
      OBJECT_STORAGE_NAMESPACE = data.oci_objectstorage_namespace.tenancy.namespace
      LOW_STOCK_THRESHOLD      = "10"
    }
  }
}
output "administrator_runtime_iam" {
  description = "If IAM creation was disabled, install these BEFORE learner handoff. No user permissions are granted by this stack."
  value = {
    home_region        = var.home_region
    dynamic_group_name = local.dynamic_group_name
    matching_rule      = local.dynamic_group_rule
    policy_compartment = var.compartment_ocid
    policy_statements  = local.runtime_policy_statements
  }
}
