# Introduction

## About this Workshop

One of the most common uses cases of predictive manitenance in manufacturing industry is predicting 
Remaining Useful Life (RUL) of equipment.This sample application demonstrates running streaming application with doing 
machine learning on top of it to predict RUL of equipment.

To demonstrate ,
1. RULSurvivalModelTrainer - Offline model trainer for predicting Remaining Useful Life using Apache Spark MLlib.
2. SensorDataSimulator     - Random sensor data simulator for equipment using Apache Spark Structured Streaming.
3. RealtimeRULPredictor    - Realtime RUL Predictor using Apache Spark Structured Streaming.
4. DeltaTable              - DeltaTable operations on predicted RUL Apache Spark and DeltaLake.

### Workshop Architecture
  ![Workshop Architecture](images/manufacturing_app_architecture.png " ")

Estimated Workshop Time: 120 minutes

### About Oracle Cloud Infrastructure Data Flow
Data Flow is a cloud-based serverless platform with a rich user interface. It allows data engineers and data scientists
to create, edit, and run Apache Spark workloads at any scale without the need for clusters, an operations team, or highly
specialized Spark knowledge. Being serverless means there is no infrastructure for you to deploy or manage.
It is entirely driven by REST APIs, giving you easy integration with applications or workflows. You can:

* Connect to Apache Spark data sources.
* Create reusable Apache Spark applications.
* Launch Apache Spark jobs in seconds.
* Create Apache Spark applications using SQL, Python, Java, Scala, or spark-submit.
* Manage all Apache Spark applications from a single platform.
* Process data in the Cloud or on-premises in your data center.
* Create Big Data building blocks that you can easily assemble into advanced Big Data applications.

The diagram below provides an overview of the OCI Data Flow Service, its features, components, and some of the other OCI services it integrates with.

![Data Flow Architecture](images/df_overview.png " ")

In the workshop, you will learn how to create spark batch and streaming application with manufacturing usecase example

### Objectives
In this workshop, you will:
* Create Apache Spark Machine Learning application and execute in OCI Data Flow.
* Create Apache Spark Structured Streaming applications and execute in OCI Data Flow.
* Create Apache Spark Batch application with Delta Table operations in OCI Data Flow. 
* Explore Spark UI for Apache Spark batch and structued streaming applications in OCI Data Flow.
* Access Spark driver,executor and application logs in realtime in OCI Data Flow.
* Integrate with other OCI services such as OCI Streaming, OCI Object Storage, OCI Autonomous Databases, OCI Vault.

### Prerequisites
* An Oracle Free Tier with a 30-day free trial or Paid Cloud Account - Please view this workshop's LiveLabs landing page to see which environments are supported. 

If you are running the workshop in a Paid Cloud Account, ensure you have the permissions below:
* Oracle Cloud Account Administrator role to manage polices, compartment, usergroup, resource manager.

## Acknowledgements
- **Author** -  Sivanesh Selvanataraj, Software Engineer, OCI Data Flow
- **Contributors** - Sujoy Chowdhury, Product Manager, OCI Data Flow
- **Last Updated By/Date** - Sivanesh Selvanataraj, September 2022
