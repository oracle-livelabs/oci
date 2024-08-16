# Build and Run the Application

## Introduction

This section of the lab takes you through the steps to build and run the sample application and then send emails.

Estimated Lab Time: 10 minutes

### Objectives

In this lab, you will:

* Build and run the application
* Send the emails
	* Send a simple plain-text email
	* Send a templated email
	* Send an email with an attachment

## Task 1: Build and run the application

1. In the same terminal in VS Code, run the following command(s).

<if type="mn_run">
   Use `mn:run` to build and start the application on port 8080.

	``` bash
	<copy>
	./mvnw install -pl lib -am && MICRONAUT_ENVIRONMENTS=oraclecloud ./mvnw mn:run -pl oci &
	</copy>
	```
</if>

<if type="jar">
   Build an executable JAR file and then use `java -jar` to run it.

	``` bash
	<copy>
	./mvnw install -pl lib -am && ./mvnw package -pl oci

	MICRONAUT_ENVIRONMENTS=oraclecloud java -jar oci/target/oci-email-demo-oci-1.0-SNAPSHOT.jar &
	</copy>
	```
</if>

## Task 2: Send the emails

1. In the same terminal in VS Code, press the enter (return) key.

2. Send a simple plain-text email using the following command:

	``` bash
	<copy>
	curl -X POST localhost:8080/email/basic
	</copy>
	```

	Check the email you provided in Lab **3** Task **4**. You should see the basic email in your Inbox or Spam folder.

3. Send a templated email using the following command:

	``` bash
	<copy>
	curl -X POST localhost:8080/email/template/test
	</copy>
	```

	Check the email you provided in Lab **3** Task **4**. You should see the templated email in your Inbox or Spam folder.

4. Send an email with an attachment using the following command:

	``` bash
	<copy>
	curl -X POST \
		-H "Content-Type: multipart/form-data" \
		-F "file=@ README.md" \
		localhost:8080/email/attachment
	</copy>
	```

	Check the email you provided in Lab **3** Task **4**. You should see the attachment email in your Inbox or Spam folder.

## Task 3: Stop the application

1. Bring the running application to the foreground:

	``` bash
	<copy>
	fg
	</copy>
	```

2. Once the application is running in the foreground, press `CTRL+C` to stop it.

Congratulations! You've successfully completed this lab. Your Java application can successfully send emails using OCI Email Delivery.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
