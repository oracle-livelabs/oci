# Create an APM Domain and obtain Data Upload Endpoint and Private Data Key

## Introduction

In this lab, you will create an APM Domain. You will acquire a Data Upload Endpoint and a Private Data Key, which are needed to configure the APM Tracer on the application.

Estimated time: 10 minutes

### Objectives

*	Create an APM Domain
*	Obtain a Data Upload Endpoint and a Private Data Key


### Prerequisites

* This lab requires an [Oracle Cloud account](https://www.oracle.com/cloud/free/). You may use your own cloud account, or a Free tier account, a cloud account that you obtained through a trial.
* To create an APM domain, you will need an Oracle Cloud Account Administrator role or manage apm-domains permission in the target compartment. For more details, refer to the OCI Documentation, [Create an APM Domain](https://docs.oracle.com/en-us/iaas/application-performance-monitoring/doc/create-apm-domain.html).

## Task1: Create an APM domain

1.	From the OCI menu, select **Observability & Management**, then **Administration**.
	![Oracle Cloud console Menu](images/2-1-domain.png " ")

2. Select the **apmworkshop** compartment from the pulldown menu.
		![Oracle Cloud console Menu](images/2-1-2-domain.png " ")

3.	Click **Create APM Domain**.
  ![Oracle Cloud console, Create APM Domain](images/2-2-domain.png " ")
4.	Name your APM domain as **apmworkshop** and select the compartment you created. Add a check to the **Create as Always Free Domain**, then click **Create**.
  ![Oracle Cloud console, Create APM Domain](images/2-3-domain.png " ")


5. Press the refresh button periodically to check the status. This may take a few minutes.
  ![Oracle Cloud console, Create APM Domain](images/2-4-domain.png " ")
6.	Once the job is completed, the status turns to Active with a green icon.
  ![Oracle Cloud console, Create APM Domain](images/2-5-domain.png " ")
  For more details on how to create an APM Domain, refer to the OCI documentation, [Create an APM Domain](https://docs.oracle.com/en-us/iaas/application-performance-monitoring/doc/create-apm-domain.html).

## Task2: Obtain Data Upload Endpoint and Private and Public Data Keys

To upload tracing data to an APM domain, Data Upload Endpoint and both Private and Public Data Keys must be configured in the application’s configuration files. Next, you are going to obtain the values for them and then enter them into the Oracle Cloud console.

1.	Click the link to the APM domain.
  ![Oracle Cloud console, APM Domain](images/3-1-domain.png " ")

2.	In the **APM Domain Information** tab, find **Data Upload Endpoint**, then click **Copy**. Paste the copied value to a text file and save. You will need this value in the later steps in the workshop.

3.	Under **Data Keys**, find **auto\_generated\_private_data\_key**. Click **Copy** and save the value to the text file.

4.  In the same section, find **auto\_generated\_public_data\_key**. Click **Copy** and save the value to the text file.
  ![Oracle Cloud console, APM Domain](images/3-2-domain.png " ")

For more details on Data Upload Endpoint and Data keys, refer to the OCI documentation, [Obtaining Data Upload Endpoint and Data keys](https://docs.oracle.com/en-us/iaas/application-performance-monitoring/doc/obtain-data-upload-endpoint-and-data-keys.html).

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - Yutaka Takatsu, Product Manager, Enterprise and Cloud Manageability
- **Contributors** -
Steven Lemme, Senior Principal Product Manager,  
Anand Prabhu, Sr. Member of Technical Staff,  
Avi Huber, Vice President, Product Management
* **Last Updated By/Date** - Yutaka Takatsu, August 2022
