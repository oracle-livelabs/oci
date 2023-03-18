
# Introduction

Estimated time: 120 minutes

### Goal: Create an API Portal with APIs from OCI API Gateway, Oracle Integration or Cloud Native 

With the following features:
- API Origin. The Portal will shows APIs from:
    - OCI API Gateway
    - Oracle Integration 
    - Cloud Native applications using Virtual Machines, Kubernetes, ...
    - ...
- API type:
    -  Any API specification type is allowed: REST (OpenAPI) or SOAP (WSDL), ...
- Git Integration:
    - The APIs are linked to GIT where the API source code is stored.

![Introduction Usecase](images/apim-intro.png)

### Architecture

![Architecture](images/apim-architecture.png)

### How it works

The APIs definitions are stored in a database. The user interface is developed with Oracle APEX. 

The APIs database can be populated in 2 ways:
- For existing APIS, by collecting (harvesting) all APIs definition 
- For new APIs, during a CI/CD DevOps pipeline, via a command line tool to add the new API in the Portal

### Objectives

- Create an Autonomous to install the APEX Application
- Install the APEX program
- Test the solution with 
  - Oracle Integraton
  - API Gateway
  - Cloud Native program 

## Acknowledgements 

- **Author**
    - Marc Gueury
