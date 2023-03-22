
# Introduction

Estimated time: 60 minutes

### Objective

Create an API Management Portal 

### Features

In this lab, we will create an API Management Portal with the following features:
- API Origin: The Portal will shows APIs from:
    - OCI API Gateway
    - Oracle Integration 
    - Cloud Native applications using Virtual Machines, Kubernetes, ...
- API type:
    -  Any API specification type is allowed: REST (OpenAPI) or SOAP (WSDL), ...
- Git Integration:
    - The APIs are linked to GIT where the API source code is stored.

![Introduction Usecase](images/apim-intro.png)

### Architecture

![Architecture](images/apim-architecture.png)

### How it works

The APIs definitions are stored in a database. The user interface is developed with Oracle APEX running in the same database.  

The APIs database can be populated in 2 ways:
- For new APIs, during a CI/CD DevOps pipeline, with "curl" to add the new API in the Portal
- For existing APIS, by discovering / collecting / harvesting APIs definition 

### Objectives

- Create an Autonomous to install the APEX Application
- Install the APEX program
- Test the solution with 
  - API Gateway
  - Cloud Native program 
  - Oracle Integration

## Acknowledgements 

- **Author**
    - Marc Gueury / Tom Bailiu / Valeria Chiran