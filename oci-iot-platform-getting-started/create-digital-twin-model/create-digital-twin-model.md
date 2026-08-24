# Lab 4: Create the Water Pump Digital Twin Model

## Introduction

Create the reusable *ElectricMotor* and *WaterPump* digital twin models for the beverage factory. The *WaterPump* model includes the motor as a component, so a pump uses the motor telemetry shape without redefining it. This lab follows the model in [Understanding Digital Twin Models in OCI IoT Platform](https://blogs.oracle.com/cloud-infrastructure/understanding-oci-iot-digital-twin-models).

The model preserves the source example's platform features. Motor temperature and vibration are historized so the platform retains them as time-series data. Flow rate uses the OCI validation extension to reject values outside its configured range. Discharge pressure uses the DTDL quantitative-types extension to identify the measurement as pressure in bar.

Estimated Time: 30 minutes

### Objectives

In this lab, you will:

- Define the reusable ElectricMotor model.
- Define the WaterPump model that includes the motor component.
- Preserve historization, validation, and pressure-unit semantics.
- Create and verify both models with the OCI CLI.

## Task 1: Prepare the model files

1. This lab references `IOT_DOMAIN_OCID` and `WORKSHOP_DIR`, which you set in Labs 2 and 3. Do not set them again.

2. Use a new DTMI version if you change a model after it has been created. For example, changing `dtmi:com:oracle:iot:example:WaterPump;1` requires a new identifier such as `dtmi:com:oracle:iot:example:WaterPump;2`.

    You can also create these models in the OCI Console. The CLI commands in this lab make the model definitions repeatable and provide model OCIDs for later labs.

## Task 2: Define and create the ElectricMotor model

1. Review how the two models use historization and extensions. The **ElectricMotor** model defines three telemetry values. `motorTemperature` and `vibrationLevel` use the `Historized` annotation from the historization extension. OCI IoT Platform stores their time-series observations in `HISTORIZED_DATA` and maintains their latest normalized values in `SNAPSHOT_DATA`, which supports trend analysis and maintenance investigations. `powerConsumption` is telemetry but is not historized, so its latest normalized value is stored in `SNAPSHOT_DATA` only.

    The **WaterPump** model reuses ElectricMotor through its `motor` component. Therefore, `motor.motorTemperature` and `motor.vibrationLevel` are historized and stored in both `HISTORIZED_DATA` and `SNAPSHOT_DATA`; `motor.powerConsumption` remains non-historized and is stored in `SNAPSHOT_DATA` only. The top-level `flowRate` and `dischargePressure` telemetry values are also not historized, so their latest normalized values are stored in `SNAPSHOT_DATA`. The WaterPump model uses the OCI validation extension to mark `flowRate` as `Validated` and reject values outside the configured range of 0 through 1000. It uses the DTDL quantitative-types extension to declare that `dischargePressure` is `Pressure` measured in `bar`; this gives the value measurement meaning but does not convert units. The custom adapter in Lab 5 converts PSI to bar before it updates the model. Both models use the base DTDL v3 context. The WaterPump model's `installedOn` relationship is also a base DTDL construct, not an extension, and links a pump instance to its Production Line context.

    **Reminder:** OCI IoT Platform stores each incoming device message in `RAW_DATA` before normalization. A message that fails normalization is also recorded in `REJECTED_DATA` with the reason for rejection.

2. Create `$WORKSHOP_DIR/electric-motor-model.json` with the following DTDL specification. The `Historized` annotations instruct OCI IoT Platform to retain motor temperature and vibration as time-series data. Power consumption remains telemetry but is not historized.

    ```json
    {
      "@context": [
        "dtmi:dtdl:context;3",
        "dtmi:dtdl:extension:historization;1"
      ],
      "@id": "dtmi:com:oracle:iot:example:ElectricMotor;1",
      "@type": "Interface",
      "displayName": "Electric Motor",
      "contents": [
        {
          "@type": ["Telemetry", "Historized"],
          "name": "motorTemperature",
          "schema": "double"
        },
        {
          "@type": ["Telemetry", "Historized"],
          "name": "vibrationLevel",
          "schema": "double"
        },
        {
          "@type": "Telemetry",
          "name": "powerConsumption",
          "schema": "double"
        }
      ]
    }
    ```

3. Create the ElectricMotor model and save the returned model OCID.

    ```bash
    export ELECTRIC_MOTOR_MODEL_ID=$(oci iot digital-twin-model create \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --display-name "Electric Motor Model" \
      --spec "file://$WORKSHOP_DIR/electric-motor-model.json" \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)
    ```

## Task 3: Define and create the WaterPump model

1. Create `$WORKSHOP_DIR/water-pump-model.json` with the following DTDL specification. The `motor` component references the ElectricMotor model. `flowRate` is both telemetry and validated, so the platform accepts values from 0 through 1000. `dischargePressure` is typed as pressure and uses `bar` as its unit. The `installedOn` relationship allows a water-pump instance to link to its ProductionLine instance.

    ```json
    {
      "@context": [
        "dtmi:dtdl:context;3",
        "dtmi:dtdl:extension:quantitativeTypes;1",
        "dtmi:com:oracle:dtdl:extension:validation;1"
      ],
      "@id": "dtmi:com:oracle:iot:example:WaterPump;1",
      "@type": "Interface",
      "displayName": "Water Pump",
      "contents": [
        {
          "@type": "Component",
          "name": "motor",
          "schema": "dtmi:com:oracle:iot:example:ElectricMotor;1"
        },
        {
          "@type": ["Telemetry", "Validated"],
          "name": "flowRate",
          "schema": "double",
          "minimum": 0,
          "maximum": 1000
        },
        {
          "@type": ["Telemetry", "Pressure"],
          "name": "dischargePressure",
          "schema": "double",
          "unit": "bar"
        },
        {
          "@type": "Relationship",
          "name": "installedOn",
          "target": "dtmi:com:oracle:beverage:ProductionLine;1"
        }
      ]
    }
    ```

2. Create the WaterPump model and save the returned model OCID. Create the ElectricMotor model first because the WaterPump component references its DTMI.

    ```bash
    export WATER_PUMP_MODEL_ID=$(oci iot digital-twin-model create \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --display-name "Water Pump Model" \
      --spec "file://$WORKSHOP_DIR/water-pump-model.json" \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)
    ```

3. Use the OCI Console or the CLI to inspect the WaterPump model. Confirm the motor component, the five modeled telemetry paths, and the `installedOn` relationship are available: `motor.motorTemperature`, `motor.vibrationLevel`, `motor.powerConsumption`, `flowRate`, and `dischargePressure`.

## Task 4: Verify the stored model specifications

1. Retrieve both stored specifications. Confirm that the ElectricMotor model includes the historization extension and that the WaterPump model includes the validation and quantitative-types extensions.

    ```bash
    oci iot digital-twin-model get-spec \
      --digital-twin-model-id "$ELECTRIC_MOTOR_MODEL_ID"

    oci iot digital-twin-model get-spec \
      --digital-twin-model-id "$WATER_PUMP_MODEL_ID"
    ```

2. Before you use production telemetry, replace the illustrative `flowRate` limits with ranges approved for the installed pumps. Values that violate the configured validation rules are rejected rather than normalized.

3. In the OCI Console, select the workshop compartment, open **Internet of Things**, and open the IoT domain. Select the **Digital twin models** tab. Locate **Electric Motor Model** and **Water Pump Model**, then open each model to inspect its stored DTDL specification.

## Resources

- [OCI IoT Domain Database Schema Reference](https://docs.oracle.com/en-us/iaas/Content/internet-of-things/iot-domain-database-schema.htm)

## Acknowledgements

* **Author** - Pete St. Pierre, Director, Product Management
* **Last Updated By/Date** - Draft structure, August 2026
