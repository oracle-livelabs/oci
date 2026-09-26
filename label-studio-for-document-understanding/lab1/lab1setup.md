# Prepare files for a Label Studio dataset

## Introduction

In this WorkShop, we provide a sample of fake invoices in PDF format and you will need to convert to images for Label Studio. 
If you desire, you can also follow the Workshop with your own data.

PDF files will be converted to images since Label Studio does not natively support PDF annotation.
</br>
Ref: https://labelstud.io/blog/new-in-label-studio-1-15-fundamental-tools-for-pdf-labeling/.
</br>


***Estimated Lab Time*** 5 minutes


### Objectives:

In this lab, you will:
* Download some PDF documents: examples of fake invoices (optional)
* Download and install poppler Library for PDF manipulation in Python
* Bulk convert PDF files into Label Studio supported format
* Prepare a json as a starting point for Label Studio

### Prerequisites

* Having Python3 installed and configured on your local machine (refer [setup](../Introduction/introduction.md))

This lab assumes you have:
* All previous labs successfully completed.
* Basic scripting skills in Python and Bash

## Task 1: Installing and running Poppler 

Poppler is an open source Python Library for rendering and manipulating documents.
In this task, we will be installing Poppler and that requires different steps depending on your operating system (Windows, Mac).

### **For Windows:**


1. Download the latest poppler package version from [github](https://github.com/oschwartz10612/poppler-windows/releases/) 

2. Locate the bin/ directory in the installed package.
  </br>
  Identify the folder you want to add to your system’s PATH. For example, assume the full path to the bin directory is: C:\path\to\your\bin\folder.

3. Open Environment Variables in your System
    - Press Windows key + R to open the Run dialog, type `sysdm.cpl` and click Enter.
    - Navigate to the 'Advanced' tab in the System properties pop up window.
    - In the System Properties window, click on the “Environment Variables” button at the bottom.
  	  ![Environment variables screen on windows](images/environment_variables.png =30%x*)

4. Edit the PATH variable
    - In the Environment Variables window, under “System variables,” find the “Path” variable and select it.
    ![Path variable under system variables screen on windows](images/edit_path.png =30%x*)
    - Click the “Edit” button.

5. Add the bin/ folder to the PATH:
    - In the Edit Environment Variable window, click the “New” button.
    - Type or paste the full path to your “bin” folder (e.g., “C:\path\to\your\bin\folder”).
    - Click “OK” to close all the windows.

6. Verify your installation 
   - Test that all the steps went well by opening cmd and making sure that you can call 
    ```bash
     pdftoppm -h 

    ```
    Your terminal should display the version of Poppler you have installed.

### **For Mac**

1. Install Poppler in Mac using the following command in Terminal:

    ```bash
    brew install poppler

    ```
2. Verify your installation 
  - Test that all the steps went well by opening cmd and making sure that you can call 
    ```bash
     pdftoppm -h 

    ```
    Your terminal should display the version of Poppler you have installed.

## Task 2: Download the examples (optional if you want to use your own data)

As mentioned, we provide some fake invoices to practise the setup and training of custom models in Document Understanding.
The examples contain 3 different simple layouts, one with fake IBAN information that is not extracted using the pretrained Key-Value model but can be extracted with a custom model.

Download [zip file](dataset/synthetic_dataset_invoices.zip), which contains the PDFs.

## Task 3: Converting your PDF files into Label Studio supported format and creating json with tasks for Label Studio

1. We will convert the required PDF files into PNG format to ensure compatibility with Label Studio. Each PDF file will be split into its own folder, and each page within the PDF will be saved as a separate PNG image. If the conversion is not needed, only a json will be created. The resulting file structure is shown below for PDFs:

	![Converted PDF file structure](images/folder_structure.png =40%x*)

2. Download [this Python code](code/generate_ls_tasks.py) and open it in a code editor of your choice (i.e. VSCode)

    _**Note**: For Mac add the following line of code at the beginning:_
    
    ```os.environ["PATH"] = "/opt/homebrew/bin:" + os.environ["PATH"]``` 
    
    _It ensures that the system can locate the binaries installed via Homebrew to convert PDFs to images._

3. Modify the following variables to reflect your local file paths at the end of the code:

    - `ls_document_root` – Set this variable to the directory that contains the folder where your PDF files are stored.
    - `input_root` – This should point one level deeper than `ls_document_root`; it should be the folder that directly contains your PDF files.
    - `output_json` – Specify the name of the JSON file to be generated. You don’t need to create this file manually—it will be created for you. 

4. Next, open a new terminal window and navigate to the directory where your code is saved by running:
  
    ``` 
    cd <path\to\your\code\directory>
    ```

5. Now, verify that Python is installed on your machine by executing the following command:

    ```
    python --version
    ```

    If Python is properly installed, you will see the current version displayed (e.g., Python 3.11.13). If not, refer to the setup section to install Python on your machine.

6. Run the following command to execute the script:
    ```
    python generate_LS_tasks.py 
    ```

7. If the script runs successfully, you should see the following message in your terminal (with X representing the number of PDF files converted or the number of images):
    
    ```
    JSON created with X entries and saved to `output_json`
    ```
    _`output_json`: must be the JSON name you specified_

At this point, you have successfully generated a task list that includes links to your images or your PDF files (now in image format), ready to be imported into Label Studio.

</br>
You may now **proceed to the next lab**

## Acknowledgements
* **Authors** 
    - Cristina Granes, AI Cloud Services Black Belt
    - David Attia, AI Cloud Services Black Belt
* **Last Updated By/Date**  
    - Cristina Granes, AI Cloud Services Black Belt - August 2025
