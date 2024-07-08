# Create Transaction Review Process

## Introduction

In this lab we will create Transaction review process using Integrations created in previous lab.

Estimated Time: 30 mins

### About Process Automation

Oracle Cloud Infrastructure Process Automation is a native service for developers and business experts to quickly automate approval workflows that span your ERP, HCM, and CX systems. Simplify repetitive tasks with reusable business rules, prebuilt integrations, and low-code designers.

### Objectives

In this lab, you will:

* Create Transaction Review Process
* Run Transaction Review Process for Approved or Rejected cases

### Prerequisites (Optional)

This lab assumes you have:

* An Oracle Cloud account
* Access to Oracle Integration Cloud Instance Generation 3 and Oracle Process Automation Instance
* Integration Services in previous lab has been created and tested.

## Create Process

Create Transaction Review Process

   1. login to Oracle Process Automation and click on create application, select **Create process application**
   ![Create Table](images/opa-01.png " ")
   2. Provide title and version tag
   ![Create Table](images/opa-02.png " ")
   3. The process is as shown below, the process flow will be as follows 
      * Service call to get latest transaction from Oracle integration cloud. 
      * Human task to review the latest transaction in a form
      * Human reviewer can Approve or Reject a given transaction based on data available or can also analyze customer information in AI for Financial Services application, before making a decision on the transaction.
      * If the task is Approved or Rejected this makes call to another Integration service that updates the record with an updated Transaction status
   4. Complete process flow
   ![Create Table](images/opa-00.png " ") 
   5. Under properties map to integration service to get latest OnHold transaction
   ![Create Table](images/opa-03.png " ")
   6. Under properties map to integration service to update the selected OnHold transaction with new status such as Approved or Rejected
   ![Create Table](images/opa-04.png " ")
   7. Rejected service call will also invoke the same service as approved task
   ![Create Table](images/opa-05.png " ")
   8. User Task is mapped to a Form UI where all the form elements such as Customer Name, Category of purchase, Transaction amount etc. are seen
   ![Create Table](images/opa-06.png " ")
   9. Start event will also use the same form as above
   ![Create Table](images/opa-07.png " ")
   10. Map Output data objects from source to destination
   ![Create Table](images/opa-08.png " ")
   11. Map Input data objects from source to destination
   ![Create Table](images/opa-09.png " ")
   12. Data mapping from Integration service invocation to process UI form.
   ![Create Table](images/opa-10.png " ")
   13. Output Mapping
   ![Create Table](images/opa-11.png " ")
   14. Process to Form mapping
   ![Create Table](images/opa-12.png " ")
   15. Map Task outcome to form object
   ![Create Table](images/opa-13.png " ")
   16. Update mapper to integration service invocation to update data
   ![Create Table](images/opa-14.png " ")
   17. Update mapper to integration service invocation to update data
   ![Create Table](images/opa-15.png " ")
   18. Decision activity based on reject outcome
   ![Create Table](images/opa-16.png " ")
   19. Service Invocation to get lastest transaction which OnHold.
   ![Create Table](images/opa-17.png " ")

## Run Transaction Review Process

Run the Manual transaction review process and check updated status 

   1. Review transaction dashboard, created from transaction data
   ![Create Table](images/opa-18.png " ")
   2. Login to Oracle Process Automation, Click on the transaction review Application.
   ![Create Table](images/opa-19.png " ")
   3. Click on the transaction review Process.
   ![Create Table](images/opa-20.png " ")
   4. Click on **Activate** button
   ![Create Table](images/opa-21.png " ")
   5. Click on **Test in Workspace**
   ![Create Table](images/opa-22.png " ")
   6. Click on **Start Event**
   ![Create Table](images/opa-23.png " ")
   7. Provide latest transaction id as in Oracle APEX Dashboard. and hit **Submit** button
   ![Create Table](images/opa-24.png " ")
   8. On the confirmation screen, click on **Open Now**
   ![Create Table](images/opa-25.png " ")
   9. Click on **Open** Task to view the task form, with all transaction related data.
   ![Create Table](images/opa-26.png " ")
   10. Transaction reviewer can Approve or Reject a transaction. They can also review customer profile before taking decision on transaction. 
   ![Create Table](images/opa-27.png " ")
   11. Review **Audit** tab
   ![Create Table](images/opa-28.png " ")
   12. Close the window
   ![Create Table](images/opa-29.png " ")
   13. This will update the transaction in database table with Approved or Rejected status, which can be viewed in Oracle APEX Dashboard as shown in green row.
   ![Create Table](images/opa-30.png " ") 

## Learn More

* [Oracle APEX](https://apex.oracle.com/en/)
* [Autonomous Database](https://www.oracle.com/in/autonomous-database/)
* [Anomaly Detection AI Service](https://www.oracle.com/in/artificial-intelligence/anomaly-detection/)
* [Document Understanding](https://www.oracle.com/in/artificial-intelligence/document-understanding/)
* [Process Automation](https://www.oracle.com/in/integration/process-automation/)
* [Analytics Platform](https://www.oracle.com/in/business-analytics/analytics-platform/)
* [AI Language](https://www.oracle.com/in/artificial-intelligence/language/)
* [Oracle Digital Assistant](https://www.oracle.com/in/chatbots/)

## Acknowledgements

* **Author** - Architect, Author and Developer - Madhusudhan Rao B M, Principal Product Manager, Oracle Database
* **Last Updated By/Date** - Jan 22nd, 2024
