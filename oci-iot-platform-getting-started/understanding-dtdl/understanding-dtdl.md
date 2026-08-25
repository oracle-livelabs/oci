# Understanding DTDL

## Introduction

[Digital Twins Definition Language (DTDL)](https://github.com/Azure/opendigitaltwins-dtdl/blob/master/DTDL/v3/DTDL.v3.md) describes the shape and meaning of a digital twin in JSON. Review these terms before you create the reusable ElectricMotor and WaterPump models in Lab 4.

Estimated Time: 20 minutes

### Objectives

In this section, you will:

- Identify the DTDL constructs that define a model and its contents.
- Explain how a model relationship becomes a directed link between twin instances.
- Distinguish base DTDL constructs from platform and DTDL extensions.
- Recognize how the WaterPump model uses each construct.

## DTDL constructs

DTDL uses typed model content to describe what an asset reports and how OCI IoT Platform handles the data. `Telemetry` and `Component` are base DTDL constructs. `Historized`, `Validated`, and quantitative types are extension annotations used by the model.

**`@context`**

`@context` identifies the DTDL version and any extensions used by the model. The WaterPump model uses DTDL v3, the quantitative-types extension for units, and OCI's validation extension.

```json
"@context": [
  "dtmi:dtdl:context;3",
  "dtmi:dtdl:extension:quantitativeTypes;1",
  "dtmi:com:oracle:dtdl:extension:validation;1"
]
```

**`@id`**

`@id` is the Digital Twin Model Identifier (DTMI), a unique, versioned identifier for the model. Change the version number when you change the model's meaning or structure.

```json
"@id": "dtmi:com:oracle:iot:example:WaterPump;1"
```

**`@type`**

`@type` declares what a DTDL object represents. At the top level, a model is an `Interface`. Within `contents`, `@type` identifies elements such as telemetry, components, properties, or relationships.

```json
"@type": "Interface"
```

**Telemetry**

Telemetry is a named, typed measurement emitted by a physical asset or its control system. For example, `powerConsumption` reports the pump motor's current power use.

```json
{
  "@type": "Telemetry",
  "name": "powerConsumption",
  "schema": "double"
}
```

**Component**

A component embeds a reusable model inside another model's data shape. The WaterPump model uses the `motor` component to include the ElectricMotor model and its telemetry.

```json
{
  "@type": "Component",
  "name": "motor",
  "schema": "dtmi:com:oracle:iot:example:ElectricMotor;1"
}
```

**Relationship**

A relationship defines a directed connection from one digital twin instance to another. Define the relationship in the source model, then create the instance-level link with the relationship's name as its content path. In Lab 3, the Factory model defines `contains`, which links **Beverage Factory** to its production lines; Lab 6 uses `installedOn` to link each water pump to its production line.

```json
{
  "@type": "Relationship",
  "name": "contains",
  "target": "dtmi:com:oracle:beverage:ProductionLine;1"
}
```

**Schema**

`schema` defines the data type accepted by a telemetry value, property, command, or component. A schema can be a primitive type such as `double` or a DTMI that references another DTDL model.

```json
{
  "@type": "Telemetry",
  "name": "vibrationLevel",
  "schema": "double"
}
```

## Extensions

Extensions add specialized behavior beyond base DTDL. The following annotations are used by the WaterPump model.

**Historized**

`Historized` marks telemetry that OCI IoT Platform retains as time-series data in addition to its current snapshot. Use it for values that need trend analysis, such as motor temperature and vibration.

```json
{
  "@type": ["Telemetry", "Historized"],
  "name": "motorTemperature",
  "schema": "double"
}
```

**Validated**

`Validated` enables OCI's validation extension for a property, telemetry value, or command. The model can then enforce rules before incoming data is normalized; here, flow rate must be between 0 and 1000.

```json
{
  "@type": ["Telemetry", "Validated"],
  "name": "flowRate",
  "schema": "double",
  "minimum": 0,
  "maximum": 1000
}
```

**Quantitative Type**

A quantitative type adds measurement meaning and a unit to numeric telemetry. Here, `Pressure` identifies the value as pressure and `bar` specifies its unit.

```json
{
  "@type": ["Telemetry", "Pressure"],
  "name": "dischargePressure",
  "schema": "double",
  "unit": "bar"
}
```

## Check your understanding

1. Answer each question, then review the explanation before you continue to Lab 4.

    ```quiz
    Q: What does the @context field identify in a DTDL model?
    * The DTDL version and any extensions used by the model.
    - The current telemetry values reported by the device.
    - The OCID of the IoT domain that stores the model.
    - The display name of the digital twin instance.
    > The @context field tells a DTDL processor which language version and extensions the model uses.

    Q: Why does the WaterPump model use a motor component?
    - To create a separate digital twin instance for every motor.
    * To include the reusable ElectricMotor model and its telemetry in the pump data shape.
    - To replace the schema for flow-rate telemetry.
    - To send telemetry without a digital twin adapter.
    > A component embeds a reusable model in the parent model, so the WaterPump can use the ElectricMotor telemetry contract without redefining it.

    Q: Which annotation retains a telemetry value as time-series data as well as its current snapshot?
    - Validated
    * Historized
    - Pressure
    - Interface
    > Historized telemetry is retained with time context, which supports trend and time-window analysis.

    Q: What does the Validated annotation enable for flowRate telemetry?
    - It automatically converts flow-rate values to bar.
    - It makes the flow-rate field a reusable component.
    * It enforces the configured rules, such as the accepted numeric range, before data is normalized.
    - It stores every flow-rate value as a relationship.
    > OCI's validation extension applies model rules to incoming data. Values outside the configured range are rejected instead of normalized.
    ```

## Resources

- [Digital Twins Definition Language v3 reference](https://github.com/Azure/opendigitaltwins-dtdl/blob/master/DTDL/v3/DTDL.v3.md)

## Acknowledgements

* **Author** - Pete St. Pierre, Director, Product Management
* **Last Updated By/Date** - Pete St. Pierre, August 2026
