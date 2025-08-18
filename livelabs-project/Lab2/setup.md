# Setup OCI OCR Integration for Pre-Annotation

## Introduction

To streamline the annotation workflow and minimize manual effort, interactive pre-annotation can be enabled in Label Studio. This setup allows automatic generation of bounding boxes using OCR service. We have integrated OCI OCR as the ML backend to generate bounding boxes on images for key-value annotation. Please clone the repository below and install the required dependencies.

***Estimated Lab Time*** 5 minutes


### Objectives:

In this lab, you will:
* Download OCI OCR and start the service

### Prerequisites (Optional)

* Having Python3 installed and configured on your local machine (refer - ******add link to lab where setup is done*****)

This lab assumes you have:
* All previous labs successfully completed.
* Basic scripting skills in Python and Bash

## Task 1: Setup OCI OCR service backend


1. 

	Please clone the repository below and install the required dependencies. 

  https://github.com/HumanSignal/label-studio-ml-backend 

  https://labelstud.io/guide/ml_create 

2. Install label-studio-ml-backend 
  </br>
      ```
      git clone https://github.com/HumanSignal/label-studio-ml-backend.git 
      cd label-studio-ml-backend/ 
      pip install -e .  

      ```

3. 
  [Download OCI-OCR](files/ociocr.zip) zip file and configure to call OCI Text extraction service, extract its contents into the directory *label-studio-ml-backend/label_studio_ml/examples/* . 


4. 
  Move to the examples folder: 
      ```
      cd label_studio_ml/examples/ 

      ``` 

Inside that folder, configure the following to your COMPARTMENT_ID and SERVICE_ENDPOINT. To find which if your service endpoint, check the following list and copy your region: https://docs.oracle.com/en-us/iaas/api/#/en/document-understanding/20221109/  

      ```
      CONFIG_PROFILE = "DEFAULT" 
      COMPARTMENT_ID = "ocid1.compartment.oc1.xxxxxxxxxxxxxxxxxxxxxxxx" 
      SERVICE_ENDPOINT = "https://document-preprod.aiservice.xxxxxxxxxxxxxxxx" 
      LANGUAGE="ENG"
      ```

5. 
  Start Text extraction service
  Run the command below to start the OCR service inside the examples folder, for example with port 9001. 
      ```
      label-studio-ml start ./ociocr --port 9001 
      ```

## Acknowledgements
* **Authors** 
    - Cristina Granés, AI cloud services Black Belt
    - David Attia, AI cloud services Black Belt
* **Last Updated By/Date** - <Name, Month Year>
