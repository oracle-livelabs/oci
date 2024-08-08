# Configure OCI Logging

## Introduction

This lab provides instructions to configure the OCI Logging service.

Estimated Lab Time: 05 minutes

### Objectives

In this lab, you will:

* Create a Log Group
* Create a Custom Log

## Task 1: Create a Log Group

1. From the Oracle Cloud Console navigation menu, go to **Observability & Management**. Under **Logging**, click **Log Groups**.

   ![Logging Menu](https://oracle-livelabs.github.io/common/images/console/logging.png)

2. Under **List scope**, select your workshop compartment.

    ![Select Compartment Button](images/select-compartment-button.jpg)

3. Click **Create Log Group**.

    ![Create Log Group Button](images/log-group-create-button.jpg#input)

4. You will see the **Create Log Group** screen. Enter the Name as "MicronautLogGroup". Click **Create** to create the Log Group.

    ![Create Log Group Screen](images/log-group-create-screen.jpg#input)

## Task 2: Create a Custom Log

1. From the **MicronautLogGroup** details screen, click **Logs** under **Resources**. Click **Create custom log**.

    ![Create Custom Log Button](images/custom-log-create-button.jpg#input)

2. You will see the **Create custom log** wizard. Enter the Custom log name as "MicronautCustomLog". Select Log group as "MicronautLogGroup" from the drop down list (if it's not already selected). Click **Create custom log** to proceed to **Create agent config**.

    ![Create Custom Log Screen 1](images/custom-log-create-screen-1.jpg#input)

3. On the **Create agent configuration** screen, select the **Add configuration later** option. Click **Create agent config**.

    ![Create Custom Log Screen 2](images/custom-log-create-screen-2.jpg#input)

4. From the Logs list, click **MicronautCustomLog** to go to the Log details screen.

    ![Open MicronautCustomLog](images/micronaut-custom-log-open.jpg#input)

15. From the **Log Information** tab of the **MicronautCustomLog** details screen, click **Copy** to copy the Log OCID. You’ll need it to configure the application in the next step.

    ![Copy MicronautCustomLog OCID](images/micronaut-custom-log-copy-ocid.jpg#input)

Congratulations! In this lab, you configured OCI Logging by creating a Log Group and a Custom Log object.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
