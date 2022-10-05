# Trigger the OCI Vision model creation and training

## Introduction

In this lab, you will create an OCI Vision project and an OCI Vision custom model. A custom model can be created with a minimum of 10 images, which we have provided.   
An OCI Vision custom model can be created in quick mode (up to 1 hour), regular mode (up to 24 hours), or custom mode. In the lab steps, we propose the quick mode, with a fast completion of the workshop in mind. Whenever suitable, we recommend the regular mode.

### Objectives

- Become familiar with OCI Vision
- Understand the OCI Vision resource hierarchy
- Create an OCI Vision custom model for Object Detection 

## Task 1: Create an OCI Vision project

1. In the Oracle Cloud Console, click the main menu icon to open the side menu.
2. Click **Analytics & AI** and then click **Vision**.
3. On the left side of the screen, click **Projects**, under Custom Models.

   ![Creation of OCI Vision project](../images/create_project.png)

4. Click **Create project**. Provide *vision-project* as name, select *vision-livelab* as compartment, and click **Create project**

## Task 2: Create the OCI Vision pipe detection model

1. While on the OCI Vision project details page, click **Create Model**.
   ![OCI Vision project details](../images/vision_project.png)
2. Select *Object Detection* in model type.
3. Select *Choose existing dataset*, *Data Labeling Service*, and select the *vision-livelab-dataset* bucket.
   ![Creation of OCI Vision model - 1](../images/create_model1.png)
4. Click **Next**.
5. Name the model *vision-model*.
6. Choose *Quick training* and click **Next**.
   ![Creation of OCI Vision model - 2](../images/create_model2.png)
7. Click **Create and train**.

## Acknowledgements

* **Authors** - Nuno Gonçalves, Jason Monden
* **Last Updated By/Date** - Nuno Gonçalves, September 2022
