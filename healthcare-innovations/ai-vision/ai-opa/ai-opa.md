# Create Process Automation for Patient Admission Process

## Introduction

In this lab, you will create end to end patient admission process using Oracle Integration Cloud Generation 2 with Process Automation, you can also create the same Process in Oracle Integration Cloud Generation 3 and enable Process Automation.
 
Estimated time: 60 minutes
 
### Objectives

In this lab, you will:
 
* Create a Patient Admission Process

### Prerequisites

This lab assumes you have the following:

* Completed Setup environment and Created an Oracle Autonomous Database lab and already logged into OCI console
* You have created Integration services as in the last two labs using Oracle Integration Cloud.
  
## Simple - Patient Admission Process

- The patient or medical consultant uploads an X-ray mammography image, and AI Vision detects that it can be a case of Breast cancer/ Lung cancer, Covid, or Pneumonia.
- The patient consults a doctor by submitting the X-Ray report and basic information ( through AI for Healthcare portal).
- The Doctor gets a mail requesting a review of the patient's case with the patient's name and ID.
- The Doctor reviews the patient's details and recommends that the patient be admitted to the hospital for immediate care and treatment.
- The hospital administrator gets a mail requesting patient admission.
- They allocate Hospital beds and other joining formalities.
- The patient gets notified and can view this detail in AI for the Healthcare portal.
- The patient is asked to upload medical history and complete the joining formalities. 
- There is also a future scope to integrate with the billing system for doctor consultation fees and hospital admission charges.
Lab testing process, for example, checking the patient blood sugar level, blood pressure, cardiovascular condition etc, is part of the initial joining formalities.
- Oracle Analytics Cloud shows the complete history of the Patient’s Initial checkup history till the admission is completed. This report is also visible from the AI for Healthcare portal.
 
## Task 1: Create a Patient Admission Process Application.

1. Select Process under the left navigation and create a blank new process
   
2. Add two swim lanes, one for Doctors and the other for Hospital Administrative staff. These are two roles that are part of this Process. In addition, you can also add patients as a part of the Process to extend it.  
   
    ![Integration Cloud](images/process-1.png =50%x* ) 

3. The Process has two human tasks and two integration tasks to keep it simple to start with. Please note that we have already added notification services as a part of integration, so that need not be called at a process level.

    ![Integration Cloud](images/process-2.png =50%x* )

4. Click on Submit Request or Process start point in the first swimlane, Edit on Open Properties

    ![Integration Cloud](images/process-3.png =50%x* )

5. Map the start point to a new form that has 1 parameter, that is ID, which takes input patient ID
   
   ![Integration Cloud](images/process-4.png =50%x* )

6. Add an integration point and invoke Get Patient Information that we have created in an earlier lab.
   
   ![Integration Cloud](images/process-5.png =50%x* )

7. It is important to Map Data Association which data flows from the form page to the integration service
   
   ![Integration Cloud](images/process-6.png =50%x* )

8. ID is mapped from Form to Integration Input ID
   
   ![Integration Cloud](images/process-7.png =50%x* )
 
## Task 2: Add Human Task as Doctor's Activity 

1.  Add Human Task. The name is Doctors Task here. A doctor will review patient details based on the mail that they received, which had a patient name and patient id
   
    ![Integration Cloud](images/process-8.png =50%x* )

2.  This activity is mapped to a Patient Details Form, which will display patient details based on the response back from the Get Patient Details integration service, where input is the patient id
   
    ![Integration Cloud](images/process-9.png =50%x* )
 
3.  We can use Image from Basic Form Pallet to Display XRay Image where XRay Image URL is part of JSON response data from get patient data integration payload
   
    ![Integration Cloud](images/process-10.png =50%x* )
 
3.  Map Integration Response Payload into Form
   
    ![Integration Cloud](images/process-12.png =50%x* )
 
## Task 3: Add Human Task as Hospital Administrator's Activity 

1.  Hospital Administrator will get an email notification with the patient id, patient name and doctor's comments. Patient logs into the Oracle Integration Cloud portal and checks their Worklist
   
2.  Let us start with creating Human Task under Admin swimlane
   
    ![Integration Cloud](images/process-13.png =50%x* )

3.  Let us create a form for Admin where they can view doctors' comments, patient names and patient IDs. They also have the option to add comments, allocate hospital names, hospital beds and admission charges
   
    ![Integration Cloud](images/process-14.png =50%x* )

4.  Update the patient record by calling integration service (update patient record) with all the form data based on patient id
   
    ![Integration Cloud](images/process-15.png =50%x* )

5.  Map Data from Admin Form to Integration Service request parameter
   
    ![Integration Cloud](images/process-16.png =50%x* )

6.  Update the status with a success message to end the Process.

## Task 4: Complete Patient Admission Process  

1. Complete flow of the Patient Admission Process
   
    ![Integration Cloud](images/process-17.png =75%x* )
 
## Task 5: Patient consults Doctor based on a report received.
  
1. Patient or Medical consultant uploads Breast cancer mammography image into AI for the Healthcare portal. AI vision detects if this is the case of Breast cancer or if it is normal tissue.
   
   ![Integration Cloud](images/test-process-01.png =50%x* ) 

2. The patient decides to consult a doctor and fills in basic data, and selects the Doctor whom they want to consult.

   ![Integration Cloud](images/test-process-02.png =50%x* ) 

3. Doctor consultation is confirmed.

   ![Integration Cloud](images/test-process-03.png =50%x* ) 

4. Doctor gets email notification from AI for Healthcare application.

   ![Integration Cloud](images/test-process-07.png =50%x* ) 

## Task 6: Running the Patient Admission Process in Process Player

1. Click on the Test button to test the Process. 
    ![Integration Cloud](images/test-01.png =50%x* ) 

2. Click on the process name

    ![Integration Cloud](images/test-02.png =50%x* ) 

3. Run the Process in the process player 
    ![Integration Cloud](images/test-03.png =50%x* ) 

4. Provide the patient Id based on the email received by the Doctor. APEX Application will trigger the email when the patient clicks on the Consult Doctor button in AI for Healthcare Application.
   
   ![Integration Cloud](images/test-04.png =50%x* ) 

5. Click on Launch Form
   ![Integration Cloud](images/test-05.png =50%x* ) 

6.  View the patient data along with an XRay image of breast cancer mammography of that patient
   ![Integration Cloud](images/test-06.png =50%x* ) 

7.  The Doctor will provide their comments
   ![Integration Cloud](images/test-07.png =50%x* ) 

8.  The administrative officer gets mail from the Doctor to allocate Hospital beds for the patient.
    ![Integration Cloud](images/mail-01.png =50%x* )

9.  The administrative officer will log in to Oracle Integration Portal and review the task under their workflow
   ![Integration Cloud](images/test-08.png =50%x* ) 

10.  The administrative officer will allocate hospital, hospital bed and initial admission charges. They will also add their comments.
   ![Integration Cloud](images/test-09.png =50%x* ) 

11. Approve will take the Process towards completion. That is database record is now updated for the patient.
    ![Integration Cloud](images/test-10.png =50%x* ) 
  
## Task 7: Patient logs into AI for Healthcare portal to get latest update

1.  The patient gets mail to complete the admission formalities
    ![Integration Cloud](images/mail-02.png =50%x* ) 

2. Patient logs into AI for the Healthcare portal to get the latest update and comments from the Doctor and Administrative staff
   ![Integration Cloud](images/test-process-04.png =50%x* ) 

3. Reviews Test Reports and XRay scan
   ![Integration Cloud](images/test-process-05.png =50%x* ) 

4. View the doctor's information.
   ![Integration Cloud](images/test-process-06.png =50%x* ) 

## Task 8: Enhanced - Patient Admission Process

1. Enhanced Patient Admission Process
    
    ![Integration Cloud](images/enhanced-process.png =75%x* ) 
 
    > **Congratulations:**, you have completed **Create Process Automation for Patient Admission Process** Labs. The subsequent labs are optional, however, please proceed to the next lab to learn more about **Setup OCI Email**.  
  
## Learn More
 
* [Oracle Integration Generation 2](https://docs.oracle.com/en/cloud/paas/integration-cloud/index.html)
* [Oracle Cloud Infrastructure Process Automation](https://docs.oracle.com/en/cloud/paas/process-automation/index.html)
 
## Acknowledgements

* **Author** - Madhusudhan Rao B M, Principal Product Manager, Oracle Database
* **Last Updated By/Date** - Sept 26th, 2025