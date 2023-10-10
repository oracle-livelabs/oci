
# Introduction

Estimated time: 30 minutes

## Goal: OCI Starter: Create a Cloud Native Application in 5 mins

![Introduction Usecase](images/starter-website.png =100%x*)

In this tutorial, we will create custom Cloud Native applications using:

- Terraform scripts (or Resource Manager)
- A Compute or Kubernetes, Serverless (Function)
- An user interface in HTML or ReactJS, Angular, JET, JSP, PHP
- A backend using Java or Node, Python, .NET, Go, ORDS
    - For Java: 
        - Framework: SpringBoot or Helidon, Tomcat, Micronaut
        - VM: JDK or SpringBoot
- An Autonomous database or Oracle Database System, Pluggable Database, MySQL
- Using new or existing infrastructure resources

We will use OCI Starter. It is an open source project that allow to start from 
a working sample for most combinations of the above choices.

## Architecture

![Architecture](images/starter-architecture-all.png)

## How

It works like this:
- We will go to the Website https://www.ocistarter.com/ to get a zip file with all the code that we need
- Check what it contains
- Run ./build.sh

## Labs

If you have no idea on which type of infrastructure to deploy your program, please use: 
- Lab 1 - Compute (Virtual Machine)
- Then check the "Lab - Customize" to see how to customize this sample to your needs

If you have other requirements, please do other choice of labs based on requirements and the list of components. (See below)

### Components

Whatever choices that you do, you will get a working sample with terraform to create the program of your choice. You have the choice of the following components:

1. Infrastucture
    - Compute (Default) - [Virtual Machine](https://docs.oracle.com/en-us/iaas/Content/Compute/home.htm)
    - Kubernetes - [OCI Container Engine for Kubernetes](https://docs.oracle.com/en-us/iaas/Content/ContEng/home.htm)
    - Container Instance - [Container Instance](https://docs.oracle.com/en-us/iaas/Content/container-instances/home.htm)
    - Function - [Functions](https://docs.oracle.com/en-us/iaas/Content/Functions/home.htm)
2. User Interface 
    - HTML 5 
    - ReactJS 
    - Angular
    - JET
    - PHP
    - APEX
3. Backend
    - Java (Default) - [Java](https://dev.java/)
    - NodeJS - [NodeJS](https://nodejs.org/)
    - Python -[Python](https://www.python.org/)
    - .NET - [.NET](https://dotnet.microsoft.com/)
    - Go - [Go](https://go.dev/)
    - ORDS - [Oracle REST Data Services](https://docs.oracle.com/en/database/oracle/oracle-rest-data-services/index.html)
4. For Java, seevral Java Framework
    - SpringBoot  - [SpringBoot](https://spring.io/projects/spring-boot)
    - Helidon - [SpringBoot](https://helidon.io/)
    - Tomcat Servlet/JSP - [Tomcat](https://tomcat.apache.org/)
    - Micronaut - [Micronaut](https://micronaut.io/)
5. For the database
    - Oracle Autonomous Database - [Autonomous Database](https://docs.oracle.com/en/database/autonomous-database-cloud-services.html)
    - Oracle Database - [Base Database Service](https://docs.oracle.com/en/cloud/paas/base-database/index.html)
    - Pluggable Database - [PDB on top of an existing Oracle Database](https://docs.oracle.com/en-us/iaas/dbcs/doc/pluggable-databases.html)
    - Oracle DB 23c Free (running on a Compute) - [Database Free ](https://www.oracle.com/be/database/free/)
    - MySQL - [MySQL](https://docs.oracle.com/en-us/iaas/mysql-database/index.html)

For Advanced Features, check the Lab - Advanced. For things like Resource Manager, GraalVM Native and so on... 


## Acknowledgements 

- **Author**
    - Marc Gueury
    - Ewan Slater 

- **History** - Creation - 30 nov 2022