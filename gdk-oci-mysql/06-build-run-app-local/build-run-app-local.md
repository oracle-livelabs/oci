# Build and Run the Application

## Introduction

This lab takes you through the steps to simulate the local development flow and run the application pointing to a local MySQL database running in a container on the same machine.

![GDK JAR Local MySQL Container](images/gcn-jar-mysql-container.png#input)

For this, you will start a local MySQL container, and use the Micronaut Maven build plugin to build and run the sample `Genre` application with this local MySQL database.

Estimated Lab Time: 10 minutes

### Objectives

In this lab, you will:

* Run a MySQL container
* Build and run the application
* Send an HTTP POST request to add a Genre
* Check the Genres present in the MySQL database
* Stop the application

## Task 1: Run a MySQL container

1. Open a new terminal in VS Code using the **Terminal>New Terminal** menu.

2. Copy the following command to run a MySQL container:

    ``` bash
	<copy>
    docker run -it --rm \
    --name "mysql.8" \
    -p 3306:3306 \
    -e MYSQL_DATABASE=db \
    -e MYSQL_USER=sherlock \
    -e MYSQL_PASSWORD=elementary \
    -e MYSQL_ALLOW_EMPTY_PASSWORD=true \
    mysql:8
	</copy>
    ```

3. Place your cursor in the terminal in VS Code and paste (`CTRL+SHIFT+V`) the command you copied. A dialog box will ask **Are you sure you want to paste 8 lines of text in to the terminal?**. Select **Do not ask me again** and click **Paste** to proceed.

    ![VS Code Paste view](./images/paste-mysql-8-confirm.jpg#input)

    Press the enter (return) key. The MySQL container starts in a few seconds. When MySQL is up and running, you will see a similar message in the terminal window:

    ``` bash
    ... [Server] /usr/sbin/mysqld: ready for connections. Version: '8.4.4'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  MySQL Community Server - GPL.
    ```

## Task 2: Build and run the application

1. Open a second terminal in VS Code using the **Terminal>New Terminal** menu.

2. Run the following command(s):

<if type="mn_run">
   Use `mn:run` to build and start the application on port 8080. Run the application in the background by appending an `&` as shown below.

	``` bash
	<copy>
	./mvnw install -pl lib -am && MICRONAUT_ENVIRONMENTS=oraclecloud ./mvnw mn:run -pl oci &
	</copy>
	```
</if>

<if type="jar">
   Build an executable JAR file and then use `java -jar` to run it. Run the application in the background by appending an `&` as shown below.

	``` bash
	<copy>
	./mvnw install -pl lib -am && MICRONAUT_ENVIRONMENTS=oraclecloud ./mvnw package -pl oci

    MICRONAUT_ENVIRONMENTS=oraclecloud java -jar oci/target/oci-db-demo-oci-1.0-SNAPSHOT.jar &
	</copy>
	```
</if>

## Task 3: Send an HTTP POST request to add a Genre

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

## Task 4: Check the Genres present in the MySQL database

1. Check the `genres` present in the MySQL database using the `/list` endpoint exposed by the application:

    ``` bash
	<copy>
    curl localhost:8080/genres/list | jq
	</copy>
    ```

## Task 5: Stop the application

1. Bring the running application in the foreground:

    ```bash
	<copy>
    fg
	</copy>
    ```

2. Once the application is running in the foreground, use `CTRL+C` to stop it.

Congratulations! You've successfully completed this lab. Your Java application can successfully use the OCI MySQL HeatWave Database instance as its backend, with secrets in OCI Vault.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
