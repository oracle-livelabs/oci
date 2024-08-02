# Configure

## Introduction

Welcome to Oracle’s Cloud Adventure.  This is a fresh and unique way to offer you a chance for hands-on experience of highly differentiated and specifically curated content of numerous vignettes that are typically encountered Supply Chain Management. We hope you will enjoy today’s adventure exploring a complete and unified solution for the office of the COO.

As you follow along, do not forget to answer the Adventure Check Point questions! 


Estimated Time: 10 minutes


### Objectives

In this activity, you will use Redwood to incorporate rules and define content surfaced in the application to tailor the user experience. 




## Task 1: Enhance the Change Salary Experience 

1. You are the Redwood expert for your organization.  You will use Redwood, Oracle’s next-generation design system, to quickly and efficiently design a Change Salary Interface for Non-HR mangers.

    You will first navigate to the Change Salary Page.

    > From the application home page, click on the **My Team** tab.

    ![Application Home Page](images/image001.png).

    > Click on **Change Salary** under **Quick Actions**.

    ![My Team Page](images/image002.png)

    > Click on the **X** to remove the Direct Reports Filter because Casey Brown does not have any direct reports.  This action allows us to see other people.

    ![My Team Page](images/image003.png)


2. Now you will enter the Change Salary process so we can make the required changes using Visual Builder Studio.

    > Click on **Barrett Reed**

    ![Change Salary Page](images/image004.png)


3. You have entered the Change Salary Screen.  Now you will quickly review the current configuration of Change Salary.

    You need to enter the required information before you can move to the next screen.

    > (1) Pick a **future date** for when the salary will start. <br>

    > (2) Select **Salary Change** under Action Name. <br>

    > (3) Select **Career Progression** for why you are changing the salary. <br>

    > (4) Click **Continue** once complete.

    ![Change Salary Page 1st page](images/image005.png)


4. You will now create new rule that hides Annualized Full-Time Salary because it is repetitive.  You will also hide Compa-Raito since this is mainly used by HR.  

    > (1) Click on **Casey’s image**.  <br>

    > (2) Then select **Edit Page in Visual Builder Studio**.

    ![Change Salary Page 2nd page](images/image006.png)


5. A project has already been created for this exercise.

    > (1) Click on the **Create Change Salary for HR** project.  <br>

    > (2) Then click **Select**.

    ![Select Project](images/image007.png)


6.  Oracle Visual Builder Studio (VB Studio), a robust application development platform that helps your team effectively plan and manage your work throughout all stages of the app dev lifecycle: design, build, test, and deploy.

    Now we will use VB Studio to make the required changes.

    > Click on **Configure Fields and Regions**.

    ![VB Studio](images/image008.png)


7. First we will duplicate the default rule because you cannot edit the default rule in VB Studio.

    > (1) Click on **Default** under Built in Rules.   <br>

    > (2) Click on the **… icon**.  <br>

    > (3) Then click **Duplicate**.

    ![Fields and Regions](images/image009.png)

    > (1) Enter **Change Salary Non-HR Manager** in Label to name the new rule.     <br>

    > (2) Then click **Create**.

    ![Fields and Regions](images/image010.png)


8.  Now we will add the conditions that applies this rule to all non-HR personnel.

    > (1) Click on **Change Salary Non-HR Manager**.     <br>

    > (2) Then click **Design**.

    ![Fields and Regions](images/image011.png)

    > (1) In conditions, change the box to the right of User Roles from **contains** to **does not contain.**    <br>

    > (2) Then enter the **Human Resource Manager** role in the right most box.

    ![Fields and Regions, Conditions](images/image012.png)

    This configuration routes the current configuration to all people who are not assigned to the Human Resource Manager Role.

9. Now you will hide Annualized Full-Time Salary and Compa-Ratio

    > (1) Click on the **Box** next to Annualized Full-Time Salary <br>

    > (2) Select **Hidden.**  <br>

    > (3) Do the same actions for **Compa-Ratio.**

    ![Fields and Regions](images/image013.png)

10.  You also want to show the Action Reason from the First Screen in the 2nd screen with all the detailed Salary Data.

    > (1) Click on the **Hidden Box** to the right of Action Reason.       <br>

    > (2) Then select **Visible**.

    ![Fields and Regions](images/image014.png)

11. Now you will add a validation step for the next salary review date.  We want all salary reviews to be on or after February 1st, 2025.

    > Click on **Validate Field Values**

    ![Fields and Regions](images/image015.png)

    > Click on **+ Validation**

    ![Validation](images/image016.png)

    > (1) Enter **Next Salary Review Date** in Label to name the validation.    <br>

    > (2) Then Click **Create**.

    ![Validation](images/image017.png)


12.  First you will set the conditions for this rule for anyone who enters a date before February 1st, 2025

    > (1) Click on **Next Salary Review Date.**    <br>

    > (2) Then Click **Design**.

    ![Create Validation](images/image020.png)

    > Click on **+ Condition**.

    ![Create Validation](images/image021.png)

    > (1) Start Typing **Next Salary Review Date.**     <br>

    > (2) Then select the **first Next Salary Review Date**.

    ![Create Validation](images/image022.png)

    > (1) Click on the **middle box.**       <br>

    > (2) Then select  **less than.**.

    ![Create Validation](images/image023.png)

    > (1) Click on the **Right Most Box.**       <br>

    > (2) Then select  **February 1st, 2025.**.

    This action will not allow users to enter in a next Salary Review date before February 1st, 2025

    ![Create Validation](images/image024.png)

13.  you will configure the error message users will see if they enter in a next salary review date before February 1st, 2025 (6 months from the salary change

    > (1) Enter **Invalid Next Salary Review Date** in Summary.    <br>

    > (2) Then enter **The date needs to be on or after February 1st, 2025.**

    ![Create Validation](images/image018.png)

    > (1) Click on the **Down Arrow.**      <br>

    > (2) Then select **Error.**

    The error configuration will not allow any user who entered in incorrect data to submit the change without fixing the error

    ![Create Validation](images/image019.png)

14.  Well done.  You have configured a new rule for HR personnel.

    Redwood offers a quick way to review your changes as they appear in the application.

    > (1) Click on the **play icon** in the upper right of  the screen.   <br>

    > (2) A new window will pop up.

    ![Create Validation](images/image025.png)

15.  You have reentered the Change Salary Screen.  Let’s review the changes.

    You need to enter the required information before you can move to the next screen.

    > (1) Pick a **future date** for when the salary will start. <br>

    > (2) Select **Salary Change** under Action Name. <br>

    > (3) Select **Career Progression** for why you are changing the salary. <br>

    > (4) Click **Continue** once complete.

    ![Change Salary Screen 1](images/image026.png)

16.  Note that Annualized Full-Time Salary and Compa-Ratio are no longer visible while Action Reason is now Visible.

    Now we will test the validation for the Next Salary Review Date.


    > (1) Enter any **date that is before September 1st, 2024** in Next Salary Review date.     <br>

    > (2) Then click **Continue.**

    ![Change Salary Screen 2](images/image027.png)

17.  The system will not allow the user to continue because the Next Salary Review date is invalid and displays the message you configured in this exercise.

    ![Change Salary Screen 2 error message](images/image028.png)


18. Adventure awaits, click on the image, show what you know and rise to the top of the leader board!!!

    [![Checkpoint](images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:20:::::QN:10) 




## Summary

Oracle Redwood is Oracle Fusion’s new design system that enhances the user experience through a visually stimulating, easy-to-use interface. By uniting customer-inspired design philosophies with industry-leading technology solutions, Oracle Redwood helps companies reduce costs, foster efficiency, revitalize the customer journey, and evolve continuously toward the future.   

Oracle Visual Builder Studio (or VB Studio, for short) is an integrated development platform that helps your team effectively plan and manage your work throughout the application's lifecycle. It combines the simplicity of a visual development environment with powerful management tools to streamline application development and deliver modern, innovative user experiences.

In this example, you used Redwood, Oracle’s next-generation design system, to quickly and efficiently enhance the Change Salary Page


**You have successfully completed the Activity!**

**For extra credit (and possibly some Oracle swag) please make sure you record the information regarding the Item with highest Lead Time Variance Percentage in the review Item Category Set.**



## Acknowledgements
* **Author** - Casey Doody, Sales Consultant, Advanced Technology Services
* **Contributors** -  Sajid Saleem, Master Principal Sales Consultant, Advanced Technology Services
* **Last Updated By/Date** - Casey Doody, August 2024


