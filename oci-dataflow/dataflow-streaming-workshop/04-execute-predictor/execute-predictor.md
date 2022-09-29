# Run Remaining Useful Life (RUL) Predictor

## Introduction

This workshop uses OCI Data Flow to predicts realtime RUL using Apache Spark streaming application with the resources provisioned in Lab 1, Lab 2, Lab 3.

Estimated time: 15 minutes

### Objectives

* Run realtime Machine Learning prediction in OCI Data Flow

### Prerequisites

* Completion of the preceding labs in this workshop

## Task1: Verify artifacts.

1. Go to OCI Object Storage Console (aka. hamburger menu) in the Oracle Cloud console, and select **Storage ** > **Buckets**.

   ![Oracle Cloud console, a](images/object%20storage%20menu.png " ")

2. Select ```dataflow-labs``` compartment in left side and select ```dataflow-labs``` bucket

   ![Oracle Cloud console, Dataflow](images/object-storage-bucket.png " ")

3. Select object ```demo```.
   ![Oracle Cloud console, Dataflow](images/demo%20object.png " ")

4. Select ```artifacts``` object and verify ```application.conf``` object is available
   ![Oracle Cloud console, Dataflow](images/artifacts%20object.png" ")

## Task2: Run Realtime Predictor

1. Go to OCI Data Flow Console (aka. hamburger menu) in the Oracle Cloud console, and select **Analytics & AI ** > **Data Flow**.

   ![Oracle Cloud console, Dataflow](images/dataflow-menu.png " ")

2. Click ```RealtimeRULPredictor``` Application.
   ![Oracle Cloud console, Dataflow](images/predictor.png " ")

3. Click ``Run`` button on top and confirm by clicking ```Run``` again
   ![Oracle Cloud console, Dataflow](images/predictor-run.png " ")

4. Run will be created with ACCEPTED state

   ![Oracle Cloud console, Dataflow](images/predictor-run.png " ")

5. In 2-3 minutes state of OCI Data Flow run will be moved to IN PROGRESS

   ![Oracle Cloud console, Dataflow](images/predictor-progress.png " ")


## Task3: Verify delta table and parquet table.

1. Go to OCI Object Storage Console (aka. hamburger menu) in the Oracle Cloud console, and select **Storage ** > **Buckets**.

   ![Oracle Cloud console, Object Storage](images/object%20storage%20menu.png " ")

2. Select dataflow-labs compartment in left side and select dataflow-labs bucket

   ![Oracle Cloud console, Object Storage](images/object-storage-bucket.png " ")

3. Select object demo.
   ![Oracle Cloud console, Object Storage](images/demo%20object.png " ")

4. Predicted RUL DeltaTable and ParquetTable
   ![Oracle Cloud console, Object Storage](images/sinks.png " ")


## Task4: Verify Autonomous Database.

1. Go to OCI Oracle Database Console (aka. hamburger menu) in the Oracle Cloud console, and select **Oracle Database ** > **Autonomous Data Warehouse**.

   ![Oracle Cloud console, Autonomous Database](images/adb_menu.png " ")

2. Select dataflow-labs compartment in left side and select manufacturing autonomous database instance

   ![Oracle Cloud console, Autonomous Database](images/adb_manufacturing.png " ")

3. Click on manufacturing autonomous database and click on Database Actions button.
   ![Oracle Cloud console, Autonomous Database](images/abd_details.png " ")

4. Select SQL developer tool
   ![Oracle Cloud console, Autonomous Database](images/adb_sql_tool.png " ")

5. Select PREDICTED_RUL_ALERTS table
   ![Oracle Cloud console, Autonomous Database](images/adb_fields.png " ")
   
6. Click on Data to see predicted RUL data.
   ![Oracle Cloud console, Autonomous Database](images/adb_data.png " ")

7. Alternate to step 5. you can write SQL queries to fetch data from PREDICTED_RUL_ALERTS table.
   ![Oracle Cloud console, Autonomous Database](images/adb_alternate_sql.png " ")


You may now **proceed to the next lab**.

## Acknowledgements
- **Author** -  Sivanesh Selvanataraj, Software Engineer, OCI Data Flow
- **Contributors** - Sujoy Chowdhury, Product Manager, OCI Data Flow
- **Last Updated By/Date** - Sivanesh Selvanataraj, September 2022
