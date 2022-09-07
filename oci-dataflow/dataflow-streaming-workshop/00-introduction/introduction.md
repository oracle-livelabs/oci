# Introduction

## About this Workshop

One of the most common uses cases of predictive manitenance in manufacturing industry is predicting 
Remaining Useful Life (RUL) of equipment.This sample application demonstrates running streaming application with doing 
machine learning on top of it to predict RUL of equipment.

This budle has set of four spark applications,
1. RULSurvivalModelTrainer - Offline model trainer for predicting RUL.(Spark Batch)
2. SensorDataSimulator     - Random sensor data simulator for equipment.(Spark Streaming)
3. RealtimeRULPredictor    - Realtime RUL Predictor (Spark Streaming)
4. DeltaTable              - DeltaTable operations on predicted RUL (Spark Batch)

### Workshop Architecture
  ![Workshop Architecture](images/manufacturing_app_architecture.png " ")

Estimated Workshop Time: 65 minutes

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
* Create Apache Spark Batch application with Delta Table operations.  
* Explore Spark UI for batch and streaming applications.
* Access Spark driver, executor and application logs in realtime.
* Integrate with other OCI services such as OCI Streaming, OCI Object Storage, OCI Autonomous Databases, OCI Vault

### Prerequisites
* An Oracle Free Tier with a 30-day free trial or Paid Cloud Account - Please view this workshop's LiveLabs landing page to see which environments are supported. 

If you are running the workshop in a Paid Cloud Account, ensure you have the permissions below:
* Oracle Cloud resources and permissions to create a file system. See **[Creating File Systems](https://docs.oracle.com/en-us/iaas/Content/File/Tasks/creatingfilesystems.htm)** and **[Service Limits](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/servicelimits.htm#top)** in the Oracle Cloud documentation.
*	Oracle Cloud Account Administrator role or manage apm-domains permission in the target compartment. See **[Perform Oracle Cloud Infrastructure Prerequisites (APM)](https://docs.oracle.com/en-us/iaas/application-performance-monitoring/doc/perform-oracle-cloud-infrastructure-prerequisite-tasks.html)** in the Oracle Cloud documentation.

## Acknowledgements
- **Author** - Sujoy Chowdhury, Senior Principal Product Manager,
- **Contributors** - OCI Data Flow Sivanesh Selvanataraj, Senior Software Engineer, OCI Data Flow
- **Last Updated By/Date** - Sivanesh Selvanataraj, September 2022
