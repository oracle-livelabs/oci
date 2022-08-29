## Introduction

### Objectives

## Task 1: Object storage bucket setup

1. Click the main menu icon to open the side menu.
2. Click **Storage** and then click **Buckets**. Click **Create Buckets**.
3. Create two buckets, one called *input*, and another called *output*. In each case, leave the remaining values as they are and click **Create**.
4. Click [here](https://github.com/oracle-livelabs/oci/raw/main/oci-vision-inventory/images/model/test.jpg) to download the sample test image. 
5. Upload *test.jpg* to the *input* bucket.

## Task 2: Compute instance setup

1. Connect to your instance via SSH

      ```bash
      <copy>ssh -i ~/.ssh/<your_ssh_key> opc@<your_VM_instance_public_IP></copy>
      ```

2. Install the OCI CLI

      ```bash
      <copy>sudo dnf install oraclelinux-developer-release-el8
      sudo dnf install python36-oci-cli</copy>
      ``` 

3. Upload *config* and *oci_api_key.pem* to the instance

      ```bash
      <copy>scp -i ~/.ssh/<your_ssh_key> config oci_api_key.pem opc@<your_VM_instance_public_IP>:/home/opc</copy>
      # Run from your local environment
      ```

4. Move the files to ~/.oci/ and fix permissions

      ```bash
      <copy>mkdir ~/.oci/
      mv config oci_api_key.pem ~/.oci/
      cd ~/.oci/
      chmod 600 *</copy>
      ```

5. Download and install the Python wheel file

      ```bash
      <copy>cd
      wget https://github.com/oracle-livelabs/oci/raw/main/oci-vision-inventory/files/vision_service_python_client-0.3.99-py2.py3-none-any.whl
      sudo su
      pip3 install vision_service_python_client-0.3.99-py2.py3-none-any.whl</copy>
      ```

## Task 3: Test the model using the Python SDK

1. While connected to your Compute instance, download *pipes.py*

      ```bash
      <copy>wget https://github.com/oracle-livelabs/oci/raw/main/oci-vision-inventory/files/pipes.py</copy>
      ```

2. Replace the entries in *pipes.py* with the following:

      ```bash
      endpoint = "https://vision.aiservice.us-ashburn-1.oci.oraclecloud.com"
      object_detection_modelid = "<your_vision_model_ocid>"
      namespace = "<your_tenancy_namespace>"
      input_bucket = "input"
      output_bucket = "output"
      compartment = "<your_compartment_ocid>"
      start_image = "test.jpg"
      ```

3. Run the program. Observe that the last element in the command line response will be the pipe count.

      ```bash
      python3.6 pipes.py
      ```

## Acknowledgements

* **Author** - Nuno Gonçalves
* **Last Updated By/Date** - Nuno Gonçalves, August 2022