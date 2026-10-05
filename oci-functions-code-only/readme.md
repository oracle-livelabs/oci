# From Code to Cloud in Minutes with OCI Functions

Beginner workshop demonstrating code-only OCI Functions deployment and an
Object Storage -> OCI Events -> Python -> report workflow. Learners create the two buckets, application, configuration, and invocation log.

## Workshop structure

```text
oci-functions-code-only/
  introduction/
    introduction.md
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
      readme.md
    tenancy/
      index.html
      manifest.json
      readme.md
  foundation/                    Shared Terraform root, Resource Manager schema, mock tests
  author/                        Maintenance scripts and review records; not a learner lab
```

Both manifests contain **Introduction**, **Get Started**, **Lab 1**, **Lab 2 (Optional)**,
and the environment-specific common **Need Help?** page. Get Started differs by environment; Lab 1 and Lab 2 are
shared. Folder names use lowercase, hyphen-separated descriptions, matching
the repository's sample-workshop conventions.

Estimated workshop time: **60–90 minutes**. Arranging a tenancy, permissions,
or additional capacity can take extra time. The estimate still needs a novice
timing run; this author-only note is not part of the learner instructions.

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
[validation evidence](author/validation.md).

The shared [foundation](foundation/readme.md) and downloadable Resource Manager
package prepare the network/log group and optionally administrator-approved runtime
IAM. Learners build the application-facing resources. See
[administrator setup](author/administrator-setup.md) and
[initialization ownership](author/initialization.md).

Remaining release gates:

- Restricted learner-role validation; the fresh foundation and all four CSV cases
  passed an administrator-led Console walkthrough on September 30, 2026.
- LiveLabs reservation/expiry integration and a published deploy-button package URL.
- Normal-browser report/custom-ZIP download checks, novice timing, and cleanup tests.
- Final screenshot coverage review.
- Confirmation of OCI help routing and final contributor acknowledgements.

See [QA corrections and remaining release checks](author/qa-corrections.md).
For GitHub Pages and Oracle LiveLabs updates, see [publication instructions](author/publication.md).

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
See [foundation validation evidence](author/foundation-validation.md).

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
its Oracle Contributor Agreement/sign-off requirements. Review the full workshop diff before committing or pushing.
