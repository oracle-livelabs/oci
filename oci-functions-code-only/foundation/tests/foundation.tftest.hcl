mock_provider "oci" {
  mock_data "oci_core_services" {
    defaults = {
      services = [{ id = "service-test", name = "All ORD Services In Oracle Services Network", cidr_block = "all-ord-services-in-oracle-services-network" }]
    }
  }
  mock_data "oci_objectstorage_namespace" {
    defaults = { namespace = "testnamespace" }
  }
}
mock_provider "oci" {
  alias = "home"
}
variables {
  tenancy_ocid     = "ocid1.tenancy.oc1..test"
  compartment_ocid = "ocid1.compartment.oc1..learner1"
  region           = "us-chicago-1"
  home_region      = "us-ashburn-1"
}
run "foundation_without_iam" {
  command = plan
  assert {
    condition     = length(oci_identity_dynamic_group.functions) == 0 && length(oci_identity_policy.runtime) == 0
    error_message = "Default mode must not create IAM."
  }
  assert {
    condition     = oci_core_subnet.lab.prohibit_public_ip_on_vnic && length(oci_core_security_list.lab.ingress_security_rules) == 0
    error_message = "Subnet must remain private with no ingress."
  }
  assert {
    condition     = output.resource_sheet.incoming_bucket_name != output.resource_sheet.output_bucket_name && output.resource_sheet.application_configuration.LOW_STOCK_THRESHOLD == "10"
    error_message = "Bucket names must differ and default threshold must be 10."
  }
}
run "administrator_iam" {
  command = plan
  variables { create_runtime_iam = true }
  assert {
    condition     = length(oci_identity_dynamic_group.functions) == 1 && length(oci_identity_policy.runtime) == 1
    error_message = "Administrator mode must define scoped runtime IAM."
  }
  assert {
    condition     = length(oci_identity_policy.runtime[0].statements) == 3 && !strcontains(join(" ", oci_identity_policy.runtime[0].statements), "OBJECT_DELETE")
    error_message = "Only the three runtime grants belong here; no object-delete permission."
  }
}

run "second_learner_names" {
  command = plan
  variables {
    compartment_ocid = "ocid1.compartment.oc1..learner2"
  }
  assert {
    condition     = output.resource_sheet.incoming_bucket_name != run.foundation_without_iam.resource_sheet.incoming_bucket_name
    error_message = "Separate learner compartments must receive different bucket names."
  }
  assert {
    condition     = length(oci_core_security_list.lab.egress_security_rules) == 1 && one(oci_core_security_list.lab.egress_security_rules).protocol == "6" && one(oci_core_security_list.lab.egress_security_rules).tcp_options[0].min == 443 && one(oci_core_security_list.lab.egress_security_rules).tcp_options[0].max == 443
    error_message = "The dedicated security list must permit only TCP 443 egress."
  }
}

run "reject_invalid_prefix" {
  command = plan
  variables {
    name_prefix = "Bad Prefix"
  }
  expect_failures = [var.name_prefix]
}

run "reject_tenancy_root" {
  command = plan
  variables {
    compartment_ocid = "ocid1.tenancy.oc1..test"
  }
  expect_failures = [var.compartment_ocid]
}
