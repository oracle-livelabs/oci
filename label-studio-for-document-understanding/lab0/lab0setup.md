# Download and install Label Studio and dependencies

## Introduction
In this session we will focus on setting up the environment and downloading the dependencies needed in order to get Label Studio running on your machine.

***Estimated Lab Time*** 10 minutes


### Objectives:

In this lab, you will:
* Download Label Studio
* Setup Label Studio and the dependencies needed
* Setup OCI CLI Authentification

### Prerequisites

This lab assumes you have:
* Basic scripting skills in Python and Bash

## Task 1: Installation steps/Get started

Install Python 3.11.13 in your computer. If you have a newer version of Python, create a new virtual environment with the version 3.11.3.

1. 

	Download the [requirements.txt](files/requirements.txt.zip) file

2. 
  Choose one of the following approaches (venv or conda) and run the corresponding commands in your terminal to set up your environment:

| create virtual environment using virtual environment | create virtual environment using conda |
| ------------- | ------------- |
| python3 -m venv env_name   | conda create --name env_name python=3.11.13 |
| source env_name/bin/activate | conda activate env_name   |
| pip install -r requirements.txt | pip install -r requirements.txt |


## Task 2: Token based authentication

There are multiple ways to generate the session, they are explained in this [guide](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/clitoken.htm), one of the ways (using the browser is explained below). 

1. Ensure that the OCI CLI is set up on your local machine. If it's not already installed, follow this [guide](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm)

2. In the CLI, run the following command
</br> 
    ```
    <copy>
    OCI session authenticate
    <copy>
    ```
3. Select the same region where you have your tenancy running

4. Once the browser opens, enter your credentials to sign in 

5. After successful authentication, close the browser and follow interactive prompt on the terminal. A configuration file will be created.

6. Your key files should now be updated and referenced in your .oci/config file.

</br>
You may now **proceed to the next lab**

## Acknowledgements
* **Authors** 
    - Cristina Granes - AI Cloud Services Black Belt
    - David Attia - AI Cloud Services Black Belt
* **Last Updated By/Date** 
    - David Attia - AI Cloud Services Black Belt, August 2025
