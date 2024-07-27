# Build and Run a Native Executable

## Introduction

This lab describes how to build and run a native executable for the application, and then send emails using OCI Email Delivery.

You will use [GraalVM Native Image](https://docs.oracle.com/en/graalvm/jdk/17/docs/overview/)’s ahead-of-time compilation to build a native executable for the application.

At build time, GraalVM analyzes a Java application and its dependencies to identify just what classes, methods, and fields are absolutely necessary, and then generates a native executable with optimized machine code for just these elements.

Native executables built with GraalVM require less memory, are smaller in size, and start upto 100x faster than just-in-time compiled applications running on a Java Virtual Machine.

Estimated Lab Time: 15 minutes

### Objectives

In this lab, you will:

* Build and run a native executable for the application
* Send the emails
	* Send a simple plain-text email
	* Send a templated email
	* Send an email with an attachment

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
	./mvnw install -pl lib -am && ./mvnw clean package -pl oci -Dpackaging=native-image
	</copy>
	```

   It can take approximately 3-4 minutes to generate the native executable.

3. The native executable is created in the _oci/target_ directory and can be run with the following command:

	``` bash
	<copy>
	MICRONAUT_ENVIRONMENTS=oraclecloud oci/target/oci-email-demo-oci &
	</copy>
	```

   The native executable starts instantaneously.

## Task 2: Send the emails

1.	In the same terminal in VS Code, press the enter (return) key.

2.	Send a simple plain-text email using the following command:

	``` bash
	<copy>
	curl -X POST localhost:8080/email/basic
	</copy>
	```

	Check your email as before.

3.	Send a templated email using the following command:

	``` bash
	<copy>
	curl -X POST localhost:8080/email/template/native
	</copy>
	```

	Check your email as before.

4.	Send an email with an attachment using the following command:

	``` bash
	<copy>
	curl -X POST \
		-H "Content-Type: multipart/form-data" \
		-F "file=@ README.md" \
		localhost:8080/email/attachment
	</copy>
	```

	Check your email as before.

5.	Bring the running application to the foreground:

	```
	<copy>
	fg
	</copy>
	```

6.	Once the application is running in the foreground, press `CTRL+C` to stop it.

Congratulations! You've successfully completed this lab. Your Java application native executable can successfully send emails using OCI Email Delivery.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
