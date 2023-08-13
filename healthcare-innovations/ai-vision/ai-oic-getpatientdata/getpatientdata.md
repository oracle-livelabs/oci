# Get Patient Details Integration - Oracle Integration Cloud 

## Introduction

In this Lab, you will learn how to create Oracle Integration Cloud Integration Service and Process automation for the Patient Admission process. We will use Integration Cloud [OIC] Generation 2 and its Process flow in this Lab. 

Optionally you can use Integration Cloud Generation 3, but the screenshots below will differ slightly. In Generation 3, You have to create Oracle Process Automation and Oracle Integration Cloud services separately or login to Integration cloud generation 3 service and enable Process Automation. OIC Generation 3 is not covered in this Lab.

Estimated time: 30 minutes

### Objectives

In this lab, you will:
 
* Create Autonomous Database Connection Connection from OIC.
* Create Integration point to **Select Patient record from Patients Table**. 
* Send Notification Emails.

### Prerequisites

This Lab assumes you have the following:

* Completed **Setup environment** and **Created an Oracle Autonomous Database** lab and already logged into OCI console.
* Integration Cloud Gen 2 has already been created.
* AI Vision Model is ready and has an Application user interface to get details about patient user information such as XRay analysis data, xray image location, confidence scoring and basic patient data such as name, email, and date of birth.

> **Note:** You are at the beginning of **Part 9** Labs.
 
### Process flow

**Breast Cancer Patient Admission Use case and process flow** (with Integration Cloud and Process Automation):

* The patient or medical consultant uploads an X-ray mammography image, and AI Vision detects that it can be a case of Breast cancer/ Lung cancer, Covid, or Pneumonia.
* The patient consults a doctor by submitting the X-Ray report and basic information ( through AI for Healthcare portal).
* The doctor gets a mail requesting a review of the patient's case with the patient's name and ID.
* The doctor reviews the patient's details and recommends that the patient be admitted to the hospital for immediate care and treatment.
* The hospital administrator gets a mail requesting patient admission.
* They allocate Hospital beds and other joining formalities.
* The patient gets notified and can view this detail in AI for the Healthcare portal.
* The patient is asked to upload medical history and complete the joining formalities.
* There is also a future scope to integrate with the billing system for doctor consultation fees and hospital admission charges. Lab testing process, for example, checking the patient blood sugar level, blood pressure, cardiovascular condition etc, is part of the initial joining formalities.
* Oracle Analytics Cloud shows the Patient's Initial checkup history until the admission is completed. This report is also visible from the AI for Healthcare portal.
  
### About Oracle Integration Generation 2

Oracle Integration [OIC] is a fully managed, pre-configured environment that gives you the power to integrate your cloud and on-premises applications, automate business processes, gain insight into your business processes, develop visual applications, use an SFTP-compliant file server to store and retrieve files, and exchange business documents with a B2B trading partner.

With Oracle Integration, you can:

* Design integrations to monitor and manage connections between your applications, selecting from our portfolio of hundreds of prebuilt adapters and recipes to connect with Oracle and third-party applications.
* Create process applications to automate and manage your business work flows, whether structured or dynamic.
* Model and extract meaningful metrics for your business processes to achieve real-time visibility and react quickly to changing demands. 
* Develop visual applications using the embedded Visual Builder feature.
* Store and retrieve files in Oracle Integration using the embedded SFTP-compliant file server.
* Create integrations that use B2B e-commerce to extend business processes to reach trading partners.
  
## Task 1: Access Autonomous Database Instance and Download Wallet

1. Log in to the Oracle Autonomous Database cloud console.

    ![Access ADB](images/adb-instance.png =50%x* )

2. Click on **Database Connection** and Download wallet

    ![Download Wallet](images/download-wallet.png =50%x* )

3. Copy the **Connection string**, We would need this later.

    ![Connection Details](images/connection-details.png =50%x* )
  
## Task 2: Log in to Oracle Integration Cloud and Create an Oracle Autonomous Warehouse Database connection

1. Log in to Oracle Integration Cloud (Generation 2). 

    ![Connection Details](images/oic-service.png =50%x* )

2. Click on **Create Connection**

    ![Connection Details](images/create-connection-1.png =50%x* )

3. Select Oracle Autonomous Warehouse, Provide Hostname, Port and SID

    ![Connection Details](images/provide-db-hostname.png =50%x* )

4. Under Security, select JDBC over SSL, Upload Database Wallet, Provide database username and password, and save and test the connection.

    ![Connection Details](images/adb-security.png =50%x* )

## Task 3: Create the First Integration to Get Patient Details

1. Select App Driven Integration to Get Patient Details based on Patient ID received through an Email.

    ![Integration Cloud](images/integration-01.png =50%x* )

2. Drag and Drop Rest API Connection
 
    ![Integration Cloud](images/integration-03.png =15%x* )

3. Under the Configuration screen, provide the name and basic details about the integration endpoint, click Next
   
    ![Integration Cloud](images/integration-04.png =50%x* )

4. Configure rest endpoint. You can name the **endpoint URI** as it as **/getPatientInfo/{id}**

    ![Integration Cloud](images/integration-05.png =50%x* )

5. You will now see **ID** as a type string as a **Template parameter**

    ![Integration Cloud](images/integration-06.png =50%x* )

6. Edit response payload JSON, and it should be as shown below. and Type should be **JSON** format

    ![Integration Cloud](images/integration-07.png =50%x* )

    ![Integration Cloud](images/integration-08.png =50%x* )

7. Click Next and Done button.

    ![Integration Cloud](images/integration-09.png =50%x* ) 
 
## Task 4: Create Autonomous Database Connection from Integration Cloud

1. At this stage, if you see an error message, just drag and drop **ID** under **Business Identifier for Tracking**

    ![Integration Cloud](images/integration-11.png =50%x* )
    
    ![Integration Cloud](images/integration-10.png =50%x* )

2. Create one more integration point that connects to Autonomous Database and Gets a record based on the Patient ID
3. Add Oracle Database Adapter Endpoint  
 
    ![Integration Cloud](images/integration-12.png =15%x* )

4. We would need **Select** Operation on a table.

    ![Integration Cloud](images/integration-13.png =50%x* )

5. Select the Schema and Table name.

    ![Integration Cloud](images/integration-14.png =50%x* )

6. Select the columns in the Table.

    ![Integration Cloud](images/integration-15.png =50%x* )

7. In the expression editor, map the ID as shown.

    ![Integration Cloud](images/integration-16.png =50%x* )

8. Verify the Select Query.

    ![Integration Cloud](images/integration-17.png =50%x* )

9. Set Maximum records to 1 as we get single patient records based on ID.

    ![Integration Cloud](images/integration-18.png =50%x* )

10. Verify Summary and SQL Query.

    ![Integration Cloud](images/integration-19.png =50%x* )

11. Click on the Done button.

    ![Integration Cloud](images/integration-20.png =50%x* )
 
## Task 5: Add Mapper to Map JSON Payload

1. Add Mapper before Autonomous Database Connection Adapter 

    ![Integration Cloud](images/integration-21.png =15%x* )

2. Map from **Template Parameter** ID to **Request Parameter** ID of Database

    ![Integration Cloud](images/integration-22.png =50%x* )

3. Drag and Drop Mapper after Database Connection Adapter

    ![Integration Cloud](images/integration-23.png =50%x* )

4. Click on Edit Mapper Icon

    ![Integration Cloud](images/integration-24.png =15%x* )

5. Map from Patient Collection to Get Patient Details Response JSON

    ![Integration Cloud](images/integration-25.png =50%x* )
 
## Task 6: Add Email Notification

1. Drag and Drop Notification Icon

    ![Integration Cloud](images/integration-26.png =50%x* )

2. Drop the Notification Icon after Mapper

    ![Integration Cloud](images/integration-27.png =15%x* )

3. Complete From mail address, To mail address. You can add parameters to map values from a database table through the expression builder

    ![Integration Cloud](images/integration-28.png =50%x* )

4. Example showing patient id being mapped in the expression builder. 

    ![Integration Cloud](images/integration-29.png =50%x* )

5. Similarly, you will also need the Patient's name to be sent in the email.

    ![Integration Cloud](images/integration-30.png =50%x* )

6. Map Patient Name.
  
    ![Integration Cloud](images/integration-31.png =50%x* )

## Task 7: Activate the Integration and Test the Integration Service

7. Click on the power button to Activate Integration

    ![Integration Cloud](images/integration-32.png =50%x* )

8. Click on the **Test** link

    ![Integration Cloud](images/integration-34.png =50%x* )

9. Provide the Patient ID and click on Test Button. You should now see the JSON response of patient data from the database table, as shown.

    ![Integration Cloud](images/integration-35.png =50%x* )

## Task 8: View Complete Integration Flow.

1. View the flow to get patient data based on patient id

    ![Integration Cloud](images/integration-33.png =75%x* )

## Task 9: Create Second Integration to Update Patient Details

1. Drag and Drop Rest API endpoint.

    ![Integration Cloud](images/update-patient.png =15%x* )
  
2. Edit Icon to get into configuration screens.
 
    ![Integration Cloud](images/integration-03a.png =50%x* )

3. Configure rest endpoint. You can name the **endpoint URI** as it as **/updatePatientInfo/{id}**, Select PUT Operation 
   
    ![Integration Cloud](images/integration-04a.png =50%x* )

4. You will now see **ID** as a type string as a **Template parameter**

    ![Integration Cloud](images/integration-05a.png =50%x* )

5. Request payload should be **JSON** format

    ![Integration Cloud](images/integration-06a.png =50%x* )

6. Edit request payload JSON, and it should be as shown below. 

    ![Integration Cloud](images/integration-07a.png =50%x* )

7. The response should also be **JSON** format

    ![Integration Cloud](images/integration-08a.png =50%x* )

7. Click Next, OK and Done button.

    ![Integration Cloud](images/integration-09a.png =50%x* ) 

    ![Integration Cloud](images/integration-10a.png =50%x* )
 
## Task 10: Drag and Drop Database Connection Adapter
 
1. Add Oracle Database Adapter Endpoint  
 
    ![Integration Cloud](images/integration-13a.png =15%x* )
  
2. Select the Schema and Table name.  We would need **Update** Operation on a Patient table based on Patient Id. 

    ![Integration Cloud](images/integration-14a.png =50%x* )

3. Select the Patient Table. 

    ![Integration Cloud](images/integration-15a.png =50%x* )

4. Select the columns in the Table.

    ![Integration Cloud](images/integration-16a.png =50%x* )

5. Review the summary and click Done.

    ![Integration Cloud](images/integration-17a.png =50%x* )

## Task 11: Add Mapper

1. Add Mapper before Oracle Database Adapter  
 
    ![Integration Cloud](images/mappera.png =15%x* )

2. Map Request Parameter from REST endpoint to Database Adapter endpoint Request JSON

    ![Integration Cloud](images/mapa.png =50%x* )
 
## Task 12: Send Notification Email

1. Select the columns in the Table.

    ![Integration Cloud](images/integration-18a.png =15%x* ) 

2. Edit the Notification Icon. Provide From email id, To email, Subject and message body 

    ![Integration Cloud](images/integration-19a.png =50%x* )

3. Use expression builder to get dynamic variables like Administrator's comments
   
    ![Integration Cloud](images/integration-20a.png =50%x* )

4. Add Business Identity for Tracking.

    ![Integration Cloud](images/integration-21a.png =50%x* )

## Task 13: Activate and Test Integration.

1. Activate and Test Integration

    ![Integration Cloud](images/test-integration-01a.png =50%x* )

2. Under **URI** Parameters tab, provide patient id, and under **Body**, provide the JSON data to update the record

    ![Integration Cloud](images/test-integration-02a.png =50%x* )

3. Test and Verify Integration if there are no errors.

    ![Integration Cloud](images/test-integration-03a.png =50%x* )

4. Log in to Oracle APEX Workspace and verify if the patient data has been updated based on ID.
  
    ![Integration Cloud](images/test-integration-05a.png =50%x* )

5. Showing the patient Id

    ![Integration Cloud](images/test-integration-06a.png =50%x* )

6. View Notification Email

    ![Integration Cloud](images/notification-maila.png =50%x* )
  
## Task 14: Complete Integration flow.

1. The complete integration flow accepts input JSON and updates the corresponding record based on Patient Id. In addition, it also sends a notification email.

    ![Integration Cloud](images/integration-01a.png =75%x* ) 
 
    You can **proceed now to the next lab**.

## Learn More

* [Oracle Integration 3](https://docs.oracle.com/en/cloud/paas/application-integration/index.html)
* [Oracle Integration Generation 2](https://docs.oracle.com/en/cloud/paas/integration-cloud/index.html)
 
## Acknowledgements

* **Author** - Madhusudhan Rao B M, Principal Product Manager, Oracle Database
* **Last Updated By/Date** - 18th July, 2023.