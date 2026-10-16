# Administrator preparation

**Audience:** Workshop maintainers.

**Estimated Time:** Reference material; no timed learner activity.

### Objectives

- Review provisioning, runtime, and learner permission ownership before deploying the foundation.

## Scope and prerequisites

Use one existing, isolated compartment per participant. For the own-tenancy path,
use one foundation stack per compartment; the sandbox uses its reservation's
pre-created network and policies. Do not use production compartments. Assign each learner
only their own compartment; a common group with access to all learner
compartments does not provide learner isolation. Existing compartments are not
created or deleted by the stack.

The own-tenancy instructions use Chicago. Sandbox learners use their reservation's
assigned region; Chicago is not required. Use the actual tenancy home region for IAM.
Check available Functions application slots, concurrent memory, networks, buckets,
Events rules, log groups, Cloud Shell access, and applicable compartment quotas.
The author's earlier 20-application limit is not a guarantee for another tenancy.
No Compute instance, NAT gateway, API key, or local Docker installation is needed.

For an own-tenancy foundation deployment, the provisioning identity must already have rights to read the namespace and
create/manage the assigned compartment's network and log group. With runtime IAM
enabled, it also needs authority to manage dynamic groups in the tenancy and the
scoped policy in the lab compartment. Resource Manager does not grant these rights.
Use your organization's approved deployment identity and review its Plan.

## Runtime identity: choose one owner

The own-tenancy Resource Manager form selects **Create runtime IAM** by default.
Administrators should keep it enabled for a new standalone lab: Functions do not
inherit the deploying user's administrator permissions. The shared Terraform
CLI/module default remains false; sandbox automation must explicitly choose its
IAM ownership model. Do not rely on the form default for an existing stack.

- **Terraform-managed:** an authorized administrator sets create_runtime_iam=true.
  The stack creates a compartment-scoped fnfunc dynamic group in the default IAM
  domain and a policy with exactly three statements: input read, output create/
  overwrite (no delete), and Functions-service network use in the lab compartment.
- **Administrator/platform-managed:** leave create_runtime_iam=false. Use the
  administrator_runtime_iam output to create the group/rule and statements before
  learner handoff. If your identity-domain conventions require qualified names
  or group OCIDs, adapt the policy subject accordingly. Record this external
  ownership; stack Destroy will not remove those permissions.

Do not later toggle true to false casually: Terraform will plan deletion of its
managed IAM. Do not toggle false to true over existing same-named resources without
an administrator-led import/ownership decision. The stack does not adopt resources.

In the own-tenancy foundation, bucket names are known before buckets exist. Policies restrict runtime access
to those exact names, and the dynamic group selects Functions in the lab
compartment before a function exists. Keep the chosen prefix stable after handoff.
Renaming the prefix later changes intended bucket names and policies.

## Learner identity (separate from function runtime)

The foundation deliberately does not create users, groups, memberships, Cloud
Shell policies, or learner grants. A tenancy/platform administrator must establish
them before the session. The following policy template is for a dedicated learner
group and isolated compartment; substitute actual OCIDs and review locally:

```text
Allow group id <learner-group-ocid> to inspect compartments in tenancy
Allow group id <learner-group-ocid> to read objectstorage-namespaces in tenancy
Allow group id <learner-group-ocid> to use cloud-shell in tenancy
Allow group id <learner-group-ocid> to use virtual-network-family in compartment id <lab-compartment-ocid>
Allow group id <learner-group-ocid> to manage functions-family in compartment id <lab-compartment-ocid>
Allow group id <learner-group-ocid> to manage buckets in compartment id <lab-compartment-ocid>
Allow group id <learner-group-ocid> to manage objects in compartment id <lab-compartment-ocid>
Allow group id <learner-group-ocid> to manage cloudevents-rules in compartment id <lab-compartment-ocid>
Allow group id <learner-group-ocid> to manage logging-family in compartment id <lab-compartment-ocid>
Allow group id <learner-group-ocid> to read metrics in compartment id <lab-compartment-ocid>
```

This is a review template, not a claim of tested minimum IAM. Namespace/compartment
discovery and Cloud Shell access are tenancy-level; resource-management grants are
limited to the learner compartment. Learners need no IAM administration. Their
object-delete rights support own-tenancy cleanup; the function runtime does not
get those rights. Do not grant Cloud Shell public-network access automatically:
the supplied checker and repackager do not need external package downloads.
If learners also operate Resource Manager, an administrator must separately grant
the appropriate stack/job and underlying resource permissions, or deploy for them.

## Sandbox integration contract

The reservation supplies the assigned compartment, VCN, public and private subnets,
and required learner/runtime policies. Publish the assigned region and compartment
in Tenancy Information. No resource_sheet is supplied, and learners do not deploy
the own-tenancy foundation stack. If more than one VCN or private subnet is visible,
identify the correct network in the reservation instructions.

Learners retrieve their own tenancy's namespace with
`oci os ns get --query data --raw-output` in Cloud Shell, record their values in
personal notes, and choose participant-specific resource names. They create the
log group, two buckets, application, invocation log, function, and Events rule.
Do not precreate those exercise resources. The application uses the private subnet.

Runtime permissions must support learner-chosen bucket names in the assigned
compartment. Do not reuse the own-tenancy stack's exact-bucket-name policies
unchanged for this sandbox flow. Scope function identity membership and object
access to the assigned learner compartment, allowing reads and object creation/
overwrite without deletion. This permits access to both learner buckets, unlike
the own-tenancy input-only/output-only restrictions; the platform administrator
must approve that scope and verify participant isolation. Ensure learner grants
also permit log-group creation and Events rule creation with a Functions action.
These are requirements for platform setup, not instructions for learners to edit IAM.

## Readiness gate

Sandbox teardown must also remove the learner-created buckets, objects,
application, function, invocation log, log group, and Events rule. Validate the
reservation's expiry/cleanup hook; do not give platform-integration tasks to learners.
The own-tenancy Terraform stack does not manage sandbox learner-created resources.

For the own-tenancy path, confirm Apply succeeded and the log group exists.
For both paths, verify that the private subnet has a working route to the regional
Object Storage service and HTTPS egress. For the sandbox, confirm learners can
create their own log group rather than expecting one at handoff.
Check both runtime IAM and learner IAM; allow propagation. Use a fresh disposable
reservation to create the log group/buckets/application/log/function/rule and run all four
CSV cases under participant permissions. Remove the test's resources before
reusing a reservation; do not leave completed exercises for the next learner.

References:
- [Functions user/network/logging permissions](https://docs.oracle.com/en-us/iaas/Content/Functions/Tasks/functionscreatingpolicies.htm)
- [Function resource principals](https://docs.oracle.com/en-us/iaas/Content/Functions/Tasks/functionsaccessingociresources.htm)
- [Object Storage policy conditions](https://docs.oracle.com/en-us/iaas/Content/Identity/Reference/objectstoragepolicyreference.htm)

## Acknowledgements

- **Author** - Graham Shroyer
- **Last Updated By/Date** - Graham Shroyer, October 2026
