# Screenshot capture checklist

Use real OCI Console captures in US Midwest (Chicago), compartment LiveLab.
Keep images adjacent to their numbered actions in the corresponding lab Markdown. Do not use invented
screens or source-PDF illustrations as console evidence.

Captured and linked in the guide:

- `00-application-config.png`: shared configuration and default threshold 10.
- `01-input-bucket.png`: incoming bucket with object events enabled.
- `02-upload-dialog.png`: real file-upload selection panel (no CSV attached).
- `02a-cloud-shell-upload.png`: source ZIP selected in the real Cloud Shell upload dialog.
- `02b-cloud-shell-checks.png`: Python 3.12.14, all six checks passing, and custom ZIP created.
- `02c-cloud-shell-download.png`: custom archive's home-relative download path.
- `03-create-from-archive-menu.png`: Functions Actions menu and archive entry.
- `04-function-active.png`: verified compact deployment, runtime, and handler.
- `05-event-function-target.png`: existing-rule review with condition and target.
- `05-event-condition.png`: active rule's Object Create and bucketName filter.
- `06-generated-reports.png`: both real reports under the fresh verification prefix.
- `07-threshold-override.png`: function threshold 20 overrides inherited 10.
- `08-rejected-row-log.png`: actual INV-007 / invalid_quantity diagnostic.

Captured September 17, 2026. Guide captions distinguish existing-resource review
screens from first-time creation, and explain the `-verified` filename suffix.
The logging screenshot hides datetime/type columns only to fit the full message;
the user's original default columns were restored after capture.

The Cloud Shell upload/check/repackage/download sequence was verified with the
exact teaching bundle; the download transfer completed. The upload dialog was
recaptured with a cleared terminal to exclude the welcome banner's account details.

Still useful for a fresh learner dry run: the compact ZIP attached to the initial
Create form, and a CSV in the upload
review step. Do not reuse the old failed Object Storage-source screenshot or the
old source-only archive form. Superseded captures are retained privately under
the original authoring workspace's `author/state/screenshots/`, outside the learner content.

Publication checks: no credentials or auth tokens; crop irrelevant tenancy/user
details; meaningful alt text; legible at normal guide width. Any screenshot
redaction must be visibly a redaction, never an altered result.


## New locations

- Environment screenshots: `../get-started/images/`.
- Cloud Shell, deployment, Events, and initial report screenshots: `../deploy-function/images/`.
- Threshold and rejected-row screenshots: `../configure-troubleshoot/images/`.

Screenshots were copied without alteration; the old `img/` directory is not used.

## Learner-created resource expansion

The existing bucket and application screenshots are explicitly labeled end-state
references in Lab 1. Capture actual bucket creation, event-emission editing,
application creation with x86/private subnet, four configuration entries, and
invocation-log enablement during the authorized fresh-environment dry run. Also
capture Resource Manager variables/outputs and the sandbox resource sheet after
real integration; do not invent screenshots or mark these steps cloud-verified.
