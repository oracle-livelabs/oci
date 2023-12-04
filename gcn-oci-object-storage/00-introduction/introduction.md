# Introduction

## About this Workshop

This workshop takes you step by step through the process of building a Java application to upload, download, and delete files from Oracle Cloud Infrastructure (OCI) Object Storage using Graal Cloud Native (GCN). You'll use GraalVM Native Image to package and run the application as a native executable.

It is aimed at application developers and DevOps engineers with a basic knowledge of Java.

Estimated Workshop Time: 1 hour

### What is Graal Cloud Native?

[Graal Cloud Native (GCN)](https://www.graal.cloud/gcn) is a build of a curated set of Micronaut framework modules and their required libraries for building portable cloud-native microservices that take full advantage of powerful cloud platform services and that can be compiled ahead-of-time by GraalVM Native Image. GCN also provides project creation utilities and VS Code extensions for application development and deployment.

### What is Micronaut?

[Micronaut](https://micronaut.io/) is a modern, JVM-based framework to build modular, easily testable microservice and serverless applications. By avoiding runtime reflection in favor of annotation processing, Micronaut improves the Java-based development experience by detecting errors at compile time instead of runtime, and improves Java-based application startup time and memory footprint. Micronaut includes a persistence framework called Micronaut Data that precomputes your SQL queries at compilation time making it a great fit for working with databases like MySQL, Oracle Autonomous Database, etc.

### What is GraalVM Native Image?

[GraalVM Native Image](https://www.graalvm.org/) technology compiles Java applications ahead-of-time into self-contained native executables that are small in size, start almost instantaneously, provide peak performance with no warmup, and require less memory and CPU. Only the code that is required at run time by the application gets added into the executable file. Native Image is perfect for containerized workloads and microservices — which is why it has been embraced by Micronaut, Spring Boot, Helidon, and Quarkus.

GCN modules are designed from the ground up to ensure they can be compiled ahead-of-time with GraalVM Native Image to produce native executables that are ideal for microservices: they start instantly, provide peak performance with no warmup, and have a small memory footprint.

> Graal Cloud Native, Micronaut, and Oracle GraalVM are available at no additional cost on Oracle Cloud Infrastructure (OCI).

### Objectives

In this workshop, you will:

* Use Visual Studio Code (VS Code) from a remote desktop running in an OCI Compute Instance
* Review the application source code developed with Graal Cloud Native and Micronaut
* Provision a new OCI Object Storage bucket
* Configure the application to use the OCI Object Storage bucket
* Build a native executable for the application using GraalVM Native Image
* Run the application and upload, download and delete files from the OCI Object Storage bucket
* Verify the contents of the OCI Object Storage bucket using the Oracle Cloud Console

### Prerequisites

This workshop assumes you have:

* Familiarity with Oracle Cloud Infrastructure (OCI) is helpful
* Understanding of the Java programming language
* Oracle GraalVM for JDK 17
* Visual Studio Code (VS Code)
* Browser with access to the internet
* An Oracle Cloud Infrastructure (OCI) account with adequate permissions

## Learn More

* [Graal Cloud Native](https://www.graal.cloud/gcn/)

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
