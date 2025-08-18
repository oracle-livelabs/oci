# Generating tasks list for labeling PDF files

## Introduction

Label Studio does not natively support PDF annotation.
</br>
Ref: https://labelstud.io/blog/new-in-label-studio-1-15-fundamental-tools-for-pdf-labeling/.
</br>
If the files you plan to label are in the supported formats (jpg, jpeg, png, gif, bmp, svg, webp), you can import them directly into Label Studio and [Skip to Lab 2](../Lab2/setup.md) . Otherwise if you would like to label documents in PDF format proceed with this lab.

***Estimated Lab Time*** 5 minutes


### Objectives:

In this lab, you will:
* Download and install poppler Library for PDF manipulation in Python
* Bulk convert PDF files into Label Studio supported format

### Prerequisites (Optional)

* Having Python3 installed and configured on your local machine (refer [setup](../Introduction/introduction.md))

This lab assumes you have:
* All previous labs successfully completed.
* Basic scripting skills in Python and Bash

## Task 1: Installing and running Poppler on Windows

Poppler is an open source Python Library for rendering and manipulating documents

1. Download the latest poppler package version from [github](https://github.com/oschwartz10612/poppler-windows/releases/) 

2. 
  Locate the bin/ directory in the installed package.
  </br>
  Identify the folder you want to add to your system’s PATH. For example, assume the full path to the bin directory is: C:\path\to\your\bin\folder.

3. 
  Open Environment Variables in your System
  - Right-click on “This PC” (or “My Computer” in older versions of Windows) and select “Properties”.
  - In the System window, click on “Advanced system settings” in the left-hand pane.
  - In the System Properties window, click on the “Environment Variables” button at the bottom.
  	![Environment variables screen on windows](images/environment_variables.png =50%x*)

4. Edit the PATH variable
  - In the Environment Variables window, under “System variables,” find the “Path” variable and select it.
  ![Path variable under system variables screen on windows](images/edit_path.png =50%x*)
  - Click the “Edit” button.

5. 
  Add the bin/ folder to the PATH:
  - In the Edit Environment Variable window, click the “New” button.
  - Type or paste the full path to your “bin” folder (e.g., “C:\path\to\your\bin\folder”).
  - Click “OK” to close all the windows.

6. 
  Verify your installation 
  - Test that all the steps went well by opening cmd and making sure that you can call 
    ```
     pdftoppm -h 

    ```
    Your terminal should display the version of Poppler you have installed.

## Task 2: Installing and running Poppler on Mac

Poppler is an open source Python Library for rendering and manipulating documents

1. Step 1


2. Step 2


3. 


4. 


5. 


6. 


## Task 3: Converting your PDF files into Label Studio supported format 

If the files you intend to label are in supported image formats (jpg, jpeg, png, gif, bmp, svg, webp), you can import them directly into Label Studio and skip this step. However, if your documents are in PDF format—which Label Studio does not support—you'll need to follow the steps below to prepare them for labeling.

1. We will convert the required PDF files into PNG format to ensure compatibility with Label Studio. Each PDF file will be split into its own folder, and each page within the PDF will be saved as a separate PNG image. The resulting file structure is shown below:

	![Converted PDF file structure](images/folder_structure.png)

2. Copy and paste the code below into a code editor of your choice 

    ```

      <copy>
      import os
      import json
      from pathlib import Path
      from pdf2image import convert_from_path
      
      def pdf_to_images(pdf_path, output_folder):
          
          # Converts a PDF to images and saves them in a folder named after the PDF inside output_folder.

          pdf_name = pdf_path.stem
          save_folder = output_folder / pdf_name
          save_folder.mkdir(parents=True, exist_ok=True)
      
          # Skip conversion if images already exist
          if any(save_folder.iterdir()):
              return save_folder
      
          pages = convert_from_path(str(pdf_path), dpi=300)
          for idx, page in enumerate(pages):
              image_path = save_folder / f"page_{idx + 1}.png"
              page.save(str(image_path), 'PNG')
      
          return save_folder
      
      def generate_label_studio_tasks_json(ls_document_root, input_root, output_json, prefix="/data/local-files/?d="):
          
          # Scans input_root for PDFs and images, converts PDFs to images in output_images with the same structure,
          # and creates a Label Studio JSON.

          # Args:
              # ls_document_root (str): Label Studio document root. Same as LABEL_STUDIO_LOCAL_FILES_DOCUMENT_ROOT env variable.
              # input_root (str): Root directory containing PDFs and images.
              # output_json (str): Path to save the generated JSON.
              # prefix (str): Prefix to replace the local root path for Label Studio.
      
          # Returns:
              # int: Number of tasks created.

          input_root = Path(input_root)
          output_root = input_root.parent / "output_images"
          output_root = input_root.parent / f"Images_{input_root.name}"
          output_root.mkdir(parents=True, exist_ok=True)
      
          ls_document_root = Path(ls_document_root)
          tasks = []
          
          for root, _, files in os.walk(input_root):
              root_path = Path(root)
          
              for file in sorted(files):
                  document_path = root_path / file
                  file_lower = file.lower()
                  if file_lower.endswith('.pdf'):
                      relative_folder = root_path.relative_to(input_root)
                      output_folder = output_root / relative_folder
                      output_folder.mkdir(parents=True, exist_ok=True)
      
                      # Convert PDF to images
                      image_folder = pdf_to_images(document_path, output_folder)
      
                      # Build base URL for Label Studio
                      base_task_url = f"{prefix}{image_folder.relative_to(ls_document_root)}"
                      pdf_label_studio_path = f"{prefix}{document_path.relative_to(ls_document_root)}"
      
                      task = {
                          "data": {
                              "document": pdf_label_studio_path,
                              "pages": [],
                              "ls_document_root": str(ls_document_root)
                          }
                      }
      
                      images = sorted(image_folder.iterdir())
                      for img in images:
                          page_entry = {
                              "page": f"{base_task_url}/{img.name}"
                          }
                          task["data"]["pages"].append(page_entry)
      
                      tasks.append(task)
      
                  elif file_lower.endswith(('.png', '.jpg', '.jpeg', '.tiff', '.bmp', '.gif')):
                      image_label_studio_path = f"{prefix}{document_path.relative_to(ls_document_root)}"
      
                      task = {
                          "data": {
                              "document": image_label_studio_path,
                              "pages": [{
                                  "page": image_label_studio_path
                              }],
                              "ls_document_root": str(ls_document_root)
                          }
                      }
                      tasks.append(task)
      
          # Save JSON
          with open(output_json, "w") as f:
              json.dump(tasks, f, indent=2)
      
          print(f"JSON created with {len(tasks)} entries and saved to {output_json}")
          return len(tasks)
      
      ## Sample Example
      generate_label_studio_tasks_json(
          ls_document_root="/home/raraushk/LS_integration/label_studio/datasets",
          input_root="/home/raraushk/LS_integration/label_studio/datasets/multi_folder",
          output_json="kv_tasks.json"
      )
      </copy>

    ```  

3. Next, open a new terminal window in Windows and navigate to the directory where your code is saved by running:
  
    ```
    cd <path\to\your\code\directory>
    ```

4. Now, verify that Python is installed on your machine by executing the following command:

    ```
    python --version
    ```

    If Python is properly installed, you will see the current version displayed (e.g., Python 3.11.13). If not, refer to the setup section ****Link to the first section***** to install Python on your machine.

5. After confirming Python is installed, you’ll need to modify just three variables at the end of the code:

    - `ls_document_root` – Set this variable to the directory that contains the folder where your PDF files are stored.
    - `input_root` – This should point one level deeper than `ls_document_root`; it should be the folder that directly contains your PDF files.
    - `output_json` – Specify the name of the JSON file to be generated. You don’t need to create this file manually—it will be created for you. 

6. Once you’ve updated the variables to reflect your local file paths, run the following command to execute the script:
    ```
    python file_name.py 
    ```

7. If the script runs successfully, you should see the following message in your terminal (with X representing the number of PDF files converted):

    ```
    JSON created with X entries and saved to kv_tasks.json
    ```
At this point, you have successfully generated a task list that includes links to your PDF files (now in image format), ready to be imported into Label Studio.

## Acknowledgements
* **Authors** 
    - Cristina Granés, AI cloud services Black Belt
    - David Attia, AI cloud services Black Belt
* **Last Updated By/Date** - <08/2025>
