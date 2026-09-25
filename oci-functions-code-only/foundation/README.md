# Shared OCI Functions lab foundation

Use this same Terraform root configuration for sandbox provisioning and the
own-tenancy Resource Manager stack. It is a foundation, not a complete application
deployment. Live cloud validation and reservation integration remain required.

## Creates

Six explicitly managed resources: VCN, service gateway, route table, security list,
private regional subnet, and log group. OCI also creates a VCN's default resources;
the lab subnet uses the explicitly restricted route/security list. With the
administrator option enabled, also creates one dynamic group and one scoped policy.

Does NOT create a compartment, users/groups, learner IAM, buckets, Functions
application, function, invocation log, Events rule, Compute VM, NAT gateway, public
IP, or container registry. Learners create the application-facing resources.

## Inputs and outputs

- tenancy_ocid and compartment_ocid: existing tenancy and isolated learner compartment.
- region: workload region; default us-chicago-1.
- home_region: actual tenancy home region for IAM, not an assumed fixed region.
- name_prefix: 3-20 lowercase characters; default inventory. An eight-character
  compartment-derived suffix is added. Use one stack per learner compartment.
- create_runtime_iam: false by default; true requires administrator authorization.

resource_sheet contains network IDs, log group, exact bucket/application/rule names,
namespace, and configuration values. administrator_runtime_iam contains the matching
rule and policy statements for a separately managed IAM setup. False is NOT a
permission-free deployment: external runtime IAM is still required.

Network addresses are 10.42.0.0/16 and 10.42.1.0/24. Each independent VCN may reuse
these CIDRs because this lab does not peer VCNs. No ingress is allowed; stateful
TCP 443 egress targets the regional All Services Oracle Services Network label.

## Resource Manager

Upload the supplied functions-foundation.zip using Create Stack > My configuration.
Review variables, run Plan, then Apply after administrator review. Resource Manager
supplies authentication; do not add keys or passwords to variables. Supply actual
home-region and compartment values. IAM administration must already be authorized.

The package uses OCI provider 7.x and Terraform >=1.5,<2.0. The source includes
mock-provider tests that require Terraform >=1.7; these tests are not part of the
Resource Manager deployment ZIP. A dependency lock file is supplied after validation.

For local author validation (no OCI deployment):
```text
terraform init -backend=false
terraform fmt -check
terraform validate
terraform test
```

terraform test uses mocked OCI providers and does not create cloud resources.
Do not run plan/apply outside the mock tests without reviewing real scope/credentials.

## Publishing the deploy shortcut

The own-tenancy guide currently provides a ZIP upload path that needs no published
repository URL. After approval, publish get-started/files/functions-foundation.zip
at a stable, accessible HTTPS URL and construct the Resource Manager shortcut using:
```text
https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=<URL-encoded-approved-package-URL>
```
Do not advertise a button pointing to an unpublished/private path. This is distinct
from a LiveLabs green-button reservation. Rebuild the ZIP after changing Terraform,
schema, README, or the dependency lock file; exclude .terraform, state, tfvars,
credentials, caches, tests, and local plans.

Cleanup: manually created resources are not in Terraform state. Disable/remove the
rule, remove the function/application/invocation log and both buckets/objects before
the administrator destroys this stack. The existing compartment remains untouched.

References:
- [Resource Manager deployment](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Tasks/deploybutton.htm)
- [Resource Manager schema](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Concepts/terraformconfigresourcemanager_topic-schema.htm)
