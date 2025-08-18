# Generating tasks list for labeling PDF files

## Introduction
In this session we will focus on setting up the environment and downloading the dependencies needed in order to get Label studio running on your machine.

***Estimated Lab Time*** 5 minutes


### Objectives:

In this lab, you will:
* Download and setup Label Studio with the dependencies needed

### Prerequisites (Optional)

This lab assumes you have:
* Basic scripting skills in Python and Bash

## Task 1: Installation steps/Get started

Install Python3.11.13 in your computer. If you have a newer version of Python, create a new virtual environment with the version 3.11.3. 

1. 

	Download the requirements.txt file below
  [Requirements.txt file](Lab0/requriements.txt)

2. 
  Choose one of the following approaches (venv or conda) and run the corresponding commands in your terminal to set up your environment:

| create virtual environment using virtual environment | create virtual environment using conda |
| ------------- | ------------- |
| python3 -m venv env_name   | conda create --name env_name  |
| source env_name/bin/activate | conda activate env_name   |
| brew install poppler | brew install poppler  |
| pip install -r requirements.txt | pip install -r requirements.txt |


## Task 2: Token based authentication

Follow the instructions in the link below in order to authenticate using the OCI CLI

https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/clitoken.htm 



## Acknowledgements
* **Authors** 
    - Cristina Granés, AI cloud services Black Belt
    - David Attia, AI cloud services Black Belt
* **Last Updated Date** - <08/2025>
