# Introduction

## About this Workshop

This workshop takes you step by step through the process of deploying and running a Java microservice on Oracle Cloud Infrastructure (OCI) Container Engine for Kubernetes (OKE). The microservice application, developed using the Graal Development Kit for Micronaut (GDK), exposes REST APIs to upload, download, and delete files from OCI Object Storage. The application is packaged as a native executable using GraalVM Native Image inside a container image.

It is aimed at application developers and DevOps engineers with an intermediate knowledge of Java.

Estimated Workshop Time: 75 minutes

### What is Graal Development Kit for Micronaut?

The [Graal Development Kit for Micronaut (GDK)](https://graal.cloud/gdk) is an Oracle build of the open source Micronaut® framework. The GDK provides a curated set of Micronaut framework modules that simplify cloud application development, are designed for ahead-of-time compilation with GraalVM Native Image, and are fully supported by Oracle. The GDK also provides project creation utilities, VS Code and IntelliJ extensions to simplify application development and deployment.

### What is Micronaut?

The [Micronaut® framework](https://micronaut.io/) is a modern, JVM-based framework to build modular, easily testable microservice and serverless applications. By avoiding runtime reflection in favor of annotation processing, Micronaut improves the Java-based development experience by detecting errors at compile time instead of runtime, and improves Java-based application startup time and memory footprint. Micronaut includes a persistence framework called Micronaut Data that precomputes your SQL queries at compilation time making it a great fit for working with databases like MySQL, Oracle Autonomous Database, etc.

> Micronaut® is a registered trademark of Object Computing, Inc. Use is for referential purposes and does not imply any endorsement or affiliation with any third-party product.

### What is GraalVM Native Image?

[GraalVM Native Image](https://www.graalvm.org/) technology compiles Java applications ahead-of-time into self-contained native executables that are small in size, start almost instantaneously, provide peak performance with no warmup, and require less memory and CPU. Only the code that is required at run time by the application gets added into the executable file. Native Image is perfect for containerized workloads and microservices — which is why it has been embraced by Micronaut, Spring Boot, Helidon, and Quarkus.

The GDK modules are designed for ahead-of-time compilation with GraalVM Native Image to produce native executables that are ideal for microservices: they have a small memory footprint, start instantly, and provide peak performance with no warmup.

> Graal Development Kit for Micronaut, and Oracle GraalVM are available at no additional cost on Oracle Cloud Infrastructure (OCI).

### Objectives

In this workshop, you will:

* Use Visual Studio Code (VS Code) from a remote desktop running in an OCI Compute Instance
* Provision an OKE Cluster, an OCIR Repository, and an OCI Object Storage bucket
* Review the sample application source code developed with the GDK
* Configure the application
* Build a native executable container image for the application and push it to the OCIR Repository
* Deploy the application to the OKE Cluster
* Test the application

### Prerequisites

This workshop assumes you have:

* Some familiarity with Oracle Cloud Infrastructure (OCI)
* Understanding of the Java programming language
* Oracle GraalVM for JDK 17
* Visual Studio Code (VS Code)
* A browser with access to the internet
* An Oracle Cloud Infrastructure (OCI) account with adequate permissions

## Learn More

* [Graal Development Kit for Micronaut](https://graal.cloud/gdk/)

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
