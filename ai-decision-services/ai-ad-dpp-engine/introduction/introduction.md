# Introduction

## About this Workshop

In this workshop, users will learn how to implement an end to end **Anomaly Detection** solution using a data pre-processing workflow engine.

## Objectives
This solution will allow you to configure a training pipeline and an inference pipeline in your tenancy, along with ingestion and preprocessing of your data. Input sizes could range from a few rows to several tens of millions of rows, and 1 column to several thousands of columns.


## Prerequisites

This lab assumes you have:
* An Oracle Free Tier, or Paid Cloud Account.
* Familiar with services on Oracle Cloud Infrastructure (OCI), such as Object Storage, Identity, Virtual Cloud Network, etc. 
* Familiar with Python (or other programming language) is strongly recommended.
* Experience with data engineering, machine learning and statistics is preferred but not required. 
* Additional prerequisites (if any) are described in each lab.


## All Tasks
* Pre-requisites
* Set up OCI Anomaly Detection (AD)
* Set up Policies
* Preparation code, config, library and datasets
* Set up OCI Data Flow
* Set up OCI Function 
* Set up OCI Events
* Running the solution end to end

## Workflow Introduction

![Functional Architecture](./images/workflow.png)

A brief description of the workflow

1.  Prepare the driver config and upload it to the config bucket. Also, create **anomaly detection** application which will be used later.
2.  Upload a training/inferencing dataset to the input source bucket.
3.  OCI Events Service will be configured as a listener on the source bucket. Uploading a data file into this bucket will trigger an OCI Event.
4.  OCI event will trigger the downstream Orchestrator deployed on OCI Function, which will load the driver config and start the workflow.
5.  The workflow will run based on the driver config.
6.  As soon as the data processing workflow completes successfully, the processed data with other informations (for example, model\_info) will be written to the staging bucket.
7.  Post processing, i.e. AD training/inferencing in our example, will begin to run. 
8.  Once post processing is done, the result will be written to the result bucket.

**NOTE**:

*   Pipelines are triggered when new files are added to the input data source. For example, uploading a new training dataset into the assigned object storage bucket will trigger the pipeline.
*   The workflow engine will execute the pipeline based on the configuration file.
    *   Once the raw data is preprocessed, the transformed data will be saved in the configured staging bucket.
    *   AD service will be triggered afterward to perform training or detection, and the results will be available in the configured results bucket.
*   Users can utilize more computational power in order to run the pipelines faster. This is very easy to configure as well.

### Supported Input Sources and Formats

*   Tables stored in ATP/ADW databases
*   CSV/Parquet file formats in Object Storage

**Note**: while the pipelines are triggered by updates, they work on point-in-time snapshots of the data. Users are advised to update database sources (tables) in a single transaction to avoid processing data in a partial state.

### Supported Output Source and Formats

Output is always saved to Object Storage as a CSV file.

## Learn More


* [Introduction to all transformers](../optional/Introduction-to-Transformers-for-Data-Preprocessing.md)

## Acknowledgements
* **Author**
    * Shreyas Vinayakumar - Principal Member of Technical Staff - Oracle AI Services
    * Shujie Chen - Principal Member of Technical Staff - Oracle AI Services
    * Sudha Ravi Kumar Javvadi - Member of Technical Staff - Oracle AI Services

* **Last Updated By/Date**
    * Shujie Chen - Principal Member of Technical Staff - Oracle AI Services
