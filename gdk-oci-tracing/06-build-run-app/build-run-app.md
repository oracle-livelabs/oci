# Build and run the sample application to send traces to OCI APM Domain

## Introduction

This section of the lab takes you through the steps to build and run the sample application to send traces to the OCI APM Domain.

Estimated Lab Time: 10 minutes

### Objectives

In this lab, you will:

* Build and run the application
* Send an HTTP GET request and view the trace outputs in OCI APM Trace Explorer
* Send an HTTP POST request and view the trace output in OCI APM Trace Explorer
* Send an HTTP GET request and view the trace outputs in OCI APM Trace Explorer
* Stop the application

## Task 1: Build and run the application

1. Open a new terminal in VS Code using the **Terminal > New Terminal** menu.

2. Run the following command to build application:

<if type="mn_run">

   Use `mn:run` to build and start the application on port 8080.

	``` bash
	<copy>
	./mvnw install -pl lib -am && MICRONAUT_ENVIRONMENTS=oraclecloud ./mvnw mn:run -pl oci -Dmicronaut.application.name=oci
	</copy>
	```
</if>

<if type="jar">

   Build an executable JAR file and then use `java -jar` to run it.

	``` bash
	<copy>
	./mvnw install -pl lib -am && MICRONAUT_ENVIRONMENTS=oraclecloud ./mvnw package -pl oci

	MICRONAUT_ENVIRONMENTS=oraclecloud java -jar oci/target/oci-tracing-demo-oci-1.0-SNAPSHOT.jar -Dmicronaut.application.name=oci
	</copy>
	```
</if>

## Task 2: Send an HTTP GET request and view the trace output in OCI APM Trace Explorer

1. Open a second terminal in VS Code using the **Terminal>New Terminal** menu.

2. From the second terminal, send an HTTP GET request to the `/store/inventory/{item}` endpoint to get the count of an item:

	``` bash
	<copy>
	curl http://localhost:8080/store/inventory/laptop
	</copy>
	```

   VS Code may prompt you to open the URL in a browser as shown below. Just click the **Configure Notifications** gear icon and then click **Don't Show Again**.

   ![VS Code Paste URLs](images/vscode-paste-urls.png)

   ![VS Code Don't Show Again](images/vscode-dont-show-again.png)

3. Review the trace output in the Oracle Cloud Console. Navigate to the **Observability & Management**. Under **Application Performance Monitoring**, click **Trace Explorer**. Make sure the right compartment and domain are selected.

   You should see a row in the Traces list. You may need to refresh the page or change the selected duration ("Last 60 Minutes").

   ![Trace Explorer Get Request](./images/trace-explorer-get.png#input)

   Click the trace name to view the Trace Details. Each span is represented by a blue bar.

   ![Trace Details Get Request](./images/trace-details-get.png#input)

## Task 3: Send an HTTP POST request and view the trace output in OCI APM Trace Explorer

1. From the second terminal in VS Code, send an HTTP POST request to the `/store/order` endpoint to order an item:

	``` bash
	<copy>
	curl -X "POST" "http://localhost:8080/store/order" -H 'Content-Type: application/json; charset=utf-8' -d $'{"item":"laptop", "count":5}'
	</copy>
	```

2. Review the trace output in the Oracle Cloud Console. Navigate to the **Observability & Management**. Under **Application Performance Monitoring**, click **Trace Explorer**. Make sure the right compartment and domain are selected.

	You should see a new row in the Traces list. You may need to refresh the page or change the selected duration ("Last 60 Minutes").

   ![Trace Explorer Post Request](./images/trace-explorer-post.jpg#input)

   Click the trace name to view the Trace Details. Each span is represented by a blue bar.

   ![Trace Details Post Request](./images/trace-details-post.jpg#input)


## Task 4: Send an HTTP GET request and view the trace output in OCI APM Trace Explorer

1. From the second terminal in VS Code, send an HTTP GET request to the `store/inventory` endpoint to get the inventory details:

	``` bash
	<copy>
	curl http://localhost:8080/store/inventory
	</copy>
	```

2. Review the trace output in the Oracle Cloud Console. Navigate to the **Observability & Management**. Under **Application Performance Monitoring**, click **Trace Explorer**. Make sure the right compartment and domain are selected.

   You should see a third row in the Traces list. You may need to refresh the page or change the selected duration ("Last 60 Minutes").

   ![Trace Explorer Inventory Request](./images/trace-explorer-inventory.jpg#input)

   Click the trace name to view the Trace Details. Each span is represented by a blue bar.

   ![Trace Details Inventory Request](./images/trace-details-inventory.jpg#input)

## Task 5: Stop the application

1. In the first terminal in VS Code, use `CTRL+C` to stop the application.

Congratulations! You've successfully completed this lab. Your Java application can successfully send traces to OCI APM Tracing and you can visualize the traces using the OCI APM Trace Explorer.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
