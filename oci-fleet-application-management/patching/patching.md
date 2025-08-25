# Patch a Oracle Fusion Middleware Deployment Using FAM

## Introduction

This lab guides you through automating the patch management process for an Oracle Fusion Middleware deployment using OCI Fleet Application Management (FAM). You’ll learn how to create and manage fleets, remediate compliance issues efficiently using Oracle-defined runbooks, and streamline routine maintenance tasks. You’ll also gain visibility into patch operations and troubleshoot issues to maintain consistent and automated patching across your fleet.

Before you initiate patching, Fleet Application Management runs a series of preparation steps to ensure your resources and products are ready for automation:

* Validation: Makes sure the Fleet Application Management Service (FAMS) plugin is active on each managed instance. If it isn’t enabled, FAM automatically starts it, ensuring the instance is ready for fleet management operations.
* Discovery: Automatically detects eligible targets such as Oracle HTTP Server (OHS), WebLogic Server and Java installations on each instance and adds them to the fleet for centralized management.
* Compliance Evaluation: Checks each target’s patch status against its baseline and identifies any updates needed to keep resources secure and up to date.

Estimated Lab Time: 1 hour 30 minutes

### Objectives

In this lab, you will:

* Create fleet to manage Oracle Fusion Middleware resources
* Fix compliance issues using Oracle-defined runbooks
* Monitor patch execution logs

### Prerequisites

* This lab requires completion of the **Get Started** section in the **Contents** menu on the left.

## Task 1: Navigate to Fleet Application Management in OCI Console

1. Login to OCI Console (see **Get Started** section). Open the **Navigation menu** (hamburger icon).

    ![navigation-menu](images/navigation-menu.png " ")

2. Under **Observability & Management**, click **Fleet Application Management**.

	![fleet-application-management-navigation](images/fleet-application-management-navigation.png " ")

    ![fleet-application-management-overview](images/fleet-application-management-overview.png " ")

## Task 2: Create Fleet to Manage Oracle Fusion Middleware resources

In this task, you will create a Fleet for centralized grouping and management of middleware resources such as Oracle HTTP Server (OHS) and WebLogic Server. Fleets enable you to easily organize related resources and initiate all lifecycle operations, such as compliance checks, patching, and monitoring, from a single, unified view.

1. Navigate to **Fleets** under **Fleet Application Management**, select your assigned compartment  (refer to the sandbox **Reservation Information** page), and then click **Create fleet**.

	![fleet-listing](images/fleet-listing.png " ")

2. Enter a **Name** and ensure the **Create in Compartment** field shows your assigned compartment.

	![create-middleware-fleet-basic-info](images/create-middleware-fleet-basic-info.png " ")

3. Scroll down to the **Add Resources** section. Select **Manual selection**, then click on the **Add resources** button located on the table header.

	![create-middleware-fleet-add-resources-section](images/create-middleware-fleet-add-resources-section.png " ")

4. In the panel that opens, ensure your assigned compartment is selected. Select both compute instances (**Oracle HTTP Server** and **WebLogic Server**), then click **Add resources** at the bottom of the panel. The panel closes, and the resources appear in the table. Click **Next**.

	>Note: The compute instances are **pre-provisioned** in your assigned compartment with OHS and WebLogic pre-installed. You only need to select them from your assigned compartment.

	![create-middleware-fleet-add-resources-panel](images/create-middleware-fleet-add-resources-panel.png " ")

	![create-middleware-fleet-add-resources-review](images/create-middleware-fleet-add-resources-review.png " ")

5. Click on **Add products/product stacks**. A panel opens. In the **Applied Filters** section, set **Type** to *Product* and **Publisher** to *Oracle Defined*. From the table, select **Oracle HTTP Server**, **Oracle WebLogic Server**, and **Oracle Java** Products, then click **Add product/product stack**.

	![create-middleware-fleet-add-products-section](images/create-middleware-fleet-add-products-section.png " ")

	![create-middleware-fleet-add-products-panel](images/create-middleware-fleet-add-products-panel.png " ")

6. After the panel closes, the selected products appear in the table. Enable the **Auto confirm of targets** toggle, then click **Next**.

	![create-middleware-fleet-auto-confirm-option](images/create-middleware-fleet-auto-confirm-option.png " ")

7. Skip the **Notifications** section by clicking **Next** until you reach the **Review** step. Review all the details, then click **Create**.

	![create-middleware-fleet-review](images/create-middleware-fleet-review.png " ")

## Task 3: Validation, Discovery, and Compliance Evaluation of Targets

In the previous task, you created a fleet to manage your middleware resources. After the fleet is created, the first step you’ll see is **Resource addition**. Once resources are added, FAM automatically triggers **Validation**, **Discovery**, and **Compliance Evaluation** in sequence. In this task, you will monitor these phases and verify that each completes successfully.

1. On the **Fleet Details** page, confirm that the fleet reaches the *Active* state and shows the message *Resource addition in progress*. Once this phase completes, verify the added resources under the **Managed resources** tab.

	![middleware-fleet-resource-addition](images/middleware-fleet-resource-addition.png " ")

	![middleware-fleet-managed-resources](images/middleware-fleet-managed-resources.png " ")

2. Next, the resource *Validation* phase begins. Click **View Details** to monitor progress and review validation logs.

	![middleware-fleet-resource-validation](images/middleware-fleet-resource-validation.png " ")

	![middleware-fleet-resource-validation-details](images/middleware-fleet-resource-validation-details.png " ")

	>Note: When the FAMS plugin is successfully enabled (which can take up to **10 minutes** to reflect), validation completes successfully. However, validation may occasionally fail if the plugin is not enabled on the target instance. In such cases, first retry validation. If the issue persists, enable the FAMS plugin manually from the Compute Instance details page (Management tab) and then retry validation.

3. After *Validation* completes successfully, the *Discovery* of middleware targets begins. Click **View Details** to monitor the discovery process and review its logs.

	![middleware-fleet-target-discovery](images/middleware-fleet-target-discovery.png " ")

	![middleware-fleet-discovery-progress](images/middleware-fleet-discovery-progress.png " ")

4. Once *Discovery* completes successfully, review the discovered targets and their compliance status on the **Targets** tab.

	>Note: Because the **Auto confirm of targets** option was enabled during fleet creation, the discovered targets are automatically added to the fleet for management. If this option was not selected, you’ll see a message prompting you to manually confirm the targets.

	![middleware-fleet-discovery-success](images/middleware-fleet-discovery-success.png " ")

	![middleware-fleet-discovered-targets](images/middleware-fleet-discovered-targets.png " ")

## Task 4: Fix Compliance Issues with Runbooks

Once validation, discovery, and compliance evaluation are complete, you can remediate any non-compliant targets. In this task, you will use Oracle-defined runbooks to apply the necessary patches and bring all targets into compliance. This process simplifies patching by automating the required steps with minimal manual intervention.

1. On the Fleet Details page, review the **Compliance Status** section to check patch compliance. If any discovered targets are non-compliant, the Fix Now option will appear. Click **Fix Now** to start remediation and bring the targets into compliance.

	![middleware-fleet-fix-now-option](images/middleware-fleet-fix-now-option.png " ")

2. A panel opens for compliance fix. Ensure that your assigned compartment is selected.

	![middleware-fleet-fix-now-basic-details](images/middleware-fleet-fix-now-basic-details.png " ")

3. In the **Add runbooks** section, you will see the recommended Oracle-defined runbooks based on the products associated with the fleet. If needed, click the three dots next to a runbook to change its execution order or remove it. After reviewing, click **Next**.

	![middleware-fleet-fix-now-add-runbooks-option](images/middleware-fleet-fix-now-add-runbooks-option.png " ")

	>Note: The execution time displayed next to each runbook represents the maximum estimated duration for patching. For this lab, the estimated lab time provided at the beginning should be sufficient to complete the process, as the setup is relatively simpler than a production environment.

4. The listed runbooks do not require any input parameters. Click **Next** to proceed.

	![middleware-fleet-fix-now-runbook-arguments](images/middleware-fleet-fix-now-runbook-arguments.png " ")

5. Review the information and click **Create**. The panel will close, and you will be redirected to the **Executions** tab on the Fleet Details page. A separate execution job will be created for each runbook, and the executions will run in the defined order.

	![middleware-fleet-fix-now-review](images/middleware-fleet-fix-now-review.png " ")

	![middleware-fleet-waiting-executions](images/middleware-fleet-waiting-executions.png " ")


## Task 5: Monitor Patch Execution Logs

In this task, you will monitor the execution of the patching runbook, review detailed logs for each step, and verify whether the patch operations completed successfully.

1. On the **Executions** tab, click each execution job to view more details.

	![middleware-fleet-execution-details-navigation](images/middleware-fleet-execution-details-navigation.png " ")

	![middleware-fleet-execution-details](images/middleware-fleet-execution-details.png " ")

2. Click the **Execution Log** tab to view the runbook execution steps. Expand each step to see more details. The execution logs appear on the right, and you also have the option to download them.

	![middleware-fleet-execution-logs](images/middleware-fleet-execution-logs.png " ")


## Learn More

* [Learn About Fleet Application Management](https://docs.oracle.com/en-us/iaas/Content/fleet-management/home.htm)
* [Patching Oracle-Defined Products](https://docs.oracle.com/en-us/iaas/Content/fleet-management/patch-supported-product.htm#patch-supported-product)

## Acknowledgements

* **Author** - Bhumika Bhagia, Senior Member of Technical Staff, OCI
* **Last Updated By/Date** - Bhumika Bhagia, August 2025
