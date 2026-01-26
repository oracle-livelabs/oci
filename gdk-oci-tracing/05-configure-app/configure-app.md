# Configure the application to use the OCI APM Domain

## Introduction

This lab provides instructions to configure the application to send traces to the OCI APM Domain you created. This is achieved by setting a couple of properties in the _oci/src/main/resources/application-oraclecloud.properties_ file.

Estimated Lab Time: 05 minutes

### Objectives

In this lab, you will:

* Configure the Application to use the OCI APM Domain

## Task 1: Configure the application to use the OCI APM Domain

1. Navigate to the **Observability & Management >> Application Performance Monitoring >> Administration** section in the Oracle Cloud Console, find your recently created APM Domain, open it, in the **APM Domain Information** tab of the **gdk-apm-domain** details screen click **Copy** to copy the value of the Data Upload Endpoint.

    ![Copy Data Upload Endpoint](images/copy-data-upload-endpoint.png#input)

   The Data Upload Endpoint value should resemble `https://aaaaaaaaannaaannaa.apm-agt.us-phoenix-1.oci.oraclecloud.com`.

2. In VS Code, open _oci/src/main/resources/application-oraclecloud.properties_ and substitute the value of `<DataUploadEndpoint>` in the property `otel.exporter.zipkin.url` leaving the `https://` out.

	_oci/src/main/resources/application-oraclecloud.properties_

	``` properties
	otel.exporter.zipkin.url=https\://<DataUploadEndpoint>
	```
3. From the  **gdk-apm-domain** details screen navigate to **Resources**, choose **Data Keys**. Click **Copy** to copy the value of the public data key (`auto_generated_public_datakey`).

    ![Copy Public Data Key](images/copy-public-datakey.png#input)

   The public data key value should resemble `AAANAANAANNNAAAAANNN`.

4. In VS Code, open _oci/src/main/resources/application-oraclecloud.properties_ and substitute the value of `[public key]` in the property `otel.exporter.zipkin.path`.

	_oci/src/main/resources/application-oraclecloud.properties_

	``` properties
	otel.exporter.zipkin.path=/20200101/observations/public-span?dataFormat\=zipkin&dataFormatVersion\=2&dataKey\=[public key]
   ```

   The APM Collector URL resembles `https://aaaaaaaaannaaannaa.apm-agt.us-phoenix-1.oci.oraclecloud.com/20200101/observations/public-span?dataFormat=zipkin&dataFormatVersion=2&dataKey=AAANAANAANNNAAAAANNN`. For more information about the endpoint format, see [APM Collector URL Format](https://docs.oracle.com/en-us/iaas/application-performance-monitoring/doc/configure-open-source-tracing-systems.html#APMGN-GUID-B5EDE254-C854-436D-B844-B986A4E077AA).

5. Save the file _oci/src/main/resources/application-oraclecloud.properties_.

Congratulations! In this section, you configured the application to use the OCI APM Domain you created earlier. In the next section, you'll build and test the application.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
