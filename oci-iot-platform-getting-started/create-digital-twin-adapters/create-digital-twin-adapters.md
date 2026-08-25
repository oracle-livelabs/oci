# Lab 5: Create Digital Twin Adapters

## Introduction

Create two adapters for the shared *WaterPump* model. A default adapter is appropriate when a device already sends telemetry in the same shape, names, and units as the digital twin model. In this case, the incoming payload already has a nested `motor` object and top-level `flowRate` and `dischargePressure` fields in bar, so the adapter passes the values directly into the model.

Use a custom adapter when the source payload differs from the model. In this lab, the custom adapter processes flat telemetry by constructing the nested `motor` object required by the *WaterPump* and *ElectricMotor* models. It also converts the source `dischPressPsi` value from pounds per square inch (PSI) to bar before writing `dischargePressure` to the model.

The adapter maps incoming device payloads to the canonical model shape. It does not change the model itself. See [Working with Digital Twin Adapters in OCI Internet of Things Platform](https://blogs.oracle.com/cloud-infrastructure/working-with-iot-digital-twin-adapters) for the source examples.

Estimated Time: 45 minutes

### Objectives

In this lab, you will:

- Create a default adapter for model-shaped WaterPump telemetry.
- Create a custom adapter for flat telemetry with pressure in PSI.
- Verify that both adapters are active in OCI IoT Platform.

## Task 1: Prepare the adapter environment

1. This lab references `IOT_DOMAIN_OCID`, `WATER_PUMP_MODEL_ID`, and `WORKSHOP_DIR`, which you set in earlier labs. Do not set them again.

2. An adapter requires an inbound envelope and one or more inbound routes. The inbound envelope documents a representative endpoint and payload. An inbound route specifies the mapping that normalizes the payload. Both definitions include a `referencePayload`.

## Task 2: Create the default WaterPump adapter

1. Create `$WORKSHOP_DIR/default-water-pump-envelope.json`. This representative payload already matches the model shape and uses `dischargePressure` in bar.

    ```json
    {
      "referenceEndpoint": "/waterpump/default",
      "referencePayload": {
        "dataFormat": "JSON",
        "data": {
          "motor": {
            "motorTemperature": 68.4,
            "vibrationLevel": 1.7,
            "powerConsumption": 12.6
          },
          "flowRate": 247.5,
          "dischargePressure": 4.3
        }
      }
    }
    ```

2. Create `$WORKSHOP_DIR/default-water-pump-routes.json`. The wildcard condition applies the direct mapping to each matching payload.

    ```json
    [
      {
        "condition": "*",
        "description": "Map model-shaped water pump telemetry directly to the WaterPump model.",
        "payloadMapping": {
          "$.motor.motorTemperature": "$.motor.motorTemperature",
          "$.motor.vibrationLevel": "$.motor.vibrationLevel",
          "$.motor.powerConsumption": "$.motor.powerConsumption",
          "$.flowRate": "$.flowRate",
          "$.dischargePressure": "$.dischargePressure"
        },
        "referencePayload": {
          "dataFormat": "JSON",
          "data": {
            "motor": {
              "motorTemperature": 68.4,
              "vibrationLevel": 1.7,
              "powerConsumption": 12.6
            },
            "flowRate": 247.5,
            "dischargePressure": 4.3
          }
        }
      }
    ]
    ```

3. Create the default adapter and save its OCID.

    ```bash
    export DEFAULT_WATER_PUMP_ADAPTER_ID=$(oci iot digital-twin-adapter create \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --digital-twin-model-id "$WATER_PUMP_MODEL_ID" \
      --display-name "Water Pump Default Adapter" \
      --description "Direct mapping for model-shaped water pump telemetry." \
      --inbound-envelope "file://$WORKSHOP_DIR/default-water-pump-envelope.json" \
      --inbound-routes "file://$WORKSHOP_DIR/default-water-pump-routes.json" \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)
    ```

## Task 3: Create the custom flat-telemetry adapter

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

## Acknowledgements

* **Author** - Pete St. Pierre, Director, Product Management
* **Last Updated By/Date** - Pete St. Pierre, August 2026
