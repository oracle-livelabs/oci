# Lab 6: Create Water Pump Digital Twin Instances

## Introduction

Create one digital twin instance for each physical water pump. For structured telemetry, an instance uses a model to define its canonical data shape and an adapter to transform the device payload into that shape. The instance also uses an authentication ID so OCI IoT Platform can authenticate the connected device.

Relationships add operational context without changing telemetry. In this lab, each WaterPump instance uses the `installedOn` relationship defined in the WaterPump model to link to its ProductionLine instance. Applications can then interpret a pump's telemetry in the context of the production line where it operates.

Pump 1 uses the *Water Pump Default Adapter* because it sends telemetry in the nested *WaterPump* and *ElectricMotor* shape. Pump 2 uses the *Water Pump Flat PSI Adapter* because it sends flat telemetry and pressure in PSI. Both pumps are directly connected and use separate Vault secrets for basic authentication in this learning environment. Use certificates and mutual TLS for production devices.

Estimated Time: 30 minutes

### Objectives

In this lab, you will:

- Create a dedicated Vault secret for each water pump.
- Associate the WaterPump model and default adapter with Pump 1.
- Associate the WaterPump model and custom adapter with Pump 2.
- Create two directly connected digital twin instances.
- Relate each pump to its production line.

## Prerequisites

- Complete Labs 3 through 5.
- Have OCI Cloud Shell or a configured OCI CLI available.
- Retain the domain, model, adapter, production-line, Vault, and master-key OCIDs created in earlier labs.

## Task 1: Prepare instance values

1. This lab references `IOT_DOMAIN_OCID`, `WORKSHOP_COMPARTMENT_OCID`, `VAULT_OCID`, `VAULT_MASTER_KEY_OCID`, `WATER_PUMP_MODEL_ID`, `DEFAULT_WATER_PUMP_ADAPTER_ID`, `CUSTOM_WATER_PUMP_ADAPTER_ID`, `PRODUCTION_LINE_1_ID`, and `PRODUCTION_LINE_2_ID`, which you set in earlier labs. Do not set them again. Set the external keys for the two new pump instances; you create and set the two secret OCIDs in the next task.

    ```bash
    export PUMP_1_EXTERNAL_KEY='water-pump-1'
    export PUMP_2_EXTERNAL_KEY='water-pump-2'
    ```

2. A structured-data instance requires a model and adapter. The model defines the fields the instance can receive, and the adapter maps the inbound device payload into those fields. The authentication ID and external key establish the device credentials; with a Vault secret, the external key is the basic-authentication user name.

## Task 2: Create the water-pump Vault secrets

1. In the OCI Console, select **Identity & Security**, select **Vault**, and open `iot-factory-lab-vault` in the workshop compartment. Select **Secrets**, then select **Create Secret**.

2. Create the first secret with these values:

    - **Name:** `water-pump-1-auth`
    - **Encryption key:** Select `iot-factory-lab-master-key`, which you created in Lab 2.
    - **Secret type:** Plain-text
    - **Secret contents:** Create a strong, unique password for Water Pump 1.

    Create the secret, wait for it to become **Active**, and copy its OCID. Store the plain-text password in an approved password manager. You need it in Lab 7 and cannot retrieve it from the IoT Platform.

3. Repeat the preceding step to create a second unique secret named `water-pump-2-auth` for Water Pump 2. Copy its OCID and securely retain its plain-text password.

4. Alternatively, create both secrets with the OCI CLI. The commands use the master encryption key that you created in Lab 2. Set the two plain-text values from an approved password manager; do not add them to shell history or source control.

    ```bash
    export PUMP_1_SECRET_VALUE='<water-pump-1-plain-text-secret>'
    export PUMP_2_SECRET_VALUE='<water-pump-2-plain-text-secret>'

    export PUMP_1_SECRET_OCID=$(oci vault secret create-base64 \
      --compartment-id "$WORKSHOP_COMPARTMENT_OCID" \
      --vault-id "$VAULT_OCID" \
      --key-id "$VAULT_MASTER_KEY_OCID" \
      --secret-name water-pump-1-auth \
      --secret-content-content "$(printf %s "$PUMP_1_SECRET_VALUE" | base64)" \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)

    export PUMP_2_SECRET_OCID=$(oci vault secret create-base64 \
      --compartment-id "$WORKSHOP_COMPARTMENT_OCID" \
      --vault-id "$VAULT_OCID" \
      --key-id "$VAULT_MASTER_KEY_OCID" \
      --secret-name water-pump-2-auth \
      --secret-content-content "$(printf %s "$PUMP_2_SECRET_VALUE" | base64)" \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)
    ```

5. Set the secret OCIDs and plain-text values in your terminal if you used the Console path. The secret values are the basic-authentication passwords. Do not add them to source control or share them.

    ```bash
    export PUMP_1_SECRET_OCID='<water-pump-1-auth-secret-ocid>'
    export PUMP_2_SECRET_OCID='<water-pump-2-auth-secret-ocid>'
    export PUMP_1_SECRET_VALUE='<water-pump-1-plain-text-secret>'
    export PUMP_2_SECRET_VALUE='<water-pump-2-plain-text-secret>'
    ```

6. Use a separate secret for each directly connected pump. The IoT domain policy created in Lab 2 allows OCI IoT Platform to read both secret bundles from this Vault when it authenticates the instances.

## Task 3: Create Pump 1 with the default adapter

1. Create the directly connected Pump 1 instance. The default adapter accepts the model-shaped payload without restructuring it.

    ```bash
    export PUMP_1_INSTANCE_ID=$(oci iot digital-twin-instance create \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --digital-twin-model-id "$WATER_PUMP_MODEL_ID" \
      --digital-twin-adapter-id "$DEFAULT_WATER_PUMP_ADAPTER_ID" \
      --connectivity-type DIRECT \
      --auth-id "$PUMP_1_SECRET_OCID" \
      --external-key "$PUMP_1_EXTERNAL_KEY" \
      --display-name "Water Pump 1" \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)
    ```

2. Record `PUMP_1_INSTANCE_ID`. You use it to inspect the Pump 1 content in Lab 7.

## Task 4: Create Pump 2 with the custom adapter

1. Create the directly connected Pump 2 instance. The custom adapter converts its flat source payload into the model shape and converts pressure from PSI to bar.

    ```bash
    export PUMP_2_INSTANCE_ID=$(oci iot digital-twin-instance create \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --digital-twin-model-id "$WATER_PUMP_MODEL_ID" \
      --digital-twin-adapter-id "$CUSTOM_WATER_PUMP_ADAPTER_ID" \
      --connectivity-type DIRECT \
      --auth-id "$PUMP_2_SECRET_OCID" \
      --external-key "$PUMP_2_EXTERNAL_KEY" \
      --display-name "Water Pump 2" \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)
    ```

2. Record `PUMP_2_INSTANCE_ID`. Use the external key exactly as shown; do not include literal quote characters in an external key.

## Task 5: Relate each pump to its production line

1. Create the `installedOn` relationship from **Water Pump 1** to **Production Line 1**.

    ```bash
    oci iot digital-twin-relationship create \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --source-digital-twin-instance-id "$PUMP_1_INSTANCE_ID" \
      --target-digital-twin-instance-id "$PRODUCTION_LINE_1_ID" \
      --content-path installedOn \
      --display-name "Water Pump 1 installed on Production Line 1" \
      --wait-for-state ACTIVE
    ```

2. Create the `installedOn` relationship from **Water Pump 2** to **Production Line 2**.

    ```bash
    oci iot digital-twin-relationship create \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --source-digital-twin-instance-id "$PUMP_2_INSTANCE_ID" \
      --target-digital-twin-instance-id "$PRODUCTION_LINE_2_ID" \
      --content-path installedOn \
      --display-name "Water Pump 2 installed on Production Line 2" \
      --wait-for-state ACTIVE
    ```

## Task 6: Verify the instances and relationships

1. List the active, directly connected WaterPump instances.

    ```bash
    oci iot digital-twin-instance list \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --digital-twin-model-id "$WATER_PUMP_MODEL_ID" \
      --connectivity-type DIRECT \
      --lifecycle-state ACTIVE \
      --all \
      --output table
    ```

2. Confirm that **Water Pump 1** uses the default adapter and **Water Pump 2** uses the custom adapter before you send telemetry.

3. List the active `installedOn` relationships. Confirm that the output contains one relationship from `$PUMP_1_INSTANCE_ID` to `$PRODUCTION_LINE_1_ID` and one from `$PUMP_2_INSTANCE_ID` to `$PRODUCTION_LINE_2_ID`.

    ```bash
    oci iot digital-twin-relationship list \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --content-path installedOn \
      --lifecycle-state ACTIVE \
      --all \
      --query 'data.items[].{Source:"source-digital-twin-instance-id",Relationship:"content-path",Target:"target-digital-twin-instance-id"}' \
      --output table
    ```

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - Pete St. Pierre, Director, Product Management
* **Last Updated By/Date** - Pete St. Pierre, August 2026
