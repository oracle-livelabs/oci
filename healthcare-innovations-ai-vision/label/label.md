# Lab 4: Label images

## Introduction

TBC - To be completed. 

This lab walks you through the steps to create a new dataset of records using images from your image library and to label those images with one of the two labels: PNEUMONIA and NORMAL.

Estimated Time: 60 minutes

### About Data Labeling

Oracle Cloud Infrastructure (OCI) Data Labeling is a service for building labeled datasets to more accurately train AI and machine learning models. With OCI Data Labeling, developers and data scientists assemble data, create and browse datasets, and apply labels to data records through user interfaces and public APIs. The labeled datasets can be exported for model development across Oracleâ€™s AI and data science services for a seamless model-building experience.

In case of images, we need to assign a label to an image, which describes and classifies that image. Or using same service, we can annotate parts of images and again tell the system what is that particular part of an image. For example, a wheel as a part of the car in the picture.

### Objectives

In this lab, you will:

* Create a new dataset using images from object storage
* Label images using Data Labeling utility
* Label images programmatically

### Prerequisites

This lab assumes you have:

* Completed previous labs of this workshop: **Lab 1: Setup environment** and **Lab 2: Create image library**.

## Task 1: Generate dataset records and label images using Data Labeling tool

Basic data labeling tool is provided within OCI. With this data labeling tool, you can label one image at the time, which is useful if your image library is not too large. In case of larger libraries, manual image labeling can be very time consuming and error prone. That is why, you will use programmatic data labeling using utilities provided by Oracle. Required code and instructions will be provided in the second task.

But before you continue, you need to perform the first step, **Create Dataset** based on your object storage based image library.

1. Navigate to Data Labeling page

    From the **Navigator** menu select **Analytics & AI** and then **Data Labeling**.

    ![Navigate to Data Labeling](./images/navigate-to-data-labeling.png " ")

2. Go to datasets

    Click on **Datasets** link under **Data Labeling** on the left side of the page.

    ![Open Datasets page](./images/open-datasets-page.png " ")

3. Create a new dataset

    This will open **Dataset list** page in selected compartment (make sure you are in correct compartment as you might need to change compartment to the one you've created for this workshop).

    Make sure you've selected your compartment where your image library resides, ie. *X-Rays-Image-Classification* and then click **Create dataset**.

    ![Create a new dataset](./images/create-a-new-dataset.png " ")

4. Define your dataset - Add dataset details

    Use **Create dataset** wizard and set the parameters of your dataset.

    First, **Name** your dataset and optionally add **Description** and provide **Labeling instructions**

    ![Define dataset details](./images/define-dataset-details.png " ")

    Click *Images* from **Dataset format** and *Single label* for **Annotation class**.

    Click **Next**

5. Define your dataset - Add files and labels

    In the 2nd step choose *Select from Object Storage* and provide **Object Storage location** details. This should be your bucket (ie. *X-Rays-Image-Classification*) where you've put all of your images.

    ![Define dateset by adding files and labels](./images/define-dataset-files-and-labels.png " ")

    Then scroll down to the lower section of this step.

    You will see your images displayed in a gallery view.

    ![Define dataset - gallery view](./images/define-dataset-gallery-view.png " ")

    Enter two labels: *PNEUMONIA* and *NORMAL* in **Labels set** field.

    Click **Next**.

6. Define your dataset - Review and Create

    ![Define dataset - specify labels](./images/define-dataset-specify-labels.png " ")

    Review your dataset details and click **Create**

7. Generating records

    Records for your dataset will be generated. This will take approx. 15-30 minutes. You can track the progress in top right corner.

    ![Dataset records generation](./images/dataset-records-generation.png " ")

    For more details click **More Actions** and select **View work request** menu option.

    ![Work requests list](./images/more-actions-menu.png =20%x*)

    Work requests list opens.

    ![Work requests list](./images/work-requests.png " ")

    Click on your work request name for more details.

    ![Work request details](./images/work-requests-details.png " ")

8. Review your dataset

    When finished, you can review the results of the records generation activity. For example, you can see that there were 4938 records generated, none of them have been labeled yet.

    ![Review dataset](./images/review-dataset.png " ")

    You can switch between **Data records** and **Gallery view** details.

    ![Switch views for dataset](./images/review-dataset-switch-views.png " ")

9. Use data labeling tool and set labels manually

    Click on the first image and **Data Labeling** tool will open. Since the first image is from *PNEUMONIA* folder, you should label it as *PNEUMONIA*.

    Click **Save & next** and continue with manual labeling process.

    ![Set labels using data labeling tool](./images/set-labels-using-data-labeling-tool.png " ")

    When you're done with labeling, exit by clicking **Cancel**. You can now check how many records have been labeled. In our example, only 1 out of 4938 records.

    ![Review dataset - labeled records](./images/review-dataset-labeled-records.png " ")

    There should be alternative, bulk labeling option, to label your images.

## Task 2: Bulk image labeling

We have 5000+ images to label. This is too much to label images manually, hence we will use a python program to label images programmatically.

Oracle provides code which can be adjusted and used in your specific case. You can find the *original code* on [Github](https://github.com/oracle-samples/oci-data-science-ai-samples/tree/master/data_labeling_examples).

![Data labeling examples on Github](./images/data-labeling-examples.png " ")

For the purpose of this labe, we have used original python code and adjusted it already to this workshop requirements. You will upload this adjusted code to your OCI environment and run bulk image labeling from there.

1. Download python code.

    Download [lab2.zip](https://objectstorage.us-ashburn-1.oraclecloud.com/p/b1_vZe_9llVqw_oTDq-SQyRrkDshcuABTHc6QuUDG984jfUi0mbk5x7pOZ7mPDPh/n/c4u04/b/livelabsfiles/o/partner-solutions/oas-and-vision/lab2.zip) to your computer.

    You don't have to extract downloaded zip file to your laptop as you will upload it as such to your OCI environment.

    If unzipped, *lab2.zip* has the following structure:

    ![Lab2 ZIP file content and structure](./images/lab2-zip-file-content.png =60%x*)

2. Open cloud shell

    In the OCI console, on the top bar, click **Developer Tools** icon to open associated menu and choose **Cloud Shell** option. That would open **Cloud Shell** terminal window.

    ![Open Cloud Shell](./images/open-cloud-shell.png " ")

3. Upload pre-prepared files for data labeling.

    In the **Cloud Shell** click **Cloud Shell Menu** icon (top right icon). Select **Upload**.

    ![Upload lab2.zip file to cloud shell](./images/upload-files-using-cloud-shell.png =200px*)

    This opens a dialog window. Drop *lab2.zip* file onto designated area or browse your computer and upload it. Observe that file name appears in the list of files for upload.

    Click **Upload**.

    ![Loading lab2.zip file to Cloud shell](./images/loading-lab2-files-to-cloudshell.png =50%x*)

    You can check the upload status during the upload. Once *Completed*, click **Hide**.

    ![Verify successful lab2.zip file load in Cloud shell](./images/review-loading-lab2-files-to-cloudshell.png =50%x*)

    Now you can unzip *lab2.zip* file in your home directory (run *pwd* command to review your location).

    ```text
    <copy>unzip lab2.zip</copy>
    ```

    ![Unzipping lab2.zip file in home directory](./images/unzip-lab2-zip-file.png =50%x*)

    Please check that unzip created 2 folders: *data-labeling* and *.oci* (this folder is hidden) with files as presented in image below:

    ![Review unzipped folders and files](./images/review-unzipped-folders-and-files.png =50%x*)

    You can now minimize **Cloud Shell** terminal as you will need it again a little bit later.

    ![Minimize Cloud shell window](./images/minimize-cloudshell.png =150x*)

4. Update config.py file with required configuration parameters

    In order to run the data labeling program properly, you need to make some changes in */data-labeling/config.py* and */.oci/config* files.

    Let's update and configure */data-labeling/config.py* first.

    Pre-prepared *config.py* is basically empty at the beginning:

    ```python
    <copy># for help, run:
    # python3 help.py

    # config file path
    config_file_path="/home/.oci/config"
    # config file profile
    config_profile="DEFAULT"
    # region identifier of DLS Dataset
    # for example: eu-frankfurt-1
    region_identifier="< YOUR REGION >"
    # compartment where DLS Dataset exists
    compartment_id = "ocid1.compartment.oc1.... <YOUR COMPARTMENT OCID> ..."
    # ocid of the DLS Dataset
    dataset_id = "ocid1.datalabelingdataset.oc1.eu-frankfurt-1.... <YOUR DATASET OCID> ..."
    # an array where the elements are all of the labels that you will use to annotate records in your DLS Dataset with. Each element is a separate label.
    labels = ["NORMAL", "PNEUMONIA"]
    # the algorithm that will be used to assign labels to DLS Dataset records
    labeling_algorithm = "first_match"
    # use for first_match labeling algorithm
    first_match_regex_pattern = r'^([^/]*)/.*$'
    # maximum number of DLS Dataset records that can be retrieved from the list_records API operation for labeling
    # limit=1000 is the hard limit for list_records
    list_records_limit = 1000</copy>
    ```

    The first attribute to change is *config\_file\_path*. This is path to *config* file located in *.oci* folder. You should amend it to something like this:

    ```python
    # config file path
    <copy>config_file_path="/home/X_Ray/.oci/config"</copy>
    ```

    where *X\_Ray* is slightly transformed your user name (*X.Ray* to *X\_Ray*)

    To obtain other values and populate missing information in *config.py* check the following tasks:

    **YOUR REGION**

    Probably the easiest way to obtain your region information is to look at the URL. Spot *region* section and copy the value succeeding '=' symbol.

    ![Obtain your region information](./images/obtain-region-information.png =50%x*)

    In our example, region is *eu-frankfurt-1*, but it can not be the case with your tenancy.

    **YOUR COMPARTMENT OCID**

    To obtain your compartment OCID navigate to **Compartments** page.

    ![Navigate to Compartments page](https://oracle-livelabs.github.io/common/images/console/id-compartment.png " ")

    Your **Compartment OCID** is located in **Compartment Information** tab (displayed as default). Click **Show** to display complete OCID and **Copy** to copy it to clipboard.

    ![Obtain your compartment OCID information](./images/obtain-compartment-ocid.png =60%x*)

    **YOUR DATASET OCID**

    **Dataset OCID** can be found on your **Dataset Details Page** under **Data Labeling**.
    **Dataset OCID** information is located in **Dataset information** tab.

    ![Obtain dataset OCID information](./images/obtain-dataset-ocid.png " ")

    When updated, *config.py* file should look like this (some values are masked):

    ```python
    <copy># for help, run:
    # python3 help.py

    # config file path
    config_file_path="/home/X_Ray/.oci/config"
    # config file profile
    config_profile="DEFAULT"
    # region identifier of DLS Dataset
    # for example: eu-frankfurt-1
    region_identifier="eu-frankfurt-1"
    # compartment where DLS Dataset exists
    compartment_id = "ocid1.compartment.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    # ocid of the DLS Dataset
    dataset_id = "ocid1.datalabelingdataset.oc1.eu-frankfurt-1.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    # an array where the elements are all of the labels that you will use to annotate records in your DLS Dataset with. Each element is a separate label.
    labels = ["NORMAL", "PNEUMONIA"]
    # the algorithm that will be used to assign labels to DLS Dataset records
    labeling_algorithm = "first_match"
    # use for first_match labeling algorithm
    first_match_regex_pattern = r'^([^/]*)/.*$'
    # maximum number of DLS Dataset records that can be retrieved from the list_records API operation for labeling
    # limit=1000 is the hard limit for list_records
    list_records_limit = 1000</copy>
    ```

5. Update config file with required configuration parameters

    *config* file is located in *.oci* folder and path to *config* file is specified in *config.py* file - see previous step. This is the file to which *config.py* is referring to in the first line.

    Pay attention to the following entry from *config.py*:

    ```python
    <copy># config file path
    config_file_path="/home/<USER>/.oci/config"</copy>
    ```

    This is the location of the *config* file. It is placed in *.oci* folder.

    Initial content of *config* is as follows:

    ```text
    <copy>[DEFAULT]
    user=<YOUR USER OCID>
    fingerprint=<FINGERPRINT FOR PRIVATE API KEY>
    key_file=<PATH TO YOUR PRIVATE API KEY>
    tenancy=<YOUR TENANCY OCID>
    region=<YOUR REGION></copy>
    ```

    As you can see above, there are several entries in the *config* file that you need to set and configure:

    **YOUR USER OCID**

    In your OCI Console, navigate to **Profile** (top right corner icon) and choose **User settings** from the menu.

    ![Navigate to user profile](./images/navigate-to-user-profile.png =250x*)

    **User Details Page** opens. You can copy your user OCID information from **User Information** tab. Click **Show** to display complete OCID and click **Copy** to copy OCID to *config* file.

    ![Obtain user OCID information](./images/obtain-user-ocid.png " ")

    **FINGERPRINT FOR PRIVATE API KEY**

    On the same, **User Details** page, you can now obtain also **fingerprint for your private API key**. You will generate your private API key, download it and then upload it into your *.oci* folder.

    Click **API Keys** under **Resources** menu on the left and then click **Add API Key**.

    ![Add API key](./images/add-api-key.png =60%x*)

    In the dialog box, click **Download Private Key**. A new *.pem* file will be generated and downloaded to your computer. You will work with this file a bit later.

    In the **API Keys** section check and copy **Fingerprint** - 16 2-digit string, separated by ':'. Copy this string to *config* file.

    ![Obtain fingerprint information](./images/obtain-fingerprint.png " ")

    **PATH TO YOUR PRIVATE API KEY**

    Set this entry to:

    ```text
    <copy>key_file=~/.oci/oci_api_key.pem</copy>
    ```

    You have generated and downloaded this file (still to be renamed) in the previous step, but so far you haven't uploaded it. This will be done in the next step.

    **YOUR TENANCY OCID**

    For your tenancy OCID, open again **Profile** menu and select Tenancy option. 

    ![Navigate to Tenancy profile](./images/navigate-to-tenancy-profile.png =200x*)

    Copy **OCID** from **Tenancy Information** tab and paste it into *config* files

    ![Obtain tenancy OCID information](./images/obtain-tenancy-oci.png " ")

    **YOUR REGION**

    You should have already obtain information about your region. Just reuse it from the previous step.

    You can save *config* file.

    After updates, *config* should like like this (some values are masked):

    ```text
    <copy>[DEFAULT]
    user=ocid1.user.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    fingerprint=11:22:33:44:55:66:77:88:99:00:aa:bb:cc:dd:ee:ff
    key_file=~/.oci/oci_api_key.pem
    tenancy=ocid1.tenancy.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    region=eu-frankfurt-1</copy>
    ```

6. Rename your private key (.pem file you've downloaded) file to oci\_api\_key.pem

    You have already generated and downloaded **Private Key** for your user from OCI.

    The file has a name something like this:

    ```text
    <copy>-12-01-13-16.pem</copy>
    ```

    You'll upload it to OCI in the next step, but just before doing that, rename the file into *oci\_api\_key.pem*.

    ```text
    <copy>mv -12-01-13-16.pem oci_api_key.pem</copy>
    ```

7. Upload oci\_api\_key.pem to OCI.

    In your OCI Console click **Restore** (it should be in left-bottom corner in your console) or open **Cloud Shell** again.

    ![Restore Cloud shell window](./images/restore-cloudshell.png =100x*)

    When **Cloud Shell** is opened, click on **Cloud Shell Menu** again and select **Upload**.

    ![Open menu to start loading files to Cloud Shell](./images/upload-files-using-cloud-shell.png =200x*)

    New dialog window opens. Drop *oci\_api\_key.pem* file to the upload area or select it from your computer. Check file is ready for upload and click **Upload**.

    ![Upload oci_api_key.pem file to Cloud shell](./images/upload-oci-api-key-pem-file.png =50%x*)

    You can monitor the upload process and when completed, confirm *oci\_api\_key.pem* file was uploaded and click **Hide**

    ![Verify oci_api_key.pem is uploaded](./images/check-oci-api-key-pem-is-uploaded.png =50%x*)

    *oci\_api\_key.pem* file is now in your user home folder. (Upload utility always loads file there)

8. Copy oci\_api\_key.pem to .oci folder

    You have to put *oci_\api\_key.pem* into *.oci* folder as specified in configuration, *config* and *config.py*, files. 

    Move *oci\_api\_key.pem* file to *.oci* folder.

    ```text
    <copy>mv oci_api_key.pem .oci</copy>
    ```

    Check *.oci* folder and confirm it contains to files:  *oci\_api\_key.pem* and *config*.

    ```text
    <copy>ls ./.oci -l</copy>
    ```

    ![Verify oci_api_key.pem file has been copied into .oci folder](./images/verify-oci-api-key-pem-is-in-oci-folder.png =50%x*)

    You are now ready to run the data labeling program.

9. Run bulk image labeling program

    You can finally start with bulk image labeling. Make sure you are in *data-labeling* folder in **Cloud Shell** and run *main.py*.

    ```text
    <copy>python3 main.py</copy>
    ```

    Program will run approx. 30 minutes.

    ![Python program main.py is running](./images/main-py-running.png " ")

    Once finished, check if all images are labeled:

    ![Data Labeling is completed](./images/data-labeling-completed.png " ")

    This concludes this lab. You can **proceed to the next lab**.

## Learn More

* [OCI Data Labeling](https://docs.oracle.com/en-us/iaas/data-labeling/data-labeling/using/home.htm)

## Acknowledgements

* **Author** -  
* **Contributors** -   
* **Last Updated By/Date** -  