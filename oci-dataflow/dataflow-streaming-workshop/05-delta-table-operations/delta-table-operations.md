# Run Sensor Data Simulator

## Introduction

This workshop uses OCI Data Flow to run applications with the resources provisioned in Lab 1, Lab2, Lab3 and Lab4.

Estimated time: 10 minutes

### Objectives

* Delta Table operations using OCI Data Flow on Predicted RUL delta table created in Lab 3

### Prerequisites

* Completion of the preceding labs in this workshop

## Task1: Verify delta table location.

1. Go to OCI Object Storage Console (aka. hamburger menu) in the Oracle Cloud console, and select **Storage ** > **Buckets**.

   ![Oracle Cloud console, a](images/object%20storage%20menu.png  " ")

2. Select dataflow-labs compartment in left side and select dataflow-labs bucket

   ![Oracle Cloud console, Dataflow](images/object-storage-bucket.png " ")

3. Select object demo.
   ![Oracle Cloud console, Dataflow](images/demo%20object.png " ")

4. Verify if delta table located in below location
    ![Oracle Cloud console, Object Storage](images/sinks.png " ")

## Task2: Run DeltaTable Operations

1. Go to OCI Data Flow Console (aka. hamburger menu) in the Oracle Cloud console, and select **Analytics & AI ** > **Data Flow**.

   ![Oracle Cloud console, Dataflow](images/dataflow-menu.png " ")

2. Click RULDeltaTable Application.
   ![Oracle Cloud console, Dataflow](images/RULDeltaTable.png " ")

3. Click Run button on top and click Run again
   ![Oracle Cloud console, Dataflow](images/RULDeltaTable-run.png " ")

4. Run will be created with ACCEPTED state
   ![Oracle Cloud console, Dataflow](images/RUL_DeltaTable_Accepted.png " ")
   
5. In 2-3 minutes OCI Data Flow run will be moved to IN PROGRESS

   ![Oracle Cloud console, Dataflow](images/delta-table-progress.png " ")

6. Click Spark UI, Job and DeltaTable operations

   ![Oracle Cloud console, Dataflow](images/DeltaTableSparkUI.png " ")


You may now **proceed to the next lab**.

## Acknowledgements
- **Author** - Sujoy Chowdhury, Senior Principal Product Manager, OCI Data Flow
- **Contributors** - OCI Data Flow Sivanesh Selvanataraj, Senior Software Engineer, OCI Data Flow
- **Last Updated By/Date** - Sivanesh Selvanataraj, September 2022
