# Lab 3: Connect and Monitor Indirect Water Pumps

## Introduction

Create two indirect water-pump twins and publish telemetry through Gateway 1. Water Pump 3 sends telemetry that matches the WaterPump model. Water Pump 4 sends flat telemetry with pressure in PSI. Each target twin uses its adapter to produce the same canonical WaterPump state.

Estimated Time: 65 minutes

### Objectives

In this lab, you will:

- Create indirect twins that share a gateway association.
- Reuse the default and Flat PSI WaterPump adapters.
- Publish two source payload shapes through one MQTTs connection.
- Verify normalized values and the gateway association.

### Prerequisites

- Complete [Lab 2: Create the Gateway and Routing Adapter](?lab=create-gateway-and-routing).
- Have the ElectricMotor and WaterPump models and the default and Flat PSI WaterPump adapters in the IoT domain.
- Retain `IOT_DOMAIN_OCID`, `GATEWAY_INSTANCE_ID`, `GATEWAY_EXTERNAL_KEY`, `GATEWAY_SECRET_VALUE`, and `IOT_DEVICE_HOST` from Lab 2.

If the WaterPump models or adapters are missing, create them with [Appendix A: Create Required Factory, Production Line, and WaterPump Assets](?lab=appendix-water-pump-assets).

## Task 1: Locate the WaterPump assets

1. List active WaterPump adapters. Identify **Water Pump Default Adapter** and **Water Pump Flat PSI Adapter**. They match the adapters in the Getting Started workshop. Set their existing OCIDs. Do not create adapters with duplicate display names.

    ```bash
    oci iot digital-twin-adapter list \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --lifecycle-state ACTIVE \
      --all --output table

    export WATER_PUMP_MODEL_ID='<water-pump-model-ocid>'
    export DEFAULT_WATER_PUMP_ADAPTER_ID='<default-water-pump-adapter-ocid>'
    export FLAT_PSI_WATER_PUMP_ADAPTER_ID='<flat-psi-water-pump-adapter-ocid>'
    ```

2. Set stable external keys. The gateway routing adapter uses each key to identify an indirect device. These keys are not MQTT user names because the pumps do not authenticate to OCI.

    ```bash
    export PUMP_3_EXTERNAL_KEY='water-pump-3'
    export PUMP_4_EXTERNAL_KEY='water-pump-4'
    ```

## Task 2: Create the indirect pump twins

1. Create Water Pump 3 with the default adapter. Do not set `--auth-id`. Its `--gateways` array associates it with Gateway 1.

    ```bash
    export PUMP_3_INSTANCE_ID=$(oci iot digital-twin-instance create \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --digital-twin-model-id "$WATER_PUMP_MODEL_ID" \
      --digital-twin-adapter-id "$DEFAULT_WATER_PUMP_ADAPTER_ID" \
      --connectivity-type INDIRECT \
      --gateways "[\"$GATEWAY_INSTANCE_ID\"]" \
      --external-key "$PUMP_3_EXTERNAL_KEY" \
      --display-name "Water Pump 3" \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)
    ```

2. Create Water Pump 4 with the Flat PSI adapter. It uses the same WaterPump model and gateway association as Water Pump 3.

    ```bash
    export PUMP_4_INSTANCE_ID=$(oci iot digital-twin-instance create \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --digital-twin-model-id "$WATER_PUMP_MODEL_ID" \
      --digital-twin-adapter-id "$FLAT_PSI_WATER_PUMP_ADAPTER_ID" \
      --connectivity-type INDIRECT \
      --gateways "[\"$GATEWAY_INSTANCE_ID\"]" \
      --external-key "$PUMP_4_EXTERNAL_KEY" \
      --display-name "Water Pump 4" \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)
    ```

3. Confirm the connectivity and gateway association. Both indirect pumps have a null `auth-id`.

    ```bash
    oci iot digital-twin-instance get \
      --digital-twin-instance-id "$PUMP_3_INSTANCE_ID" \
      --query 'data.{name:"display-name",type:"connectivity-type",auth:"auth-id",gateways:gateways,key:"external-key"}'

    oci iot digital-twin-instance get \
      --digital-twin-instance-id "$PUMP_4_INSTANCE_ID" \
      --query 'data.{name:"display-name",type:"connectivity-type",auth:"auth-id",gateways:gateways,key:"external-key"}'
    ```

4. **Optional:** List devices associated with Gateway 1. This read-only pipeline lists indirect twins, then uses `jq` to filter each `gateways` array for `$GATEWAY_INSTANCE_ID`. OCI IoT has no server-side filter for a specific gateway, so `jq` completes that filter locally. This informational step is not required for the rest of the lab.

    ```bash
    oci iot digital-twin-instance list \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --connectivity-type INDIRECT \
      --all \
      --output json |
    jq --arg gateway "$GATEWAY_INSTANCE_ID" '
      .data.items[]
      | select((.gateways // []) | index($gateway) != null)
      | {
          id,
          name: ."display-name",
          externalKey: ."external-key",
          gateways
        }'
    ```

## Task 3: Connect Gateway 1 and publish telemetry

1. Configure MQTTX for Gateway 1. Use `mqtts://$IOT_DEVICE_HOST`, port `8883`, TLS, and a clean session. Use `$GATEWAY_EXTERNAL_KEY` as the user name and `$GATEWAY_SECRET_VALUE` as the password.

2. Publish gateway status telemetry to the `data` topic. The empty target keeps this message with Gateway 1.

    ```bash
    mqttx pub \
      -h "$IOT_DEVICE_HOST" -p 8883 -l mqtts \
      -t data \
      -m '{"time":"2026-09-02T18:00:00.000000Z","connectedDeviceCount":2,"cpuUtil":30,"memUtil":25,"firmware":"Oracle Linux 9.1"}' \
      -u "$GATEWAY_EXTERNAL_KEY" -P "$GATEWAY_SECRET_VALUE"
    ```

3. Publish model-shaped telemetry for Water Pump 3. The `water-pumps/water-pump-3` path resolves the target external key. OCI IoT sends the payload to Pump 3's default adapter.

    ```bash
    mqttx pub \
      -h "$IOT_DEVICE_HOST" -p 8883 -l mqtts \
      -t "water-pumps/$PUMP_3_EXTERNAL_KEY" \
      -m '{"time":"2026-09-02T18:01:00.000000Z","motor":{"motorTemperature":68.4,"vibrationLevel":1.7,"powerConsumption":12.6},"flowRate":247.5,"dischargePressure":4.3}' \
      -u "$GATEWAY_EXTERNAL_KEY" -P "$GATEWAY_SECRET_VALUE"
    ```

4. Publish flat PSI telemetry for Water Pump 4. The gateway resolves Pump 4 from the path and supplies `timeObserved`. The target adapter inherits that timestamp and receives the original endpoint. Its wildcard route matches the endpoint, maps flat pump fields, converts PSI to bar, and builds the nested motor component. No gateway-specific Flat PSI adapter is required.

    ```bash
    mqttx pub \
      -h "$IOT_DEVICE_HOST" -p 8883 -l mqtts \
      -t "water-pumps/$PUMP_4_EXTERNAL_KEY" \
      -m '{"time":"2026-09-02T18:02:00.000000Z","motorTemperature":68.4,"vibrationLevel":1.7,"powerConsumption":12.6,"flowRate":247.5,"dischPressPsi":62.37}' \
      -u "$GATEWAY_EXTERNAL_KEY" -P "$GATEWAY_SECRET_VALUE"
    ```

## Task 4: Verify normalized state and gateway association

1. Retrieve the latest content and metadata for Gateway 1 and both pumps.

    ```bash
    oci iot digital-twin-instance get-content \
      --digital-twin-instance-id "$GATEWAY_INSTANCE_ID" \
      --should-include-metadata true

    oci iot digital-twin-instance get-content \
      --digital-twin-instance-id "$PUMP_3_INSTANCE_ID" \
      --should-include-metadata true

    oci iot digital-twin-instance get-content \
      --digital-twin-instance-id "$PUMP_4_INSTANCE_ID" \
      --should-include-metadata true
    ```

    The first response shows Gateway 1 status. The second shows Water Pump 3 values in the model-shaped payload. The third shows Water Pump 4 values after the Flat PSI adapter normalizes its payload. For Water Pump 4, look for the canonical `dischargePressure`, `flowRate`, and nested `motor` fields. The metadata records the observation time for each field and `timeLastHeard` for the pump. Your `etag` value will differ.

    The following is an example Water Pump 4 response:

    ```json
    {
      "data": {
        "_metadata": {
          "dischargePressure": {
            "timeObserved": "2026-09-02T18:02:00.000000+00:00"
          },
          "flowRate": {
            "timeObserved": "2026-09-02T18:02:00.000000+00:00"
          },
          "motor": {
            "motorTemperature": {
              "timeObserved": "2026-09-02T18:02:00.000000+00:00"
            },
            "powerConsumption": {
              "timeObserved": "2026-09-02T18:02:00.000000+00:00"
            },
            "vibrationLevel": {
              "timeObserved": "2026-09-02T18:02:00.000000+00:00"
            }
          },
          "timeLastHeard": "2026-09-02T18:02:00.000000+00:00"
        },
        "dischargePressure": 4.300260121773,
        "flowRate": 247.5,
        "motor": {
          "motorTemperature": 68.4,
          "powerConsumption": 12.6,
          "vibrationLevel": 1.7
        }
      },
      "etag": "06a4a140a4c7d6d8cc66bc5cb5bc591dc89c98feb78fbdd947ac37e56d4c04d0"
    }
    ```

2. Confirm that both pumps expose the canonical WaterPump paths. For Water Pump 4, `62.37` PSI is approximately `4.30` bar. Check recent `timeLastHeard` metadata for the gateway and both pumps.

## Learn More

- [Scenario: Create digital twins for indirectly connected devices using a gateway](https://docs.oracle.com/en-us/iaas/Content/internet-of-things/gateway-instance.htm)
- [Route indirect device data using target and contentRoot](https://docs.oracle.com/en-us/iaas/Content/internet-of-things/gateway-target-content-root.htm)
- [IoT domain database schema reference](https://docs.oracle.com/en-us/iaas/Content/internet-of-things/iot-domain-database-schema.htm)

## Acknowledgements

* **Author** - Pete St. Pierre, Director, Product Management
* **Last Updated By/Date** - Pete St. Pierre, September 2026
