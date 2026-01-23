# Release Application to OCI Using GitHub Actions

## Introduction

In this step, you will trigger a full end-to-end CI/CD pipeline by pushing code to the main branch.
This will automatically build, containerize, publish, and deploy your Spring Boot application into Oracle Cloud Infrastructure (OCI) using a blue-green deployment strategy.

What Happens When You Run This Project

When you push code to the main branch, your CI/CD pipeline performs a fully automated blue-green deployment on Oracle Cloud Infrastructure.
1. Build Phase

The pipeline automatically executes:

Spring Boot source code  
→ Maven build (JAR)  
→ Docker image  
→ Push to OCI Container Registry (OCIR)


This produces a versioned Docker image:

<region>.ocir.io/<namespace>/<repo>:<git-sha>


and also updates the latest tag.

2. Deploy Phase (Blue-Green Strategy)

The deployment scripts then execute the following workflow:

- Detect Existing Instances

The pipeline finds all currently running OCI Container Instances for this application:

list_matching_instance_ids()


These represent the currently live version.
 
- Create a New Container Instance

A brand-new container instance is created using:

The newly built image from OCIR

Environment variables for PostgreSQL:

SPRING_DATASOURCE_URL

SPRING_DATASOURCE_USERNAME

SPRING_DATASOURCE_PASSWORD

This guarantees the new version is immutable and isolated from the old one.

- Wait Until the New Instance Is Ready

The pipeline waits until OCI reports:

lifecycleState = ACTIVE


This ensures the container is fully started and ready to receive traffic.

- Resolve the Instance IP

The pipeline retrieves the new instance’s:

Private IP (for internal Load Balancer)

or Public IP (if configured)

This IP will be registered into the Load Balancer.

- Register the New Instance in the Load Balancer

The new container instance is added to the OCI Load Balancer backend set.

Traffic is not yet switched until health checks pass.

- Wait for Health Checks

The pipeline continuously polls OCI until the Load Balancer reports:

health = OK (or WARNING)


Only when the new container is healthy does the system proceed.

- Remove Old Backends

All old container instances are removed from the Load Balancer.

At this moment, 100% of traffic is now served by the new version.

- Delete Old Container Instances

The previous container instances are then deleted from OCI.

This frees resources and guarantees only the new version remains running.

Final Result

You have achieved:

Zero-downtime, enterprise-grade blue-green deployment on Oracle Cloud Infrastructure

### Objectives

* Verify that a Git push automatically triggers:

- Maven build of the Spring Boot application

- Docker image creation

- Push to OCI Container Registry (OCIR)

- Deployment to OCI Container Instances

- Load Balancer traffic cutover

- Zero-downtime replacement of the running version

### Prerequisites (Optional)

This lab assumes you have:
* An active GitHub account
* IntelliJ IDEA installed (Community or Ultimate edition)
* Basic familiarity with the command line

## Task 1: Make a Small Application Change

Edit any file in the Spring Boot project, for example:

```
   "variables": ["../../variables/variables.json",
                 "../../variables/variables-in-another-file.json"],
```

## Task 2

Specify the variables in the .json file like this:

*Example: variables.json*
```
{
    "var1": "Variable 1 value",
    "var2": "Variable 2 value",
    "random_name": "LiveLabs rocks!",
    "number_of_ocpu_paid": "24"
    "number_of_ocpu_always_free": "2"
 }
 ```

You can also add multiple files that specify variables (see the example in Task 1).

 *Example: variables_in_another_file.json*
```
{
    "var11": "Variable 1 value but yet different",
    "var22": "Variable 2 value is different",
    "random_name2": "LiveLabs rocks & rules!",``
    "name_of_database": "My-Database-Name-is-the-best",
    "magic": "What is 2*2?"
 }
 ```

## Task 3

Now, you can refer to those variables using the following syntax (**Please note that you can see the syntax only in markdown**):

[](var:var1)

or

[](var:magic)


### Examples

(Check the markdown to see the syntax - the bold text is the value of the variable)

- Do you know math? This is **[](var:magic)**

- How many OCPUs do I need to run this service in my paid tenancy? You need **[](var:number_of_ocpu_paid)**

- But what if am using 'Always free'? Then you need **[](var:number_of_ocpu_always_free)**

- What is the best name for my database? It is **[](var:name_of_database)**

- Here you can find more info: **[](var:doc_link)**
