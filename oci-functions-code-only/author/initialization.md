# Initialization ownership and release gates

**Audience:** Workshop maintainers.

**Estimated Time:** Reference material; no timed learner activity.

### Objectives

- Identify resource ownership, sandbox integration requirements, and release gates.

The own-tenancy configuration is in [foundation](../foundation/readme.md).
The sandbox uses the network and policies supplied by its reservation, without a
resource sheet or learner-run foundation stack.
See [administrator setup](administrator-setup.md) for IAM and the reservation contract.

| Owner/path | Resources/actions |
| --- | --- |
| Administrator/platform | Existing isolated compartment, learner identity and permissions, quota checks |
| Own-tenancy Terraform foundation | Private VCN/subnet, service gateway, route, HTTPS egress list, log group |
| Own-tenancy administrator or explicitly authorized Terraform option | Function dynamic group, exact input-read/output-create-overwrite policy, faas network policy |
| Sandbox platform | Assigned VCN, public/private subnets, network access, and learner/runtime policies supporting learner-chosen bucket names in the assigned compartment |
| Sandbox learner | Find namespace in Cloud Shell, record assigned resources and chosen names, create log group |
| Learner | Two private buckets, incoming events enabled, x86 application, four configuration keys |
| Learner | Application invoke log (30 days), ZIP function, bucket-filtered Events rule |
| Learner | Uploads, report inspection, optional threshold change and bad-row diagnosis |

No application or bucket should exist in a fresh learner reservation. Own-tenancy
learners copy `resource_sheet` from the stack output; its names include a
compartment-derived suffix. Sandbox learners use Tenancy Information for their
assigned region and compartment, locate the existing VCN/private subnet, and
record their own chosen names in personal notes. They create their log group.
The code archive remains the verified Python 3.12 x86-64 package. Cloud Shell may
be Arm because the checker/packager use only the standard library and copy SDK
bytes without importing/rebuilding native deployment libraries.

## Release gates

- Validate Terraform formatting/schema and both mocked IAM modes locally.
- Apply in a fresh authorized tenancy/compartment; verify actual regional services.
- Test final learner and runtime policies, including identity-domain conventions.
- Verify namespace retrieval in Cloud Shell, bucket/application/log-group/log creation and event delivery.
- Validate all four CSV cases and logging; test cleanup before stack Destroy.
- Validate the LiveLabs reservation's pre-created resources, policies, and expiry cleanup, including learner-created log groups.
- Publish the approved ZIP URL, then activate the own-tenancy deployment shortcut.
- Review current screenshot coverage; see [capture notes](screenshots.md).
- Complete ordinary-browser download checks; the in-app browser did not save reports.
- Run a timed beginner rehearsal and recheck regional quotas for the event.

The older author/provision.ps1 prepares the ORIGINAL complete authoring environment
(including buckets and application); it is NOT the new foundation or a learner setup
command. Older check_environment.ps1/test_cloud.ps1 use original private author state.
Do not run them against a fresh learner foundation or claim they verify this new flow.
No cloud apply or IAM mutation is authorized merely by editing this specification.

## Acknowledgements

- **Author** - Graham Shroyer
- **Last Updated By/Date** - Graham Shroyer, October 2026
