# Working with Gateways in OCI Internet of Things (IoT) Platform

## Introduction

This workshop extends a water-pump digital twin scenario to devices that cannot connect directly to OCI. You create one authenticated gateway and use it to forward telemetry for two indirectly connected water pumps. The gateway publishes its own health data and identifies each pump from the endpoint path. OCI IoT delegates a forwarded payload to the target pump's adapter for normalization.

Estimated Workshop Time: 2 hours with existing assets; approximately 2 hours and 55 minutes if you complete the full appendix.

### Objectives

In this workshop, you will:

- Create a gateway model, routing adapter, and authenticated gateway twin.
- Create two indirectly connected WaterPump twins that use different adapters.
- Publish telemetry through one gateway MQTTs connection.
- Verify normalized state and the dependency of indirect devices on the gateway.

### Prerequisites

- An OCI tenancy, compartment, IoT domain group, and IoT domain.
- OCI CLI and MQTTX installed locally or in Cloud Shell.
- A Vault and master encryption key that the IoT domain can read for gateway credentials.
- The ElectricMotor and WaterPump models and the default and Flat PSI WaterPump adapters.

If your IoT domain does not already contain the WaterPump assets, use [Appendix A: Create Required Factory, Production Line, and WaterPump Assets](?lab=appendix-water-pump-assets). The appendix makes this workshop self-contained; it does not require the [earlier getting-started workshop](https://livelabs.oracle.com/ords/r/dbpm/livelabs/view-workshop?wid=4515).

## Workshop Flow

1. **Lab 1** compares direct and indirect connectivity and explains how gateway routing delegates a payload to its target device.
2. **Lab 2** creates Gateway 1 and its routing configuration.
3. **Lab 3** creates two indirect pumps, publishes both payload shapes through Gateway 1, and verifies the results.
4. **Appendix A** supplies the WaterPump model and adapter assets when they are not already available.

## Learn More

- [Get Started with OCI Internet of Things Platform](https://livelabs.oracle.com/ords/r/dbpm/livelabs/view-workshop?wid=4515)
- [OCI IoT gateway scenario](https://docs.oracle.com/en-us/iaas/Content/internet-of-things/gateway-instance.htm)
- [OCI IoT Platform overview](https://docs.oracle.com/en-us/iaas/Content/internet-of-things/overview.htm)

## Acknowledgements

* **Author** - Pete St. Pierre, Director, Product Management
* **Last Updated By/Date** - Pete St. Pierre, September 2026
