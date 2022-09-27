# Train the model 

## Introduction

This workshop uses OCI Data Flow to run AFT Machine Learning Model to predict Remaining Useful Life (RUL) using Apache Spark applications with the resources provisioned in Lab 1.

Estimated time: 20 minutes

### Objectives

* Run machine learning model in OCI Data Flow

### Prerequisites

* Completion of the preceding labs in this workshop

## Task1: Verify artifacts.

1. Go to OCI Object Storage Console (aka. hamburger menu) in the Oracle Cloud console, and select **Storage ** > **Buckets**.

   ![Oracle Cloud console, Dataflow](images/object%20storage%20menu.png " ")

2. Select ```dataflow-labs``` compartment in left side and select ```dataflow-labs``` object storage bucket

   ![Oracle Cloud console, Dataflow](images/object-storage-bucket.png " ")

3. Click on the object ```demo```.
   ![Oracle Cloud console, Dataflow](images/demo%20object.png " ")

4. Click ```artifacts``` object and verify ```application.conf``` object is available.
   ![Oracle Cloud console, Dataflow](images/artifacts%20object.png " ")

## Task2: Run Machine Learning Model 

1. Go to OCI Data Flow Console (aka. hamburger menu) in the Oracle Cloud console, and select **Analytics & AI ** > **Data Flow**.

   ![Oracle Cloud console, Dataflow](images/dataflow-menu.png " ")

2. Click ```RULSurvivalModelTrainer``` OCI Data Flow Application. 
   ![Oracle Cloud console, Dataflow](images/RULSurvivalModelTrainer.png " ")

3. Click ```Run``` button on top and confirm by clicking ```Run``` again.
   ![Oracle Cloud console, Dataflow](images/RunSurvivalModelTrainer-1.png " ")
   
4. OCI Data Flow Run will be created with ACCEPTED state under ```RUNS``` resources.

  ![Oracle Cloud console, Dataflow](images/model-accepted.png " ")

5. Wait for approximately 2-3 minutes for OCI Data Flow RUN to move from ACCEPTED TO IN PROGRESS state.

6. Click on the run with IN PROGRESS state.
   
  ![Oracle Cloud console, Dataflow](images/model-progress.png " ")

6. Click Spark UI to explore Spark UI Options.

  ![Oracle Cloud console, Dataflow](images/model-sparkui.png " ")

7. Wait for run to complete, it will take approximately 4-6 minutes.

   ![Oracle Cloud console, Dataflow](images/model-succeeded.png " ")

## Task3: Verify RUL survival model is created.

1. Go to OCI Object Storage Console (aka. hamburger menu) in the Oracle Cloud console, and select **Storage ** > **Buckets**.

   ![Oracle Cloud console, Dataflow](images/object%20storage%20menu.png " ")

2. Select ```dataflow-labs``` compartment in left side and select ```dataflow-labs``` bucket

   ![Oracle Cloud console, Dataflow](images/object-storage-bucket.png " ")

3. Select object ```demo```.
   ![Oracle Cloud console, Dataflow](images/demo%20object.png " ")

4. Select ```models``` object and verify three folder as shown below
   ![Oracle Cloud console, Dataflow](images/models.png " ")

5. Expand and verify models in parquet file format with associated metadata.
   ![Oracle Cloud console, Dataflow](images/models-expanded.png " ")
   
You may now **proceed to the next lab**.

## Acknowledgements
- **Author** -  Sivanesh Selvanataraj, Software Engineer, OCI Data Flow
- **Contributors** - Sujoy Chowdhury, Product Manager, OCI Data Flow
- **Last Updated By/Date** - Sivanesh Selvanataraj, September 2022
