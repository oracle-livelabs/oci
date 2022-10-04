Lab 3: Create Object Storage Buckets and Upload Code
===

In this lab, configure the following resources before proceeding to configure infrastructure resources

*   Driver code
*   Library (Archive.zip)

 ## Step 1: Download driver code

This is an executable built by OCI AI Services team and provided to users. The latest driver code can be downloaded from [here](https://github.com/bug-catcher/oci-data-science-ai-samples/blob/master/ai_services/anomaly_detection/data_preprocessing_examples/oci_data_flow_based_examples/example_code/df_driver.py).

## Step 2: Library

A Library which includes multiple data transformers and user defined functions is provided to users as an [archive file](https://objectstorage.us-phoenix-1.oraclecloud.com/p/kUGPXE9HB_BtgpCqe7jyOUUD_rorNiHD0HWsIR52r4KN4axrHpidLnBo4y1Nsnb-/n/ax3dvjxgkemg/b/archive-bucket/o/archive.zip) (archive.zip).  Download this zip file as it will be used later in this lab.

Refer to the **Transformers** [documentation](../optional/Introduction-to-Transformers-for-Data-Preprocessing.md) for a description of all available transformers.

For users interested in building their own data transformers (preprocessors) and building the archive from sources, this [document](https://github.com/bug-catcher/oci-data-science-ai-samples/blob/master/ai_services/anomaly_detection/data_preprocessing_examples/oci_data_flow_based_examples/prepackaged_dataflow_applications.md) describes how to generate an archive in the required format.

## Step 3: Set up OCI Object Storage Buckets

This guide uses the following OCI Object Storage Buckets (any change to the names will have to be reflected in the subsequent setup steps):

*   **driver-code-archive-bucket**: the bucket to store driver code and archive.zip consuming by Data Flow.
*   **training-config-bucket**: the bucket to store training process configuration.
*   **training-data\-bucket**: the bucket to store training data. Need to enable **Emit Object Events**.
*   **inferencing-config-bucket**: the bucket to store inferencing process configuration.
*   **inferencing-data-bucket**: the bucket to store training data. Need to enable **Emit Object Events**.
*   **staging-bucket**: the bucket to store processed interim data, i.e. the data passed through processing, waiting for being fed to training or inferencing. 
*   **output-bucket**: the bucket to store the finalized output from inferencing, the list of trained models and data dependent information
*   **logs-bucket**: the bucket to store data flow logs.

To enabling object event emit, you can edit the bucket by going to the bucket's page:

![](./images/Prepare-OS1.png)

## Step 4: Upload Driver and Library

Upload the Driver and Library (archive file) which you downloaded in Steps [1] and [2] into the respective OCI Object Storage Buckets. See below.

*   Put driver code into **driver-code-archive-bucket**
*   Put archive.zip into **driver-code-archive-bucket**
