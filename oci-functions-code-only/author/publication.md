# Updating the Workshop Publication

**Audience:** Workshop maintainers.

**Estimated Time:** 5–10 minutes to submit an update, excluding automated deployment and review.

### Objectives

- Update the development preview without changing its URL.
- Distinguish a fork's GitHub Pages deployment from Oracle LiveLabs production publishing.

## Update your GitHub Pages preview

1. Review the full `oci-functions-code-only` diff in your local `oci` repository, including added files, removed screenshots, and case-only renames. Commit the intended changes and push to your fork's `main` branch. This is your fork, not the Oracle production repository.
2. In the fork's **Settings > Pages > Build and deployment**, confirm **Source: GitHub Actions**. The repository already contains `.github/workflows/static.yml`, named **Deploy static content to Pages**, which publishes the repository on pushes to `main`. No workflow edit is required for ordinary content updates.
3. Open **Actions > Deploy static content to Pages** and wait for the run for your new commit to succeed. If it fails, inspect its build/deploy logs. A successful push alone does not prove a successful Pages deployment.
4. Reopen the existing [tenancy preview](https://gshroyer34.github.io/oci/oci-functions-code-only/workshops/tenancy/index.html) and [sandbox preview](https://gshroyer34.github.io/oci/oci-functions-code-only/workshops/sandbox/index.html). Refresh the browser (Ctrl+Shift+R if necessary). If old content persists after a successful deployment, check in a private browser window. Confirm the Introduction menu entry, 60–90-minute estimate, exact underscored configuration keys, download links, and Need Help page.
5. The WMS **Development GitHub/GitLab URL** can stay the same while this folder and entry-point path remain unchanged. Updating its content does not require a new development URL. Do not mark Self QA Complete until the remaining validation checks have passed.

GitHub documents the distinction between branch publishing and Actions publishing in [Configuring a publishing source](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site). The instructions above use the Actions workflow already present in this fork. The live repository's Pages setting still needs confirmation in GitHub.

## Update Oracle LiveLabs production

A push to `gshroyer34/oci` updates your development site; it does **not** merge content into `oracle-livelabs/oci` or approve the workshop in WMS.

1. Complete the outstanding self-QA checks and review the production contribution requirements. Bring the contribution branch up to date with Oracle's repository before opening the pull request.
2. Open or update a pull request from your fork to `oracle-livelabs/oci:main`, scoped to this workshop. Include the actual **WMS workshop ID** in its title and provide the requested checklist evidence. Do not include private QA evidence, credentials, Terraform state, or unrelated repository changes.
3. If a pull request for this branch is already open, push additional corrections to that same branch; they appear in the existing pull request. Do not create a duplicate request for the same change.
4. After the pull request is approved and merged, verify the workshop at the production URL configured in WMS. Allow the production deployment/CDN to update; a merge alone is not proof that the browser is serving the new content.
5. For first publication, complete **WMS > Publishing > + Publish to LiveLabs** and the required review workflow. For an existing publication, edit that publishing entry only if metadata, enabled environments, duration, or URLs need to change. Do not create a duplicate publishing entry for a normal content correction.
6. Keep sandbox/green-button publication disabled until reservation provisioning, resource-sheet delivery, participant permissions, and teardown have been tested. Publishing the sandbox Markdown does not implement reservation provisioning.

Follow Oracle's [Publish your workshop guide](https://oracle-livelabs.github.io/common/sample-livelabs-templates/create-labs/labs/workshops/livelabs/?lab=6-labs-publish) for the current WMS fields and production review process.

## Acknowledgements

- **Author** - Graham Shroyer
- **Last Updated By/Date** - Graham Shroyer, September 2026
