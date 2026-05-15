# Create custom models using OCI Document Understanding and Label Studio

## Introduction

Document Understanding is a serverless, multi-tenant service, accessible using the Console, REST APIs, SDK, or CLI. You can upload documents and images to extract text, key values, tables or elements, and classify them. Document Understanding service also allows to train custom models for key-value extraction and classification of documents.

Label Studio is an open-source labelling tool commonly used by data scientists and annotators within the AI community, to prepare datasets to train various types of models. You will see an example on how to use Label Studio to create a dataset for a custom AI model in Document Understanding, in specific for Key-Value extraction of invoices.

You will find official documentation about how to use Label Studio [here](https://docs.oracle.com/en-us/iaas/Content/document-understanding/using/label-studio-top.htm).

_Note: If you face any issues during setup and installation, please refer to the 'common issues' section._

***Estimated Lab Time*** 120 minutes


### Objectives:
In this workshop you will learn how to:
* Create a dataset from PDF documents in Label Studio for Key-Value extraction
* Setup OCI OCR backend for pre-annotation
* Train a custom Key-Value model in OCI Document Understanding with this dataset


### Prerequisites
* An Oracle Free Tier, or Paid Cloud Account
* Familiarity with Python
* Some familiarity with OCI policies and CLI is desirable
* Some familiarity with OCI SDK is desirable, but not required

</br>
You may now **proceed to the next lab**

## Acknowledgements
* **Authors** 
    - Cristina Granes - AI Cloud Services Black Belt
    - David Attia - AI Cloud Services Black Belt
* **Last Updated By/Date** 
    - Cristina Granes - AI Cloud Services Black Belt, August 2025