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

    ![Risk Management Cloud](images/image001.png)


2. 

      > **Click** on the ‘**Models**’ icon on left side of screen (NOTE – ‘Models’ is the 2nd icon)

    ![‘Models’](images/2-lab3-risk-management.png)

3. 

      > Use the search feature to **find control PTP-30001**

    ![search feature](images/image003.png)

4. 

      > **Select** Results Count **‘75’** (or whatever # is displayed) – to see results. Take note the number of results displayed.

    ![Results Count](images/4-lab3-risk-management.png)

5. 

      > Review the results. See Payables Invoice.Number column to see potential duplicates

    ![Review the results](images/5-lab3-risk-management.png)

6. 

      > **Next, click the carrot ‘<’  to go back**

    ![click the carrot](images/image006.png)

7. 

  A common objective for business controls is to adapt controls to a company’s risk profile.  Materiality levels differ by company.  Here we see how easy it is to tweak the control to make more relevant and impactful for our own objective.


    > •	**Select** the model **‘CI-PTP-30001: Duplicate Payables Invoices’** 
    >	•	Note: Click the white space next to the hyperlink so the line  item becomes shaded blue (Do not click the hyper link itself)

    ![Duplicate Payables Invoices](images/image007.png)

8. 
 
    > Next, **click** the ‘**Actions**’ drop-down menu, then **select ‘Copy’**

    ![drop-down menu](images/8-lab3-risk-management.png)

9. 
  
    > Click the hyper link for the newly-copied model

    ![Click the hyper link](images/image009.png)

10. 
  
    > **Click Edit** in upper right corner

    ![Home Page](images/image010.png)

11. 
  
    > **Rename/append** the name of the model with **CAOxx** (the user you’re logged in as)

    ![Home Page](images/image011.png)

12. 
  
    > **Click ‘Add Filter‘**

    ![Click Filter](images/image012.png)

13. 

    > (1) Enter Filter Name as ‘**Amount**’  <br>

    > (2) Change condition to ‘**Greater than or equal to**’  <br>

    > (3) Enter a number threshold limit in **Value** field (NOTE – Value should be less than 500,000)


    ![Change condition](images/13-lab3-risk-management.png)

14. 
  
    > **Click ‘Run’**

    ![Click Run](images/image014.png)

15. 
  
    > **Click ‘Yes’**

    ![Click Yes](images/image015.png)

16. 

      > **Select ‘Monitor Jobs’** (to confirm the job completes)

    ![Monitor Jobs](images/image016.png)

17. 
  
    > Note: Job says ‘Completed’ once done 
    > **Next, click the carrot ‘<’  to go back**

    ![Completed job](images/image017.png)

18. 
  
    > **Click ‘View Existing Results ‘**

    ![View Existing Results](images/image018.png)

19. 
  
    > Note: Results Screen shows Duplicate Invoice advanced control results – above the materiality threshold you selected in step 13.  **Click the carrot** ‘<’ to go back  <br>

    > **Click the carrot ‘<’** to go back

    ![Home Page](images/image019.png)

20. 
    > **Select > Save and Close**

    ![Home Page](images/image020.png)

21. 

    Adventure awaits, show what you know, and rise to the top of the leader board!!!

    [![Cloud Adventure](../gen-images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:10:)

## Acknowledgements
* **Author** - Michael Gobbo, Distinguished Sales Consultant, ERP Services
* **Contributors** -  Steve Quinton, Team Lead – Risk Solutions 
* **Last Updated By/Date** - Kevin Lazarz, August 2023
