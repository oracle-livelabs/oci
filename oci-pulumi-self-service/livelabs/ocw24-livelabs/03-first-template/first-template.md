# Create your first Backstage infrastructure template

## Introduction

In this lab you'll deploy your first template to Backstage. The provided template will be used to create a simple static web page using OCI Object Storage that serves an index.html file. The index.html file will be populated with the input provided by the userin the Backstage app.

Estimated time: 20 minutes

### Objectives

* Create a new backstage template
* Use the template to provision a static web page in OCI Object Storage

## Task 1: Create the Backstage template.

1. From the Backstage dashboard, click the **`[CREATE]`** button.

2. You'll see there is an existing template for `Create a new OCI Static Website`.

    ![View available templates](images/backstage-create-existing-templates.png)

3. Click **`[Choose]`** to select this template, then fill in the fields on the subsequent screen.

    * **Name** - a new, unique Pulumi stack name
    * **Description** - A brief summary; something like, "OCI Pulumi Workshop - First Template"
    * **Owner** - Enter a team name, such as `Development` or `Infrastructure`
    * **Compartment OCID** - Enter the OCID of the compartment that you created earlier for the workshop.

    >Note: We've not added any entities to the platform yet so Owner name isn't important just yet.

4. Click **`[NEXT]`** and fill in the Pulumi template details.

    * **Organization** - Enter somethign like, "Workshop"
    * **Pulumi ESC** - **`oci-pulumi-self-service`**
    * **Select stack** - Pick one [Development | QA | Production]
    * **Website content** - Copy and paste the following: 

        ```
        <copy>
        <html>
        <head>
        <title>OCI + Pulumi + Backstage = Self Service Portal</title>
        <h1>Well done - your first template deployment!</h1>
        </head>
        </html>
        </copy>
        ```

5.  Click **`[NEXT]`** and fill in the Repository Location (where Backstage will store your output code).

    * **Host** - Github is the only option for now. You can of course update the template later to support other options.
    * **Owner** - Your Github user ID; must be the same one you used to generate the PAT at the beginning of the workshop.
    * **Repository** - Pick a name for the new repo that Backstage will create.

6. Click **`[REVIEW]`**, make sure the details look good, then click **`[CREATE]`**. Watch the magic happen.

## Task 2: Interact with the Backstage component

1. Once the build completes, you'll see a few link options to explore.

    ![Create complete: available links](images/component-complete-01.png)

2. You can click to open the source code repo and you'll be directed to Github in a new window. You can now clone the repo and experiment with making changes to the code.

    >Note: Because this was copied from a central template repo, you can perform all the experiments you want without affecting the upstream code base.

3. Return to the component complete page and click to open the catalog info component. Here you'll see details about the component, including relations (we've not yet added entities, so this is kind of boring).

4. Note across the top menu you have things like CI/CD, API, Dependencies, and more. These are all features you may choose to leverage during implementation.

5. Click the **PULUMI** menu item to see activities details. Clicking the link in the **Type** colum will take you to app.pulumi.com where you can view complete details about the stack and corresponding infrastructure.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - Eli Schilling - Technical Architect
* **Contributors** -
* **Last Updated By/Date** - August, 2024