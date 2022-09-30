
Lab 3: Preparation code, config, library and datasets
===

Fundamentally, you will need the following things ready for setting up the whole infrastructure:

*   Orchestration configuration
*   Driver code (Orchestrator) - from our repo
*   Training/Inferencing datasets
*   Library (Archive.zip)

## Orchestration Configuration

This is a JSON file that defines the DPP workflow. The configuration is composed of the following 5 parts:

<table class="wrapped confluenceTable"><colgroup><col><col></colgroup><tbody><tr><th class="confluenceTh">Section Name</th><th class="confluenceTh">Explanation</th></tr><tr><td class="confluenceTd">inputSources</td><td class="confluenceTd">Connector for input data sources. Currently we support reading data from Object Storage, ATP and ADW.</td></tr><tr><td class="highlight-blue confluenceTd" data-highlight-colour="blue">phaseInfo<td class="highlight-blue confluenceTd" data-highlight-colour="blue">A flag specifies whether it's training or inferencing, and connector to metadata source.</td></tr><tr><td class="confluenceTd">processingSteps</td><td class="confluenceTd">Data preprocessing transformers and related input arguments.</td></tr><tr><td class="highlight-blue confluenceTd" data-highlight-colour="blue">stagingDestination</td><td class="highlight-blue confluenceTd" data-highlight-colour="blue">Connector for intermediate processed data storage, which will be used in post-processing steps.</td></tr><tr><td class="confluenceTd">outputDestination</td><td class="confluenceTd">Connector for final output.</td></tr><tr><td class="highlight-blue confluenceTd" data-highlight-colour="blue">serviceApiConfiguration (Optional)</td><td class="highlight-blue confluenceTd" data-highlight-colour="blue">Configuration required for post-processing steps. For example, arguments for anomaly detection client.</td></tr></tbody></table>

## inputSources

Dataset(s) input source(s), with **inputSources** as key and an array of dataset(s) information as value.

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

## phaseInfo

The flag indicating whether it is a training or inferencing phase, plus other required input parameters. Here we will include an object storage connector, the workflow will use it to store or read metadata, which is useful for data dependent steps (for example, one-hot encoding).

*   **connector** - the connector to object storage. It will be composed of
    *   **namespace** - the namespace of the target object storage bucket. Required if it is for object storage.
    *   **bucket** - the bucket name. Required if it is for object storage.
    *   **objectName** \- the full path and name of the object. Required if it is for object storage.

## processingSteps

This will be a list of all the transformations you want to apply. This is the core of the data processing. Every item in the list is a step, and all the steps will be executed in sequence, one after another. Users should make sure the sequence makes sense, or exceptions will be thrown. DPP doesn't responsible for process validation before execution. For each step, you need to specify the following.

*   **stepType** \- can be either **singleDataFrameProcessing** (for transforming on top of single dataframe) or **combineDataFrames** (for merging or joining two dataframes).
*   **configurations** - the configuration related to the step you take, which will include:
    *   **dataframeName** - a name you given to the output of the transformation.
    *   **steps** - a list of all transformers you want to apply to your target dataframe at this time. For each step, there will be:
        *   **stepName** - the name of the transformer you want to apply. It must exactly matches the one you defined in archive. For the full list of offered transformers, please check **Appendix II: List of Transformers**.
        *   **args** \- all the arguments required for the transformer you choose to use. For details about it, check **Appendix II: List of Transformers**.

## stagingDestination

This is where we store intermediate processed data for post processing. Basically these will be dataframes stored in csv format at an assigned object storage bucket. 

*   **combinedResult (optional)** - the final dataframe you want to output. You need to specify this parameter if you only have **one** single dataframe as the output. But if you do sharding, the sharded dataset will be the output automatically, and you don't need this parameter any more.
*   **type** \- can only be **object-storage** for now.
*   **namespace** - the namespace of the target object storage bucket. 
*   **bucket** \- the bucket name. 
*   **objectName** \- the full path and name of the object. 

## outputDestination

This is where the final output comes to, including model\_info, finalized output after inferencing, etc.

*   **type** \- can only be **object-storage** for now.
*   **namespace** - the namespace of the target object storage bucket. 
*   **bucket** \- the bucket name. 
*   **objectName** \- the full path and name of the object. 

## serviceApiConfiguration (optional)

This configuration is for post processing steps, so in theory you can put anything into that. You can check the following configuration example for anomaly detection training.

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
        "namespace":"ax3dvjxgkemg",
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

This is an executable provided by us. Here is our latest driver code that can conduct data preprocessing, training and inferencing: [link](https://github.com/bug-catcher/oci-data-science-ai-samples/blob/master/ai_services/anomaly_detection/data_preprocessing_examples/oci_data_flow_based_examples/example_code/df_driver.py).

## Training/Inferencing datasets

 Here we attached a usable set of training and testing data in csv and parquet. 

[TestData.csv](../attachments/TestData.csv) [TrainData.csv](../attachments/TrainData.csv) [TrainData.parquet](../attachments/TrainData.parquet)

## Library

Library is an archive.zip incorporating transformers we offer and user defined functions. Here is the link of an introduction to our [offered transformers](../optional/Introduction-to-Transformers-for-Data-Preprocessing.md) in this bucket. And here is a [doc](https://github.com/bug-catcher/oci-data-science-ai-samples/blob/master/ai_services/anomaly_detection/data_preprocessing_examples/oci_data_flow_based_examples/prepackaged_dataflow_applications.md) describing how to generate an archive.zip.

For this lab, we've prepared the archive for you:
[Archive link](https://objectstorage.us-phoenix-1.oraclecloud.com/p/kUGPXE9HB_BtgpCqe7jyOUUD_rorNiHD0HWsIR52r4KN4axrHpidLnBo4y1Nsnb-/n/ax3dvjxgkemg/b/archive-bucket/o/archive.zip)