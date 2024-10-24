# Build and run a native executable

## Introduction

This lab describes how to generate and run a native executable for the application using GraalVM Native Image and connect it to a MySQL Database running in a container.

You will use [GraalVM Native Image](https://docs.oracle.com/en/graalvm/jdk/17/docs/overview/)’s ahead-of-time compilation to build a native executable for the application.

At build time, GraalVM analyzes a Java application and its dependencies to identify just what classes, methods, and fields are absolutely necessary, and then generates a native executable with optimized machine code for just these elements.

Native executables built with GraalVM require less memory, are smaller in size, and start upto 100x faster than just-in-time compiled applications running on a Java Virtual Machine.

Estimated Lab Time: 15 minutes

### Objectives

In this lab, you will:

* Build and run a native executable for the application
* Send an HTTP POST request to add a Genre
* Check the Genres present in the MySQL database
* Stop the application

## Task 1: Build and run a native executable for the application

1. In the second terminal in VS Code, check the version of the GraalVM native-image utility:

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

    It takes around four minutes to generate the native executable.

3. The native executable is created in the _oci/target_ directory. Run it in the background by appending an `&` as shown below.

	``` bash
	<copy>
	MICRONAUT_ENVIRONMENTS=oraclecloud oci/target/oci-db-demo-oci &
	</copy>
	```

   The native executable starts instantaneously.

## Task 2: Send an HTTP POST request to add a Genre

1. Press the enter (return) key. From the same terminal, add a genre using the command below, and the `genre` table will now contain an entry.
	``` bash
	<copy>
	curl -X "POST" "http://localhost:8080/genres" -H 'Content-Type: application/json; charset=utf-8' -d '{ "name": "action" }' | jq
	</copy>
	```

## Task 3: Send an HTTP GET request to fetch all Genres from the database

1. From the same terminal in VS Code, check the `genres` present in the database using the `/list` endpoint exposed by the application:

	``` bash
	<copy>
	curl localhost:8080/genres/list | jq
	</copy>
	```

## Task 4: Stop the application

1. Bring the running application in the foreground:

	``` bash
	<copy>
	fg
	</copy>
	```

2. Once the application is running in the foreground, use `CTRL+C` to stop it.

3. Stop the MySQL container started in the previous lab.

	``` bash
	<copy>
	docker rm -f "mysql.8"
	</copy>
	```

Congratulations! You've successfully completed this lab. Your Java application native executable is now connected to a local MySQL Database running in a container.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
