Lab 4: Configure DPF Driver
===

In this Lab, users will create a *Driver* configuration which will be used for preprocessing data and then running AD model Training or Inference. The Data Pre-Processing Framework (DPF) driver provided by the Oracle AI Services team will read this configuration and use it to ingest data from configured data sources, execute the processing steps (run data transformers) and perform OCI Anomaly Detection Model Training or run Inference.

A brief description of the configuration file sections and their syntax is provided below.

## 1. Examine Driver Configuration File

This is a JSON file that defines the DPF workflow. The configuration is composed of the following 5 parts.


<table class="wrapped confluenceTable"><colgroup><col><col></colgroup><tbody><tr><th class="confluenceTh">Section Name</th><th class="confluenceTh">Explanation</th></tr><tr><td class="confluenceTd">inputSources</td><td class="confluenceTd">Connector for input data sources. Currently we support reading data from Object Storage, ATP and ADW.</td></tr><tr><td class="highlight-blue confluenceTd" data-highlight-colour="blue">phaseInfo<td class="highlight-blue confluenceTd" data-highlight-colour="blue">A flag specifies whether it's training or inferencing, and connector to metadata source.</td></tr><tr><td class="confluenceTd">processingSteps</td><td class="confluenceTd">Data preprocessing transformers and related input arguments.</td></tr><tr><td class="highlight-blue confluenceTd" data-highlight-colour="blue">stagingDestination</td><td class="highlight-blue confluenceTd" data-highlight-colour="blue">Connector for intermediate processed data storage, which will be used in post-processing steps.</td></tr><tr><td class="confluenceTd">outputDestination</td><td class="confluenceTd">Connector for final output.</td></tr><tr><td class="highlight-blue confluenceTd" data-highlight-colour="blue">serviceApiConfiguration</td><td class="highlight-blue confluenceTd" data-highlight-colour="blue">Configuration required for post-processing steps. For example, arguments for anomaly detection client.</td></tr></tbody></table>

### inputSources

The input data source configuration.

*   **dataframeName** - The variable name of a data frame which will be used in the execution context.
*   **type** - Input Source Type.  Supported types are **object-storage** (OCI Object Storage) and **oracle** (Oracle Database - ADB, ATP, ADW).
*   **isEventDriven** - (optional) Is the DPF Driver *Event* driven. This is an optional parameter whose default value is *false*. If set to *true*, the Driver will be triggered by a pre-configured OCI Event. Note that this option is currently only supported for Object Storage emitted events.
*   For OCI Object Storage, the following fields/elements are required.
    *  **namespace** \- The *Namespace* of the Object Storage Bucket. 
    *   **bucket** - The Bucket *Name*. 
    *   **objectName** \- Full path including name of the file object. The name can also be a wildcard *star* (\*) when *isEventDriven* is set to *true*. In this case, when a file is uploaded into the bucket folder matching the configured path and the wildcard expression, the file will be picked up by the Driver for processing. For example, assume *isEventDriven* is set to *true* and this value is set to *anomalies/\*.  When a file is uploaded into folder *anomalies/\*, the Driver will receive a file creation event and will pick up the file for processing. Also, note that anything after \* is ignored.

*   For Oracle ADW/ATP sources, the following fields/elements are required.
    *   **adbId** \- The OCID of ADW/ATP instance. 
    *   **tableName** \- Name of the database table. 
    *   **connectionId** \- Connection ID string.  This value can be found in file tnsnames.ora of [Wallet](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/connect-download-wallet.html#GUID-B06202D2-0597-41AA-9481-3B174F75D4B1) file.
    *   **user** \- ATP/ADW user name. 
    *   **password** \- ATP/ADW user password.

### phaseInfo

This defines the location where the application will store the metadata from training phase for data dependent processes, like *one_hot_encoding*.

*   **connector** - The connector to OCI Object Storage. The fields/elements below are required.
    *   **namespace** - The namespace of Object Storage Bucket. Required if it is for object storage.
    *   **bucket** - The Bucket *Name*. Required if it is for object storage.
    *   **objectName** \- The full path and name of the file object. Required if it is for object storage.

### processingSteps

This section lists transformations that need to be applied to the input data sets. This is the core of the data processing. Every item in the list is a step, and all the steps will be executed in sequence, one after another. 

Users should ensure the data processing steps are configured properly in the right sequence otherwise the workflow might fail and throw exceptions. DPF does not validate the individual data processing steps prior to executing the data flow.

*   **stepType** \- Can be either **singleDataFrameProcessing** (for transforming on top of single dataframe) or **combineDataFrames** (for merging or joining two dataframes).
*   **configurations** - The configuration for transformations, which will include
    *   **dataframeName** - A name to be given to the output of the transformation.
    *   **steps** - a list of all transformers you want to apply to your target dataframe. For each step, there should be
        *   **stepName** - The name of the transformer to be applied. It must exactly match a **Transformer** name as defined in the library(archive). For the full list of transformers, please refer to the document included within the **Useful Resources** section below.
        *   **args** \- All required arguments for the transformer.

### stagingDestination

This is the location where intermediate results will be stored before training/inference begins. Basically, these will be dataframes stored in csv format at the configured Object Storage Bucket. 

*   **combinedResult** - The name of the data frame to output. 
    * Specify this parameter only when a single data frame needs to be output. 
    * If sharding is desired/configured, the sharded dataset will be output automatically. In this case, there is **no need** to specify this parameter.
*   **type** \- Only **object storage** is supported at present.
*   **namespace** - The namespace of the Object Storage Bucket. 
*   **bucket** \- Bucket name. 
*   **folder** \- Folder name prefix where the intermediate results will be stored.

### outputDestination

This is where the final output (Anomaly Detection results) and model information (model_info) is stored after inferencing or model training.

*   **type** \- Only **object storage** is supported at present.
*   **namespace** - The namespace of the Object Storage Bucket. 
*   **bucket** \- The Bucket name. 
*   **objectName** \- The full path and name of the object. This will be used for training phase for storing the model information. 
*   **folder** \- The name of the folder where the inferencing result will be stored.

### serviceApiConfiguration

This is used for configuring OCI Anomaly Detection(AD) Service

* **serviceEndpoint** - This is the region specific endpoint for AD service. Use **null** for now.
* **profileName** - Use **"DEFAULT"** for now. This is used for local runs to specify the OCI SDK profile to use from ~/.oci
* **projectId** - OCID of Anomaly Detection Project from **Lab 1**.
* **compartmentId** - OCID of OCI Compartment from **Lab 2**.

## 2. Update Driver Configuration Files

Driver configuration files (Json) used in this workshop are provided below.

**Training Configuration**

```json
<copy>
{
    "inputSources": [
        {
            "dataframeName": "S1",
            "type": "object-storage",
            "namespace":"<your-namespace>",
            "bucket":"training-data-bucket",
            "objectName": "TrainData.csv"
        }
    ],
    "phaseInfo": {
        "connector": {
            "namespace":"<your-namespace>",
            "bucket":"output-bucket",
            "objectName": "metadata.json"
        }
    },
    "processingSteps": [
        {
            "stepType": "singleDataFrameProcessing",
            "configurations": {
                "dataframeName": "S1",
                "steps": [
                    {
                        "stepName": "format_timestamp",
                        "args": {}
                    }
                ]
            }
        }
    ],
    "stagingDestination": {
        "combinedResult":"S1",
        "type": "object-storage",
        "namespace":"<your-namespace>",
        "bucket": "staging-bucket",
        "folder": "training_processed_data"
    },
    "outputDestination": {
        "type": "object-storage",
        "namespace":"<your-namespace>",
        "bucket": "output-bucket",
        "objectName": "model_info.json",
        "folder":"processing_folder"
    },
    "serviceApiConfiguration": {
        "anomalyDetection": {
            "serviceEndpoint": null,
            "profileName": "DEFAULT",
            "projectId": "<ad-project-ocid>",
            "compartmentId": "<your-compartment-ocid>"
        }
    }
}
</copy>
```
1. Copy the contents of the configuration snippet above and paste it into a file named *training-config.json*.
2. Look up the namespace string by navigating to **Object Storage** and clicking on any bucket. The display panel will have a field called *Namespace*. Under the **inputSources**,**phaseInfo**, **stagingDestination** and **outputDestination** sections, populate the **namespace** field with this value. 
3. Populate **projectId** under **serviceApiConfiguration** with the OCI AD Project OCID from Lab 1.
4. Populate compartmentId with compartment OCID from **Lab 2**.

**Inferencing Configuration** 

```json
<copy>
{
    "inputSources": [
        {
            "dataframeName": "S1",
            "type": "object-storage",
            "namespace":"<your-namespace>",
            "bucket":"inferencing-data-bucket",
            "objectName": "TestData.csv"
        }
    ],
    "phaseInfo": {
        "connector": {
            "namespace":"<your-namespace>",
            "bucket":"output-bucket",
            "objectName": "metadata.json"
        }
    },
    "processingSteps": [
        {
            "stepType": "singleDataFrameProcessing",
            "configurations": {
                "dataframeName": "S1",
                "steps": [
                    {
                        "stepName": "format_timestamp",
                        "args": {}
                    }
                ]
            }
        }
    ],
    "stagingDestination": {
        "combinedResult":"S1",
        "type": "object-storage",
        "namespace":"<your-namespace>",
        "bucket": "staging-bucket",
        "folder": "training_processed_data"
    },
    "outputDestination": {
        "type": "object-storage",
        "namespace":"<your-namespace>",
        "bucket": "output-bucket",
        "objectName": "model_info.json",
        "folder":"processing_folder"
    },
    "serviceApiConfiguration": {
        "anomalyDetection": {
            "serviceEndpoint": null,
            "profileName": "DEFAULT",
            "projectId": "<ad-project-id>",
            "compartmentId": "<your-compartment-ocid>"
        }
    }
}
</copy>
```

1. Copy the contents of the configuration snippet above and paste it into a file named *inference-config.json*.
2. Look up the namespace string by navigating to **Object Storage** and clicking on any bucket. The display panel will have a field called namespace. Under the **inputSources**,**phaseInfo**, **stagingDestination** and **outputDestination** sections, populate the **namespace** field with this value. 
3. Populate **projectId** under **serviceApiConfiguration** with the AD project OCID from Lab 1.
4. Populate compartmentId with compartment OCID from **Lab 2**.

## 3. Upload Driver Configuration Files
*   Upload OCI AD model training configuration file into **training-config-bucket** in OCI Object Storage Bucket, created in **Lab 4**.
*   Upload OCI AD inferencing configuration file into **inferencing-config-bucket**.

## Useful Resources

- [List of available Data Flow Transformers](https://github.com/ganrad/oci/blob/main/ai-decision-services/ai-ad-dpp-engine/optional/Introduction-to-Transformers-for-Data-Preprocessing.md)

[Go to *Lab 3*](#prev) | [Go to *Lab 5*](#next)
