# Configure

## Introduction

Oracle offers hundreds of prebuilt pages, workflows and forms “out of the box” as part of the Oracle Fusion Cloud.  Many of our customers want to configure these pages and workflows to meet their specific business needs.  You can unify your experience in our applications by using Redwood.

Oracle Redwood is Oracle Fusion’s new design system that enhances the user experience through a visually stimulating, easy-to-use interface. By uniting customer-inspired design philosophies with industry-leading technology solutions, Oracle Redwood helps companies reduce costs, foster efficiency, revitalize the customer journey, and evolve continuously toward the future.   

In this exercise, you are the Redwood expert for your organization.  You will use Redwood, Oracle’s next-generation design system, to quickly and efficiently design a Change Salary Interface for Non-HR mangers.

Do not forget to answer the Adventure Check Point questions at the end of the exercise! 


Estimated Time: 15 minutes


### Objectives

In this activity, you will use Redwood to incorporate rules and define content surfaced in the application to tailor the user experience. 

![Configure  OBJs](images/configure_objs.png).



## Task 1: Enhance the Change Salary Experience

1. You are the Redwood expert for your organization.  You will use Redwood, Oracle’s next-generation design system, to quickly and efficiently design a Change Salary Interface for Non-HR mangers.  Change Salary is a dynamic form that allow you to create pages with user information that appears based on conditions you configure.

    You will first navigate to the Change Salary Page.

    > From the application home page, click on the **My Team** tab.

    ![Application Home Page](images/image001.png).

    > Click on **Change Salary** under **Quick Actions**.

    ![My Team Page](images/image002.png)

    > Click on the ![X](images/icon01_x.png) **Icon** to remove the Direct Reports Filter because your user does not have any direct reports.  This action allows you to see other people.

    ![My Team Page](images/image003.png)


2. Now you will enter the Change Salary Form so we can make the required changes using Visual Builder Studio.  Now you will select a person so you can enter the Change Salary form.

    > (1) Search for **Barrett Reed** in the search field. <br>

    > (2) Select **Barrett Reed** in the drop down (add new picture). <br>


    ![Change Salary Page](images/image004.png)

3.  You have entered the Change Salary Form.  Now you will quickly review the current configuration of the Change Salary Form.

    > Click **Continue**.

   ![Change Salary Page](images/image005.png)

    > (1) Enter a **future date** for **When does the salary will start?** <br>

    > (2) Select **Change Salary** for **What is the action name?** <br>

    > (3) Select **Career Progression** for **why you are changing the salary for Barrett Reed?** <br>

    > (4) Click **Continue** once complete.

    ![Change Salary Page](images/image006.png)




4. You will now create new rule that hides Annualized Full-Time Salary because it is repetitive.  You will also hide Compa-Raito since this is mainly used by HR.  You also want to show the action reason in this section of the Change Salary Form.

    ![Change Salary Page 2nd page](images/image007.png)

5. Now you will enter the Visual Builder Studio.

    > (1) Click on the ![CO Image](images/icon02_co.png) **Image** in the top right corner of the screen.  <br>

    > (2) Then select **Edit Page in Visual Builder Studio** from the drop down options.

    ![Change Salary Page 2nd page](images/image008.png)

    The following image appears as Visual Builder Studio is loading.

    ![Select Project](images/image009.png)


6.  Welcome to Oracle Visual Builder Studio (VB Studio), a robust application development platform that helps your team effectively plan and manage your work throughout all stages of the app dev lifecycle: design, build, test, and deploy.

    Now we will use VB Studio to make the required changes to the Change Salary Form.

    > Click on **Configure Fields and Regions**.

    ![VB Studio](images/image010.png)


7. First we will create a new form rule for change salary.

    > Click on the ![+ Icon](images/icon05_plus.png) **Icon** to add a new form rule.

    ![Fields and Regions](images/image011.png)

    > (1) Enter **Change Salary Non-HR** in label. <br>

    > (2) Click on **Create**.

    ![Fields and Regions](images/image012.png)


8.  Note that rules are based on a hierarchy.  The rules on top supersede the rules below .

    Now we will add the conditions that applies this rule to all non-HR personnel


    > Click on the **Edit button.**

    ![Fields and Regions](images/image013.png)
    
    > (1) Click on the middle box that has **contains** in the User Roles Row. <br>

    > (2) Select **does not contain** from the drop down options.  

    ![Fields and Regions](images/image014.png)

    > (1) Enter the **Human Resource Manager** role in the right most box of the **User Roles** row. <br>

    > (2) Select the first **Human Resource Manager** role from the drop down options.  

    ![Fields and Regions](images/image015.png)

     **Note:** This configuration routes the this version of the Change Salary Form to all people who are not assigned to the Human Resource Manager Role


9.  Now you want to add and hide fields.

    > Click on the **Drop Down** ![Drop Down Icon](images/icon03_dropdown.png) Icon to the left of Salary to expand the salary section.

    ![Fields and Regions, Conditions](images/image016.png)



10.  First you want to the configure the form to hide the **Annualized Full-Time Salary** Field.

    > (1) Click in the Box in the **Hidden Column** for **Annualized Full-Time Salary Field** row.       <br>

    > (2) Then select **Hidden** from the options that appear.

    ![Fields and Regions, Conditions](images/image017.png)


11. Now you want to the configure the form to hide the **Compa-Ratio** field.

    > (1) Click in the Box in the **Hidden Column** for **Compa-Ratio** row.       <br>

    > (2) Then select **Hidden** from the options that appear.

    ![Fields and Regions, Conditions](images/image018.png)

12. Now you will configure the form to show the **Action Reason** field.

    > (1) Click in the Box in the **Hidden Column** for **Action Reason** row.       <br>

    > (2) Then select **Visible** from the options that appear.

    ![Fields and Regions, Conditions](images/image019.png)



13. Please verify that Action Reason is **Visible**, and Annualized Full-Time Salary Field and Compa-Ratio are **Hidden**.

    Now you will add a validation step for the Adjustment Percentage.  You do not want users to enter in a Salary Percentage Greater than 15%

    > Click on **Validate Field Values**

    ![Fields and Regions](images/image020.png)

    > Click on **+ Validation**

    ![Validation](images/image021.png)

    > (1) Enter **Adjustment Percentage** in **Label** to name the validation.    <br>

    > (2) Then Click **Create**.

    ![Validation](images/image022.png)


14.  Now you will set the conditions for this rule so that the form will not accept any adjustment percentage greater than 15%.

    > Click on **Edit**. 

    ![Create Validation](images/image023.png)

    > Click on **+ Condition**.

    ![Create Validation](images/image024.png)

    > (1) Enter **Adjustment Percentage** in the box below Country.     <br>

    > (2) Then select the first **Adjustment Percentage** under **Salary Details**.

    ![Create Validation](images/image025.png)

    > (1) In the new Adjustment Percentage row you just created, click the **middle box** that says **Equals**.       <br>

    > (2) Then select  **greater than.**.

    ![Create Validation](images/image026.png)

    > Enter **15** in the right most box in the Adjustment Percentage row.

    ![Create Validation](images/image027.png)

    The form will not allow any user to enter an adjustment percentage greater than 15%. 


15.  Now you will configure the error message users will see if they enter in an Adjustment Percentage greater than 15%.

    > (1) Under **Messages**, Enter **Adjustment Percentage is too high** in **Summary**.    <br>

    > (2) Then enter **The Adjustment Percentage must be lower than 15%** in **Detail**.

    ![Create Validation](images/image028.png)

    > Click on **Warning** under **Severity**.

    ![Create Validation](images/image029.png)

    > Then select **Error** from the drop-down options that appear.

    The error configuration will not allow any user who entered incorrect data to submit the change without fixing the error

    ![Create Validation](images/image030.png)
    


16.  Well done.  You have configured a new rule for Non-HR personnel.

    Redwood offers a quick way to review your changes as they appear in the application.

    > (1) Click on the **Preview** ![Preview Icon](images/icon04_preview.png) icon in the upper right of  the screen.   <br>

    > (2) A new window will pop up.

    ![Create Validation](images/image031.png)

17.  You have reentered the Change Salary Form.  Let’s review the changes.

    > Click **Continue**.

    ![Change Salary 1](images/image032.png)

    You need to enter the required information before you can move to the next screen.

    > (1) Enter a **future date** for **When does the salary will start?** <br>

    > (2) Select **Change Salary** for **What is the action name?** <br>

    > (3) Select **Career Progression** for **why you are changing the salary for Barrett Reed?** <br>

    > (4) Click **Continue** once complete.

    ![Change Salary Page 2nd page](images/image033.png)


18.  Note that Annualized Full-Time Salary and Compa-Ratio are no longer visible while Action Reason is now Visible.

    Now we will test the validation for the Adjustment Amount Percentage.

    > Enter an Adjustment Percentage that is greater than 15%.

    ![Change Salary Screen 2](images/image034.png)

19.  The system gives us a warning that the increase in salary is outside the worker’s salary range.  You will ignore this warning.

    > Click **Continue.**

    ![Change Salary Screen 2](images/image035.png)

20.  The system will not allow the user to continue because the Adjustment Percentage exceeds 15%

    ![Change Salary Screen 2 error message](images/image036.png)

    > Click on the **Home** ![Home Icon](images/icon07_home.png) Icon.

    ![Change Salary Screen 2](images/image037.png)




21. Adventure awaits, click on the image, show what you know and rise to the top of the leader board!!!

    [![Checkpoint](images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:LOGIN_TEAM:::::CC:CIOADVENTURE) 




## Summary

Oracle Redwood is Oracle Fusion’s new design system that enhances the user experience through a visually stimulating, easy-to-use interface. By uniting customer-inspired design philosophies with industry-leading technology solutions, Oracle Redwood helps companies reduce costs, foster efficiency, revitalize the customer journey, and evolve continuously toward the future.   

Oracle Visual Builder Studio (or VB Studio, for short) is an integrated development platform that helps your team effectively plan and manage your work throughout the application's lifecycle. It combines the simplicity of a visual development environment with powerful management tools to streamline application development and deliver modern, innovative user experiences.

In this example, you used Redwood, Oracle’s next-generation design system, to quickly and efficiently enhance the Change Salary Form.


**You have successfully completed the Activity!**



## Acknowledgements
* **Author** - Casey Doody, Sales Consultant, Advanced Technology Services
* **Contributors** -  Sajid Saleem, Master Principal Sales Consultant, Advanced Technology Services
* **Last Updated By/Date** - Casey Doody, August 2024


