# Lab 7: Send Telemetry and View Results

## Introduction

Send telemetry to each directly connected water-pump instance and inspect the normalized results. This lab uses `curl` to make HTTPS requests because it is a simple way to test a device payload. The external key is the basic-authentication user name, and the plain-text Vault-secret value is the password.

An MQTT client is also an option for publishing telemetry. Use MQTT when the device must receive commands from OCI IoT Platform because the device can maintain an MQTT connection and subscribe for outbound messages. Sending and receiving commands is outside the scope of this lab; the examples here send telemetry only.

Estimated Time: 30 minutes

### Objectives

In this lab, you will:

- Send telemetry in nested format to Pump 1 with curl.
- Send flat PSI telemetry to Pump 2 with curl.
- Inspect the normalized digital twin content with the OCI CLI and the OCI Console.

## Task 1: Prepare the publishing values

1. This lab references `IOT_DOMAIN_OCID`, the pump instance identifiers, external keys, and plain-text secret values that you set in earlier labs. Do not set them again. Retrieve and export the IoT device host from the IoT domain. Keep secret values out of shell history and source control.

    ```bash
    export IOT_DEVICE_HOST=$(oci iot domain get \
      --iot-domain-id "$IOT_DOMAIN_OCID" \
      --query 'data."device-host"' \
      --raw-output)
    ```

2. The HTTPS endpoint for this lab is `https://$IOT_DEVICE_HOST/telemetry`. A successful request is accepted for asynchronous processing; inspect the twin content in the next task to confirm that the adapter normalized the telemetry.

## Task 2: Send telemetry with curl

1. Send Pump 1 telemetry using the nested structure expected by the default adapter. Pressure is already in bar.

    ```bash
    curl -i -X POST \
      -u "$PUMP_1_EXTERNAL_KEY:$PUMP_1_SECRET_VALUE" \
      -H "Content-Type: application/json" \
      "https://$IOT_DEVICE_HOST/telemetry" \
      -d '{
        "motor": {
          "motorTemperature": 68.4,
          "vibrationLevel": 1.7,
          "powerConsumption": 12.6
        },
        "flowRate": 247.5,
        "dischargePressure": 4.3
      }'
    ```

2. Send Pump 2 telemetry using the flat payload expected by the custom adapter. The custom adapter builds the nested `motor` component and converts `dischPressPsi` to bar.

    ```bash
    curl -i -X POST \
      -u "$PUMP_2_EXTERNAL_KEY:$PUMP_2_SECRET_VALUE" \
      -H "Content-Type: application/json" \
      "https://$IOT_DEVICE_HOST/telemetry" \
      -d '{
        "motorTemperature": 68.4,
        "vibrationLevel": 1.7,
        "powerConsumption": 12.6,
        "flowRate": 247.5,
        "dischPressPsi": 62.37
      }'
    ```

3. Expect an `HTTP/1.1 202 Accepted` response when the platform accepts each telemetry request. A 202 response confirms acceptance, not that the data has completed normalization.

## Task 3: View the normalized telemetry

1. OCI IoT Platform records incoming device messages in `RAW_DATA`, which preserves the original payload, endpoint, content type, and receipt time. If a message cannot be normalized because of an adapter mapping, model validation, or other processing error, OCI IoT Platform records the rejected message and the reason in `REJECTED_DATA`. Use those tables when you need to diagnose an ingest or normalization issue. For table details, see the [OCI IoT Domain Database Schema Reference](https://docs.oracle.com/en-us/iaas/Content/internet-of-things/iot-domain-database-schema.htm).

    The `get-content` examples in this task retrieve each instance's latest normalized values and metadata. Those values correspond to the current-state records in `SNAPSHOT_DATA`, not the original payload in `RAW_DATA` or a time-series record in `HISTORIZED_DATA`.

2. Use the OCI CLI to retrieve the current content and metadata for Pump 1.

    ```bash
    oci iot digital-twin-instance get-content \
      --digital-twin-instance-id "$PUMP_1_INSTANCE_ID" \
      --should-include-metadata true
    ```

3. Retrieve the current content and metadata for Pump 2.

    ```bash
    oci iot digital-twin-instance get-content \
      --digital-twin-instance-id "$PUMP_2_INSTANCE_ID" \
      --should-include-metadata true
    ```

4. Confirm that both instances show the canonical paths `motor.motorTemperature`, `motor.vibrationLevel`, `motor.powerConsumption`, `flowRate`, and `dischargePressure`. For Pump 2, 62.37 PSI should appear as approximately 4.30 bar.

5. In the OCI Console, select the workshop compartment, open **Internet of Things**, and select the IoT domain. On the **Digital twin instances** tab, select **Water Pump 1** or **Water Pump 2** and inspect its content and metadata. The Console view shows the same normalized snapshot values returned by `get-content`.

## Acknowledgements

* **Author** - Pete St. Pierre, Director, Product Management
* **Last Updated By/Date** - Pete St. Pierre, August 2026
