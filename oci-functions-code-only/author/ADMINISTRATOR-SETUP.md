# Administrator preparation

## Scope and prerequisites

Use one existing, isolated compartment per participant, with one foundation
stack per compartment. Do not use production compartments. Assign each learner
only their own compartment; a common group with access to all learner
compartments does not provide learner isolation. Existing compartments are not
created or deleted by the stack.

Choose Chicago for the workload and the actual tenancy home region for IAM.
Check available Functions application slots, concurrent memory, networks, buckets,
Events rules, log groups, Cloud Shell access, and applicable compartment quotas.
The author's earlier 20-application limit is not a guarantee for another tenancy.
No Compute instance, NAT gateway, API key, or local Docker installation is needed.

The provisioning identity must already have rights to read the namespace and
create/manage the assigned compartment's network and log group. With runtime IAM
enabled, it also needs authority to manage dynamic groups in the tenancy and the
scoped policy in the lab compartment. Resource Manager does not grant these rights.
Use your organization's approved deployment identity and review its Plan.

## Runtime identity: choose one owner

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

The bucket names are known before buckets exist. Policies restrict runtime access
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

Invoke the same foundation configuration with the reservation's tenancy OCID,
assigned compartment, workload region, home region, and stable prefix. The platform
may own IAM separately (false) or explicitly authorize the stack to manage it (true).
Export resource_sheet to the reservation instructions. Never precreate the learner
buckets, application, function, Events rule, or invocation log. No reservation API
or hook has been implemented: adapt this contract to the LiveLabs team's supported
integration, validate expiry/cleanup, and test the final participant role.

## Readiness gate

Before handing over, confirm Apply succeeded, the private subnet routes only via
the regional service gateway, HTTPS egress is present, and the log group exists.
Check both runtime IAM and learner IAM; allow propagation. Use a fresh disposable
reservation to create the buckets/application/log/function/rule and run all four
CSV cases under participant permissions. Remove the test's resources before
reusing a reservation; do not leave completed exercises for the next learner.

References:
- [Functions user/network/logging permissions](https://docs.oracle.com/en-us/iaas/Content/Functions/Tasks/functionscreatingpolicies.htm)
- [Function resource principals](https://docs.oracle.com/en-us/iaas/Content/Functions/Tasks/functionsaccessingociresources.htm)
- [Object Storage policy conditions](https://docs.oracle.com/en-us/iaas/Content/Identity/Reference/objectstoragepolicyreference.htm)
