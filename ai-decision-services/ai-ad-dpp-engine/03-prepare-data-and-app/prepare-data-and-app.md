Lab 3: Configure OCI Object Storage Buckets and Upload Driver
===

## 1. Download DPF Engine Driver Code

The Data Processing Framework (DPF) is an executable (~Driver) built by OCI AI Services team and provided to users. The latest driver code can be downloaded from [here](https://github.com/bug-catcher/oci-data-science-ai-samples/blob/master/ai_services/anomaly_detection/data_preprocessing_examples/oci_data_flow_based_examples/example_code/df_driver.py).

## 2. Download DPF Transforms Library

A Library which includes multiple data transformers and user defined functions is provided to users as an [archive file](https://objectstorage.us-phoenix-1.oraclecloud.com/p/kUGPXE9HB_BtgpCqe7jyOUUD_rorNiHD0HWsIR52r4KN4axrHpidLnBo4y1Nsnb-/n/ax3dvjxgkemg/b/archive-bucket/o/archive.zip) (archive.zip).  Download this zip file as it will be used later in this lab.

Refer to the **Transformers** [documentation](../optional/Introduction-to-Transformers-for-Data-Preprocessing.md) for a description of all available transformers.

For users interested in building their own data transformers (preprocessors) and building the archive from sources, this [document](https://github.com/bug-catcher/oci-data-science-ai-samples/blob/master/ai_services/anomaly_detection/data_preprocessing_examples/oci_data_flow_based_examples/prepackaged_dataflow_applications.md) describes how to generate an archive in the required format.

## 3. Set up OCI Object Storage Buckets

Labs in this workshop use the following OCI Object Storage Buckets. Any change to the names will have to be reflected in subsequent setup steps.

Create the following OCI Object Storage Buckets using OCI Console or OCI CLI.

*   **driver-code-archive-bucket**: The bucket to store driver code and archive.zip consuming by Data Flow.
*   **training-config-bucket**: The bucket to store training process configuration.
*   **training-data\-bucket**: The bucket to store training data. Need to enable **Emit Object Events**.
*   **inferencing-config-bucket**: The bucket to store inferencing process configuration.
*   **inferencing-data-bucket**: The bucket to store training data. Need to enable **Emit Object Events**.
*   **staging-bucket**: The bucket to store processed interim data, i.e. the data passed through processing, waiting for being fed to training or inferencing. 
*   **output-bucket**: The bucket to store the finalized output from inferencing, the list of trained models and data dependent information
*   **logs-bucket**: The bucket to store data flow logs.

To enable OCI Object Store events to be emitted, update the respective Storage Bucket by going to the bucket's page:

![](./images/Prepare-OS1.png)

## 4. Upload Driver and Library

Upload the DPF Driver and Transforms Library (archive.zip) which you downloaded in Steps [1] and [2] into the respective OCI Object Storage Buckets. See below.

*   Put driver code into **driver-code-archive-bucket**
*   Put archive.zip into **driver-code-archive-bucket**

## Useful Resources
Refer to OCI documentation (link below) to learn more about OCI Object Storage.

- [OCI Object Storage](https://docs.oracle.com/en-us/iaas/Content/Object/Concepts/objectstorageoverview.htm)
