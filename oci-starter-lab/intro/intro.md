
# Introduction

Estimated time: 30 minutes

## Goal: OCI Starter: Create a Cloud Native Sample in 5 mins

![Introduction Usecase](images/starter-website.png =100%x*)

In this tutorial, we will create custom Cloud Native applications using:

- Terraform scripts (or Resource Manager)
- A Shape (CPU/Memory) x86, ARM or Free Tier(x86)
- A Compute, Instance Pool, Kubernetes, Container Instance, Serverless Function
- An user interface in HTML or ReactJS, Angular, JET, JSP, PHP, APEX
- A backend using Java or Node, Python, .NET, Go, ORDS
    - For Java: 
        - Framework: SpringBoot or Helidon, Tomcat, Micronaut
        - VM: JDK or GraalVM JIT, GraalVM Native
- An Oracle Autonomous Database or Oracle Database System, Pluggable Database, Oracle Database Free, MySQL, PostgreSQL
- Using new or existing infrastructure resources

*See "Labs" below for a link to the documentation of each of these technologies*

We will use OCI Starter. It is an open source project that allow to start from 
a working sample for most combinations of the above choices.

## Architecture

![Architecture](images/starter-architecture-all.png)

## How

It works like this:
- We will go to the Website https://www.ocistarter.com/ to get a zip file with all the code that we need
- Check what it contains: readme.md, LICENCE (Apache 2 License), source files
- Run ./build.sh

## Labs

If you have no idea on which type of infrastructure to deploy your program, please use: 
- Lab 1 - Compute (Virtual Machine)
- Then check the "Lab 6 - How to Customize" to see how to customize this sample to your needs

If you have other requirements, please do other choice of labs based on requirements and the list of components. (See below)

### Components

Whatever choices that you do, you will get a working sample with terraform to create the program of your choice. You have the choice of the following components:

1. Shape 
    - AMD x86 - [x86 Shape](https://docs.oracle.com/en-us/iaas/Content/Compute/References/computeshapes.htm)
    - ARM Ampere - [ARM Shape](https://docs.oracle.com/en-us/iaas/Content/Compute/References/arm.htm)
    - Free Tier x86 - [Free Tier](https://www.oracle.com/be/cloud/free/)
2. Infrastructure
    - Lab 1 - Compute (Default) - [Virtual Machine](https://docs.oracle.com/en-us/iaas/Content/Compute/home.htm)
    - Lab 2 - Instance Pool - [Instance Pools](https://docs.oracle.com/en-us/iaas/Content/Compute/Concepts/instancemanagement.htm)
    - Lab 3 - Kubernetes - [OCI Container Engine for Kubernetes](https://docs.oracle.com/en-us/iaas/Content/ContEng/home.htm)
    - Lab 4 - Container Instance - [Container Instance](https://docs.oracle.com/en-us/iaas/Content/container-instances/home.htm)
    - Lab 5 - Function - [Functions](https://docs.oracle.com/en-us/iaas/Content/Functions/home.htm)
3. User Interface 
    - HTML 5 - [HTML](https://html.spec.whatwg.org/multipage/)
    - ReactJS - [React](https://react.dev/)
    - Angular - [Angular](https://angular.io/)
    - JET - [JET](https://www.oracle.com/webfolder/technetwork/jet/index.html)
    - PHP - [PHP](https://www.php.net/)
    - APEX - [APEX](https://apex.oracle.com)
4. Backend
    - Java (Default) - [Java](https://dev.java/)
    - NodeJS - [NodeJS](https://nodejs.org/)
    - Python -[Python](https://www.python.org/)
    - .NET - [.NET](https://dotnet.microsoft.com/)
    - Go - [Go](https://go.dev/)
    - ORDS - [Oracle REST Data Services](https://docs.oracle.com/en/database/oracle/oracle-rest-data-services/index.html)
5. For Java, several Java Framework
    - SpringBoot  - [SpringBoot](https://spring.io/projects/spring-boot)
    - Helidon - [Helidon](https://helidon.io/)
    - Tomcat Servlet/JSP - [Tomcat](https://tomcat.apache.org/)
    - Micronaut - [Micronaut](https://micronaut.io/)
6. For the database
    - Oracle Autonomous Database - [Autonomous Database](https://docs.oracle.com/en/database/autonomous-database-cloud-services.html)
    - Oracle Database - [Base Database Service](https://docs.oracle.com/en/cloud/paas/base-database/index.html)
    - Pluggable Database - [PDB on top of an existing Oracle Database](https://docs.oracle.com/en-us/iaas/dbcs/doc/pluggable-databases.html)
    - Oracle DB 23c Free (running on a Compute) - [Database Free ](https://www.oracle.com/be/database/free/)
    - MySQL - [MySQL](https://docs.oracle.com/en-us/iaas/mysql-database/index.html)
    - PostgreSQL - [PostgreSQL](https://docs.oracle.com/en-us/iaas/Content/postgresql/home.htm)
    - OpenSearch - [OpenSearch](https://docs.oracle.com/en-us/iaas/Content/search-opensearch/home.htm)

For Advanced Features, check the Lab - Advanced. For things like Resource Manager, GraalVM Native and so on... 


## Acknowledgements 

* Author - Marc Gueury
* Contributors - Ewan Slater 
* Last Updated - Mar, 11th 2024