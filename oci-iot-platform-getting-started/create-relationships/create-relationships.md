# Lab 3: Create the Factory and Production Line Digital Twins

## Introduction

Create the non-telemetry part of the beverage-factory hierarchy. You create a *Factory* model and a *ProductionLine* model, then create one factory instance and two production-line instances. Finally, you create `contains` relationships from **Beverage Factory** to each production line.

Neither model receives telemetry. OCI permits `NONE` connectivity only for models that have no telemetry, property, or command content. Therefore, the Factory model defines only its `contains` relationship and the ProductionLine model has no content. Store the factory address, map coordinates, plant manager, line name, and line manager as instance tags. Later labs add the water-pump model, connected devices, adapters, and telemetry.

Estimated Time: 20 minutes

### Objectives

In this lab, you will:

- Define the Factory and ProductionLine models.
- Create the two models with the OCI CLI.
- Create the Beverage Factory, Production Line 1, and Production Line 2 instances.
- Relate the factory to its production lines.

## Task 1: Prepare the CLI working directory

1. Install and configure the OCI CLI if you have not already done so. See [Quickstart: Install and configure the OCI CLI](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm).

2. This lab references `IOT_DOMAIN_OCID`, which you set in Lab 2. Do not set it again. Create the workshop directory once for the model specification files; later labs reuse it.

    ```bash
    export WORKSHOP_DIR="$HOME/oci-iot-water-pump"
    mkdir -p "$WORKSHOP_DIR"
    ```

    You can perform the same model, instance, and relationship actions in the OCI Console. This lab uses the CLI so the configuration is explicit and repeatable.

## Task 2: Define and create the Factory model

1. Create a file named `factory-model.json` in `$WORKSHOP_DIR` with the following Digital Twin Definition Language (DTDL) specification. It defines the `contains` relationship and no telemetry, property, or command content, which permits a `NONE`-connectivity instance.

    ```json
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
    ```

2. Create the model. The command returns the model OCID; save it as `FACTORY_MODEL_ID`.

    ```bash
    export FACTORY_MODEL_ID=$(oci iot digital-twin-model create \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --display-name "Factory Model" \
      --spec "file://$WORKSHOP_DIR/factory-model.json" \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)
    ```

## Task 3: Define and create the ProductionLine model

1. Create a file named `production-line-model.json` in `$WORKSHOP_DIR` with the following DTDL specification. It has no DTDL content, which permits a `NONE`-connectivity instance. The instance tags in Task 4 record the line name and line manager.

    ```json
    {
      "@context": "dtmi:dtdl:context;3",
      "@id": "dtmi:com:oracle:beverage:ProductionLine;1",
      "@type": "Interface",
      "displayName": "Production Line",
      "description": "A beverage factory production line."
    }
    ```

2. Create the model and save its OCID as `PRODUCTION_LINE_MODEL_ID`.

    ```bash
    export PRODUCTION_LINE_MODEL_ID=$(oci iot digital-twin-model create \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --display-name "Production Line Model" \
      --spec "file://$WORKSHOP_DIR/production-line-model.json" \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)
    ```

## Task 4: Create the factory and production-line instances

1. Create the non-connected **Beverage Factory** instance. `NONE` is appropriate because the Factory model has only relationship content. The freeform tags retain the requested factory context; OCI tag values are strings.

    ```bash
    export FACTORY_INSTANCE_ID=$(oci iot digital-twin-instance create \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --digital-twin-model-id "$FACTORY_MODEL_ID" \
      --connectivity-type NONE \
      --display-name "Beverage Factory" \
      --freeform-tags '{"factoryAddress":"100 Bottle Way","latitude":"37.3382","longitude":"-121.8863","plantManager":"Avery Chen"}' \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)
    ```

2. Create **Production Line 1** and **Production Line 2**. Neither production line sends telemetry, so both use `NONE` connectivity. Their tags retain the line name and line manager.

    ```bash
    export PRODUCTION_LINE_1_ID=$(oci iot digital-twin-instance create \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --digital-twin-model-id "$PRODUCTION_LINE_MODEL_ID" \
      --connectivity-type NONE \
      --display-name "Production Line 1" \
      --freeform-tags '{"lineName":"Production Line 1","lineManager":"Jordan Lee"}' \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)

    export PRODUCTION_LINE_2_ID=$(oci iot digital-twin-instance create \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --digital-twin-model-id "$PRODUCTION_LINE_MODEL_ID" \
      --connectivity-type NONE \
      --display-name "Production Line 2" \
      --freeform-tags '{"lineName":"Production Line 2","lineManager":"Sam Patel"}' \
      --wait-for-state ACTIVE \
      --query 'data.id' --raw-output)
    ```

## Task 5: Relate the factory to each production line

1. Create the first `contains` relationship from **Beverage Factory** to **Production Line 1**.

    ```bash
    oci iot digital-twin-relationship create \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --source-digital-twin-instance-id "$FACTORY_INSTANCE_ID" \
      --target-digital-twin-instance-id "$PRODUCTION_LINE_1_ID" \
      --content-path contains \
      --display-name "Beverage Factory contains Production Line 1" \
      --wait-for-state ACTIVE
    ```

2. Create the second `contains` relationship from **Beverage Factory** to **Production Line 2**.

    ```bash
    oci iot digital-twin-relationship create \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --source-digital-twin-instance-id "$FACTORY_INSTANCE_ID" \
      --target-digital-twin-instance-id "$PRODUCTION_LINE_2_ID" \
      --content-path contains \
      --display-name "Beverage Factory contains Production Line 2" \
      --wait-for-state ACTIVE
    ```

3. List the active `contains` relationships whose source is **Beverage Factory**. Confirm that the output has two rows and that the target OCIDs match `$PRODUCTION_LINE_1_ID` and `$PRODUCTION_LINE_2_ID`.

    ```bash
    oci iot digital-twin-relationship list \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --source-digital-twin-instance-id "$FACTORY_INSTANCE_ID" \
      --content-path contains \
      --lifecycle-state ACTIVE \
      --all \
      --query 'data.items[].{Relationship:"content-path",Target:"target-digital-twin-instance-id",Name:"display-name"}' \
      --output table
    ```

## Resources

- [OCI IoT Platform: Creating a Digital Twin Model](https://docs.oracle.com/en-us/iaas/Content/internet-of-things/create-digital-twin-model.htm)

## Acknowledgements

* **Author** - Pete St. Pierre, Director, Product Management
* **Last Updated By/Date** - Pete St. Pierre, August 2026
