# Build a native executable, package it in a container image and push the container image to OCIR

## Introduction

This lab describes how to build a native executable for the application, package it in a container image, and push the container image to the OCIR Repository.

You will use [GraalVM Native Image](https://docs.oracle.com/en/graalvm/jdk/17/docs/overview/)’s ahead-of-time compilation to build a native executable for the application.

At build time, GraalVM analyzes a Java application and its dependencies to identify just what classes, methods, and fields are absolutely necessary, and then generates a native executable with optimized machine code for just these elements.

Native executables built with GraalVM require less memory, are smaller in size, and start upto 100x faster than just-in-time compiled applications running on a Java Virtual Machine.

Estimated Lab Time: 15 minutes

### Objectives

In this lab, you will:

* Build a native executable for the application and package it in a container image
* Push the container image to the OCIR Repository

## Task 1: Build a native executable for the application and package it in a container image

1. In the same terminal in VS Code, check the version of the GraalVM native-image utility:

	``` bash
	<copy>
	native-image --version
	</copy>
	```

2. To generate a native executable and package it in a container image using Maven, run the following command:

	``` bash
	<copy>
	./mvnw clean package -Dpackaging=docker-native -Pgraalvm
	</copy>
	```

   It can take approximately 6-7 minutes to generate the native executable.

## Task 2: Push the container image to the OCIR Repository

1. From the same terminal in VS Code, run `docker login` to log in to OCIR.

	``` bash
	<copy>
	docker login $OCI_REGION.ocir.io -u $OCIR_USERNAME -p $AUTH_TOKEN
	</copy>
	```

2. Push the container image to the OCIR Repository.

	```bash
	<copy>
	docker push $OCI_OS_OKE_IMAGE
	</copy>
	```

Congratulations! You've successfully completed this lab. Your container image has been pushed to the OCIR Repository.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
