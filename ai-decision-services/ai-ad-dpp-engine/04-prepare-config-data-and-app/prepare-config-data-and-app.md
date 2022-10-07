Lab 4: Configure DPF Driver
===

In this Lab, users will create a *Driver* configuration which will be used for preprocessing data and then running AD model Training or Inference. The Data Pre-Processing Framework (DPF) driver provided by the Oracle AI Services team will read this configuration and use it to ingest data from configured data sources, execute the processing steps (run data transformers) and perform OCI Anomaly Detection Model Training or run Inference.

A brief description of the configuration file sections and their syntax is provided below.

## Driver Configuration

This is a JSON file that defines the DPF workflow. The configuration is composed of the following 5 parts.

<table class="wrapped confluenceTable"><colgroup><col><col></colgroup><tbody><tr><th class="confluenceTh">Section Name</th><th class="confluenceTh">Explanation</th></tr><tr><td class="confluenceTd">inputSources</td><td class="confluenceTd">Connector for input data sources. Currently we support reading data from Object Storage, ATP and ADW.</td></tr><tr><td class="highlight-blue confluenceTd" data-highlight-colour="blue">phaseInfo<td class="highlight-blue confluenceTd" data-highlight-colour="blue">A flag specifies whether it's training or inferencing, and connector to metadata source.</td></tr><tr><td class="confluenceTd">processingSteps</td><td class="confluenceTd">Data preprocessing transformers and related input arguments.</td></tr><tr><td class="highlight-blue confluenceTd" data-highlight-colour="blue">stagingDestination</td><td class="highlight-blue confluenceTd" data-highlight-colour="blue">Connector for intermediate processed data storage, which will be used in post-processing steps.</td></tr><tr><td class="confluenceTd">outputDestination</td><td class="confluenceTd">Connector for final output.</td></tr><tr><td class="highlight-blue confluenceTd" data-highlight-colour="blue">serviceApiConfiguration</td><td class="highlight-blue confluenceTd" data-highlight-colour="blue">Configuration required for post-processing steps. For example, arguments for anomaly detection client.</td></tr></tbody></table>

### inputSources

The input data source configuration.

*   **dataframeName** - the variable name of this data frame will be used in the whole context.
*   **type** - can either be **object-storage** or **oracle**.
*   **isEventDriven** - (optional) This is an optional parameter whose default value is _false_. It takes a boolean value of _true_ is provided if the input source needs to be taken from a configured event. Note that this option is currently only supported for Object Storage emitted events.
*   For object storage, the following are required:
    *  **namespace** \- the namespace of the target object storage bucket. 
    *   **bucket** - the bucket name. 
    *   **objectName** \- the full path and name of the object. This can also be a prefix with star (\*) when _isEventDriven_ is provided with _true_ value, where the object generating the event is considered and attempted to read if the name matches the provided expression. For example, updating object with name _anomalies/test.csv_ can generate an event and can be captured by using _anomalies/\*_ as the objectName, provided isEventDriven is set to true. Also, note that anything after \* is ignored in our current version and we will add more functionality in upcoming sprints.
*   For Oracle ADW/ATP sources, the following are required:
    *   **adbId** \- the OCID of your ADW application. 
    *   **tableName** \- name of the table. 
    *   **connectionId** \- the format is **<DBName>\_high**, which can be found under tnsnames.ora of [Wallet](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/connect-download-wallet.html#GUID-B06202D2-0597-41AA-9481-3B174F75D4B1). 
    *   **user** \- the owner of the table. In most cases it will be **admin**. 
    *   **password** \- the password you setup when you download the Wallet. 

### phaseInfo

This defines the location where the application will store the metadata from training phase for data dependent processes, like **one_hot_encoding**.

*   **connector** - the connector to object storage. It will be composed of
    *   **namespace** - the namespace of the target object storage bucket. Required if it is for object storage.
    *   **bucket** - the bucket name. Required if it is for object storage.
    *   **objectName** \- the full path and name of the object. Required if it is for object storage.

### processingSteps

This section lists transformations that need to be applied to the input data sets. This is the core of the data processing. Every item in the list is a step, and all the steps will be executed in sequence, one after another. 

Users should ensure the data processing steps are configured properly in the right sequence otherwise the workflow might fail and throw exceptions. DPF does not validate the individual data processing steps prior to executing the workflow.

*   **stepType** \- can be either **singleDataFrameProcessing** (for transforming on top of single dataframe) or **combineDataFrames** (for merging or joining two dataframes).
*   **configurations** - the configuration related to the step to be taken, which will include:
    *   **dataframeName** - a name to be given to the output of the transformation.
    *   **steps** - a list of all transformers you want to apply to your target dataframe at this time. For each step, there will be:
        *   **stepName** - the name of the transformer to be applied. It must exactly matches the ones defined in the library(archive). For the full list of offered transformers, please check **Appendix II: List of Transformers**.
        *   **args** \- all the arguments required for the transformer you choose to use. For details about it, refer to **Appendix II: List of Transformers**.

### stagingDestination

This is the location where intermediate results will be stored before training/inference begins. Basically these will be dataframes stored in csv format at an assigned object storage bucket. 

*   **combinedResult** - The name of the data frame to output. 
    * Specify this parameter only when a single data frame needs to be output. 
    * If sharding is desired/configured, the sharded dataset will be output automatically. In this case, there is **no need** to specify this parameter.
*   **type** \- only **object storage** is supported at present.
*   **namespace** - the namespace of the target object storage bucket. 
*   **bucket** \- the bucket name. 
*   **folder** \- folder name prefix where you want to store your intermediate processed data.

### outputDestination

This is where the final output (AD results) and model information (model_info) is stored after inferencing.

*   **type** \- only **object storage** is supported at present.
*   **namespace** - the namespace of the target object storage bucket. 
*   **bucket** \- the bucket name. 
*   **objectName** \- the full path and name of the object. This will be used for training phase for storing the model information. 
*   **folder** \- the name of the folder where you want to store the inferencing result.

### serviceApiConfiguration

This configuration is used for Anomaly Detection(AD) specific options:

* **serviceEndpoint** - this is the region specific endpoint for AD service. Use **null** for now.
* **profileName** - use **"DEFAULT"** for now. This is used for local runs to specify the OCI SDK profile to use from ~/.oci
* **projectId** - OCID of AD project from Lab 2.
* **compartmentId** - user's compartment Id.

</details>

## 1. Update Driver Configuration Files

Driver configuration files used in this workshop are provided below.

**Training Configuration**

```
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
```
1. Copy the contents of the configuration snippet above and paste it into a file named training-config.json.
2. Look up the namespace string by navigating to **Object Storage** and clicking on any bucket. The display panel will have a field called namespace. Under the **inputSources**,**phaseInfo**, **stagingDestination** and **outputDestination** sections, populate the **namespace** field with this value. 
3. Populate **projectId** under **serviceApiConfiguration** with the OCI AD Project OCID from Lab 1.
4. Populate compartmentId with compartment OCID from **Lab 2**.

**Inferencing Configuration** 

```
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
            "compartmentId": "<your-compartment-ocid>",
        }
    }
}
```

1. Copy the contents of the configuration snippet above and paste it into a file named inference-config.json.
2. Look up the namespace string by navigating to **Object Storage** and clicking on any bucket. The display panel will have a field called namespace. Under the **inputSources**,**phaseInfo**, **stagingDestination** and **outputDestination** sections, populate the **namespace** field with this value. 
3. Populate **projectId** under **serviceApiConfiguration** with the AD project OCID from Lab 1.
4. Populate compartmentId with compartment OCID from **Lab 2**.

## 2. Upload Driver Configuration Files
*   Upload OCI AD model training configuration file into **training-config-bucket** in OCI Object Storage Bucket, created in **Lab 4**
*   Upload OCI AD inferencing configuration file into **inferencing-config-bucket**
