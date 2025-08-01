# Provision Infrastructure Resources Using Fleet Application Management

## Introduction

This lab walks you through the steps to define and provision infrastructure resources such as Compute, Networking, and Storage using Fleet Application Management. You will learn how to use Catalog Items, Runbooks, and Fleets to organize resources and streamline infrastructure provisioning workflows.

Estimated Time: 30 minutes

### Objectives

In this lab, you will:

* Create private Catalog Items for Terraform configurations and parameters
* Build a Runbook by adding Catalog Items as tasks to define provisioning steps
* Create a Fleet to organize resources
* Execute the Runbook on the Fleet and monitor the deployment

### Prerequisites

* This lab requires completion of the Get Started section in the Contents menu on the left.

## Task 1: Navigate to Fleet Application Management in OCI Console

1. Open the **Navigation** menu.

2. Under **Observability & Management**, click **Fleet Application Management**.

## Task 2: Create a Private Terraform Catalog Item

In this task, you will learn how to create a Private Terraform Catalog Item in Fleet Application Management, enabling you to securely reuse and standardize Terraform configurations for automated resource provisioning in your cloud environment.

1. From the left-side menu, navigate to **Provisioning** &rarr; **Catalogs** &rarr; **Private catalog**.

2. Select your assigned compartment (refer to the sandbox **Reservation Information** page), then click **Add catalog item**.

3. Enter a **Name**, **Short description**, **Long description**, **Version** (e.g., 1.0.0), and **Version description**.

4. For **Type**, select **Terraform package**, and ensure the **Create in compartment** field shows your assigned compartment.

5. In the **Add resource** section, choose **Select from Object Storage bucket**. Select your assigned compartment, bucket, and *Terraform package (.zip file)* from the available objects, then click **Create** to finish.

## Task 3: Create a Private Configuration Catalog Item

In this task, you will learn how to create a Private Configuration Catalog Item in Fleet Application Management. The *config.json* file you upload provides values for the variables defined in the Terraform package's *variables.tf*, allowing you to keep configuration data separate from code and avoid hardcoding values directly in your Terraform modules.

1. Download the sample [config.json](files/config.json) file.

2. Modify the file with the appropriate values found in the **Terraform Values** section of the sandbox **Reservation Information** page.

3. From the navigation menu (**Hamburger icon**), go to **Storage** &rarr; **Buckets**.

4. Select your assigned compartment (see the sandbox **Reservation Information** page). Locate the pre-provisioned Object Storage bucket, click on it, go to the **Objects** tab, and choose **Upload objects**. Select the modified *config.json* from your computer and proceed through the prompts to complete the upload.

5. From the navigation menu, go to **Observability & Management** &rarr; under **Fleet Application Management** &rarr; **Provisioning** &rarr; **Catalogs** &rarr; **Private catalog**.

6. Select your assigned compartment, then click **Add catalog item**.

7. Enter a **Name**, **Short description**, **Long description**, **Version** (e.g., 1.0.0), and **Version description**.

8. For **Type**, select **Configuration file**, and ensure the **Create in compartment** field shows your assigned compartment.

9. In the **Add resource** section, choose **Select from Object Storage bucket**. Select your assigned compartment, bucket, and *config.json* file from the available objects, then click **Create** to finish.

## Task 4: Build a Runbook and Add Catalog Items as Tasks

## Task 5: Create a Fleet Without Resources

A Fleet in Fleet Application Management is a logical grouping of infrastructure resources that simplifies the management and automation of application deployments. In this task, you'll create a new Fleet, which serves as the target group for provisioning resources in subsequent steps.

1. From the left-side menu, click **Fleet**, select your assigned compartment (see the sandbox **Reservation Information** page), then click **Create Fleet**.
2. Enter a **Name** and **Description**, ensure the **Create in Compartment** field shows your assigned compartment, then click **Next**.
3. Leave all optional steps as default and keep clicking **Next** until you reach the review step.
4. Review your configuration, then click **Create** to finish.

## Task 6: Execute the Runbook on the Fleet

## Task 7: Monitor Deployments and Provisioned Resources

## Learn More

* [Provisioning Resources Using Fleet Application Management](https://docs.oracle.com/en-us/iaas/Content/fleet-management/provision-resources.htm)

## Acknowledgements

* **Author** - Bhumika Bhagia, Senior Member of Technical Staff, OCI
* **Last Updated By/Date** - Bhumika Bhagia, August 2025
