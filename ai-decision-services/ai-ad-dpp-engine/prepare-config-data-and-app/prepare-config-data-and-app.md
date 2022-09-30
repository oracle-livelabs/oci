
Lab 3: Preparation code, config, library and datasets
===

Ensure the following resources are setup properly before proceeding to configure infrastructure resources:

*   Orchestration configuration
*   Driver code (Orchestrator)
*   Training/Inferencing datasets
*   Library (Archive.zip)

## Orchestration Configuration

This is a JSON file that defines the Data Pre-Processing (DPP) workflow. The configuration is composed of the following 5 parts.

<table class="wrapped confluenceTable"><colgroup><col><col></colgroup><tbody><tr><th class="confluenceTh">Section Name</th><th class="confluenceTh">Explanation</th></tr><tr><td class="confluenceTd">inputSources</td><td class="confluenceTd">Connector for input data sources. Currently we support reading data from Object Storage, ATP and ADW.</td></tr><tr><td class="highlight-blue confluenceTd" data-highlight-colour="blue">phaseInfo<td class="highlight-blue confluenceTd" data-highlight-colour="blue">A flag specifies whether it's training or inferencing, and connector to metadata source.</td></tr><tr><td class="confluenceTd">processingSteps</td><td class="confluenceTd">Data preprocessing transformers and related input arguments.</td></tr><tr><td class="highlight-blue confluenceTd" data-highlight-colour="blue">stagingDestination</td><td class="highlight-blue confluenceTd" data-highlight-colour="blue">Connector for intermediate processed data storage, which will be used in post-processing steps.</td></tr><tr><td class="confluenceTd">outputDestination</td><td class="confluenceTd">Connector for final output.</td></tr><tr><td class="highlight-blue confluenceTd" data-highlight-colour="blue">serviceApiConfiguration (Optional)</td><td class="highlight-blue confluenceTd" data-highlight-colour="blue">Configuration required for post-processing steps. For example, arguments for anomaly detection client.</td></tr></tbody></table>

## inputSources

The input data source configuration.

*   **dataframeName** - the variable name of this data frame will be used in the whole context.
*   **type** - can either be **object-storage** or **oracle**.
*   **isEventDriven** - (optional) This is an optional parameter whose default value is _false_. It takes a boolean value of _true_ is provided if the input source needs to be taken from a configured event. Note that currently, it is only supported for Object Storage emitted events.
*   For object storage, you will require:
    *  **namespace** \- the namespace of the target object storage bucket. 
    *   **bucket** - the bucket name. 
    *   **objectName** \- the full path and name of the object. This can also be a prefix with star (\*) when _isEventDriven_ is provided with _true_ value, where the object generating the event is considered and attempted to read if the name matches the provided expression. For example, updating object with name _anomalies/test.csv_ can generate an event and can be captured by using _anomalies/\*_ as the objectName, provided isEventDriven is set to true. Also, note that anything after \* is ignored in our current version and we will add more functionality in upcoming sprints.
*   For oracle, you will require:
    *   **adbId** \- the OCID of your ADW application. 
    *   **tableName** \- name of the table. 
    *   **connectionId** \- the format is **<DBName>\_high**, which can be found under tnsnames.ora of [Wallet](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/connect-download-wallet.html#GUID-B06202D2-0597-41AA-9481-3B174F75D4B1). 
    *   **user** \- the owner of the table. In most cases it will be **admin**. 
    *   **password** \- the password you setup when you download the Wallet. 

## phaseInfo (optional)

This will define the location where we store the metadata we gained from training phase for data dependent processes, like **one_hot_encoding**.

*   **connector** - the connector to object storage. It will be composed of
    *   **namespace** - the namespace of the target object storage bucket. Required if it is for object storage.
    *   **bucket** - the bucket name. Required if it is for object storage.
    *   **objectName** \- the full path and name of the object. Required if it is for object storage.

## processingSteps

This section lists transformations that need to be applied to the input data sets. This is the core of the data processing. Every item in the list is a step, and all the steps will be executed in sequence, one after another. 

Users should ensure the data processing steps are configured properly in the right sequence otherwise the workflow might fail and throw exceptions. DPP does not validate the individual data processing steps prior to executing the workflow.

*   **stepType** \- can be either **singleDataFrameProcessing** (for transforming on top of single dataframe) or **combineDataFrames** (for merging or joining two dataframes).
*   **configurations** - the configuration related to the step you take, which will include:
    *   **dataframeName** - a name you given to the output of the transformation.
    *   **steps** - a list of all transformers you want to apply to your target dataframe at this time. For each step, there will be:
        *   **stepName** - the name of the transformer you want to apply. It must exactly matches the one you defined in archive. For the full list of offered transformers, please check **Appendix II: List of Transformers**.
        *   **args** \- all the arguments required for the transformer you choose to use. For details about it, check **Appendix II: List of Transformers**.

## stagingDestination

This is the location where intermediate results will be stored before post processing steps begin. Basically these will be dataframes stored in csv format at an assigned object storage bucket. 

*   **combinedResult (optional)** - The name of the data frame to output. Specify this parameter only when a single data frame needs to be output. However, if sharding is desired/configured, the sharded dataset will be output automatically. In this case, there is no need to specify this parameter.
*   **type** \- only **object storage** is supported at present.
*   **namespace** - the namespace of the target object storage bucket. 
*   **bucket** \- the bucket name. 
*   **objectName** \- the full path and name of the object. 

## outputDestination

This is where the final output (AD results) and model information (model_info) is stored after inferencing.

*   **type** \- only **object storage** is supported at present.
*   **namespace** - the namespace of the target object storage bucket. 
*   **bucket** \- the bucket name. 
*   **objectName** \- the full path and name of the object. 

## serviceApiConfiguration

This configuration is used after data preprocessing steps. Here we will use it for AD related configuration:

* **serviceEndpoint** - this is the region specific endpoint for AD service. Use **null** for now.
* **profileName** - use **"DEFAULT"** for now. This is used for local runs to specify the OCI SDK profile to use from ~/.oci
* **projectId** - ocid of AD project from Lab 2.
* **compartmentId** - user's compartment Id.

## Example

A basic template to get you started:

**Training config**

```java
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

**Inferencing config** 

```java
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
    },
    "serviceApiConfiguration": {
        "anomalyDetection": {
            "serviceEndpoint": null,
            "profileName": "DEFAULT",
            "projectId": "<ad-project-id>",
            "compartmentId": "<your-compartment-ocid>",
            "modelId": "<>"
        }
    }
}
```

  

## Driver code

This is an executable built by OCI AI Services team and provided to users. The latest driver code can be downloaded from here: [link](https://github.com/bug-catcher/oci-data-science-ai-samples/blob/master/ai_services/anomaly_detection/data_preprocessing_examples/oci_data_flow_based_examples/example_code/df_driver.py).

## Training/Inferencing datasets

Attached are a set of training and testing (/inference) data files in CSV and Parquet formats.

[TestData.csv](./files/TestData.csv) [TrainData.csv](./files/TrainData.csv) [TrainData.parquet](./files/TrainData.parquet)

## Library

Library is an archive.zip incorporating transformers and user defined functions. Here is the link of an introduction to the [transformers](../optional/Introduction-to-Transformers-for-Data-Preprocessing.md) in this bucket. And here is a [doc](https://github.com/bug-catcher/oci-data-science-ai-samples/blob/master/ai_services/anomaly_detection/data_preprocessing_examples/oci_data_flow_based_examples/prepackaged_dataflow_applications.md) describing how to generate an archive.

For this lab, use the archive below.
[Archive link](https://objectstorage.us-phoenix-1.oraclecloud.com/p/kUGPXE9HB_BtgpCqe7jyOUUD_rorNiHD0HWsIR52r4KN4axrHpidLnBo4y1Nsnb-/n/ax3dvjxgkemg/b/archive-bucket/o/archive.zip)