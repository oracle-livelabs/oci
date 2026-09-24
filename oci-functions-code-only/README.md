# From Code to Cloud in Minutes with OCI Functions

Beginner workshop demonstrating code-only OCI Functions deployment and an
Object Storage -> OCI Events -> Python -> report workflow. This reorganization
contains the existing lab only; the proposed 90-minute additions are not included.

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
  author/                        Maintenance scripts and review records; not a learner lab
```

Both manifests contain exactly three entries: **Get Started**, **Lab 1**, and
**Lab 2 (Optional)**. Get Started differs by environment; Lab 1 and Lab 2 are
shared. Folder names use lowercase, hyphen-separated descriptions, matching
the repository's sample-workshop conventions.

The current scope remains approximately 35-40 minutes for Get Started and
Lab 1, plus 10-15 minutes for optional Lab 2. Estimates need a beginner dry run.

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

This is not yet a ready-to-publish self-service workshop:

- Green-button provisioning and the own-tenancy setup experience remain pending.
- Own-tenancy learners currently need administrator-prepared supporting resources.
- Test final learner IAM, names/isolation, runtime availability, and teardown.
- Confirm the OCI help routing and final author/contributor acknowledgements.
- Perform the beginner timing and final screenshot/content review.

[INITIALIZATION.md](author/INITIALIZATION.md) records the prerequisite resources
and the boundary between initialization and learner activities.

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

The archive was copied byte-for-byte during migration, not rebuilt. The author
scripts have updated asset paths. Provisioning requires an explicit compartment
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
