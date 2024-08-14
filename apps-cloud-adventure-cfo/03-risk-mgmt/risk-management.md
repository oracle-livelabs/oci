# Risk Management

## Introduction

In this activity you'll discover how easy it is to detect anomalies and provide details to mitigate concerns.

Estimated Time: 5 minutes


### Objectives

In this activity, you will:
* Detect Anomalies



## Task 1: Risk Management


1. 

  To further the discussion on how impactful/empowering this functionality is for business users, let’s drill into how the rules engine tailor a control for our own purposes...


    > Go to **Risk Management Cloud tab**, then click **‘Advanced Controls’**

    ![Risk Management Cloud](images/1-task1-risk-management.jpg)


2. 

      > **Click** on the ‘**Models**’ icon on left side of screen (NOTE – ‘Models’ is the 2nd icon).

    ![‘Models’](images/2-task1-risk-management.jpg)


3. 

      > **Select** Results Count **‘64’** (or whatever # is displayed) – to see results.

    ![Results Count](images/4-task1-risk-management.jpg)

4. 

      > Review the results. See Payables Invoice. Number column to see potential duplicates.

    ![Review the results](images/5-task1-risk-management.jpg)

5. 

      > **Next, click the carrot ‘<’  to go back**.

    ![click the carrot](images/6-task1-risk-management.jpg)

6. 

  Let’s see how easy it is to modify a control by adding a materiality threshold.  


    > •	Click the row (white space) for **‘CI-PTP-30001: Duplicate Payables Invoices’** so that the row becomes shaded blue (Do not click the Model name/hyperlink itself).

    ![Duplicate Payables Invoices](images/7-task1-risk-management.jpg)

7. 
 
    > Next, **click** the ‘**Actions**’ drop-down menu, then **select ‘Copy’**.

    ![drop-down menu](images/8-lab3-risk-management.png)

8. 
  
    > Click the hyper link for the newly-copied model.

    ![Click the hyper link](images/9-task1-risk-management.jpg)

9. 
  
    > **Click Edit** in upper right corner.

    ![Home Page](images/10-task1-risk-management.jpg)

10. 
  
    > **Rename/append** the name of the model with **CAOxx** (the user you’re logged in as).

    ![Home Page](images/11-task1-risk-management.jpg)

11. 
  
    > **Click ‘Add Filter‘**.

    ![Click Filter](images/12-task1-risk-management.jpg)

12. 

    > (1) Enter Filter Name ‘**Amount**’  <br>

    > (2) Select Object:  ‘**Payables Invoice**’  <br>

    > (3) Change condition to ‘**Greater than or equal to**’  <br>

    > (4) Enter a dollar limit in **Value** field (NOTE – Value should be less than 500,000) <br>

    > (5) Click **OK**


    ![Change condition](images/13-task1-risk-management.jpg)

13. 

    > **Click ‘Run’** > **Click ‘Yes’** > **Click ‘Ok’**.

    ![Click Run](images/14a-task1-risk-management.jpg)

    ![Click Yes](images/14b-task1-risk-management.jpg)

    ![Click Yes](images/14c-task1-risk-management.jpg)

14. 

      > **Select ‘Monitor Jobs’** (to confirm the job completes).

    ![Monitor Jobs](images/16-task1-risk-management.jpg)

15. 
  
    > Note: (1) Once job is ‘**Completed**’ (2) Next, **click the carrot ‘<’ to go back**.

    ![Completed job](images/17-task1-risk-management.jpg)

16. 
  
    > **Click ‘View Existing Results ‘**.

    ![View Existing Results](images/18-task1-risk-management.jpg)

17. 
  
    > Note: Results Screen show updated results based on Amount threshold chosen in previous step.   <br>

    > **Click the carrot ‘<’** to go back.

    ![Home Page](images/19-task1-risk-management.jpg)

20. 
    > **Select > Save and Close**.

    ![Home Page](images/image020.png)

21. 

    Adventure awaits, show what you know, and rise to the top of the leader board!!!

    [![Cloud Adventure](../gen-images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:10:)

    [Click here](https://apex.oracle.com/pls/apex/f?p=159406:10:) 

## Acknowledgements
* **Author** - Michael Gobbo, Distinguished Sales Consultant, ERP Services
* **Contributors** -  Steve Quinton, Team Lead – Risk Solutions 
* **Last Updated By/Date** - Ramona Magadan, Technical Program Manager, Database Product Management, August 2024
