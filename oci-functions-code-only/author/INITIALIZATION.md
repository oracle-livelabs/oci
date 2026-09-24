# Green-button initialization specification

Working specification for Terraform translation; not yet a deployable stack.
The authoring environment is `LiveLab` in `us-chicago-1` (Chicago). Do not copy
authoring OCIDs into the published stack. Accept the assigned compartment,
region, namespace, and a reservation-specific name suffix as inputs.

## Prepare before the learner starts

| Component | Required configuration |
| --- | --- |
| VCN | Private lab network; authoring CIDR `10.42.0.0/16` |
| Regional subnet | `10.42.1.0/24`; prohibit public IPs; application uses this subnet |
| Service gateway | All regional services in Oracle Services Network |
| Route table | Regional Oracle Services Network service CIDR -> service gateway |
| Security list | No ingress; stateful TCP 443 egress to the regional service CIDR |
| Incoming bucket | Private, Standard tier, object events enabled |
| Output bucket | Private, Standard tier, object events disabled |
| Functions application | `GENERIC_X86`; configured subnet and four shared settings below |
| Dynamic group | Only `fnfunc` resources in the assigned learner compartment |
| IAM policy | Input read, output create/overwrite, Functions-service network use |
| Invocation logging | Functions application `invoke` service log; enabled; 30-day retention |
| Teaching assets | Versioned ZIP, CSVs, expected reports, prompt, checks, and checksums |

No NAT gateway, public bucket, inbound listener, API Gateway, OCIR repository,
personal API key in the code, or AI-service access is required by this design.
Cloud Shell needs its normal workshop access separately. Task 2 is verified with
the preinstalled `/usr/bin/python3.12` (3.12.14) and `unzip`; the guide uses the
explicit version because `python3` resolved to 3.9.25 in the authoring session.
No pip install, virtual environment, or Python dependency bootstrap is needed
for the supplied processing checker and ZIP repackager. Ensure the participant
can start Cloud Shell and use its Menu upload/download controls.

Application configuration:

```text
INPUT_BUCKET=<resolved incoming bucket name>
OUTPUT_BUCKET=<resolved output bucket name>
OBJECT_STORAGE_NAMESPACE=<tenancy namespace>
LOW_STOCK_THRESHOLD=10
```

Dynamic-group rule:

```text
ALL {resource.type = 'fnfunc', resource.compartment.id = '<learner compartment OCID>'}
```

Runtime/service policy templates (substitute actual names and compartment):

```text
Allow dynamic-group <lab dynamic group> to read objects in compartment id <compartment OCID> where target.bucket.name = '<incoming bucket>'
Allow dynamic-group <lab dynamic group> to manage objects in compartment id <compartment OCID> where all {target.bucket.name = '<output bucket>', any {request.permission = 'OBJECT_CREATE', request.permission = 'OBJECT_OVERWRITE'}}
Allow service faas to use virtual-network-family in compartment id <compartment OCID>
```

These are workload permissions, not participant permissions. The initial author
used an existing administrative identity. Define and test the participant role
separately: inspect prepared resources, create/update their function, create an
Events rule/action, upload inputs, read reports, view logs, and use Cloud Shell.
Do not grant tenancy-wide management just to make the lab work. IAM setup may
require tenancy-level administration and propagation time before handoff.

## Leave these actions to the learner

1. Review/generate and check `inventory.py`.
2. Create the function from the prepared ZIP in the existing application.
3. Create an enabled Events rule: `com.oraclecloud.objectstorage.createobject`,
   with `data.additionalDetails.bucketName` restricted to the incoming bucket,
   and a Functions action targeting the learner's function.
4. Upload a newly named CSV; inspect both output reports.
5. Optionally override the function threshold and investigate rejected-row logs.

Do not precreate the function, Events rule, exercise CSV objects, or result
reports in initialization. The sample files belong in the downloadable bundle,
not in the event-emitting bucket before the learner starts.

## Dependency and readiness order

Create network and buckets, then application/configuration and logging. Create
the dynamic group and scoped policies before handoff. Wait for resources to be
ready and IAM propagation. Run the read-only checks represented by
`check_environment.ps1`, then perform one isolated acceptance test in a fresh
reservation, not by leaving completed exercises in the learner's environment.

The code-only ZIP must contain `function/` with Linux/Python 3.12 x86-64 SDK
dependencies. The runtime supplies FDK but does not install requirements.txt.
Use a tested, compact build: the all-service SDK ZIP exceeded the direct-upload
request limit. Do not require the learner to build Docker images.

The tested Cloud Shell host is Arm (`aarch64`), while the Functions application
and bundled dependencies are x86-64. This is intentional: Task 2 executes only
standard-library processing code and copies the prebuilt ZIP entries unchanged.
Do not rebuild the deployment dependencies with Cloud Shell's native pip or try
to import the archive's native x86-64 libraries there.

The additional single-object `faas` archive-read grant in the authoring tenancy
was a troubleshooting experiment for the failed Object Storage-source method.
It is not part of the direct-upload initialization specification.

## Publication gates

- Confirm code-only runtime availability in the green-button tenancy and region.
- Confirm Terraform/provider coverage for the prepared application and logging;
  function deployment remains a learner Console action.
- Parameterize names in instructions or provide a reservation resource summary.
- Repeat the verified Cloud Shell upload/check/repackage/download and fresh-name
  event delivery under the final learner IAM role, without an administrator identity.
- Verify all four expected report pairs and the invalid-row log.
- Perform a timed beginner run; current core estimate is 35-40 minutes plus buffer.
- Define reservation expiry, budget/quota safeguards, and scoped teardown.
- Teardown must disable/remove the lab rule before function/network cleanup,
  handle only that reservation's bucket objects, then remove the prepared
  resources and scoped IAM. No automated destructive cleanup is implemented yet.
