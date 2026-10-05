# Author validation and initialization record

## Introduction

**Audience:** Workshop maintainers.

**Estimated Time:** Reference material; no timed learner activity.

### Objectives

- Review historical code and cloud acceptance evidence without treating it as current release approval.

Last updated: 2026-09-17. Region: US Midwest (Chicago).

## Current evidence

- LiveLab compartment and private supporting infrastructure created through OCI CLI.
- VCN, private subnet, service gateway, Oracle Services Network route, and HTTPS
  egress security list are recorded in `state/resources.json`.
- Private incoming/output buckets created; only incoming emits object events.
- Application configuration includes input/output bucket, namespace, threshold 10.
- Dynamic group is limited to Functions resources in LiveLab. Runtime permission
  is input-object read plus output-object create/overwrite, without delete.
- Functions-service network permission is limited to LiveLab.
- Invocation log and log group created, enabled, with 30-day retention.
- Eleven infrastructure read-back checks passed (`state/environment-checks.json`).
- Six processing tests and four adapter tests passed locally. All four
  event-driven cloud exercises passed; both output files matched the expected
  files byte-for-byte. No manual function invocation was used.
- The Console exposes Create from archive, Python runtime `python312.ol9`,
  handler `func.handler`, and Function update runtime-version management.
- First creation failed before code execution: `Object does not exist or you
  are not authorized to access it`. The private archive was verified present.
- User approved an additional service `faas` read permission restricted to the
  exact object `deployment/inventory-reporter.zip` in the incoming bucket.
  `allow_archive_read.ps1` applies that statement without dropping existing ones.
- Installed CLI 3.89.3 does not expose archive creation or runtime listing.
  Management API `20260325`, accessed with signed `oci raw-request` calls, exposes
  archive metadata and asynchronous work requests. Use the supported Console
  direct-upload control for source deployment; do not probe updates with guessed
  or incomplete request bodies.
- Direct-upload source-only archive created an Active function. The bucket-scoped
  Events rule invoked it after `inventory-run1.csv` was uploaded. Invocation logs
  showed `No module named 'oci'`: the runtime provides FDK but does not install
  requirements.txt automatically.
- An archive with all Linux OCI SDK dependencies inside `function/` passed a
  Linux import check but was rejected by direct upload: `Request Entity Too Large`
  at 42,499,346 bytes (40.5 MiB). The exact service size limit is not established.
- The packager now retains shared SDK helpers and Object Storage, excluding
  unrelated service packages. Its check constructs a resource-principal signer
  with synthetic credentials and signs an Object Storage PUT without network
  access. Real event-driven bucket reads/writes subsequently passed.
- The compact archive passed that isolated Linux check: 8,034,611 bytes (7.7 MiB).
  SHA-256: `ae359b36ff8964c13ff46011a6b103c69d5b5e0379f8590c0bad7598c4730873`.
  Console update completed at 2026-09-17 19:33:29 UTC. The function is Active;
  its API-reported source fingerprint exactly matches this archive.

## Cloud acceptance results

| New object uploaded | Threshold | Restock rows | Rejected rows | Both files |
| --- | ---: | ---: | ---: | --- |
| inventory-run1-verified.csv | 10 | 5 | 0 | Exact match |
| inventory-run2.csv | 20 | 11 | 0 | Exact match |
| inventory-bad.csv | 20 | 10 | 1 | Exact match |
| inventory-fixed.csv | 20 | 11 | 0 | Exact match |

Core completed at 19:35:07 UTC; extensions completed at 19:37:54 UTC on
2026-09-17. Evidence and downloaded reports are in `state/cloud-core/` and
`state/cloud-extensions/`. The core filename has a `-verified` suffix because
the original name was already uploaded during packaging diagnosis. The source
bytes are identical; the output prefix follows the uploaded name.

Actual invocation logs include all four `reports_written` counts and:

```json
{"message":"record_rejected","source_file":"inventory-bad.csv","record_id":"INV-007","reason":"invalid_quantity"}
```

The function-level threshold was restored to **10** after the extensions. The
application default also remains 10. This proves the selected runtime, current
network route, scoped runtime permissions, event action, reporting logic, and
logging work together in the authoring environment. It does not establish the
participant IAM role or fresh-tenancy/green-button readiness.

The two failed Object Storage-source deployment resources were removed. The
current function and rule IDs are in the private `state/resources.json` file.
The extra archive-read policy remains applied but is not used by direct upload;
omit it from the eventual initialization stack unless that source path is chosen
and separately proven. `deploy_archive.ps1` records the FAILED Object Storage
source experiment; it is not a working deployment path.

## CLI-first completion order

1. DONE: Read back network, IAM, application, bucket, and logging settings.
2. DONE: Deploy the smaller Linux dependency archive via direct upload.
3. DONE: Create the bucket-scoped Events rule with `connect_event.ps1` and confirm
   event delivery in actual invocation logs.
4. DONE: Upload new CSVs through CLI and compare both output files to expected data.
5. DONE: Verify all counts, inspect rejected-record logs, and restore threshold 10.
6. DONE for the main flow: capture ten real Console screenshots and update the
   guide, including the log time-range controls. The source bundle contains the
   verified compact archive; its custom packager preserves every dependency byte.
   Fresh learner-path capture gaps are recorded in `author/screenshots.md`.

For a later retest, pass a NEW suffix to both suites, for example
`test_cloud.ps1 -Suite Core -SourceSuffix '-review2'`. Reusing an existing source
name would test object update, not this lab's object-create rule.

## Task 2: actual OCI Cloud Shell validation

Verified September 17, 2026, through the signed-in Console's Cloud Shell terminal,
not a local Docker substitute. Menu > Upload transferred the teaching bundle;
it was extracted into the new `~/inventory-lab` directory and tested as supplied.
Its SHA-256 matched the local artifact exactly:
`154aa1cb2807e701bc178089e8868f7c92098371a9c71afcd4531b0e4809c5e0`.

| Check | Observed result |
| --- | --- |
| Cloud Shell session region | `us-chicago-1`; machine/home hosted in tenancy home region Ashburn |
| Host architecture | `aarch64` |
| Default `python3 --version` | Python 3.9.25 |
| Explicit `python3.12 --version` | Python 3.12.14 |
| `unzip` | Preinstalled at `/usr/bin/unzip` |
| Default Python's OCI SDK | Preinstalled, 2.185.0; not needed by Task 2 |
| `python3 verify_inventory.py` | All six tests passed |
| `python3.12 verify_inventory.py` | All six tests passed |
| `python3.12 -S verify_inventory.py` | All six passed with site-package loading disabled |
| `python3.12 package_logic.py` | Created `inventory-reporter-custom.zip` |
| ZIP validation with Python 3.12 `-S` | No corrupt entries; entry names match reference; all non-source entry bytes unchanged; four packaged source files match extracted source |
| Menu > Download | `inventory-lab/inventory-reporter-custom.zip` transfer showed Completed |

No dependencies were installed, no Python default was changed, and no IAM or
network settings were changed. Cloud Shell was already using Public network;
the helper commands do not make cloud API calls or download packages. The
reference deployment ZIP and published teaching bundle were left unchanged.
The uploaded bundle and extracted directory remain in the author's Cloud Shell
home directory for review.

The checker loads only `function/inventory.py`, not the OCI adapter. Both helpers
and the reference processing module use Python's standard library. Cloud Shell's
preinstalled SDK does not mean the Functions runtime installs it: deployment
dependencies remain bundled in the tested x86-64 ZIP. Arm Cloud Shell can check
pure Python logic and copy these ZIP bytes; it must not rebuild/import the
native x86-64 deployment libraries.

The guide now explicitly uses Cloud Shell and `python3.12`, explains the six-test
success signal and no-install requirement, and gives the home-relative download
path. Three real screenshots capture upload selection, successful checks and
packaging, and the download path. Oracle documents the general environment in
[Cloud Shell overview](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cloudshellintro.htm)
and [Cloud Shell file transfers](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/devcloudshellgettingstarted.htm).

This proves the supplied helpers and reference module in the current Cloud Shell
image. Arbitrary AI-generated replacements still need to pass the checker; the
final participant role and fresh green-button reservation need separate testing.
No additional function deployment was performed for this check.

## Green-button initialization inventory

Translate these tested prerequisites into Terraform later; the current scripts
are authoring aids, not a supported green-button implementation.

See [initialization.md](initialization.md) for exact configuration, policy
templates, creation order, learner-owned steps, isolation, and teardown gates.

| Prepared by initialization | Created by learner |
| --- | --- |
| Compartment / learner IAM boundaries | Python processing module or reference code |
| Private VCN, subnet, gateway, route, egress | Function in the prepared application |
| Functions application and shared configuration | Bucket-filtered Events rule and action |
| Incoming/output buckets and event-emission setting | CSV uploads and report inspection |
| Dynamic group and narrow service/runtime policies | Optional threshold override and log diagnosis |
| Invocation logging and artifact distribution | |

Still required before publication: code-only availability in each learner
tenancy, repeat the proven Cloud Shell path under participant IAM, artifact
hosting and checksums, resource naming/isolation, teardown, novice timing test,
and final author/contact information. Do not precreate the learner's function
or Events rule in the eventual initialization stack.

## LiveLabs repository migration (September 23, 2026)

The learner content is split into environment-specific Get Started, shared
Lab 1 (deploy-function), and optional Lab 2 (configure-troubleshoot). Historical
references to Task 2 above mean the code-checking task in the original guide,
now Lab 1 Task 1. ZIP contents were not changed during this migration. Private
state/evidence files remain in the original authoring workspace and are not
included here. The new path layout does not prove fresh tenancy provisioning
or green-button readiness. See the root README for remaining publication gates.

## Foundation and learner-created resources (September 25, 2026)

New source includes a shared Terraform foundation with Resource Manager schema,
explicit administrator-only IAM option, and mock-provider tests. The learner guide
now creates buckets, application/configuration, and invocation logging, using a
resource sheet rather than fixed authoring names. Historical September 17 cloud
results remain valid for the original environment, not proof of the new stack.
No live Apply, new IAM mutation, reservation integration, or new UI capture was
performed while authoring these changes. Consult foundation-validation.md for
local test evidence and outstanding live checks.

## Acknowledgements

- **Author** - Graham Shroyer
- **Last Updated By/Date** - Graham Shroyer, September 2026
