# Setup OCI OCR Integration for Pre-Annotation

## Introduction

To streamline the annotation workflow and minimize manual effort, interactive pre-annotation can be enabled in Label Studio. This setup allows automatic generation of bounding boxes using OCR service. We have integrated OCI OCR as the ML backend to generate bounding boxes on images for key-value annotation. Please clone the repository below and install the required dependencies.

***Estimated Lab Time*** 15 minutes


### Objectives:

In this lab, you will:
* Download OCI OCR and start the service

### Prerequisites (Optional)

* Having Python3 installed and configured on your local machine (refer - Lab1)

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
      <copy>
      git clone https://github.com/HumanSignal/label-studio-ml-backend.git 
      cd label-studio-ml-backend/ 
      pip install -e .  
      </copy>
      ```

3. 
  [Download OCI-OCR](files/ociocr.zip) zip file and configure to call OCI Text extraction service, extract its contents into the directory *label-studio-ml-backend/label_studio_ml/examples/* . 


4. 
  Move to the examples folder: 
      ```
      <copy>
      cd label_studio_ml/examples/ 
      </copy>
      ``` 

5. Navigate to `label_studio_ml/examples/ociocr` directory, open the .env file and configure the following to your `COMPARTMENT_ID` and `SERVICE_ENDPOINT`. To find which if your service endpoint, check the following list and copy your region: [regions endpoints](https://docs.oracle.com/en-us/iaas/api/#/en/document-understanding/20221109/) (make sure that the service endpoint region and the region your compartment is in are matching).  

        <copy>
        CONFIG_PROFILE = "DEFAULT" 
        COMPARTMENT_ID = "ocid1.compartment.oc1.xxxxxxxxxxxxxxxxxxxxxxxx" 
        SERVICE_ENDPOINT = "https://document-preprod.aiservice.xxxxxxxxxxxxxxxx" 
        LANGUAGE="ENG"
        </copy>

6. Run the command below to start the OCR service inside the examples folder, for example with port 9001. 
    <br>
      ```
      <copy>
      label-studio-ml start ./ociocr --port 9001
 
      ```
    </br>
</br>
You may now **proceed to the next lab**

## Acknowledgements
* **Authors** 
    - Cristina Granes, AI Cloud Services Black Belt
    - David Attia, AI Cloud Services Black Belt
* **Last Updated By/Date** 
    - David Attia - AI Cloud Services Black Belt, August 2025
