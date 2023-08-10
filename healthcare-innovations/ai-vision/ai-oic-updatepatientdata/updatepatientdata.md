# Update Patient Details Integration - Oracle Integration Cloud 

## Introduction

This lab is an extension of the previous lab. Here we will create an Integration service to update patient record based on patient id.
  
Estimated time: 30 minutes
 
### Objectives

In this lab, you will:
 
* Create Autonomous Database Connection Connection from OIC. 
* Create an Integration point to **Update a Patient record** in the Patients Table.
* Send Notification Emails.

### Prerequisites

This lab assumes you have the following:

* Completed Setup environment and Created an Oracle Autonomous Database lab and already logged into OCI console.
* Integration Cloud Generation 2 has already been created.
* AI Vision Model is ready and has an Application user interface to get details about patient user information such as XRay analysis data, xray image location, confidence scoring and basic patient data such as name, email, and date of birth (as in Lab 8).
     
 
## Task 1: Create Second Integration to Update Patient Details

1. Drag and Drop Rest API endpoint.

    ![Integration Cloud](images/update-patient.png =15%x* )
  
2. Edit Icon to get into configuration screens.
 
    ![Integration Cloud](images/integration-03.png =50%x* )

3. Configure rest endpoint. You can name the **endpoint URI** as it as **/updatePatientInfo/{id}**, Select PUT Operation 
   
    ![Integration Cloud](images/integration-04.png =50%x* )

4. You will now see **ID** as a type string as a **Template parameter**

    ![Integration Cloud](images/integration-05.png =50%x* )

5. Request payload should be **JSON** format

    ![Integration Cloud](images/integration-06.png =50%x* )

6. Edit request payload JSON, and it should be as shown below. 

    ![Integration Cloud](images/integration-07.png =50%x* )

7. The response should also be **JSON** format

    ![Integration Cloud](images/integration-08.png =50%x* )

7. Click Next, OK and Done button.

    ![Integration Cloud](images/integration-09.png =50%x* ) 

    ![Integration Cloud](images/integration-10.png =50%x* )
 
## Task 2: Drag and Drop Database Connection Adapter
 
1. Add Oracle Database Adapter Endpoint  
 
    ![Integration Cloud](images/integration-13.png =15%x* )
  
2. Select the Schema and Table name.  We would need **Update** Operation on a Patient table based on Patient Id. 

    ![Integration Cloud](images/integration-14.png =50%x* )

3. Select the Patient Table. 

    ![Integration Cloud](images/integration-15.png =50%x* )

4. Select the columns in the Table.

    ![Integration Cloud](images/integration-16.png =50%x* )

5. Review the summary and click Done.

    ![Integration Cloud](images/integration-17.png =50%x* )

## Task 3: Add Mapper

1. Add Mapper before Oracle Database Adapter  
 
    ![Integration Cloud](images/mapper.png =15%x* )

2. Map Request Parameter from REST endpoint to Database Adapter endpoint Request JSON

    ![Integration Cloud](images/map.png =50%x* )
 
## Task 4: Send Notification Email

1. Select the columns in the Table.

    ![Integration Cloud](images/integration-18.png =15%x* ) 

2. Edit the Notification Icon. Provide From email id, To email, Subject and message body 

    ![Integration Cloud](images/integration-19.png =50%x* )

3. Use expression builder to get dynamic variables like Administrator's comments
   
    ![Integration Cloud](images/integration-20.png =50%x* )

4. Add Business Identity for Tracking.

    ![Integration Cloud](images/integration-21.png =50%x* )

## Task 5: Activate and Test Integration.

1. Activate and Test Integration

    ![Integration Cloud](images/test-integration-01.png =50%x* )

2. Under **URI** Parameters tab, provide patient id, and under **Body**, provide the JSON data to update the record

    ![Integration Cloud](images/test-integration-02.png =50%x* )

3. Test and Verify Integration if there are no errors.

    ![Integration Cloud](images/test-integration-03.png =50%x* )

4. Log in to Oracle APEX Workspace and verify if the patient data has been updated based on ID.
  
    ![Integration Cloud](images/test-integration-05.png =50%x* )

5. Showing the patient Id

    ![Integration Cloud](images/test-integration-06.png =50%x* )

6. View Notification Email

    ![Integration Cloud](images/notification-mail.png =50%x* )
  
## Task 6: Complete Integration flow.

1. The complete integration flow accepts input JSON and updates the corresponding record based on Patient Id. In addition, it also sends a notification email.

    ![Integration Cloud](images/integration-01.png =75%x* ) 
  
  
    You can **proceed now to the next lab**.

## Learn More

* [Oracle Integration 3](https://docs.oracle.com/en/cloud/paas/application-integration/index.html)
* [Oracle Integration Generation 2](https://docs.oracle.com/en/cloud/paas/integration-cloud/index.html)
 
## Acknowledgements

* **Author** - Madhusudhan Rao B M, Principal Product Manager, Oracle Database
* **Last Updated By/Date** - 18th July, 2023.
 