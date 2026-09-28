# Appendix A: Create Required Factory, Production Line, and WaterPump Assets

## Introduction

Use this appendix only when the IoT domain you are using does not contain the models and adapters created in [Get Started with OCI Internet of Things Platform](https://livelabs.oracle.com/ords/r/dbpm/livelabs/view-workshop?wid=4515). If those assets are available, retain their OCIDs and reuse them rather than creating duplicate models or adapters.

Continue with this appendix only if your OCI IoT domain lacks those models and adapters. The tasks create the Factory, ProductionLine, ElectricMotor, and WaterPump models in that order, followed by the default and Flat PSI WaterPump adapters. Factory and ProductionLine keep the WaterPump model consistent with Getting Started. ProductionLine supplies the target for the WaterPump `installedOn` relationship, while WaterPump uses ElectricMotor as a component. Installing the complete model set also supports future labs.

Estimated Time: 55 minutes

### Objectives

In this appendix, you will:

- Create the Factory, ProductionLine, ElectricMotor, and WaterPump models.
- Create the default WaterPump adapter.
- Create the Flat PSI WaterPump adapter.
- Record and verify the resulting OCIDs.

### Prerequisites

- An active IoT domain and OCI CLI profile.
- A writable working directory.
- Permission to create digital twin models and adapters in the IoT domain.

## Task 1: Create the Factory, ProductionLine, ElectricMotor, and WaterPump models

1. Set your working directory and IoT domain OCID. The following commands save the model specifications as JSON files in the working directory.

    ```bash
    export WORKSHOP_DIR="$PWD"
    export IOT_DOMAIN_OCID='<iot-domain-ocid>'
    ```

2. Save the Factory model specification as `$WORKSHOP_DIR/factory-model.json`. This model defines the `contains` relationship and has no telemetry, property, or command content.

    ```bash
    cat > "$WORKSHOP_DIR/factory-model.json" <<'EOF'
    {
      "@context": "dtmi:dtdl:context;3",
      "@id": "dtmi:com:oracle:beverage:Factory;1",
      "@type": "Interface",
      "displayName": "Factory",
      "description": "A beverage production factory.",
      "contents": [
        {
          "@type": "Relationship",
          "name": "contains"
        }
      ]
    }
    EOF
    ```

3. Save the ProductionLine model specification as `$WORKSHOP_DIR/production-line-model.json`. This model has no DTDL content and provides the target type for the WaterPump `installedOn` relationship.

    ```bash
    cat > "$WORKSHOP_DIR/production-line-model.json" <<'EOF'
    {
      "@context": "dtmi:dtdl:context;3",
      "@id": "dtmi:com:oracle:beverage:ProductionLine;1",
      "@type": "Interface",
      "displayName": "Production Line",
      "description": "A beverage factory production line."
    }
    EOF
    ```

4. Save the ElectricMotor model specification as `$WORKSHOP_DIR/electric-motor-model.json`.

    ```bash
    cat > "$WORKSHOP_DIR/electric-motor-model.json" <<'EOF'
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
    EOF
    ```

5. Save the WaterPump model specification as `$WORKSHOP_DIR/water-pump-model.json`. Its `motor` component references ElectricMotor and its `installedOn` relationship targets ProductionLine. This definition is identical to the WaterPump model in the Getting Started workshop.

    ```bash
    cat > "$WORKSHOP_DIR/water-pump-model.json" <<'EOF'
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
    EOF
    ```

6. Create the models in the same order as their files: Factory, ProductionLine, ElectricMotor, then WaterPump. This order creates the referenced ProductionLine and ElectricMotor DTMIs before the WaterPump model.

    ```bash
    export FACTORY_MODEL_ID=$(oci iot digital-twin-model create \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --display-name "Factory Model" \
      --spec "file://$WORKSHOP_DIR/factory-model.json" \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)

    export PRODUCTION_LINE_MODEL_ID=$(oci iot digital-twin-model create \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --display-name "Production Line Model" \
      --spec "file://$WORKSHOP_DIR/production-line-model.json" \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)

    export ELECTRIC_MOTOR_MODEL_ID=$(oci iot digital-twin-model create \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --display-name "Electric Motor Model" \
      --spec "file://$WORKSHOP_DIR/electric-motor-model.json" \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)

    export WATER_PUMP_MODEL_ID=$(oci iot digital-twin-model create \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --display-name "Water Pump Model" \
      --spec "file://$WORKSHOP_DIR/water-pump-model.json" \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)
    ```

7. Verify the four stored specifications.

    ```bash
    oci iot digital-twin-model get-spec --digital-twin-model-id "$FACTORY_MODEL_ID"
    oci iot digital-twin-model get-spec --digital-twin-model-id "$PRODUCTION_LINE_MODEL_ID"
    oci iot digital-twin-model get-spec --digital-twin-model-id "$ELECTRIC_MOTOR_MODEL_ID"
    oci iot digital-twin-model get-spec --digital-twin-model-id "$WATER_PUMP_MODEL_ID"
    ```

## Task 2: Create the default WaterPump adapter

1. Create the default adapter. This command matches the default adapter in the Getting Started workshop. It requires no JSON files because the source payload already matches the WaterPump model shape and uses bar for pressure. If you completed that workshop, retain its adapter OCID rather than creating a second adapter.

    ```bash
    export DEFAULT_WATER_PUMP_ADAPTER_ID=$(oci iot digital-twin-adapter create \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --digital-twin-model-id "$WATER_PUMP_MODEL_ID" \
      --display-name "Water Pump Default Adapter" \
      --description "Default adapter for model-shaped water pump telemetry." \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)
    ```

## Task 3: Create the Flat PSI WaterPump adapter

1. Save the Flat PSI adapter inbound envelope as `$WORKSHOP_DIR/flat-psi-water-pump-envelope.json`. This definition is identical to the Flat PSI adapter in the Getting Started workshop. If that adapter already exists, use its OCID in Lab 3 rather than creating another one.

    ```bash
    cat > "$WORKSHOP_DIR/flat-psi-water-pump-envelope.json" <<'EOF'
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
    EOF
    ```

2. Save the Flat PSI adapter routes as `$WORKSHOP_DIR/flat-psi-water-pump-routes.json`. The route builds the nested motor component and converts PSI to bar.

    ```bash
    cat > "$WORKSHOP_DIR/flat-psi-water-pump-routes.json" <<'EOF'
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
    EOF
    ```

3. Create the Flat PSI adapter.

    ```bash
    export FLAT_PSI_WATER_PUMP_ADAPTER_ID=$(oci iot digital-twin-adapter create \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --digital-twin-model-id "$WATER_PUMP_MODEL_ID" \
      --display-name "Water Pump Flat PSI Adapter" \
      --description "Maps flat pump telemetry to WaterPump and converts PSI pressure to bar." \
      --inbound-envelope "file://$WORKSHOP_DIR/flat-psi-water-pump-envelope.json" \
      --inbound-routes "file://$WORKSHOP_DIR/flat-psi-water-pump-routes.json" \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)
    ```

## Task 4: Verify the WaterPump adapters

1. List active adapters for the WaterPump model. Retain the exported adapter IDs for Lab 3.

    ```bash
    oci iot digital-twin-adapter list \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --digital-twin-model-id "$WATER_PUMP_MODEL_ID" \
      --lifecycle-state ACTIVE \
      --all --output table
    ```

## Documentation References

- [Creating digital twin models](https://docs.oracle.com/en-us/iaas/Content/internet-of-things/create-digital-twin-model.htm)
- [Creating digital twin adapters](https://docs.oracle.com/en-us/iaas/Content/internet-of-things/create-digital-twin-adapter.htm)
- [Digital twin model overview](https://docs.oracle.com/en-us/iaas/Content/internet-of-things/digital-twin-models.htm)
- [DTDL v3 specification](https://azure.github.io/opendigitaltwins-dtdl/DTDL/v3/DTDL.v3.html)

## Acknowledgements

* **Author** - Pete St. Pierre, Director, Product Management
* **Last Updated By/Date** - Pete St. Pierre, September 2026
