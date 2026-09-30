# Lab 2: Create the Gateway and Routing Adapter

## Introduction

Create Gateway 1, an authenticated twin that publishes its status and forwards pump telemetry. Its adapter maps data sent to `/data` as gateway status. It derives a pump external key from paths such as `/water-pumps/water-pump-3`. When it resolves a target, OCI IoT sends the message to that pump's adapter.

If you completed the Getting Started workshop, reuse `WORKSHOP_COMPARTMENT_OCID`, `IOT_DOMAIN_OCID`, `VAULT_OCID`, and `VAULT_MASTER_KEY_OCID`. In a separate environment, retrieve the compartment and IoT domain OCIDs from their Console details pages. Retrieve the Vault OCID from the Vault details page and the key OCID from the master encryption key details page. Create a Vault and master encryption key first if they do not exist.

The Vault and master encryption key encrypt Gateway 1's authentication secret. In this lab, choose `gateway-1` as the gateway external key and choose a strong plain-text secret. Task 4 creates the Vault secret and Gateway 1 twin.

Estimated Time: 45 minutes

### Objectives

In this lab, you will:

- Create the GatewayStatus model.
- Create a gateway adapter with a target mapping in its inbound envelope.
- Create a dedicated secret and Gateway 1 twin.
- Verify that Gateway 1 is active and ready for indirect devices.

### Prerequisites

- Complete the workshop introduction and Lab 1.
- Complete [Get Started with OCI Internet of Things Platform](https://livelabs.oracle.com/ords/r/dbpm/livelabs/view-workshop?wid=4515), or ensure that both of the following prerequisites are met:
    - Have an active IoT domain, an OCI CLI profile, a Vault, and a master encryption key.
    - Have the ElectricMotor and WaterPump models and the default and Flat PSI WaterPump adapters available in the IoT domain.

If the WaterPump models or adapters are missing, use [Appendix A: Create Required Factory, Production Line, and WaterPump Assets](?lab=appendix-water-pump-assets) to create them.

## Task 1: Set gateway variables

1. Set the environment variables. If you completed Getting Started, use the saved OCIDs. Otherwise, copy the compartment, IoT domain, Vault, and key OCIDs from the OCI Console. `GATEWAY_EXTERNAL_KEY` identifies the gateway when it connects to OCI IoT. Choose a strong `GATEWAY_SECRET_VALUE`. Task 4 stores it in the Vault as Gateway 1's credential.

    ```bash
    export WORKSHOP_DIR="$PWD"
    export WORKSHOP_COMPARTMENT_OCID='<workshop-compartment-ocid>'
    export IOT_DOMAIN_OCID='<iot-domain-ocid>'
    export VAULT_OCID='<vault-ocid>'
    export VAULT_MASTER_KEY_OCID='<vault-master-key-ocid>'
    export GATEWAY_EXTERNAL_KEY='gateway-1'
    export GATEWAY_SECRET_VALUE='<gateway-1-plain-text-secret>'
    ```

2. Retrieve the device host. Lab 3 connects Gateway 1 to this host through MQTTs on port `8883`.

    ```bash
    export IOT_DEVICE_HOST=$(oci iot domain get \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --query 'data."device-host"' \
      --raw-output)
    ```

## Task 2: Create the GatewayStatus model

1. Save the GatewayStatus model as `$WORKSHOP_DIR/gateway-status-model.json`. It describes gateway data, not WaterPump data.

    ```bash
    cat > "$WORKSHOP_DIR/gateway-status-model.json" <<'EOF'
    {
      "@context": ["dtmi:dtdl:context;3"],
      "@id": "dtmi:com:oracle:iot:example:GatewayStatus;1",
      "@type": "Interface",
      "displayName": "Gateway Status",
      "description": "Reports the essential operating state of an OCI IoT gateway.",
      "contents": [
        {
          "@type": "Telemetry",
          "name": "connectedDeviceCount",
          "displayName": "Connected Device Count",
          "description": "Reports the number of indirectly connected devices currently communicating through the gateway.",
          "schema": "integer"
        },
        {
          "@type": "Telemetry",
          "name": "cpuUtilization",
          "displayName": "CPU Utilization",
          "description": "Reports the percentage of gateway CPU capacity currently in use.",
          "schema": "integer"
        },
        {
          "@type": "Telemetry",
          "name": "memoryUtilization",
          "displayName": "Memory Utilization",
          "description": "Reports the percentage of gateway memory currently in use.",
          "schema": "integer"
        },
        {
          "@type": "Telemetry",
          "name": "firmwareVersion",
          "displayName": "Firmware Version",
          "description": "Reports the firmware version running on the gateway.",
          "schema": "string"
        }
      ]
    }
    EOF
    ```

2. Create the model and retain its OCID.

    ```bash
    export GATEWAY_STATUS_MODEL_ID=$(oci iot digital-twin-model create \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --display-name "Gateway Status Model" \
      --spec "file://$WORKSHOP_DIR/gateway-status-model.json" \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)
    ```

3. Verify the stored model specification.

    ```bash
    oci iot digital-twin-model get-spec \
      --digital-twin-model-id "$GATEWAY_STATUS_MODEL_ID"
    ```

## Task 3: Create the gateway routing adapter

1. Save the inbound envelope as `$WORKSHOP_DIR/gateway-routing-envelope.json`. It resolves `target` before it evaluates routes. An empty target keeps the message with Gateway 1. A value such as `water-pump-3` sends the payload to the indirect twin with that external key.

    ```bash
    cat > "$WORKSHOP_DIR/gateway-routing-envelope.json" <<'EOF'
    {
      "referenceEndpoint": "/data",
      "referencePayload": {
        "dataFormat": "JSON",
        "data": {
          "time": "2026-09-02T18:00:00.000000Z",
          "cpuUtil": 0,
          "memUtil": 0,
          "connectedDeviceCount": 0,
          "firmware": "Oracle Linux 9.1"
        }
      },
      "envelopeMapping": {
        "timeObserved": "$.time",
        "target": "${if endpoint(1) == \"water-pumps\" then endpoint(2) else null end}",
        "contentRoot": "$"
      }
    }
    EOF
    ```

2. Save the inbound routes as `$WORKSHOP_DIR/gateway-routing-routes.json`. The routes map gateway status telemetry. OCI IoT sends indirect-device telemetry to the target twin's adapter instead.

    ```bash
    cat > "$WORKSHOP_DIR/gateway-routing-routes.json" <<'EOF'
    [
      {
        "condition": "*",
        "payloadMapping": {
          "$.cpuUtilization": "$.cpuUtil",
          "$.memoryUtilization": "$.memUtil",
          "$.connectedDeviceCount": "$.connectedDeviceCount",
          "$.firmwareVersion": "$.firmware"
        },
        "referencePayload": {
          "dataFormat": "JSON",
          "data": {
            "time": "2026-09-02T18:00:00.000000Z",
            "cpuUtil": 0,
            "memUtil": 0,
            "connectedDeviceCount": 0,
            "firmware": "Oracle Linux 9.1"
          }
        }
      }
    ]
    EOF
    ```

3. Create the adapter and retain its OCID.

    ```bash
    export GATEWAY_ROUTING_ADAPTER_ID=$(oci iot digital-twin-adapter create \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --digital-twin-model-id "$GATEWAY_STATUS_MODEL_ID" \
      --display-name "Gateway 1 Routing Adapter" \
      --description "Routes forwarded water-pump telemetry by endpoint target." \
      --inbound-envelope "file://$WORKSHOP_DIR/gateway-routing-envelope.json" \
      --inbound-routes "file://$WORKSHOP_DIR/gateway-routing-routes.json" \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)
    ```

4. Verify that the adapter is active.

    ```bash
    oci iot digital-twin-adapter get \
      --digital-twin-adapter-id "$GATEWAY_ROUTING_ADAPTER_ID" \
      --query 'data.{name:"display-name",state:"lifecycle-state",model:"digital-twin-model-id"}'
    ```

## Task 4: Create Gateway 1

1. Create a Vault secret for Gateway 1. In this lab, the external key is the MQTT user name and the plain-text value is the password.

    ```bash
    export GATEWAY_SECRET_OCID=$(oci vault secret create-base64 \
      --compartment-id "$WORKSHOP_COMPARTMENT_OCID" \
      --vault-id "$VAULT_OCID" \
      --key-id "$VAULT_MASTER_KEY_OCID" \
      --secret-name gateway-1-auth \
      --secret-content-content "$(printf %s "$GATEWAY_SECRET_VALUE" | base64)" \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)
    ```

2. Create the gateway twin. A gateway needs an authentication ID and a gateway adapter.

    ```bash
    export GATEWAY_INSTANCE_ID=$(oci iot digital-twin-instance create \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --digital-twin-model-id "$GATEWAY_STATUS_MODEL_ID" \
      --digital-twin-adapter-id "$GATEWAY_ROUTING_ADAPTER_ID" \
      --connectivity-type GATEWAY \
      --auth-id "$GATEWAY_SECRET_OCID" \
      --external-key "$GATEWAY_EXTERNAL_KEY" \
      --display-name "Gateway 1" \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)
    ```

3. Confirm that Gateway 1 is active and has an authentication ID.

    ```bash
    oci iot digital-twin-instance get \
      --digital-twin-instance-id "$GATEWAY_INSTANCE_ID" \
      --query 'data.{name:"display-name",type:"connectivity-type",auth:"auth-id",adapter:"digital-twin-adapter-id",key:"external-key",state:"lifecycle-state"}'
    ```

    You may now **proceed to the next lab**.

## Learn More

- [Creating a digital twin adapter](https://docs.oracle.com/en-us/iaas/Content/internet-of-things/create-digital-twin-adapter.htm)
- [Gateway and indirect-device scenario](https://docs.oracle.com/en-us/iaas/Content/internet-of-things/gateway-instance.htm)

## Acknowledgements

* **Author** - Pete St. Pierre, Director, Product Management
* **Last Updated By/Date** - Pete St. Pierre, September 2026
