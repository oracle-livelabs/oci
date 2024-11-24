# Build and run a native executable

## Introduction

This lab describes how to build and run a native executable for the application.

You will use [GraalVM Native Image](https://docs.oracle.com/en/graalvm/jdk/17/docs/overview/)’s ahead-of-time compilation to build a native executable for the application.

At build time, GraalVM analyzes a Java application and its dependencies to identify just what classes, methods, and fields are absolutely necessary, and then generates a native executable with optimized machine code for just these elements.

Native executables built with GraalVM require less memory, are smaller in size, and start upto 100x faster than just-in-time compiled applications running on a Java Virtual Machine.

For this step you will start a local MySQL container, update the datasources default URL, username, and password in the  _oci/src/main/resources/application-oraclecloud.properties_ file, build the native executable and run the native executable with the local MySQL database.

Estimated Lab Time: 15 minutes

### Objectives

In this lab, you will:

* Configure the application to use local MySQL database
* Build and run a native executable for the application
* Send requests to publish metrics to OCI Metrics

## Task 1: Configure the application to use local MySQL database

1. Open a third terminal in VS Code using the **Terminal>New Terminal** menu.

2. Copy the following command to run a MySQL container:

	``` bash
	<copy>
	docker run -it --rm \
	--name "mysql.latest" \
	-p 3306:3306 \
	-e MYSQL_DATABASE=db \
	-e MYSQL_USER=sherlock \
	-e MYSQL_PASSWORD=elementary \
	-e MYSQL_ALLOW_EMPTY_PASSWORD=true \
	container-registry.oracle.com/mysql/community-server:latest
	</copy>
	```

3. Place your cursor in the terminal in VS Code and paste (`CTRL+SHIFT+V`) the command you copied. A dialog box will ask **Are you sure you want to paste 8 lines of text in to the terminal?**. Select **Do not ask me again** and click **Paste** to proceed.

	![VS Code Question Icon](./images/paste-mysql-8-confirm.jpg#input)

   Press the enter (return) key. The MySQL container starts in a few seconds. When MySQL is up and running, you will see a message in the terminal window similar to:

	``` bash
	... [Server] /usr/sbin/mysqld: ready for connections. Version: '9.0.1'  socket: '/var/lib/mysql/mysql.sock'  port: 3306  MySQL Community Server - GPL.
	```

4. Uncomment the `url`, `username` and `password` under the `datasources.default` property in _oci/src/main/resources/application-oraclecloud.properties_:

	``` properties
	datasources.default.url=${DATASOURCES_DEFAULT_URL:`jdbc:mysql://localhost:3306/db`}
	datasources.default.username=${DATASOURCES_DEFAULT_USERNAME:sherlock}
	datasources.default.password=${DATASOURCES_DEFAULT_PASSWORD:elementary}
	```

   Save the file (`CTRL+S`).

## Task 2: Build and run a native executable for the application

1. In the first terminal in VS Code, check the version of the GraalVM native-image utility:

	``` bash
	<copy>
	native-image --version
	</copy>
	```

2. To generate a native executable using Maven, run the following command:

	``` bash
	<copy>
	./mvnw install -pl lib -am && ./mvnw clean package -pl oci -Dpackaging=native-image
	</copy>
	```

   It can take approximately 3-4 minutes to generate the native executable.

3. The native executable is created in the _oci/target_ directory and can be run with the following command:

	``` bash
	<copy>
	MICRONAUT_ENVIRONMENTS=oraclecloud oci/target/oci-metrics-demo-oci
	</copy>
	```

   The native executable starts instantaneously.

## Task 3: Send requests to publish metrics to OCI Metrics

1. From the second terminal, send a few test requests (2 each) with cURL, as follows:

	a) Get all the books:

	``` bash
	<copy>
	curl localhost:8080/books | jq
	</copy>
	```

	b) Get a book by its ISBN:

	``` bash
	<copy>
	curl localhost:8080/books/9781680502398 | jq
	</copy>
	```

   c) Get a list of all the available metrics:

	``` bash
	<copy>
	curl localhost:8080/metrics | jq
	</copy>
	```

   d) Get a particular metric value:

	``` bash
	<copy>
	curl localhost:8080/metrics/http.server.requests | jq
	</copy>
	```

   e) Get the value of the metric created on the `/books` endpoint: 

	``` bash
	<copy>
	curl localhost:8080/metrics/books.index | jq
	</copy>
	```

   f) Get the value of the custom metric that contains the total number of books containing the word "microservices" in their title:

	``` bash
	<copy>
	curl localhost:8080/metrics/microserviceBooksNumber.latest | jq
	</copy>
	```

## Task 4: Stop the application

1. In the first terminal in VS Code, use `CTRL+C` to stop the application.

	You may see some error stack traces with messages such as `... failed to post metrics to oracle cloud infrastructure monitoring ...` and `... Client 'oci': Cannot send HTTPS request. SSL is disabled`. You can safely ignore these messages.

2. From the same terminal, stop the MySQL container.

	``` bash
	<copy>
	docker rm -f "mysql.latest"
	</copy>
	```

Congratulations! You've successfully completed this lab. Your Java application native executable can successfully publish metrics to OCI Monitoring.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
