# Lab 5: Create Digital Twin Adapters

## Introduction

Create two adapters for the shared *WaterPump* model. A default adapter is appropriate when a device already sends telemetry in the same shape, names, and units as the digital twin model. In this case, the incoming payload already has a nested `motor` object and top-level `flowRate` and `dischargePressure` fields in bar. OCI IoT Platform generates the default envelope and mapping, so you do not supply adapter JSON files.

Use a custom adapter when the source payload differs from the model. In this lab, the custom adapter processes flat telemetry by constructing the nested `motor` object required by the *WaterPump* and *ElectricMotor* models. It also converts the source `dischPressPsi` value from pounds per square inch (PSI) to bar before writing `dischargePressure` to the model.

The adapter maps incoming device payloads to the canonical model shape. It does not change the model itself. See [Working with Digital Twin Adapters in OCI Internet of Things Platform](https://blogs.oracle.com/cloud-infrastructure/working-with-iot-digital-twin-adapters) for the source examples.

Estimated Time: 45 minutes

### Objectives

In this lab, you will:

- Create a default adapter for model-shaped WaterPump telemetry.
- Create a custom adapter for flat telemetry with pressure in PSI.
- Verify that both adapters are active in OCI IoT Platform.

## Prerequisites

- Complete Labs 3 and 4.
- Have OCI Cloud Shell or a configured OCI CLI available.
- Retain the `IOT_DOMAIN_OCID`, `WATER_PUMP_MODEL_ID`, and `WORKSHOP_DIR` values created in earlier labs.

## Task 1: Prepare the adapter environment

1. This lab references `IOT_DOMAIN_OCID`, `WATER_PUMP_MODEL_ID`, and `WORKSHOP_DIR`, which you set in earlier labs. Do not set them again.

2. A default adapter does not require an inbound envelope or inbound routes when the device payload already matches the model. A custom adapter requires both definitions to document and normalize a payload that differs from the model.

## Task 2: Create the default WaterPump adapter

1. Create the default adapter and save its OCID. Omit both `--inbound-envelope` and `--inbound-routes`; OCI IoT Platform generates the default mapping because Pump 1 already sends model-shaped telemetry.

    ```bash
    export DEFAULT_WATER_PUMP_ADAPTER_ID=$(oci iot digital-twin-adapter create \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --digital-twin-model-id "$WATER_PUMP_MODEL_ID" \
      --display-name "Water Pump Default Adapter" \
      --description "Default adapter for model-shaped water pump telemetry." \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)
    ```

## Task 3: Create the custom flat-telemetry adapter

### Understand the reference payload

`referencePayload` is a critical part of a custom adapter definition. It provides a representative example of the device telemetry shape that the adapter expects. The inbound envelope uses it to describe the complete message received at the reference endpoint. Each inbound route uses it to show the input shape that its mapping processes.

For this custom adapter, the reference payload is a flat example with `dischPressPsi`. It makes the nested-field mapping and PSI-to-bar conversion clear.

The reference payload is design-time documentation, not live telemetry. It does not create or update a digital twin, and devices do not need to send the exact sample values. Actual messages are evaluated against the route condition and then normalized by the payload mapping.

1. Create `$WORKSHOP_DIR/flat-psi-water-pump-envelope.json`. This representative device payload is flat and reports pressure as `dischPressPsi`.

    ```json
    {
      "referenceEndpoint": "/waterpump/flat-psi",
      "referencePayload": {
        "dataFormat": "JSON",
        "data": {
          "motorTemperature": 68.4,
          "vibrationLevel": 1.7,
          "powerConsumption": 12.6,
          "flowRate": 247.5,
          "dischPressPsi": 62.37
        }
      }
    }
    ```

2. Create `$WORKSHOP_DIR/flat-psi-water-pump-routes.json`. The three motor assignments populate the nested ElectricMotor paths from the flat motor fields. The `dischargePressure` expression converts PSI to bar; 62.37 PSI becomes approximately 4.30 bar.

    ```json
    [
      {
        "condition": "*",
        "description": "Build the motor component from flat telemetry and convert PSI pressure to bar.",
        "payloadMapping": {
          "$.motor.motorTemperature": "$.motorTemperature",
          "$.motor.vibrationLevel": "$.vibrationLevel",
          "$.motor.powerConsumption": "$.powerConsumption",
          "$.flowRate": "$.flowRate",
          "$.dischargePressure": "${(.dischPressPsi * 0.0689475729)}"
        },
        "referencePayload": {
          "dataFormat": "JSON",
          "data": {
            "motorTemperature": 68.4,
            "vibrationLevel": 1.7,
            "powerConsumption": 12.6,
            "flowRate": 247.5,
            "dischPressPsi": 62.37
          }
        }
      }
    ]
    ```

3. Create the custom adapter and save its OCID.

    ```bash
    export CUSTOM_WATER_PUMP_ADAPTER_ID=$(oci iot digital-twin-adapter create \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --digital-twin-model-id "$WATER_PUMP_MODEL_ID" \
      --display-name "Water Pump Flat PSI Adapter" \
      --description "Maps flat pump telemetry to WaterPump and converts PSI pressure to bar." \
      --inbound-envelope "file://$WORKSHOP_DIR/flat-psi-water-pump-envelope.json" \
      --inbound-routes "file://$WORKSHOP_DIR/flat-psi-water-pump-routes.json" \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)
    ```

## Task 4: Verify both adapters

1. List the active adapters for the WaterPump model.

    ```bash
    oci iot digital-twin-adapter list \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --digital-twin-model-id "$WATER_PUMP_MODEL_ID" \
      --lifecycle-state ACTIVE \
      --all \
      --output table
    ```

2. Confirm that **Water Pump Default Adapter** and **Water Pump Flat PSI Adapter** both have the `ACTIVE` lifecycle state. Record their OCIDs for the digital twin instance lab.

3. In the OCI Console, select the workshop compartment, open **Internet of Things**, and open the IoT domain. Select the **Digital twin adapters** tab. Locate **Water Pump Default Adapter** and **Water Pump Flat PSI Adapter** and confirm that both are active.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - Pete St. Pierre, Director, Product Management
* **Last Updated By/Date** - Pete St. Pierre, August 2026
