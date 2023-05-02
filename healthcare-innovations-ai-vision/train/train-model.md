# Lab 5: Train image classification model

## Introduction

TBC - To be completed. 

This lab walks you through the steps to train custom Image Classification model and to perform basic testing using OCI Vision.

Estimated Time: 90 minutes (up to 6 hours if maximum training duration is selected).

### About OCI Vision

OCI Vision is a serverless, cloud native service that provides deep learning-based, prebuilt, and custom computer vision models over REST APIs. OCI Vision helps you identify and locate objects, extract text, and identify tables, document types, and key-value pairs from business documents like receipts.

### Objectives

In this lab, you will:

* Set a staging bucket required for storing temporary prediction results
* Create a new image classification model using OCI Vision
* Test a model using OCI Vision

### Prerequisites

This lab assumes you have:

* Completed previous labs of this workshop: **Lab 1: Setup environment**, **Lab 2: Create image library** and **Lab 3: Label images**.

## Task 1: Create a staging bucket for Vision

Before you begin with model training, one small prerequisite is needed.

Vision service, when running predictions, requires additional storage, a staging bucket, where each prediction's results are stored temporarily. You need to create a staging bucket and then allow access and manage privileges to your user group.

1. Navigate to Buckets page

    As you've done this for the Image Library, open **Navigator** menu, select **Storage** and then choose **Buckets**

    ![Navigate to buckets](https://oracle-livelabs.github.io/common/images/console/storage-buckets.png " ")

2. Create a new bucket

    In the **Object Storage & Archive Storage** page confirm you are in your compartment, ie. *X-Rays-Image-Classification* and click **Create Bucket**

    ![Create a new bucket](./images/create-a-new-bucket.png " ")

3. Define your staging bucket

    Provide **Bucket Name**, and simply leave all other parameters as default.

    ![Define staging bucket](./images/define-staging-bucket.png " ")

    Click **Create** to create a new bucket.

4. Verify new bucket is correctly created

    You can now verify that a new bucket has been correctly created.

    ![Verify staging bucket](./images/verify-staging-bucket.png " ")

5. Set policies for access and manage objects in your compartment

    To access, read and manage objects in a staging bucket the following policies are required (replace User Group and Compartment names as required for your settings):

    ```text
    <copy>allow group OCI-X-Ray-Group to read buckets in compartment X-Rays-Image-Classification
    allow group OCI-X-Ray-Group to manage objects in compartment X-Rays-Image-Classification where any {request.permission='OBJECT_CREATE', request.permission='OBJECT_INSPECT'}</copy>
    ```

    Pay attention to the compartment selected. This policy is created at your compartment level and not on *root* compartment as most of policies in this workshop.

    ![Set policies for staging bucket](./images/set-policies-for-staging-bucket.png " ")

## Task 2: Create your first custom Vision model

In the previous lab, you have labeled all images (records) in your dataset, which is prerequisite to start working with **Vision** service. In this lab, you will create your first **vision**, image classification, model and you will run some tests to confirm it is working properly.

1. Navigate to Vision page

    Using **Navigator** (on the left) navigate to **Analytics & AI** and then choose **Vision**.

    ![Navigate to Vision](./images/navigate-to-vision.png " ")

2. Review Vision page and navigate to custom projects

    You will see a menu of Vision options on the left side of the page. As you can see **Vision** service can be used for **Image Classification**, **Object Recognition** and **Document AI**. These services are ready to use services, so you can try them without any preparation.

    In your case, you will create your own custom model. So, Click **Projects**

    ![Review Vision page and navigate to custom projects](./images/review-vision-page.png " ")

3. Continue with customer project setup

    Click **Projects** on the left side menu list, confirm you are in correct **Compartment** (ie. *X-Rays-Image-Classification*) and click **Create Project**

    ![Create a new project in Vision](./images/create-a-new-vision-project.png " ")

4. Define new custom project

    Select compartment in which you would like to create your vision model. Give your model **name** and provide **short description**. Click **Create project**.

    ![Define project](./images/define-project.png " ")

5. Verify your project

    You can monitor creation of your new project. This should be completed pretty quickly. Once done, your project should have status **ACTIVE**.

    ![Verify project](./images/verify-project.png " ")

    Click on your **project name**.

6. Create a new vision model

    Project page opens. You can see there is a list of **Models** that is currently empty. So, let's create your first Vision model.

    Click **Create Model**

    ![Create a new Vision model](./images/create-a-new-model.png " ")

7. Create and train model - Select data step

    Create and Train Model wizard will now take you through a few simple steps.

    In the first step, you need to provide data for the model to be trained on. You are obviously using your X-Ray Images dataset, which was labeled, using **Data Labeling Service** in the previous lab.

    Click **Next** to proceed to the second step.

    ![Create and train model wizard - select data](./images/create-model-select-data.png " ")

8. Create and Train Model - Train model step

    In this second step, you need to define parameters for the model itself. As you can see, there isn't much to do. Provide a name and description and then define **training duration**.

    As you can see you can choose between *up to 24 hours*, *about an hour* and *custom duration*. In the script, **the recommended** option is chosen, which means up to 24 hours. In fact it should take approx. 5 hours to complete. But feel free to pick your option.

    ![Create and train model wizard - train model](./images/create-model-train.png " ")

    Click **Next** to proceed to the **Review** step.

9. Create and Train Model - Review step

    In this step you will only review and confirm the settings. If you are ok with them, click **Create and train**.

    ![Create and train model wizard - review](./images/create-model-review.png " ")

10. Training in progress ...

    Model training is in progress. In the **Project details: models** page you can monitor the progress by clicking the **Work Request** operation (in this case **CREATE_MODEL**).

    ![Model training in progress](./images/model-training-in-progress.png " ")

11. Work request log monitoring

    You can monitor the progress by reviewing **Log Messages**.

    ![Model training in progress](./images/model-training-in-progress-monitoring-1.png " ")

    ![Model training in progress](./images/model-training-in-progress-monitoring-2.png " ")

    ![Model training in progress](./images/model-training-in-progress-monitoring-3.png " ")

12. Evaluate your model

    When model training is completed - **State** is *Succeeded* and **% Complete** is *100%*.

    In the **training metrics** area calculated metrics that were automatically calculated using 10% of images as test dataset. Training metrics **Precision**, **Recall** and **F1 Score** are in this case around 95%.

    ![Evaluate model and review metrics](./images/evaluate-model.png " ")

    Additionally, you can review more detailed metrics for each label used in the model. Click on **Training metrics** link on the left side (under **Resources**). Table reveals, that training metrics for *PNEUMONIA* are slightly higher than for *NORMAL*.

    ![Evaluate model and review metrics by label](./images/evaluate-model-by-label.png " ")

## Task 3: Test and evaluate your model

1. Test you model using known images

    Open bucket with your training image library (ie. *X-Ray-Images-for-Training*) in the second tab. Navigate to *NORMAL* folder and open details of any image. Copy **Image URL** to clipboard.

    ![Obtain URL for NORMAL image - example](./images/obtain-url-for-normal-example.png " ")

    Navigate back to tab with your Project model's details.

    Check **Object Storage** as your **Image Source** and paste **Image URL** from clipboard into **Enter Image URL** field. Click **Upload**.

    ![Upload NORMAL image](./images/upload-image-normal.png " ")

    Image will be uploaded and automatically analyzed. **Image** and prediction **Results** are displayed. And we can see that this image has been classified as *NORMAL* with very high **Confidence**.

    ![Test model for NORMAL image](./images/test-model-for-normal.png " ")

    You can repeat and perform prediction for one image which is clearly showing *PNEUMONIA* infected lungs.

    Copy **Image URL** to clipboard again ...

    ![Obtain URL for PNEUMONIA image - example](./images/obtain-url-for-pneumonia-example.png " ")

    ... and copy it to **Enter Image URL** field and click **Upload**

    ![Upload and test PNEUMONIA image](./images/upload-image-pneumonia.png " ")

    You can see that image is now classified as *PNEUMONIA* as expected with almost 100% confidence.

2. Analyze predictions, confidence, requests and responses

    You have already checked **Results** on the right side of the page. 

    Beside a table showing **Prediction Confidence** for each of the **Labels** you can see two additional items in the **Results** area: *Request* and *Response*.

    Expand *Request*. This is request code for JSON call which is requesting prediction to be performed on the selected image (some values are masked).

    ```json
    <copy>{
    "compartmentId": "ocid1.compartment.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    "image": {
        "source": "OBJECT_STORAGE",
        "namespaceName": "xxxxxxxxxxxx",
        "bucketName": "X-Ray-Images-for-Training",
        "objectName": "PNEUMONIA/person1000_bacteria_2931.jpeg"
    },
    "features": [
        {
        "modelId": "ocid1.aivisionmodel.oc1.eu-frankfurt-1.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
        "featureType": "IMAGE_CLASSIFICATION",
        "maxResults": 5
        }
    ]
    }</copy>
    ```

    Expand *Response* and observe the JSON response with prediction results.

    ```json
    <copy>{
    "imageObjects": null,
    "labels": [
        {
        "name": "PNEUMONIA",
        "confidence": 0.99974525
        },
        {
        "name": "NORMAL",
        "confidence": 0.00025476996
        }
    ],
    "ontologyClasses": [
        {
        "name": "PNEUMONIA",
        "parentNames": [],
        "synonymNames": []
        },
        {
        "name": "NORMAL",
        "parentNames": [],
        "synonymNames": []
        }
    ],
    "imageText": null,
    "imageClassificationModelVersion": "version",
    "objectDetectionModelVersion": null,
    "textDetectionModelVersion": null,
    "errors": []
    }</copy>
    ```

    This concludes this lab and you can **proceed to the next lab**.

## Learn More

* [OCI Vision](https://docs.oracle.com/en-us/iaas/vision/vision/using/home.htm)


## Acknowledgements
 