# Lab 8: Clean up IoT Lab Resources

## Introduction

The first part of this lab cleans up only OCI IoT Platform data. The cleanup script deletes every relationship, digital twin instance, adapter, and model in the selected IoT domain. It then deletes the IoT domain and its IoT domain group.

The second part covers lab-related resources that might have existed before the workshop. It is optional and applies only when you created a new Vault and the two device secrets for this lab. Review each scope carefully before you run a command.

Estimated Time: 25 minutes

### Objectives

In this lab, you will:

- Review the cleanup scope and confirmation control.
- Delete the IoT resources in dependency order with the OCI CLI.
- Optionally schedule deletion of the lab Vault and device secrets.

## Task 1: Review the cleanup scope

1. This task cleans up OCI IoT Platform-specific data only. It references `IOT_DOMAIN_OCID` from Lab 2, derives the associated IoT domain group OCID, and deletes the IoT domain and its domain group. It deletes resources in this order:

    - Digital twin relationships
    - Digital twin instances
    - Digital twin adapters
    - Digital twin models
    - IoT domain
    - IoT domain group

2. The script requires only Bash and the OCI CLI. It does not delete Vault, secret, IAM, or compartment resources. Set `CONFIRM_DELETE_IOT_RESOURCES=yes` only after you have verified that `IOT_DOMAIN_OCID` identifies the workshop domain.

## Task 2: Run the cleanup script

1. Create a file named `cleanup-iot-domain.sh` and add the following script.

    ```bash
    #!/usr/bin/env bash
    set -euo pipefail

    : "${IOT_DOMAIN_OCID:?Export IOT_DOMAIN_OCID before running this script.}"

    if [[ "${CONFIRM_DELETE_IOT_RESOURCES:-}" != "yes" ]]; then
      echo "This permanently deletes all IoT resources in $IOT_DOMAIN_OCID."
      echo "Run again with: CONFIRM_DELETE_IOT_RESOURCES=yes ./cleanup-iot-domain.sh"
      exit 1
    fi

    export IOT_DOMAIN_GROUP_OCID=$(oci iot domain get \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --query 'data."iot-domain-group-id"' \
      --raw-output)

    echo "Deleting digital twin relationships..."
    while IFS= read -r relationship_id; do
      [[ -z "$relationship_id" ]] && continue
      oci iot digital-twin-relationship delete \
        --digital-twin-relationship-id "$relationship_id" \
        --force \
        --wait-for-state DELETED
    done < <(
      oci iot digital-twin-relationship list \
        --iot-domain-id "$IOT_DOMAIN_OCID" \
        --lifecycle-state ACTIVE \
        --all \
        --query 'join(`"\n"`, data.items[].id)' \
        --raw-output
    )

    echo "Deleting digital twin instances..."
    while IFS= read -r instance_id; do
      [[ -z "$instance_id" ]] && continue
      oci iot digital-twin-instance delete \
        --digital-twin-instance-id "$instance_id" \
        --force \
        --wait-for-state DELETED
    done < <(
      oci iot digital-twin-instance list \
        --iot-domain-id "$IOT_DOMAIN_OCID" \
        --lifecycle-state ACTIVE \
        --all \
        --query 'join(`"\n"`, data.items[].id)' \
        --raw-output
    )

    echo "Deleting digital twin adapters..."
    while IFS= read -r adapter_id; do
      [[ -z "$adapter_id" ]] && continue
      oci iot digital-twin-adapter delete \
        --digital-twin-adapter-id "$adapter_id" \
        --force \
        --wait-for-state DELETED
    done < <(
      oci iot digital-twin-adapter list \
        --iot-domain-id "$IOT_DOMAIN_OCID" \
        --lifecycle-state ACTIVE \
        --all \
        --query 'join(`"\n"`, data.items[].id)' \
        --raw-output
    )

    echo "Deleting digital twin models..."
    while IFS= read -r model_id; do
      [[ -z "$model_id" ]] && continue
      oci iot digital-twin-model delete \
        --digital-twin-model-id "$model_id" \
        --force \
        --wait-for-state DELETED
    done < <(
      oci iot digital-twin-model list \
        --iot-domain-id "$IOT_DOMAIN_OCID" \
        --lifecycle-state ACTIVE \
        --all \
        --query 'join(`"\n"`, data.items[].id)' \
        --raw-output
    )

    echo "Deleting the IoT domain..."
    oci iot domain delete \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --force \
      --wait-for-state SUCCEEDED

    echo "Deleting the IoT domain group..."
    oci iot domain-group delete \
      --iot-domain-group-id "$IOT_DOMAIN_GROUP_OCID" \
      --force \
      --wait-for-state SUCCEEDED

    echo "IoT resource cleanup completed."
    ```

2. Run the script only after you have reviewed its scope and confirmed the IoT domain OCID.

    ```bash
    chmod +x cleanup-iot-domain.sh
    CONFIRM_DELETE_IOT_RESOURCES=yes ./cleanup-iot-domain.sh
    ```

## Task 3: Optionally schedule deletion of lab Vault resources

1. Complete this task only if you created a new Vault and the two device secrets specifically for this workshop. Do not run these commands if you used an existing Vault for the device secrets: they schedule the named secrets and the entire Vault for deletion. Deleting the Vault also schedules deletion of its associated master keys.

2. Schedule deletion of the two device secrets created in Lab 6.

    ```bash
    oci vault secret schedule-secret-deletion \
      --secret-id "$PUMP_1_SECRET_OCID"

    oci vault secret schedule-secret-deletion \
      --secret-id "$PUMP_2_SECRET_OCID"
    ```

3. Schedule deletion of the Vault that you created in Lab 2.

    ```bash
    oci kms management vault schedule-deletion \
      --vault-id "$VAULT_OCID"
    ```

4. The commands schedule deletion rather than deleting resources immediately. OCI retains the secrets and Vault in a pending-deletion state for the configured retention periods. Do not schedule deletion of the Vault master key separately; Vault deletion schedules its associated keys.

## Task 4: Optionally clean up tenancy and local workshop resources

1. The remaining OCI resources are the tenancy-level IAM policy, IAM group, and IAM user from Lab 2, plus the workshop compartment. Execute this task as a tenancy administrator, not as the workshop user: deleting the workshop policy can remove the workshop user's access before the remaining commands run. Delete resources only when each was created exclusively for this workshop. **Use caution:** an existing IAM user, group, policy, Vault, or compartment might be used by people or workloads outside this lab. Do not delete a reused resource. Instead, remove only the workshop-specific group membership or policy statement after confirming that doing so will not affect other access.

2. If you created these resources specifically for this lab, confirm that the IDs below identify only the workshop resources. If you created them in Lab 2 with the CLI, the variables should already be set. Otherwise, export the OCIDs that you recorded from the OCI Console before proceeding.

    ```bash
    export WORKSHOP_POLICY_OCID='<iot-factory-lab-workshop-policy-ocid>'
    export LAB_GROUP_OCID='<iot-factory-lab-group-ocid>'
    export LAB_USER_OCID='<iot-factory-student-user-ocid>'
    export WORKSHOP_COMPARTMENT_OCID='<iot-water-pump-workshop-compartment-ocid>'
    ```

3. Run the following commands in order. The group must be empty before OCI can delete it, and the user must not belong to any groups before OCI can delete it. If the user belongs to another group, stop after removing the workshop membership and retain the user.

    ```bash
    oci iam policy delete \
      --policy-id "$WORKSHOP_POLICY_OCID" \
      --force

    oci iam group remove-user \
      --group-id "$LAB_GROUP_OCID" \
      --user-id "$LAB_USER_OCID" \
      --force

    oci iam user delete \
      --user-id "$LAB_USER_OCID" \
      --force

    oci iam group delete \
      --group-id "$LAB_GROUP_OCID" \
      --force

    oci iam compartment delete \
      --compartment-id "$WORKSHOP_COMPARTMENT_OCID" \
      --force
    ```

4. OCI can delete the compartment only after it is empty. Wait for the Vault and secrets scheduled in Task 3 to be fully deleted, and remove any other resources that you created in the compartment before retrying the final command. Finally, remove saved device passwords, copied secret values, and local workshop scripts only after confirming that they are not needed for another environment.

## Acknowledgements

* **Author** - Pete St. Pierre, Director, Product Management
* **Last Updated By/Date** - Pete St. Pierre, August 2026
