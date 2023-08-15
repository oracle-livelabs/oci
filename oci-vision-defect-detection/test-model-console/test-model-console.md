# Test the model via Oracle Cloud Console

## Introduction

In this lab, you will test the OCI Vision custom model using the test interface in the OCI Console.

Estimated Time: 10 minutes

### Objectives

- Test the OCI Vision custom model by uploading a test image to the OCI Console

## Task 1: Test the model via Oracle Cloud Console

1. Click [here](https://github.com/oracle-livelabs/oci/raw/main/oci-vision-inventory/images/model/utility_pole_test.jpg) to view the test image. Right click on the image and save it to your computer.

2. In the Oracle Cloud Console, click the main menu icon to open the side menu.
3. Click **Analytics & AI** and then click **Vision**.
4. On the left side of the screen, click **Projects**, under Custom Models.
5. Click **vision-project**, and then **vision-model**.
6. Click **Analyze** on the left side of the screen.
7. In the OCI Vision model details page, upload the test image *test.jpg* by dragging it to the screen.

   ![Test the OCI Vision model - 1](../images/test_model1.png)

8. You can view the JSON response on the right side of the screen. The JSON response includes the confidence values for each instance of rust that was identified.

      > **Note:** The intent of this lab is to provide you with the knowledge of how to build a custom model with the OCI Vision service, not to build a production ready model. To build a production ready model, we recommend using a much larger dataset to train the model.

      ![Test the OCI Vision model - 2](../images/test_model2.png)

## Acknowledgements

* **Authors** - Mark Heffernan and Jason Monden
* **Last Updated By/Date** - Mark Heffernan, August 2023
