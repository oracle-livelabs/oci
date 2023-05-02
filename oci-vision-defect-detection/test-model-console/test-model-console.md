# Test the model via Oracle Cloud Console

## Introduction

In this lab, you will test the recently created OCI Vision model to recognize stacked pipes in a test picture. You will do so by accessing the existing user interface for model testing in the Oracle Cloud Console.

Estimated Time: 10 minutes

Watch the video below for a quick walk-through of the lab.
[Test the model via Oracle Cloud Console](videohub:1_csn26fmf)

### Objectives

- Test the model by uploading a test image in the Oracle Cloud Console UI

## Task 1: Test the model via Oracle Cloud Console

1. Click [here](https://github.com/oracle-livelabs/oci/raw/main/oci-vision-inventory/images/model/test.jpg) to download the sample test image. 

2. In the Oracle Cloud Console, click the main menu icon to open the side menu.
2. Click **Analytics & AI** and then click **Vision**.
3. On the left side of the screen, click **Projects**, under Custom Models.
4. Click **vision-project**, and then **vision-model**.
5. In the OCI Vision model details page, upload the test image *test.jpg* by dragging it to the screen.

   ![Test the OCI Vision model - 1](../images/test_model1.png)

3. You can view the JSON response on the right side of the screen. The JSON response includes the confidence values for each pipe that was identified.

   > **Note:** You may see in your test results that some objects were incorrectly labeled or some pipes were not labeled. This is because the dataset used to train the model in this lab is very small. The intent of this lab is to provide you with the knowledge of how to build a custom model with the OCI Vision service, not to build a production ready model. To build a production ready model, we recommend using a much larger dataset to train the model.

   ![Test the OCI Vision model - 2](../images/test_model2.png)

## Acknowledgements

* **Authors** - Mark Heffernan, Jason Monden, and Ted Basile
* **Last Updated By/Date** - Mark Heffernan, May 2023
