# Run Sensor Data Simulator

## Introduction

This workshop uses OCI Data Flow to produce sensor data using an Apache Spark application with the resources provisioned in Lab 1.

Estimated time: 15 minutes

### Objectives

* Run sensor data streaming simulator(producer) in OCI Data Flow to OCI Streaming.

### Prerequisites

* Completion of the preceding labs in this workshop

## Task 1: Verify artifacts.

1. Go to OCI Object Storage Console (aka. hamburger menu) in the Oracle Cloud console, and select **Storage ** &gt; **Buckets**.

   ![Oracle Cloud console, a](images/object-storage-menu.png " ")

2. Select the ```dataflow-labs``` compartment on the left side and select the ```dataflow-labs``` bucket.

   ![Oracle Cloud console, Dataflow](images/object-storage-bucket.png " ")

3. Select object demo from object storage.
   ![Oracle Cloud console, Dataflow](images/demo-object.png " ")

4. Select ```artifacts``` object and verify the ```application.conf``` object is available.
   ![Oracle Cloud console, Dataflow](images/artifacts-object.png " ")

## Task 2: Run Streaming Simulator

1. Go to OCI Data Flow Console (aka. hamburger menu) in the Oracle Cloud console, and select **Analytics & AI ** &gt; **Data Flow**.

   ![Oracle Cloud console, Dataflow](images/dataflow-menu.png " ")

2. Click ```SensorDataSimulator``` OCI Data Flow Application.
   ![Oracle Cloud console, Dataflow](images/sensor-data-simulator.png " ")

3. Click the ```Run``` button on top and confirm by clicking ```Run``` again.
   ![Oracle Cloud console, Dataflow](images/sensor-data-simulator-run.png " ")

4. Run will be created with ACCEPTED and moved to IN PROGRESS state.

   ![Oracle Cloud console, Dataflow](images/simulator-progress.png " ")

6. Click Spark UI, Job, and ```Structured Streaming query```

   ![Oracle Cloud console, Dataflow](images/streaming-jobs.png " ")
   ![Oracle Cloud console, Dataflow](images/spark-ui-streaming-query.png " ")
   ![Oracle Cloud console, Dataflow](images/streaming-ui.png " ")

## Task 3: Verify Simulator is streaming sensor data.

1. Go to OCI Streaming Console (aka. hamburger menu) in the Oracle Cloud console, and select **Analytics & AI ** &gt; **Streaming**.

   ![Oracle Cloud console, Dataflow](images/streaming-menu.png " ")

2. Select the ```dataflow-labs``` compartment on the left side.

   ![Oracle Cloud console, Dataflow](images/stream.png " ")

3. Click ```sensor-data-simulator-stream``` streams.
   ![Oracle Cloud console, Dataflow](images/stream-details.png " ")

4. Click on ```Load Messages``` and verify we are receiving messages.
   ![Oracle Cloud console, Dataflow](images/stream-message.png " ")

You may now **proceed to the next lab**.

## Acknowledgments
- **Created By** -  Sivanesh Selvanataraj, Senior Software Engineer, OCI Data Flow
- **Contributors** - Sujoy Chowdhury, Senior Principal Product Manager, OCI Data Flow
- **Last Updated By/Date** - Sivanesh Selvanataraj, October 2022
