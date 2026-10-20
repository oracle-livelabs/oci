# Self-QA Corrections — September 30, 2026

**Audience:** Workshop maintainers and reviewers.

**Estimated Time:** 5–10 minutes to review this change record.

### Objectives

- Map the self-QA findings to the corrected workshop files.
- Distinguish content verification from remaining cloud and publication checks.

## Corrections applied

| Findings | Correction |
| --- | --- |
| QA-011 | All literal configuration keys, resource-sheet fields, and uppercase resource placeholders use inline code. The rendered application table preserves `OBJECT_STORAGE_NAMESPACE` and `LOW_STOCK_THRESHOLD`. |
| TEXT-01–04 | Added a shared Introduction with 60–90-minute workshop timing. Removed author-review notes, event-buffer wording, unpublished shortcuts, and platform integration directions from learner pages. Kept administrator requirements in maintainer documentation. |
| TEXT-05, TEXT-14 | Added the standard own-tenancy and sandbox Need Help pages. Retained the configured OCI help address and corrected the shared renderer's undefined email subject with `workshops/help-link.js`, using each manifest's title. No email was sent. Mailbox ownership still needs confirmation. |
| TEXT-06 | Replaced the image-based Code Editor link with Oracle's code-only archive documentation. |
| TEXT-07–08, QA-006–010 | Split administrator prerequisites from learner tasks. Added exact compartment selection, ZIP upload, saved Plan/Apply, Apply Logs/resource-sheet, networking, and logging navigation. |
| TEXT-09 | Added Cloud Shell file viewing, a protected reference backup, explicit optional AI file upload/replacement, reference recovery, and CSV inspection commands. |
| TEXT-10 | Separated function-creation settings from inherited application configuration. Highlighted memory, runtime, handler, and runtime-management choices. |
| Live navigation findings | Corrected bucket event enablement, application Monitoring > Logs, the function-level Actions menu, Events Service selection, rule preview, upload completion, Objects Actions > Refresh, row Actions > Download, and log Time range > Edit. |
| TEXT-11 and image findings | Replaced all 13 old screenshots with eight focused real Console captures. Removed personal usernames, namespace, OCIDs, endpoints, excessive blank areas, and the incorrect report prefix from the current image set by choosing clean capture rectangles. Written steps cover forms not pictured. See `screenshots.md`. |
| TEXT-12–13 | Capitalized optional task titles and replaced the partner exercise with a self-paced recap. |
| Structure/lint | Added Introduction and environment-specific Need Help navigation, Objectives/Prerequisites headings, Acknowledgements, next-lab transitions, and four-space indentation inside steps. |
| Filename conventions | Renamed nine Markdown files to lowercase, updated case-sensitive links and the package allowlist, and rebuilt the foundation ZIP. Git case-only renames are staged so Windows preserves the names; the remaining edits are not committed. |
| QA-001 | Added `publication.md` with exact fork Pages workflow and production PR/WMS instructions. The public site is not updated until the owner pushes and deployment succeeds. |

## Verification

- The official Oracle Bash validator passed the six local learner/reference pages, both launchers/manifests, and the maintainer Markdown pages with **0 errors**, avoiding the previously observed Windows-validator exceptions. Separate checks passed for 81 lowercase paths, 35 local references, both manifest sequences, and all eight image descriptions and dimensions.
- Six supplied inventory tests and four adapter tests passed locally on Python 3.12.14. The six supplied tests were also rerun successfully in OCI Cloud Shell on Python 3.12.14.
- The production function source, reference deployment ZIP, sample CSVs, and expected outputs were not changed. No new cloud foundation, IAM policy, function, or event rule was applied in this correction pass.
- The foundation ZIP was rebuilt only for its lowercase readme and updated validation note; all six non-readme members were compared with the committed archive and are byte-for-byte unchanged. SHA256: `427be3db51607324d76f60225a38d010a7be2940b0f2aa17acafe3ad44c1d281`.
- Browser preview confirmed the new Introduction, 60–90-minute estimate, exact underscored keys, and populated email subject. The old preview origin initially served cached content; an uncached preview served the corrected files. Verify the final public revision separately after deployment.
- The original detailed QA observations and retired screenshots remain in the private local QA folder, outside the publishing repository. This record does not retroactively mark an untested workflow as passed.

## Remaining release checks

Do not mark **Self QA Complete** yet:

- Verify custom-ZIP and report downloads in a normal supported browser; the in-app browser did not save those transfers during the original walkthrough.
- Test sandbox reservation provisioning, credential delivery, resource sheet, and expiry/teardown. Publishing its Markdown is not a working green-button deployment.
- Repeat under the intended restricted learner identity; the successful cloud walkthrough used the author/administrator identity.
- Test owner-approved cleanup. QA resources are retained and were not deleted.
- Confirm the help mailbox owner and actual WMS workshop ID/title. Confirm the desired contributor acknowledgements.
- Review screenshot coverage with the LiveLabs reviewer and upload the required filename, accessibility, and successful-lint evidence to WMS.
- Push, wait for GitHub Pages deployment, and check the public URL. Follow the separate upstream PR and WMS review/publishing process for production.
- Run a timed beginner rehearsal; no concurrency/capacity test was performed in this pass.

## Acknowledgements

- **Author** - Graham Shroyer
- **Last Updated By/Date** - Graham Shroyer, September 2026
