# Initialization ownership and release gates

The shared configuration is in [foundation](../foundation/README.md). Sandbox
automation and own-tenancy Resource Manager use the same inputs and outputs.
See [administrator setup](ADMINISTRATOR-SETUP.md) for IAM and the reservation contract.

| Owner | Resources/actions |
| --- | --- |
| Administrator/platform | Existing isolated compartment, learner identity and permissions, quota checks |
| Terraform foundation | Private VCN/subnet, service gateway, route, HTTPS egress list, log group |
| Administrator or explicitly authorized Terraform option | Function dynamic group, exact input-read/output-create-overwrite policy, faas network policy |
| Learner | Two private buckets, incoming events enabled, x86 application, four configuration keys |
| Learner | Application invoke log (30 days), ZIP function, bucket-filtered Events rule |
| Learner | Uploads, report inspection, optional threshold change and bad-row diagnosis |

No application or bucket should exist in a fresh learner reservation. Give the
learner resource_sheet before starting; names include a compartment-derived suffix.
The code archive remains the verified Python 3.12 x86-64 package. Cloud Shell may
be Arm because the checker/packager use only the standard library and copy SDK
bytes without importing/rebuilding native deployment libraries.

## Release gates

- Validate Terraform formatting/schema and both mocked IAM modes locally.
- Apply in a fresh authorized tenancy/compartment; verify actual regional services.
- Test final learner and runtime policies, including identity-domain conventions.
- Verify namespace read, Cloud Shell, bucket/application/log creation and event delivery.
- Validate all four CSV cases and logging; test cleanup before stack Destroy.
- Implement the LiveLabs platform's actual reservation and expiry integration.
- Publish the approved ZIP URL, then activate the own-tenancy deployment shortcut.
- Capture the new bucket/application/log creation screens; current images are reference end states.
- Run a timed beginner rehearsal and recheck regional quotas for the event.

The older author/provision.ps1 prepares the ORIGINAL complete authoring environment
(including buckets and application); it is NOT the new foundation or a learner setup
command. Older check_environment.ps1/test_cloud.ps1 use original private author state.
Do not run them against a fresh learner foundation or claim they verify this new flow.
No cloud apply or IAM mutation is authorized merely by editing this specification.
