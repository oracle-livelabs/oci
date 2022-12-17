# Train Anomaly Detection Model

## Introduction

In this session, we will show you how to train an anomaly detection model using Oracle Anomaly Detection and the synthetic signal data as our training data.

Anomaly detection is the identification of rare items, events, or observations in data that differ significantly from the expectation. This can be used for several scenarios like asset monitoring, maintenance and prognostic surveillance in industries such as utility, aviation, transportation, and manufacturing.

The core algorithm of Anomaly Detection is an Oracle-patented multivariate time-series anomaly detection algorithm originally developed by Oracle Labs and had been successfully used in several industries for prognosis analysis.

Oracle Anomaly Detection will create customized Machine Learning models by taking the data uploaded by users, using the core algorithm to train the model, and hosted in the cloud to be ready for detection. Users can then send new data to the detection endpoints to get detected anomaly results.

*Estimated Time*: 30 minutes

### Objectives

* Understand a high level overview of the Oracle Anomaly Detection service
* Understand the full cycle/workflow of services provided in the Oracle Anomaly Detection service
* Hand-on activities to experience the whole pipeline of machine learning model development from training to detecting


### Prerequisites

- set up policy is taken care of in lab1: set-up-environment
- training data csv is stored in object storage bucket

## Task 1: Create Anomaly Detection Project

A project is a way to organize multiple data assets, models, deployments to the same workspace

1. Log into the OCI Cloud Console. Using the Burger Menu on the top left corner, click  **Analytics and AI** , and then select  **Anomaly Detection** item under  **AI services**.

    ![Create Project](./images/imageCP1.png " ")

2. In the Anomaly Detection section,
    - Under  **Compartment**, select the name of the compartment you created 
    - Select  **Create Project**

    ![Create Project](./images/imageCP2.png " ")

3. In this form,
    - Select  **AD_Workshop** as the compartment
    - Type  **AD_Project** as the Name of the project

    Once the details are entered, click the  **Create** Button.

    ![Create Project](./images/imageCP3.png " ")

4. If the project is successfully created, it will show up in projects pane. (You may need to reload the page)
    - select your   **Project**

    ![Create Project](./images/imageCP4.png " ")

5. **If you have NOT completed the previous Labs (01 and 02),**
    - Download the [Training Dataset here](https://objectstorage.us-ashburn-1.oraclecloud.com/p/-z6yMfwSuQJ4RfpMFPu4rShFG8O8IZGzdUz_PgR_tgbNmDH9-Pjpu-vlpqBW5aKG/n/orasenatdpltintegration03/b/AD_bucket/o/AD_train_6cycle.csv)
    - Then **skip to Task 3: Create a Model**


## Task 2: Create a Data Asset


The Data Asset is the data utilized for training your Anomaly Detection Model. The Data Asset should be data that has NO anomalies, so that the Anomaly Detection model will be trained on data that represents the 'normal' state.

1.  Under your project, click the   **Data Assets** menu on the left. Then click  **Create Data Asset**

    ![Create Data Asset](./images/imageCDA1.png " ")

2.  In the \_Create Data Asset\_ menu, 
    - Select  your compartment for _Compartment_
    - Type  **AD\_data\_asset** as the Data Asset \_Name\_
    - Select  **Oracle Object Storage** for \_Type\_
    - Select  your bucket for _Choose a bucket_ 
    - Select  your csv file created from Lab 2 for _Training Data_
    - Press  **Create**

    (Optional) you can also download this [Training Dataset](https://objectstorage.us-ashburn-1.oraclecloud.com/p/eUdCwwaXR3NM8GD7CmVEEBvePoYqTtobdpnVubPxrqroKxcN5-gyoFixU2VMlVBD/n/orasenatdpltintegration03/b/digitaltwin/o/train_10cycle.csv) if you don't have training data csv in the bucket. Upload the downloaded csv file to Object Storage Bucket. Follow Lab 1 Task 3 to navigate to Bucket. 

    ![Create Data Asset](./images/imageCDA2.png " ")

    The data asset should now show in the data asset main panel.

    This demo only covers data from Object Storage. However, data can be imported other sources such as Oracle Autonomous Transaction Processing (ATP), InfluxDB, and more. 


## Task 3: Create a model

Now it's time to train the Anomaly Detection Model and make predictions.

Creating a model requires 3 actions:
- Select the proper compartment and data asset that we just created.
- Set training parameters
- Train a model

1. From here, 
    - Go to **Models** on the left menu
    - Click **Create and Train Model**

    ![Create Model](./images/imageCM1.png " ")

2. Make sure _Choose an existing data asset_ is toggled
    Under _Choose data asset in compartment_, select  **AD_data_asset**. The click **Next**. 

    ![Create Model](./images/imageCM2.png " ")


## Task 4: Parameter Selections

**FAP (False Alarm Probability)**
>FAP stands for False Alarm Probability, which is the likelihood (percentage) that a timestamp is flagged as an anomaly in the anomaly-free training data (data asset). It is calculated at every signal level and then averaged across all signals as the final achieved FAP by our model.
>A high FAP means the likelihood of an anomaly flagged by Anomaly Detection service to be a _false alarm_ is high. If this is not desired, depending on the sensitivity requirements of a user, user can specify it to be low.
>Typically, FAP can be set to be around the same level of percentage of anomalies in real business scenarios, and a value 0.01 or 1% is relatively appropriate for many scenarios. Also, be aware that if specifying a lower target FAP, the model needs more time to train, and may not achieve to the target FAP.
![Create Model](./images/FAP_Formula.png " ")

>FAP = sum(number of anomalies in each signal) / (number of signals  * number of timestamps)
**Train Fraction Ratio**
>Train Fraction Ratio specifies the division ratio of the whole training data to be used training and validation. The default value 0.7 or 70% specifies the model to use 70% of the data for training, and the rest 30% is used to produce model performance (validation).
1. In this demo, set...
    - select your compartment as the Model \_Compartment\_
    - **AD_Model** as the _Name_
    - _FAP_ value as **0.5**
    - _Train Fraction Ratio_ as  **0.7** (_default value_)

    Click **Next**:

    ![Create Model](./images/imageCM3.png " ")

2. Review the model information.

    Click **Create**:

    ![Create Model](./images/imageCM4.png " ")

3. The model may take 10-15 minutes to finish training.

    ![Create Model](./images/imageCM5.png " ")

    When `Status` changes from **Creating** ...

    ![Create Model](./images/imageCM6.png " ")

    ... to **Active**,

    ![Create Model](./images/imageCM7.PNG " ")

    Your Anomaly Detection model is ready, and you may proceed to the next task.

You many now **proceed to the next lab.**


## Acknowledgements

- **Authors**
      - Adrian Alba - Staff Cloud Engineer
- **Contributors** 
      - Tony Zhang - Master Principal Cloud Architect
      - Jiayuan Yang - Senior Cloud Engineer 
      - Samuel Cacela, Staff Cloud Engineer
- **Last Updated By/Date** - September, 2022






