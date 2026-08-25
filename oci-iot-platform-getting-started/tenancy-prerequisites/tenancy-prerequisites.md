# Lab 2: Set Up the Tenancy

## Introduction

Prepare a dedicated top-level OCI compartment for the water-pump solution. Create it directly under the tenancy root, not inside another compartment. The compartment is the container for this workshop's IoT resources and supporting security resources. Keep the resources in one region and use the compartment only for this workshop or a similarly scoped development environment.

This lab follows [OCI IoT Platform Setup for Developers: Preparing Your Tenancy](https://blogs.oracle.com/cloud-infrastructure/oci-iot-setup-for-devs-prep-your-tenancy) and the [OCI IoT Platform prerequisites](https://docs.oracle.com/en-us/iaas/Content/internet-of-things/overview.htm#prerequisites). You need tenancy-administrator access, or help from a tenancy administrator, to complete the IAM and service setup.

Estimated Time: 60 minutes

### Objectives

In this lab, you will:

- Create a dedicated compartment for the workshop.
- Create the `iot-factory-lab` IAM group and add a lab user.
- Grant the group access to OCI IoT Platform and Vault resources.
- Create a Vault and authorize the IoT Platform to read its device secrets.
- Create an IoT domain group and IoT domain in the workshop compartment.

## Task 1: Create the workshop compartment

1. Sign in as a tenancy administrator. Open the navigation menu, select **Governance & Administration**, and then select **Compartments**.

2. Select **Create Compartment**. Set its parent to the tenancy root. Do not select an existing child compartment. Use a name that is unique in your tenancy, such as `iot-water-pump-workshop`, and add a description such as `OCI IoT Platform water-pump workshop resources`.

3. Create the top-level compartment. Copy its OCID and select it as the working compartment for the remaining labs.

    A compartment provides the ownership, lifecycle, and IAM boundary for the IoT domain, digital twins, and supporting security resources.

4. Alternatively, use the OCI CLI to create the compartment. Set `TENANCY_OCID` to the tenancy OCID, which is the parent for this top-level compartment. Do not substitute the OCID of another compartment.

    ```bash
    export TENANCY_OCID='<tenancy-ocid>'
    export WORKSHOP_COMPARTMENT_OCID=$(oci iam compartment create \
      --compartment-id "$TENANCY_OCID" \
      --name iot-water-pump-workshop \
      --description "OCI IoT Platform water-pump workshop resources" \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)
    ```

## Task 2: Create the workshop team and grant access

IAM users, groups, and the policy are tenancy-level resources. Execute every step in this task as a tenancy administrator; do not use the workshop compartment as the IAM scope. The policy later grants the group access only to the workshop compartment.

1. In the OCI Console navigation menu, select **Identity & Security**, then select **Domains**. Open the identity domain for the tenancy, select **Groups**, and then select **Create group**. Name the group `iot-factory-lab` and add a description such as `Users who build the OCI IoT factory workshop`.

2. Select **Users**, then select **Create user**. Create at least one lab user, such as `iot-factory-student`, using an email address that the learner can access. Follow the Console prompts to set up the user's sign-in credentials.

    If you are completing the workshop with your existing user, add that user to `iot-factory-lab` as well. Select the new user, select **Groups**, and add `iot-factory-lab`.

3. Alternatively, create the group and a lab user with the OCI CLI, then add the user to the group. These tenancy-level IAM commands require tenancy-administrator privileges. `TENANCY_OCID` must be the tenancy OCID, not the workshop compartment OCID. Set `LAB_USER_EMAIL` to an address that the learner can access.

    ```bash
    export LAB_GROUP_OCID=$(oci iam group create \
      --compartment-id "$TENANCY_OCID" \
      --name iot-factory-lab \
      --description "Users who build the OCI IoT factory workshop" \
      --query 'data.id' --raw-output)

    export LAB_USER_EMAIL='iot-factory-student@example.com'
    export LAB_USER_OCID=$(oci iam user create \
      --compartment-id "$TENANCY_OCID" \
      --name iot-factory-student \
      --email "$LAB_USER_EMAIL" \
      --description "OCI IoT factory workshop learner" \
      --query 'data.id' --raw-output)

    oci iam group add-user \
      --group-id "$LAB_GROUP_OCID" \
      --user-id "$LAB_USER_OCID"
    ```

4. As a tenancy administrator, open **Identity & Security**, select **Policies**, and create a policy in the root compartment named `iot-factory-lab-workshop-policy`. The policy is attached at the tenancy level, while its statements grant access only to the workshop compartment. Replace the compartment name if you chose a different one in Task 1.

    ```
    Allow group iot-factory-lab to manage iot-family in compartment iot-water-pump-workshop
    Allow group iot-factory-lab to manage vaults in compartment iot-water-pump-workshop
    Allow group iot-factory-lab to manage keys in compartment iot-water-pump-workshop
    Allow group iot-factory-lab to manage secret-family in compartment iot-water-pump-workshop
    ```

5. Alternatively, create the policy with the CLI. This command creates the policy in the root compartment and saves its OCID for the Vault-specific policy update in the next task.

    ```bash
    export WORKSHOP_POLICY_OCID=$(oci iam policy create \
      --compartment-id "$TENANCY_OCID" \
      --name iot-factory-lab-workshop-policy \
      --description "Permissions for the OCI IoT factory workshop" \
      --statements '[
        "Allow group iot-factory-lab to manage iot-family in compartment iot-water-pump-workshop",
        "Allow group iot-factory-lab to manage vaults in compartment iot-water-pump-workshop",
        "Allow group iot-factory-lab to manage keys in compartment iot-water-pump-workshop",
        "Allow group iot-factory-lab to manage secret-family in compartment iot-water-pump-workshop"
      ]' \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)
    ```

6. Sign in as the lab user, or confirm that your existing user is a member of `iot-factory-lab`. The permissions can take a few minutes to propagate. For a production environment, split domain-administration, Vault, and digital-twin responsibilities, then grant only the required permissions. Review the [OCI IoT Platform user policies](https://docs.oracle.com/en-us/iaas/Content/internet-of-things/user-policies.htm) before you apply production policies.

## Task 3: Create a Vault for device credentials

1. In the OCI Console, select **Identity & Security**, select **Vault**, and select the workshop compartment. Select **Create Vault**. Name it `iot-factory-lab-vault`, leave **Make it a virtual private vault** cleared for this learning environment, and create the vault. Wait until its lifecycle state is **Active**.

    The Vault stores the secrets that authenticate the two pumps later in the workshop. This lab uses basic authentication for clarity; use certificates and mutual TLS for production devices.

2. Copy the Vault OCID and export it for the later CLI commands. If you use the Console path, set the value shown on the Vault details page.

    ```bash
    export VAULT_OCID='<iot-factory-lab-vault-ocid>'
    ```

3. Alternatively, create the default Vault with the OCI CLI and save its OCID.

    ```bash
    export VAULT_OCID=$(oci kms management vault create \
      --compartment-id "$WORKSHOP_COMPARTMENT_OCID" \
      --display-name iot-factory-lab-vault \
      --vault-type DEFAULT \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)
    ```

4. Create a master encryption key in the Vault. In the OCI Console, open `iot-factory-lab-vault`, select **Master Encryption Keys**, and select **Create Key**. Name the key `iot-factory-lab-master-key`, use an AES key with a 256-bit length, and wait until the key is enabled. Copy the key OCID and export it for Lab 6.

    ```bash
    export VAULT_MASTER_KEY_OCID='<iot-factory-lab-master-key-ocid>'
    ```

5. Alternatively, create the master encryption key with the CLI. The Vault management endpoint is required for key-management operations.

    ```bash
    export VAULT_MANAGEMENT_ENDPOINT=$(oci kms management vault get \
      --vault-id "$VAULT_OCID" \
      --query 'data."management-endpoint"' --raw-output)

    export VAULT_MASTER_KEY_OCID=$(oci kms management key create \
      --compartment-id "$WORKSHOP_COMPARTMENT_OCID" \
      --display-name iot-factory-lab-master-key \
      --key-shape '{"algorithm":"AES","length":32}' \
      --endpoint "$VAULT_MANAGEMENT_ENDPOINT" \
      --wait-for-state ENABLED \
      --query 'data.id' --raw-output)
    ```

6. As a tenancy administrator, add the following policy statement to `iot-factory-lab-workshop-policy`. Replace `<vault-ocid>` with the OCID for the Vault you just created.

    ```
    Allow any-user to {SECRET_BUNDLE_READ, SECRET_READ} in compartment iot-water-pump-workshop where ALL {request.principal.type = 'iotdomain', target.vault.id = '<vault-ocid>'}
    ```

7. Alternatively, update the policy by using the CLI. OCI requires a version date whenever you update policy statements. This policy has no fixed version date, so pass an explicit empty value. The update command replaces the policy statements with the complete set, including the IoT domain access to the Vault.

    ```bash
    oci iam policy update \
      --policy-id "$WORKSHOP_POLICY_OCID" \
      --version-date '' \
      --statements "[
        \"Allow group iot-factory-lab to manage iot-family in compartment iot-water-pump-workshop\",
        \"Allow group iot-factory-lab to manage vaults in compartment iot-water-pump-workshop\",
        \"Allow group iot-factory-lab to manage keys in compartment iot-water-pump-workshop\",
        \"Allow group iot-factory-lab to manage secret-family in compartment iot-water-pump-workshop\",
        \"Allow any-user to {SECRET_BUNDLE_READ, SECRET_READ} in compartment iot-water-pump-workshop where ALL {request.principal.type = 'iotdomain', target.vault.id = '$VAULT_OCID'}\"
      ]"
    ```

8. Confirm that the policy contains both the four group statements from Task 2 and the IoT domain secret-read statement. You create the individual pump secrets in Lab 6 before you create the pump instances.

9. If your organization uses certificate authentication, follow the certificate policies in the tenancy-preparation blog instead. Keep certificate resources in the same region and compartment as the IoT resources.

## Task 4: Create an IoT domain group and IoT domain

1. In the OCI Console, select the workshop compartment. Open **Internet of Things**, then create an IoT domain group. An IoT domain group provides the database used by the platform.

2. Create an IoT domain in that domain group. The domain is the container for the models, adapters, instances, and relationships that you create in the next labs.

3. Copy the IoT domain OCID. You use it as `IOT_DOMAIN_OCID` in every OCI CLI command in this workshop.

4. Confirm that the domain is active before you continue.

5. Alternatively, use the OCI CLI to create the development domain group and domain. The create commands are asynchronous, so the list commands retrieve the new resource OCIDs after their work requests succeed.

    ```bash
    oci iot domain-group create \
      --compartment-id "$WORKSHOP_COMPARTMENT_OCID" \
      --display-name "IoT Factory Lab Domain Group" \
      --description "Development domain group for the OCI IoT factory workshop" \
      --type DEVELOPMENT \
      --wait-for-state SUCCEEDED

    export IOT_DOMAIN_GROUP_OCID=$(oci iot domain-group list \
      --compartment-id "$WORKSHOP_COMPARTMENT_OCID" \
      --all \
      --query 'data.items[?"display-name"==`IoT Factory Lab Domain Group`].id | [0]' \
      --raw-output)

    oci iot domain create \
      --compartment-id "$WORKSHOP_COMPARTMENT_OCID" \
      --iot-domain-group-id "$IOT_DOMAIN_GROUP_OCID" \
      --display-name "IoT Factory Lab Domain" \
      --description "Digital twin resources for the OCI IoT factory workshop" \
      --wait-for-state SUCCEEDED

    export IOT_DOMAIN_OCID=$(oci iot domain list \
      --compartment-id "$WORKSHOP_COMPARTMENT_OCID" \
      --all \
      --query 'data.items[?"display-name"==`IoT Factory Lab Domain`].id | [0]' \
      --raw-output)

    oci iot domain get --iot-domain-id "$IOT_DOMAIN_OCID"
    ```

## Acknowledgements

* **Author** - Pete St. Pierre, Director, Product Management
* **Last Updated By/Date** - Pete St. Pierre, August 2026
