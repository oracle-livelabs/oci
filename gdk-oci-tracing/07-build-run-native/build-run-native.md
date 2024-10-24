# Build and run a native executable to send traces to OCI APM Tracing

## Introduction

This lab describes how to build and run a native executable for the application, and send traces to the OCI APM Domain.

You will use [GraalVM Native Image](https://docs.oracle.com/en/graalvm/jdk/17/docs/overview/)’s ahead-of-time compilation to build a native executable for the application.

At build time, GraalVM analyzes a Java application and its dependencies to identify just what classes, methods, and fields are absolutely necessary, and then generates a native executable with optimized machine code for just these elements.

Native executables built with GraalVM require less memory, are smaller in size, and start upto 100x faster than just-in-time compiled applications running on a Java Virtual Machine.

Estimated Lab Time: 15 minutes

### Objectives

In this lab, you will:

* Build and run a native executable for the application
* Send an HTTP GET request and view the trace output in OCI APM Trace Explorer
* Send an HTTP POST request and view the trace outputs in OCI APM Trace Explorer
* Stop the application

## Task 1: Build and run a native executable for the application

1. In the first terminal in VS Code, check the version of the GraalVM native-image utility:

	``` bash
	<copy>
	native-image --version
	</copy>
	```

2. To generate a native executable using Maven, run the following command:

	``` bash
	<copy>
	./mvnw install -pl lib -am && MICRONAUT_ENVIRONMENTS=oraclecloud ./mvnw clean package -pl oci -Dpackaging=native-image
	</copy>
	```

   It can take approximately 3-4 minutes to generate the native executable.

3. The native executable is created in the _oci/target_ directory and can be run with the following command:

	``` bash
	<copy>
	MICRONAUT_ENVIRONMENTS=oraclecloud oci/target/oci-tracing-demo-oci -Dmicronaut.application.name=oci-native
	</copy>
	```

   The native executable starts instantaneously.

## Task 2: Send an HTTP GET request and view the trace output in OCI APM Trace Explorer

1. From the second terminal, send an HTTP GET request to the `/store/inventory/{item}` endpoint to get the count of an item:

	``` bash
	<copy>
	curl http://localhost:8080/store/inventory/laptop
	</copy>
	```

2. Review the trace output in the Oracle Cloud Console. Navigate to the **Observability & Management**. Under **Application Performance Monitoring**, click **Trace Explorer**. Make sure the right compartment and domain are selected.

   You should see a row in the Traces list. You may need to refresh the page or change the selected duration ("Last 60 Minutes").

   ![Trace Explorer Get Request](./images/trace-explorer-native-get.jpg#input)

   You'll notice the native executable processes the request a lot faster. Click the trace name to view the Trace Details. Each span is represented by a blue bar.

   ![Trace Details Get Request](./images/trace-details-native-get.jpg#input)

## Task 3: Send an HTTP POST requests and view the trace outputs in OCI APM Trace Explorer

1. From the second terminal in VS Code, send an HTTP POST request to the `/store/order` endpoint to order an item:

	``` bash
	<copy>
	curl -X "POST" "http://localhost:8080/store/order" -H 'Content-Type: application/json; charset=utf-8' -d $'{"item":"laptop", "count":5}'
	</copy>
	```

2. Review the trace output in the Oracle Cloud Console. Navigate to the **Observability & Management**. Under **Application Performance Monitoring**, click **Trace Explorer**. Make sure the right compartment and domain are selected.

   You should see a new row in the Traces list. You may need to refresh the page or change the selected duration ("Last 60 Minutes").

   ![Trace Explorer Post Request](./images/trace-explorer-native-post.jpg#input)

   Click the trace name to view the Trace Details. Each span is represented by a blue bar.

   ![Trace Details Post Request](./images/trace-details-native-post.jpg#input)

> Note: For auto-activation of custom span attributes, OCI APM requires the attributes to be seen at least five times. Spans created prior to auto-activation will not show these attributes.

3. From the second terminal in VS Code, send multiple HTTP POST requests to the `/store/order` endpoint by running the following command 18-20 times:

	``` bash
	<copy>
	curl -X "POST" "http://localhost:8080/store/order" -H 'Content-Type: application/json; charset=utf-8' -d $'{"item":"laptop", "count":5}'
	</copy>
	```

4. Review the trace output in the Oracle Cloud Console. Navigate to the **Observability & Management**. Under **Application Performance Monitoring**, click **Trace Explorer**. Make sure the right compartment and domain are selected.

   You should see ten new rows in the Traces list. You may need to refresh the page or change the selected duration ("Last 60 Minutes").

   ![Trace Explorer Ten Requests](./images/trace-explorer-native-post-ten-requests.jpg#input)

   Click the most recent trace name to view the Trace Details. Each span is represented by a blue bar.

   ![Trace Details Tenth Request](./images/trace-details-native-tenth-request.jpg#input)

   Click the span named `oci-native: storecontroller.order#store.order` to view the Span Details showing the custom span attributes - `count` and `order.item`.

   ![Span Details 1](./images/trace-native-span-tags-custom-1.jpg#input)

   Click the span named `oci-native: warehouseclient.order` to view the Span Details showing the custom span attribute - `warehouse.order`.

   ![Span Details 2](./images/trace-native-span-tags-custom-2.jpg#input)

## Task 4: Stop the application

1. In the first terminal in VS Code, use `CTRL+C` to stop the application.

Congratulations! You've successfully completed this lab. Your Java application native executable can successfully send traces to OCI APM Tracing and you can visualize the traces and spans using the OCI APM Trace Explorer.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
