# Lab 3: Create image library

## Introduction

TBC - To be completed. 

This lab walks you through the steps to organize an image library in Object Storage. You will have an option to download images directlty to OCI Cloud Shell and then from Cloud Shell into Object Storage. Alternatively, you can also load images to Object Storage from your laptop, assuming you have already download images to your laptop. The first approach is faster and recommended.

Estimated time: 30 minutes

### About OCI Object Storage

OCI Object Storage service is an internet-scale, high-performance storage platform that offers reliable and cost-efficient data durability. The Object Storage service can store an unlimited amount of unstructured data of any content type, including analytic data and rich content, like images and videos.

### Objectives

In this lab, you will:

* Create a new bucket within Object Storage
* Set bucket visibility and access
* Download images from Kaggle.com to OCI Cloud Shell
* Load images from OCI Cloud Shell to your bucket
* Alternatively, load images to Object Storage from your computer

### Prerequisites

This lab assumes you have:

* Completed **Lab 1: Setup environment** lab.

## Task 1: Create a new bucket

You will organize your image library in a new **Object Storage Bucket**.

1. Login into OCI using your (new) workshop user

    Login as a user which will be used for managing the image library. Most likely this is the user you've created in the previous lab. You will use this same user to perform the rest of the activities in this workshop.

    You can follow log into OCI steps as described in **Get started** lab.

    ![Navigate to Buckets page](./images/sign-in-as-new-user.png =50%x*)

2. Navigate to Buckets page

    From the **Navigator** menu (top-left corner) select **Storage** and then **Buckets**.

    ![Navigate to Buckets page](./images/navigate-to-buckets.png " ")

3. Create a new bucket

    Please pay attention that you've selected correct compartment, ie. *X-Rays-Image-Classification*.

    Then click **Create Bucket**.

    ![Create a new buckets](./images/create-a-new-bucket.png " ")

4. Define bucket

    When defining a new bucket, you should provide a **Bucket Name** of your choosing and then leave everything else as default:
    * choose *Standard* for **Default Storage Tier**,
    * use *Encrypt* using Oracle managed keys for **Encryption** and
    * provide some **Tags** if you want to improve your OCI management and control.

    ![Define a new bucket](./images/define-a-new-bucket.png " ")

    Finally click **Create** to create a new bucket.

## Task 2: Set visibility

In order to make your image library visible to other users or services, you have to update its visibility. Default visibility is set to *Private*.

One way of changing visibility settings is simply to set visibility to **Public**. However, it is not recommended to use this option from security reasons. It is much better to control visibility and access using Pre-Authenticated Request (PAR), which is explained in the next task.

1. Change visibility

    From your bucket list choose your newly created bucket.

    ![Buckets List](./images/buckets-list.png " ")

2. Click on edit visibility

    In the Bucket Details page, click **Edit Visibility**.

    ![Bucket Details Page](./images/edit-bucket-visibility.png " ")

3. (optional) Update visibility to public

    Please take a look at the note about pre-authenticated requests. It is recommended to use pre-authenticated requests instead of public visibility therefore you can skip this step and continue with the next step.

    If you decided to set visibility to *public* afterall, then complete this and skip the next step.

    Check **Public** radio button and click **Save Changes**. Also pay attention to the **Consider using pre-authenticated requests instead** note.

    ![Update visibility to public](./images/update-visibility-to-public.png =50%x*)

4. Set Pre-Authenticated Request (PAR)

    Oracle recommends using **pre-authenticated requests** instead of public buckets. Pre-authenticated requests support additional authorization, expiry, and scoping capabilities not possible with public buckets.

    This is why you will set and use **Pre-Authentication Request** instead of **public** visibility.

    Click **Pre-Authentication Requests** link under **Resources** and then **Create Pre-Authenticated Request**.

    ![PAR](./images/par.png " ")

    Fill required field in PAR definition and finally click **Create Pre-Authenticated Request**.

    ![Create PAR](./images/define-par.png " ")

    Pre-Authenticated Request details popup window is displayed.

    > **NOTE**: Make sure you **make a copy of the URL** as you will require it later to access and view images. This URL won't be shown again.

    ![Store PAR URL](./images/store-par-url.png =60%x*)

    Click **Close** to return to the **Bucket Details** page.

    ![Bucket Details Page - PAR list](./images/par-list.png " ")

## Task 3a: Load images to Object Storage from Cloud Shell

Original image dataset resides on Kaggle.com. There are several options how to load data into Object Storage. The simplest (but most time consuming) way is to download all images to your laptop and then upload them to the bucket using upload utility from console. This is fine when you are dealing with smaller datasets, but with 5000+ images this process could be a bit lengthy and unproductive. That is why, you can use better and much faster approach:

* download image to OCI Cloud Shell,
* unzip downloaded image dataset to OCI Cloud Shell file system (each user has 5GB of free space available by default)
* perform images bulk load to Object Storage into respective folders in bucket folders.

This procedure will probably save you more than 90% of the time if you don't decide to load images manually. But before you start you need to perform some short setup steps:

1. Install GetCookies in Chrome

    In Chrome, navigate to Chrome Web Store and install *Get cookies.txt* extension. This will help you to store cookie information which is needed to connect and download images from Kaggle.com from command line interface.

    In Chrome, navigate to:

    ```text
    <copy>https://chrome.google.com/webstore/detail/get-cookiestxt/bgaddhkoddajcdgocldbbfleckgcbcid/related</copy>
    ```

    ![Install get cookies](./images/install-get-cookies.png " ")

    ... and click **Add to Chrome**.

    Then follow the dialog:

    ![Add extension window](./images/add-extension-window.png =30%x*)

    ![Add extension notification](./images/add-extension-notification.png =30%x*)

2. Login to Kaggle.com using your account and save GetCookies.txt file

    In order to obtain proper cookies, log into Kaggle.com and obtain cookie information using **Get cookie.txt** extension. If you don't have Kaggle.com account, create one. It is not complicated and is free. And you will need it anyway.

    In your browser search for GetCookie.txt extension and open it.

    ![GetCookies.txt](./images/get-cookies-txt.png " ")

    Get cookies.txt window for www.kaggle.com will open. You have to copy its content to clipboard. Therefore click **Copy**.

    ![Copy cookies.txt](./images/copy-cookie-txt.png " ")

3. Save copied cookie information to local file

    Open a new file on your local laptop and copy clipboard content to this new file. Save it, for example as *kaggle\_cookies.txt*.

    ![Save kaggle-cookies.txt](./images/save-cookie-txt.png " ")

    When your cookie.txt file is locally stored, you can start the loading process.

4. Open Cloud Shell

    Return to your OCI console and open Cloud Shell. You can do it by clicking on **Developer tools** menu icon. From the list of available options, select **Cloud Shell**.

    ![Open Cloud Shell](./images/open-cloudshell.png " ")

    Cloud Shell opens as Command Line Interface (CLI).

    ![Cloud Shell CLI](./images/cloud-shell-cli.png " ")

5. Upload your cookie.txt file to Cloud Shell

    To start downloading images from Kaggle.com, you must first upload your cookie.txt file to Cloud Shell.

    ![Upload utility to Cloud Shell](./images/upload-cookie-file.png =20%x*)

    ![Upload file to Cloud Shell](./images/upload-file-to-home-folder.png =50%x*)

    ![Cookie file uploaded](./images/cookie-file-uploaded.png =50%x*)

    ![Confirm cookie file is uploaded](./images/confirm-cookie-file-is-uploaded.png =50%x*)

    When you've confirmed cookie.txt file has been uploaded, run the following command:

     ```console
    <copy>chmod u=rwx kaggle_cookies.txt</copy>
    ```

6. Download images to Cloud Shell

    Images can be downloaded from Kaggle.com by issuing the following command:

    ```console
    <copy>wget -x -c --load-cookies kaggle_cookies.txt https://www.kaggle.com/datasets/paultimothymooney/chest-xray-pneumonia/download?datasetVersionNumber=2</copy>
    ```

    Image archive download starts and you can track progress. This operation won't take long to complete.

    ![Downloading images from Kaggle](./images/downloading-from-kaggle.png " ")

7. Unzip image archive

    When image archive is downloaded, create a new folder for images and unzip all images into that folder.

    ```console
    <copy>
    mkdir pneumonia-dataset

    unzip www.kaggle.com/datasets/paultimothymooney/chest-xray-pneumonia/download\?datasetVersionNumber\=2 -d pneumonia-dataset/
    </copy>
    ```

    This operation won't take much time as well. After unzip is completed, a new */pneumonia-dataset/chest-xray* folder is created. You will use content of *train* and *val* folders.

    For example, you can check the number of images in /train/NORMAL and /train/PNEUMONIA folders.

    ![Image count by folder](./images/image-count-by-folder.png =50%x*)

8. Load images to Object Storage

    In the last step, you will load images from Cloud Shell to Object storage. 

    Return to Cloud Shell and issue the following command to load images. The content of the *train* folder will be uploaded. This will also create two new folders, NORMAL and PNEUMONIA. respectively:

    ```console
    <copy>
    oci os object bulk-upload -ns frly8pi3k85f -bn X-Ray-Images-for-Training --src-dir /home/X_Ray/pneumonia-dataset/chest_xray/chest_xray/train --overwrite --content-type 'image/jpeg'
    </copy>
    ```

    Again, you can track the process. It might take a little bit longer than download, but not by much. When completed, you can verify the number of images copied into your bucket.

    ![Check the number of images downloaded to Object Storage](./images/x-ray-images-for-training.png " ")

## Task 3b: Alternative option to manually load images to Object Storage

If you successfully completed previous task, task 3a, then simply skip this this one. If not, then you can load our images manually as described below.

The following steps might seem a bit time consuming and far from being optimal as all images will be loaded using **Upload** utility provided on **Bucket Details** page. More elegant way of uploading is already described and performed in previous task.

The main issue with **Upload** is that you can only upload approx. 200 images in one attempt. This means repeating the upload step several times to upload all 5000 images. This step can take approx. 30 minutes to complete.

1. Initiate images **Upload**

    You should still be located in the **Objects** sub-page of the **Bucket Details** page of your bucket.

    Navigate to the *PNEUMONIA* folder. You will have to create *PNEUMONIA* folder first: click **More Actions** and select **Create Folder**.

    ![Upload images to PNEUMONIA folder](./images/upload-to-pneumonia-folder.png " ")

    And click **Upload**.

2. Upload images for *PNEUMONIA*

    In the dialog window leave **Object Name Prefix** empty, and leave **Storage Tier** unchanged, ie. *Standard*.

    Then **drag image files** or **select files** from your computer (images from local folder *TRAIN/PNEUMONIA*) onto **Choose Files from your Computer Area**. When ready, **Upload** button will become enabled (blue). Please note that you can upload approx. 200 images in one upload job and that you will need to make several iterations to upload all of approx 3800 images for *PNEUMONIA*.

    Click **Upload** and wait all images are uploaded.

    ![Upload pneumonia images in iterations](./images/iterative-upload.png " ")

    Repeat this step for all 3800 images for *PNEUMONIA*.

3. Upload images for *NORMAL*

    Repeat the previous two steps, except this time for *NORMAL* folder and upload images from *TRAIN/NORMAL* local folder.

    ![Upload images to NORMAL folder](./images/upload-to-normal-folder.png " ")

    There should be approx. 1300 images for *NORMAL*.

## Task 4: Verify images are loaded properly

When you have successfully completed the task of loading images to Object Storage, make sure that you've uploaded all images and that images are correctly placed in *PNEUMONIA* and *NORMAL* folders:

1. Verify images are loaded into proper folders.

    ![Verify loaded images for pneumonia](./images/verify-pneumonia-folder.png " ")

    ![Verify loaded images for normal](./images/verify-normal-folder.png " ")

2. Check if you can see your images

    You are using a private bucket with pre-authenticated request. This means, that you will not be able to see your image using URL provided in object details.

    Navigate to one of the folders, ie. NORMAL and click on the menu icon on the right. Select **View Object Details**. 

    ![View object details menu](./images/view-object-details.png " ")

    This opens details of selected image. If the visibility is set to public, then image URL will contain active link and you will be able to view an image. If it is set to private, then image URL is simple text.

    ![Image URL](./images/image-url.png " ")

    Copying image URL into your browser will not display an image, because visibility for the bucket is set to *private*. In order to be able to view an image, you must replace first part of the image URL with the URL that you stored when you were creating pre-authenticated request (PAR).

    For example, if the URL of an image is:

    ```text
    https://objectstorage.eu-frankfurt-1.oraclecloud.com/n/...domain.../b/X-Ray-Images-for-Training/o/PNEUMONIA%2Fperson1000_bacteria_2931.jpeg
    ```

    and PAR URL is:

    ```text
    https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/...some code.../n/...domain.../b/X-Ray-Images-for-Training/o/
    ```

    then replace first part of the image URL with PAR URL and add only image name at the end, for example: `PNEUMONIA/person1000_bacteria_2931.jpg`. New URL should look like this:

     ```text
    https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/...some code.../n/...domain.../b/X-Ray-Images-for-Training/o/PNEUMONIA%2Fperson1000_bacteria_2931.jpeg
    ```

    You can now open an image with this combined URL, for example:

    ![Image URL using PAR URL](./images/image-url-using-par.png " ")

    If you don't use combined URL, then your browser would display the following error:

    ![Image URL using error](./images/image-url-error.png " ")

    This concludes this lab. You can **proceed now to the next lab**.

## Learn More

* [OCI Object Storage](https://docs.oracle.com/en-us/iaas/Content/Object/home.htm)
* [OCI CLI Command Reference](https://docs.oracle.com/en-us/iaas/tools/oci-cli/3.22.3/oci_cli_docs/oci.html)


## Acknowledgements 