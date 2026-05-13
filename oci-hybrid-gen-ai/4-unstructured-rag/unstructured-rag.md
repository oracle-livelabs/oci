# Unstructured RAG

## Introduction

In this lab, you create the unstructured retrieval source for the Example Motors support agent. The source document is a PDF pairing guide for the Example Motors infotainment system. The app attaches the resulting vector store to OCI Generative AI Responses API requests through the `file_search` tool.

Estimated Time: 25 minutes

### Objectives

In this lab, you will:

- Create an Object Storage bucket for vehicle manuals
- Upload the infotainment pairing guide PDF
- Create an unstructured vector store
- Create and run a data sync connector
- Record the vector store ID for the sample app

### Prerequisites

This lab assumes you have:

- Completed the Setup lab
- A workshop compartment with the required IAM policies
- The PDF file `4-unstructured-rag/files/talexion-infotainment-pairing-guide.pdf`

## Task 1: Create the manual bucket

1. In the Console navigation menu, go to **Storage**, then **Buckets**.

2. Select the workshop compartment.

3. Click **Create bucket**.

4. Enter the following values:

    ```text
    Bucket name: car-manufacturer-manuals
    Default storage tier: Standard
    Visibility: Private
    Emit object events: Disabled
    Object versioning: Disabled
    ```

    ![Create Object Storage bucket](images/create-bucket.png)

5. Click **Create bucket**.

6. Open the bucket from the bucket list.

    ![Buckets list with car manufacturer manuals bucket](images/buckets-list.png)

7. On the bucket details page, record the namespace and bucket name.

    ![Bucket details page](images/bucket-details.png)

## Task 2: Upload the infotainment PDF

1. In the `car-manufacturer-manuals` bucket, click **Upload objects**.

2. Drag or select this file:

    ```text
    4-unstructured-rag/files/talexion-infotainment-pairing-guide.pdf
    ```

    ![Upload objects select file step](images/upload-objects-select-file.png)

3. Review the file upload list.

    ![Upload objects review step](images/upload-objects-review.png)

4. Click **Upload objects**.

5. Wait for the upload to complete.

    ![Upload objects progress complete](images/upload-objects-progress.png)

6. Confirm that the bucket contains the PDF.

    ![Bucket object list with pairing guide PDF](images/bucket-object-list.png)

## Task 3: Create the unstructured vector store

1. In the Console navigation menu, go to **Analytics & AI**, then **Generative AI**.

2. Select **Vector stores**.

    ![Vector stores list](images/vector-stores.png)

3. Click **Create vector store**.

4. Enter the following values:

    ```text
    Name: car-operation
    Description: Example Motors infotainment and operation manuals
    Compartment: <workshop-compartment>
    Data source type: Unstructured data
    ```

    ![Create vector store with unstructured data source](images/create-vector-stores.png)

5. Click **Create**.

6. Wait until the vector store status is `Completed`.

    ![Created vector store in completed state](images/vector-store-created.png)

7. Open the vector store details page.

    ![Vector store details page](images/vector-store-details.png)

8. Copy the vector store ID.

    You will use this value later as:

    ```text
    OCI_GENAI_VECTOR_STORE_IDS
    ```

## Task 4: Create the data sync connector

1. In the `car-operation` vector store, select the **Data sync connectors** tab.

2. Click **Create data sync connector**.

    ![Create data sync connector button](images/create-data-sync-connector.png)

3. Enter the following values:

    ```text
    Name: car-manuals
    Object Storage bucket: car-manufacturer-manuals
    Object prefix: leave blank
    ```

4. Select the uploaded PDF file from the bucket.

    ![Select all files in bucket for data sync connector](images/select-all-files-in-bucket.png)

5. Click **Create**.

6. Confirm that the data sync connector appears in the list.

    ![Data sync connector created](images/data-sync-created.png)

7. Open the data sync connector details page.

    ![Data sync connector details page](images/data-sync-connector-details.png)

## Task 5: Run and verify data sync

1. In the vector store details page, open the **Data sync** tab.

    ![Data sync details page](images/data-sync-details.png)

2. Click **Perform Data Sync**.

3. Enter the following value:

    ```text
    Name: car-manuals
    ```

    ![Perform data sync dialog](images/create-perform-data-sync.png)

4. Click **Perform**.

5. Wait until the data sync job reaches a completed state.

    ![Performed data sync job created](images/perform-data-sync-created.png)

6. Return to the vector store details page.

7. Confirm that the file count is at least `1`.

8. Save the vector store ID with your workshop notes.

You may now **proceed to the next lab**.

## Learn More

- [Managing Object Storage buckets](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/managingbuckets.htm)
- [Uploading objects to Object Storage](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/managingobjects.htm)
- [OCI Generative AI QuickStart for vector stores and file search](https://docs.oracle.com/en-us/iaas/Content/generative-ai/get-started-agents.htm)

## Acknowledgements

- **Author** - Julien Lehmann, Product Marketing Manager, Yanir Shahak, Senior Principal Software Engineer
