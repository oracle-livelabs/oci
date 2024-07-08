# Create Transaction Review Integrations

## Introduction

In this lab we will create integration services required in our Transaction review process.

Estimated Time: 30 mins

### About Oracle Integration Cloud

Oracle Cloud Infrastructure integration services connect any application and data source, including Salesforce, SAP, Shopify, Snowflake, and Workday, to automate end-to-end processes and centralize management. The broad array of integrations, with prebuilt adapters and low-code customization, simplify migration to the cloud while streamlining hybrid and multi cloud operations.

### Objectives
 
In this lab, you will:

* Create REST and Autonomous Database Connections
* Create and Test Integration to get latest OnHold Transactions
* Create and Test Integration to update OnHold Transactions

### Prerequisites (Optional)
 
This lab assumes you have:

* An Oracle Cloud account
* Access to Oracle Integration Cloud Instance Generation 3 and Oracle Process Automation Instance
 
## Create REST Connection

Login to your Oracle Integration Cloud Generation 3 Instance.

   1. We would need two connections in this integration, first will be a simple REST connection, click on Connections Tab in left navigation from the catalog select REST, 

   ![Create Table](images/oic-conn-04.png =70%x*" ")

   Select security as OAuth 2.0, provide any name for this connection, here we have the given the name as **Oracle Sample REST endpoint Interface**

   ![Create Table](images/oic-conn-05.png =70%x*" ")

   Test the Connection.

   ![Create Table](images/oic-conn-06.png =70%x*" ")

## Create Oracle Autonomous Database Connection

   1. In the connection catalogue select Oracle ADW for Oracle Autonomous Database of workload Data warehouse,

   ![Create Table](images/oic-conn-03.png =70%x*" ")

   2. Provide the hostname, port, service name, set security policy as JDBC over SSL. upload the wallet.zip file along with wallet password
 
   ![Create Table](images/oic-conn-01.png =70%x*" ")

   ![Create Table](images/oic-conn-02.png =70%x*" ")

## Create Integration to get OnHold Transactions

   1. Create our first integration for this lab,  Navigate to Design menu and then select integration, click on Create button on top right navigation.
   ![Create Table](images/oic-24.png =70%x*" ")
   2. Provide the name and identifier for our integration
   ![Create Table](images/oic-25.png =70%x*" ")  
   3. We can now see a blank canvas with Start and End tasks. 
   ![Create Table](images/oic-26.png =70%x*" ")   
   4. From start select Oracle REST Sample endpoint, If this is not visible then we would need to check connection step 
   ![Create Table](images/oic-trigger-06.png =50%x*" ") 
   5. Provide the name for the endpoint 
   ![Create Table](images/oic-trigger-01.png =50%x*" ") 
   6. Provide an operation name as **default**, resource URI as **/transactions/{id}** and operation as **GET**, check add and review parameters and configure this endpoint 
   ![Create Table](images/oic-trigger-02.png =50%x*" ") 
   7. Template parameter will be **id** of type string 
   ![Create Table](images/oic-trigger-03.png =50%x*" ") 
   8. Response payload will of type JSON and edit the response JSON as shown below 
   ![Create Table](images/oic-trigger-04.png =50%x*" ")

      ``` 
      <copy>
      {
         "ID": "2233",
         "INV_NO": "INVCC_37429961",
         "CATEGORY": "Souvenir",
         "TOTAL_PAY": "75654",
         "INV_DATE": "11/7/2023",
         "MALL": "Viaport Outlet",
         "CREDIT_CARD_NO": "5523854300101220",
         "CC_ID": "1211",
         "CUST_FIRST_NAME": "James",
         "CUST_LAST_NAME": "Smith",
         "TRANS_STATUS": "UNDER REVIEW",
         "TRANSACTION_STATUS": "OnHold",
         "TX_TIMESTAMP": "07/11/2023 07:38:45",
         "MERCHANT_REGION": "Arab States",
         "MERCHANT_STATE": "Algeria",
         "MERCHANT_PLACE": "Kasbah of Algiers",
         "LONGITUDE": "3.06028",
         "LATITUDE": "36.78333",
         "CUSTOMER_FULLNAME": "Abbie Kerry",
         "MERCHANT_FULLNAME": "Abbie Moy",
         "COMMENTS": ""
      } 
      </copy>
      ```
   9. Review endpoint summary  
   ![Create Table](images/oic-trigger-05.png =50%x*" ") 
   10. Drag and Drop ADW Invoke task in to the canvas, provide endpoint name and **Perform an operation On a table** and choose the operation as **Select** 
   ![Create Table](images/oic-02.png =70%x*" ")  
   11. Choose the table that contains Retail transaction data (in our case it is RETAIL\_SHOPPING\_FD table), choose required columns from the table.   
   ![Create Table](images/oic-03.png =70%x*" ") 
   12. This will generate select statement, since we are picking 1 latest onhold record at a time for review we will make max number of records as 1 
   ![Create Table](images/oic-04.png =70%x*" ")
   13. Click Next and Close
   ![Create Table](images/oic-05.png =30%x*" ")
   14. Drag and drop mapper to pass data from one activity to another (Template parameters to ADW)
   ![Create Table](images/oic-06.png =70%x*" ")
   15. Another mapper to source data from Autonomous Database table to response payload
   ![Create Table](images/oic-07.png =70%x*" ")
   16. The complete integration will be as shown below.
   ![Create Table](images/oic-01.png =30%x*" ")
   17. Save and run the Integration
   ![Create Table](images/oic-08.png =30%x*" ")
   18. The response will show the latest OnHold transaction data in a JSON format.
   ![Create Table](images/oic-09.png =70%x*" ")
   Our first integration is now ready which will be later on used in Oracle Process Automation Gen 3

## Create and Test Integration to update OnHold Transactions
 
   1. Create an Integration to update transaction table with Approved or Rejection status along with transaction reviewers comments. Drag and Drop Oracle ADW Invoke task in to the canvas after mapper.  
   ![Create Table](images/oic-10.png =30%x*" ")    
   2. Provide endpoint name and **Perform an operation On a table** and choose the operation as **Update**  
   ![Create Table](images/oic-11.png =30%x*" ") 
   3. Select retail transaction table that contains OnHold transactions.  
   ![Create Table](images/oic-13.png =30%x*" ") 
   4. Click next  
   ![Create Table](images/oic-14.png =30%x*" ")  
   5. Provide operation name and resource URL **/updateTransactions/{id}** 
   ![Create Table](images/oic-17.png =30%x*" ") 
   6. Template parameter will be ID, Query parameters will be Transaction Status, Comments. Transaction Amount(Total Pay), Category.
   ![Create Table](images/oic-18.png =30%x*" ") 
   7. Response payload is set as JSON
   ![Create Table](images/oic-19.png =30%x*" ") 
   8. Edit or View JSON format
   ![Create Table](images/oic-20.png =30%x*" ") 
   9. Review endpoint summary.
   ![Create Table](images/oic-21.png =30%x*" ") 
   10. Close and Run the integration, update JSON and click on **RUN** button 
   ![Create Table](images/oic-22.png =30%x*" ") 
   11. This will update transaction record from OnHold to Approved or Rejected status as provided in request JSON. Verify the data from SQL Developer or from Oracle APEX SQL Commands or APEX Object browser. In this case we can see that Transaction_Status has been changed from OnHold to REJECT  
   ![Create Table](images/oic-23.png =30%x*" ") 

   <!-- 
   ![Create Table](images/oic-02.png =70%x*" ") 

   ![Create Table](images/oic-03.png =70%x*" ") 
  
   ![Create Table](images/oic-04.png =70%x*" ")

   ![Create Table](images/oic-05.png =70%x*" ")

   ![Create Table](images/oic-06.png =70%x*" ")

   ![Create Table](images/oic-07.png =70%x*" ")

   ![Create Table](images/oic-08.png =70%x*" ")

   ![Create Table](images/oic-09.png =70%x*" ")
   12. A 
   ![Create Table](images/oic-15.png =30%x*" ") 
   13. A 
   ![Create Table](images/oic-16.png =30%x*" ") 

   ``` 
   <copy>
   {
      "ID" : "123",
      "INV_NO" : "INV-RAND_6977", 
      "TOTAL_PAY" : "6977", 
      "MALL" : "Viaport Outlet",
      "CREDIT_CARD_NO" : "5523854300100111",
      "CC_ID" : "10", 
      "TRANS_STATUS" : "UNDER REVIEW",
      "TRANSACTION_STATUS" : "OnHold",
      "TX_TIMESTAMP" : "2024-01-19T18:39:51.029781+00:00",
      "MERCHANT_REGION" : "Europe and North America",
      "MERCHANT_STATE" : "United States of America",
      "MERCHANT_PLACE" : "Mesa Verde National Park",
      "LONGITUDE" : "-108.4855556",
      "LATITUDE" : "37.26166667",
      "CUSTOMER_FULLNAME" : "Sharon Smith",
      "MERCHANT_FULLNAME" : "Melissa Mcclure",
      "COMMENTS" : ""
   }
   </copy>
   ```
      -->
 <!-- 
## Task 2: Task 2

   Text 

   ![Create Table](images/oic-10.png =30%x*" ")   

   ![Create Table](images/oic-11.png =30%x*" ") 

   ![Create Table](images/oic-12.png =30%x*" ") 

   ![Create Table](images/oic-13.png =30%x*" ") 

   ![Create Table](images/oic-14.png =30%x*" ") 

   ![Create Table](images/oic-15.png =30%x*" ") 

   ![Create Table](images/oic-16.png =30%x*" ") 

   ![Create Table](images/oic-17.png =30%x*" ") 

   ![Create Table](images/oic-18.png =30%x*" ") 

   ![Create Table](images/oic-19.png =30%x*" ") 

   ![Create Table](images/oic-20.png =30%x*" ") 

   ![Create Table](images/oic-21.png =30%x*" ") 

   ![Create Table](images/oic-22.png =30%x*" ") 

   ![Create Table](images/oic-23.png =30%x*" ") 

   -->

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