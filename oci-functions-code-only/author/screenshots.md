# Screenshot Capture Notes

**Audience:** Workshop maintainers.

**Estimated Time:** Reference material; capture time depends on the Console state.

### Objectives

- Keep screenshots aligned with the learner's actual step and current Console controls.
- Exclude account identifiers and unnecessary whitespace without inventing results.

## Current published assets

Eight real Console captures were taken on September 30, 2026. Each is captured with a tight viewport rectangle, at no more than 1280 pixels in either dimension. No image-generation tool, fabricated Console state, or post-capture pixel editing was used. Account usernames, namespace, OCIDs, and invocation endpoints are outside the captured rectangles.

| File | Learner step shown |
| --- | --- |
| `deploy-function/images/invocation-log-active.jpg` | Monitoring > Logs, with Function Invocation Logs Active |
| `deploy-function/images/cloud-shell-checks.jpg` | Actual Cloud Shell Python 3.12.14 and six passing checks |
| `deploy-function/images/create-from-archive-menu.jpg` | Correct Actions menu beside Create from existing image |
| `deploy-function/images/create-function-archive.jpg` | Actual Create function form with device-upload archive selected |
| `deploy-function/images/function-active.jpg` | Active inventory-reporter function |
| `deploy-function/images/objects-refresh-menu.jpg` | Objects table Actions > Refresh |
| `deploy-function/images/generated-reports.jpg` | Actual inventory-run1 prefix and both reports |
| `configure-troubleshoot/images/rejected-row-log.jpg` | Actual rejected-record message for INV-007 |

The creation form was opened only for a screenshot and canceled without creating another function. The logging and report images show resources from the successful QA run. The source includes precise written steps for the remaining forms rather than recycling screenshots of different tasks or states.

## Retired assets

The previous 13 PNG images are no longer part of the workshop tree. They were moved to a recoverable private QA backup outside the repository, not deleted permanently. Do not re-add them: findings included personal account details, the wrong output prefix, oversized images, old controls, and existing-resource screens presented beside creation steps.

## Remaining capture review

Review whether additional Create bucket/application/log/rule and Resource Manager screenshots would materially help beginners. Capture the actual sandbox resource sheet only after reservation integration exists. Do not claim that written instructions or an administrator screenshot prove a restricted learner's access.

Menu-path screenshots, if added, should use the current common-path images specified by the LiveLabs authoring guide. The workshop's local images focus on resource forms and results, not the global navigation menu. Add descriptive alt text to every image and upload the requested filename/accessibility/lint evidence to WMS after final QA.

## Acknowledgements

- **Author** - Graham Shroyer
- **Last Updated By/Date** - Graham Shroyer, September 2026
