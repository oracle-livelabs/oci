# Foundation validation record

Date: September 25, 2026. This records local validation, not a cloud deployment.

## Passed locally

- Official HashiCorp Terraform 1.9.8 Windows x86-64 download checked against the
  vendor SHA-256 manifest; official signed OCI provider 7.32.0 installed.
- `terraform fmt` and `terraform validate` passed.
- Five `terraform test` runs passed with mocked OCI providers: IAM off by default,
  explicit administrator IAM, distinct names for separate learner compartments,
  invalid-prefix rejection, and rejection of tenancy-root placement.
- Assertions check a private subnet, no ingress, TCP 443-only egress, distinct
  input/output bucket names, threshold 10, and three scoped runtime grants with
  no runtime object-delete permission.
- All six existing inventory checks and four adapter tests still pass.
- Both manifests retain exactly Get Started, Lab 1, and optional Lab 2; task
  numbers are sequential and local Markdown links resolve.
- Resource Manager schema parses as JSON (also valid YAML 1.2) and covers all six
  Terraform input variables. Console schema rendering still needs live verification.
- The ZIP build is deterministic and allowlists seven root-level files only:
  versions.tf, variables.tf, main.tf, outputs.tf, schema.yaml, README.md, and
  .terraform.lock.hcl. No state, tfvars, credentials, providers, or mock tests ship.

Foundation ZIP SHA-256:
`5aabcd6acbb4c9a082cfc5e1192179180ccb4327b68efb857337b1821d083e7f`.

The existing function deployment ZIP and source bundle are unchanged.

## Still required before release

1. Authorized live foundation Plan/Apply in a fresh isolated compartment. Confirm
   the regional All Services selection, IAM home region, and actual network rules.
2. Administrator review of default-domain dynamic-group handling and the learner
   policy template; test with the actual participant identity, not an administrator.
3. IAM propagation, bucket/application/configuration/log creation, all four upload
   cases, logging, and cleanup followed by foundation Destroy.
4. Resource Manager schema/outputs screenshots, new learner creation screenshots,
   and a timed beginner rehearsal.
5. LiveLabs reservation/expiry adapter and resource-sheet handoff, then publication
   of the approved ZIP URL and activation of the own-tenancy deployment shortcut.

No OCI deployment, IAM modification, live 20-user test, reservation integration,
repository commit, or push was performed in this update. Mock success does not
establish service availability, IAM correctness, or the green-button integration.
