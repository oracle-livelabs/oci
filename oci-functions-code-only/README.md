# From Code to Cloud in Minutes with OCI Functions

Beginner workshop demonstrating code-only OCI Functions deployment and an
Object Storage -> OCI Events -> Python -> report workflow. Learners now create the two buckets, application, configuration, and invocation log.
The earlier proposed deliberate-bug and independent-challenge exercises are not included.

## Workshop structure

```text
oci-functions-code-only/
  get-started/
    get-started-sandbox.md
    get-started-tenancy.md
    images/
  deploy-function/
    deploy-function.md
    files/                       Source bundle, Python, checks, CSVs, expected reports
    images/
  configure-troubleshoot/
    configure-troubleshoot.md
    files/                       Optional-exercise CSVs and expected reports
    images/
  workshops/
    sandbox/
      index.html
      manifest.json
      README.md
    tenancy/
      index.html
      manifest.json
      README.md
  foundation/                    Shared Terraform root, Resource Manager schema, mock tests
  author/                        Maintenance scripts and review records; not a learner lab
```

Both manifests contain exactly three entries: **Get Started**, **Lab 1**, and
**Lab 2 (Optional)**. Get Started differs by environment; Lab 1 and Lab 2 are
shared. Folder names use lowercase, hyphen-separated descriptions, matching
the repository's sample-workshop conventions.

Plan 60-80 minutes including optional Lab 2, plus buffer within the 90-minute
session. Own-tenancy foundation deployment is pre-work and may take extra time.
These estimates need a beginner dry run.

## Local preview

From the `oci-functions-code-only` directory, run:

```text
python -m http.server 8000 --bind 127.0.0.1
```

Open either:

- Sandbox: http://localhost:8000/workshops/sandbox/index.html
- Own tenancy: http://localhost:8000/workshops/tenancy/index.html

Use HTTP rather than opening the HTML as a local file. The unchanged Oracle
LiveLabs launcher loads its renderer and styles from Oracle's CDN, so preview
requires internet access. The manifest paths are relative to their workshop
directories; image and download paths are relative to their lab Markdown files.

## Review and readiness

The function archive, all four cloud exercises, and the Cloud Shell checks were
verified in the authoring environment on September 17, 2026. See
[validation evidence](author/VALIDATION.md).

The shared [foundation](foundation/README.md) and downloadable Resource Manager
package prepare the network/log group and optionally administrator-approved runtime
IAM. Learners build the application-facing resources. See
[administrator setup](author/ADMINISTRATOR-SETUP.md) and
[initialization ownership](author/INITIALIZATION.md).

Remaining release gates:

- Live deployment of the new stack and final learner-role end-to-end validation.
- LiveLabs reservation/expiry integration and a published deploy-button package URL.
- New screenshots for bucket/application/log creation, novice timing, and cleanup tests.
- Confirmation of OCI help routing and final contributor acknowledgements.

The original cloud acceptance results do not validate the new foundation automatically.

## Maintainer notes

The canonical Python implementation, four fixtures, expected reports, checker,
packager, and verified deployment ZIP live under `deploy-function/files/`.
The complete source bundle stays self-contained so its checker still works
after extraction. Lab 2 has local copies of its three CSVs and expected reports;
`author/build_assets.py` synchronizes those copies when assets are rebuilt.

```text
python deploy-function/files/verify_inventory.py
python author/test_adapter.py
python author/build_assets.py
```

Rebuild the foundation download after configuration changes with
`pwsh -File author/package_foundation.ps1`. It packages only approved source files;
run the foundation's validation and mock tests before publishing the new ZIP.
See [foundation validation evidence](author/FOUNDATION-VALIDATION.md).

The archive was copied byte-for-byte during migration, not rebuilt. The author
scripts have updated asset paths; the legacy provision/check scripts still describe
the original complete authoring environment, not the new learner foundation. Provisioning requires an explicit compartment
ID rather than defaulting to the author's compartment. The legacy
`deploy_archive.ps1` remains a failed Object Storage-source experiment, not the
supported learner deployment path. Do not run cloud-changing author scripts
as part of reviewing this folder.

Original Git metadata, OCI state, credentials, logs, virtual environments, and
Python caches are not copied. The original `functions-livelab` workspace is
retained unchanged as a migration backup. This folder belongs to the enclosing
`oci` repository and must not contain its own `.git` directory.

For later contribution, follow the enclosing repository's CONTRIBUTING.md and
its Oracle Contributor Agreement/sign-off requirements. No commit or push is
part of this migration.
