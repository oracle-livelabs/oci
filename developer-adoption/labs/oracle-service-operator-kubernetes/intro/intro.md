# Introduction

## What is the OCI Service Operator for Kubernetes 

The OCI Service Operator for Kubernetes (OSOK) makes it easy to create, manage, and connect to Oracle Cloud Infrastructure (OCI) resources from a Kubernetes environment. Kubernetes users can simply install OSOK and perform actions on OCI resources using the Kubernetes API removing the need to use the [OCI CLI](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cliconcepts.htm) or other[OCI developer tools](https://docs.oracle.com/en-us/iaas/Content/devtoolshome.htm) to interact with the service API. 

OSOK is based on the [Operator Framework](https://operatorframework.io/), an open-source toolkit used to manage Operators. It uses the [controller-runtime](https://github.com/kubernetes-sigs/controller-runtime) library, which provides high-level APIs and abstractions to write operational logic and also provides tools for scaffolding and code generation for Operators.

## Tutorial Overview: Deploy OSOK on OCI Container Engine for Kubernetes (OKE)
In this tutorial, you will create an OCI Container Engine for Kubernetes (OKE) cluster. You then will install the Operator SDK to your local machine. Followed by installing the Operator Lifecycle Manager (OLM). And then you will deploy the Oracle Service Operator for Kubernetes (OSOK) to your Kubernetes cluster. Finally, you will connect to the following OCI services:

- MySQL DB System Service 
- Autonomous Database Service

Estimated time: 60 minutes


### Prerequisites

1. An Oracle Free Tier(Trial), Paid or LiveLabs Cloud Account
2. [Familiarity with OCI console](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm)
3. [OCI CLI Installation on your local machine](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm)


You may now [proceed to the next lab](#next).

## Learn More

* [Cloud Native on OCI using MuShop sample](https://oracle-quickstart.github.io/oci-cloudnative/)
* [Reference Architecture: Deploy a microservices-based application in Kubernetes](https://docs.oracle.com/en/solutions/cloud-native-ecommerce/index.html#GUID-CB180453-1F32-4465-8F27-EA7300ECF771)


## Acknowledgements

* **Author** - Rishi Johari
* **Contributors** -  Mickey Boxell
* **Last Updated By/Date** - Rishi Johari, September 2021
