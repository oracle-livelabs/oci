# Build and Run the Application

## Introduction

This lab describes how to build and run the application, and use it to connect to the OCI MySQL HeatWave Database instance with secrets in OCI Vault.

Estimated Lab Time: 10 minutes

### Objectives

In this lab, you will:

* Build and run the application
* Send an HTTP POST request to add a Genre
* Check the Genres present in the MySQL HeatWave Database
* Stop the application

## Task 1: Build and run the application

1. In the same terminal in VS Code, run the following command(s):

<if type="mn_run">
   Use `mn:run` to build and start the application on port 8080. Run it in the background by appending an `&` as shown below.

	``` bash
	<copy>
	./mvnw install -pl lib -am && MICRONAUT_ENVIRONMENTS=oraclecloud ./mvnw mn:run -pl oci &
	</copy>
	```
</if>

<if type="jar">
   Build an executable JAR file and then use `java -jar` to run it. Run it in the background by appending an `&` as shown below.

	``` bash
	<copy>
	./mvnw install -pl lib -am && MICRONAUT_ENVIRONMENTS=oraclecloud ./mvnw package -pl oci -DskipTests

	MICRONAUT_ENVIRONMENTS=oraclecloud java -jar oci/target/oci-db-demo-oci-1.0-SNAPSHOT.jar &
	</copy>
	```
</if>

## Task 2: Send an HTTP POST request to add a Genre

1. Press the enter (return) key. From the same terminal, add a genre using the command below, and the `genre` table will now contain an entry.

<if type="mn_run">

	``` bash
	<copy>
	curl -X "POST" "http://localhost:8080/genres" -H 'Content-Type: application/json; charset=utf-8' -d '{ "name": "music" }' | jq
	</copy>
	```
</if>

<if type="jar">

    ``` bash
	<copy>
	curl -X "POST" "http://localhost:8080/genres" -H 'Content-Type: application/json; charset=utf-8' -d '{ "name": "drama" }' | jq
	</copy>
	```
</if>

## Task 3: Check the Genres present in the MySQL HeatWave Database

1. Check the `genres` present in the MySQL database using the `/list` endpoint exposed by the application:

	``` bash
	<copy>
	curl localhost:8080/genres/list | jq
	</copy>
	```

## Task 4: Stop the application

1. Bring the running application in the foreground:

	```bash
	<copy>
	fg
	</copy>
	```

2. Once the application is running in the foreground, use `CTRL+C` to stop it.

Congratulations! You've successfully completed this lab. Your Java application can successfully use the OCI MySQL HeatWave Database instance as its backend database, with secrets in OCI Vault.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
