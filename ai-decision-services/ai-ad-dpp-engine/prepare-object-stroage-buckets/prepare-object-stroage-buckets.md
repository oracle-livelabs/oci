
Lab 4: Prepare Object Storage Buckets
===

This guide uses the following buckets (any change to the names will have to be reflected in the subsequent setup steps):

*   **driver-code-archive-bucket**: the bucket to store driver code and archive.zip consuming by Data Flow.
*   **training-config-bucket**: the bucket to store training process configuration.
*   **training-data\-bucket**: the bucket to store training data. Need to enable **Emit Object Events**.
*   **inferencing-config-bucket**: the bucket to store inferencing process configuration.
*   **inferencing-data-bucket**: the bucket to store training data. Need to enable **Emit Object Events**.
*   **staging-bucket**: the bucket to store processed interim data, i.e. the data passed through processing, waiting for being fed to training or inferencing. 
*   **output-bucket**: the bucket to store the finalized output from inferencing, the list of trained models and data dependent information
*   **logs-bucket**: the bucket to store data flow logs.

To enabling object event emit, you can edit the bucket by going to the bucket's page:

![](../attachments/Prepare-OS1.png)

Now you should place what you've prepared to the right buckets:

*   Put driver code into **driver-code-archive-bucket**
*   Put archive.zip into **driver-code-archive-bucket**
*   Put training configuration into **training-config-bucket**
*   Put inferencing configuration into **inferencing-config-bucket**

You do not need to upload training and inferencing data yet. The uploading action results in triggering of the pipeline, and we will discuss this later.
