# Run Sensor Data Simulator

## Introduction

This workshop uses OCI Data Flow to run applications with the resources provisioned in Lab 1.

Estimated time: 10 minutes

### Objectives

* Run sensor data streaming simulator in OCI Data Flow

### Prerequisites

* Completion of the preceding labs in this workshop

## Task1: Verify artifacts.

1. Go to OCI Object Storage Console (aka. hamburger menu) in the Oracle Cloud console, and select **Storage ** > **Buckets**.

   ![Oracle Cloud console, a](images/object storage menu.png " ")

2. Select dataflow-labs compartment in left side and select dataflow-labs bucket

   ![Oracle Cloud console, Dataflow](images/object-storage-bucket.png " ")

3. Select object demo.
   ![Oracle Cloud console, Dataflow](images/demo object.png " ")

4. Select artifacts object and verify application.conf object is available
   ![Oracle Cloud console, Dataflow](images/artifacts object.png " ")

## Task2: Run Streaming Simulator

1. Go to OCI Data Flow Console (aka. hamburger menu) in the Oracle Cloud console, and select **Analytics & AI ** > **Data Flow**.

   ![Oracle Cloud console, Dataflow](images/dataflow-menu.png " ")

2. Click RULSurvivalModelTrainer Application.
   ![Oracle Cloud console, Dataflow](images/sensor-data-simulator.png " ")

3. Click Run button on top and click Run again
   ![Oracle Cloud console, Dataflow](images/sensor-data-simulator-run.png " ")

4. Run will be created with ACCEPTED state and IN PROGRESS.

   ![Oracle Cloud console, Dataflow](images/simulator-progress.png " ")

6. Click Spark UI, Job and Structured Streaming query

   ![Oracle Cloud console, Dataflow](images/simulator-streaming-job.png " ")
   ![Oracle Cloud console, Dataflow](images/simulator-streaming-query.png " ")
   ![Oracle Cloud console, Dataflow](images/simulator-streaming-query-detailed.png " ")

## Task3: Verify Simulator is streaming sensor data.

1. Go to OCI Streaming Console (aka. hamburger menu) in the Oracle Cloud console, and select **Analytics & AI ** > **Streaming**.

   ![Oracle Cloud console, Dataflow](images/streaming-menu.png " ")

2. Select dataflow-labs compartment in left side.

   ![Oracle Cloud console, Dataflow](images/stream.png " ")

3. Click sensor-data-simulator-stream.
   ![Oracle Cloud console, Dataflow](images/stream-details.png " ")

4. Click on Load Messages and verify we are receiving messages.
   ![Oracle Cloud console, Dataflow](images/stream-message.png " ")

You may now **proceed to the next lab**.

## Acknowledgements
- **Author** - Sujoy Chowdhury, Senior Principal Product Manager,
- **Contributors** - OCI Data Flow Sivanesh Selvanataraj, Senior Software Engineer, OCI Data Flow
- **Last Updated By/Date** - Sivanesh Selvanataraj, September 2022
