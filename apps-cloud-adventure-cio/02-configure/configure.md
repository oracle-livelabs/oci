# Configure

## Introduction

Oracle offers hundreds of prebuilt pages, workflows and forms “out of the box” as part of the Oracle Fusion Cloud.  Many of our customers want to configure these pages and workflows to meet their specific business needs.  You can unify your experience in our applications by using Redwood.

Oracle Redwood is Oracle Fusion’s new design system that enhances the user experience through a visually stimulating, easy-to-use interface. By uniting customer-inspired design philosophies with industry-leading technology solutions, Oracle Redwood helps companies reduce costs, foster efficiency, revitalize the customer journey, and evolve continuously toward the future.

### Objectives

In this lab, you will use Redwood to quickly and efficiently improve the user experience in Oracle Fusion Cloud.

Estimated Time: 15 minutes

Do not forget to answer the Adventure Check Point questions at the end of the exercise!


## HCM: Enhance the Change Salary Experience

1.  You will use Redwood, Oracle’s next-generation design system, to quickly and efficiently update Change Salary Page for Non-HR managers.

![Configuration Objectives](images/configure_objs_hcm.png)

2. You will first navigate to the Change Salary Page.

    > From the application home page, click on the **My Team** tab.

    ![Application Home Page](images/image001.png).

    > Click on **Change Salary** under **Quick Actions**.

    ![My Team Page](images/image002.png)

    > Click on the ![x icon](images/icon011_x.png)  **Icon** to remove the Direct Reports Filter because your user does not have any direct reports.  This action allows you to see other people.

    ![My Team Page](images/image003.png)


3. Now you will enter the Change Salary Form so we can make the required changes using Visual Builder Studio.  Now you will select a person so you can enter the Change Salary form.

    > (1) Search for **Barrett Reed** in the search field. <br>

    > (2) Select **Barrett Reed** in the drop down. <br>


    ![Change Salary Page](images/image004.png)

4.  You have entered the Change Salary Form.  Now you will quickly review the current configuration of the Change Salary Form.  You need to enter in some information to access the form


    > (1) When does the salary will start?: Type a **future date** <br>

    > (2) What is the action name?: Select **Change Salary**. <br>

    > (3) Why you are changing the salary?: Select **Career Progression**. <br>

    > (4) Click **Continue** once complete.

    ![Change Salary Page](images/image006.png)


5. You will now create new rule that hides Annualized Full-Time Salary because it is repetitive.  You will also hide Compa-Raito since this is mainly used by HR.  You also want to show the action reason in this section of the Change Salary Form.

    ![Change Salary Page 2nd page](images/image007.png)

6. Now you will enter the Visual Builder Studio.

    > (1) Click on the ![co image](images/icon012_co.png)  **Image** in the top right corner of the screen.  <br>

    > (2) Then select **Edit Page in Visual Builder Studio** from the drop down options.

    ![Change Salary Page 2nd page](images/image008.png)

    The following image appears as Visual Builder Studio is loading.

    ![Select Project](images/image009.png)


7.  Welcome to Oracle Visual Builder Studio (VB Studio), a robust application development platform that helps your team effectively plan and manage your work throughout all stages of the app dev lifecycle: design, build, test, and deploy.

    Now we will use VB Studio to make the required changes to the Change Salary Form.

    > Click on **Configure Fields and Regions**.

    ![VB Studio](images/image010.png)


8. First we will create a new form rule for change salary.

    > Click on the ![plus icon](images/icon015_plus.png)  **Icon** to add a new form rule.

    ![Fields and Regions](images/image011.png)

    > (1) Label: Type **Change Salary Non-HR**. <br>

    > (2) Click on **Create**.

    ![Fields and Regions](images/image012.png)


9.  Note that rules are based on a hierarchy.  The rules on top supersede the rules below .

    Now we will add the conditions that applies this rule to all non-HR personnel


    > Click on the **Edit button.**

    ![Fields and Regions](images/image013.png)

    > (1) For **User Roles**, select **does not contain** from the drop down options.  <br>

    > (2) For **User Roles**, type **Human Resource Manager** and select **Human Resource Manager**.

    ![Fields and Regions](images/image014.png)


     **Note:** This configuration displays this version of the Change Salary Form to all people who are not assigned to the Human Resource Manager Role


10.  Now you want to add and hide fields.

     > Click on the **Drop Down** ![drop down icon](images/icon013_dropdown.png)  Icon to the left of Salary to expand the salary section.

     ![Fields and Regions, Conditions](images/image016.png)


     > (1) Action Reason: select **Visible**     <br>

     > (2) Annualized Full-Time Salary: select **Hidden**   <br>

     > (3) Compa-Ratio: select **Hidden**

     ![Salary Fields and Regions](images/image017.png)


11. Now you will add a validation step for the Adjustment Percentage.  You do not want users to enter in a Salary Percentage Greater than 15%

    > Click on **Validate Field Values**

    ![Fields and Regions](images/image020.png)

    > Click on **+ Validation**

    ![Validation](images/image021.png)

    > (1) Label: type **Adjustment Percentage**.    <br>

    > (2) Click **Create**.

    ![Validation](images/image022.png)


12.  Now you will set the conditions for this rule so that the form will not accept any adjustment percentage greater than 15%.

     > Click on **Edit**.

     ![Create Validation](images/image023.png)
  
     > Click on **+ Condition**.

     ![Create Validation](images/image024.png)

     > (1) Type **Adjustment Percentage** in the box and select the 1st **# Adjustment Percentage** under **Salary Details**     <br>

     > (2) Select **greater than**    <br>

     > (3) Type **15**  <br>

     ![Create Validation](images/image026.png)


      The form will not allow any user to enter an adjustment percentage greater than 15%.


13.  Now you will configure the error message users will see if they enter in an Adjustment Percentage greater than 15%.

     > (1) Summary: type **Adjustment Percentage is too high**.    <br>

     > (2) Detail:  **The Adjustment Percentage must be lower than 15%** in **Detail**. <br>

     > (3) Detail:  type **The Adjustment Percentage must be lower than 15%**.

     ![Create Validation](images/image028.png)


14.  Well done.  You have configured a new rule for Non-HR personnel.

  Redwood offers a quick way to review your changes as they appear in the application.

    > (1) Click on the **Preview** ![preview icon](images/icon014_preview.png)  icon in the top right of the screen.   <br>

    > (2) A new window will pop up.

    ![Create Validation](images/image031.png)

15.  You have reentered the Change Salary Form.  Let’s review the changes.  You need to enter the required information before you can move to the next screen.

    > (1) When does the salary will start?: Type a **future date** <br>

    > (2) What is the action name?: Select **Change Salary**. <br>

    > (3) Why you are changing the salary?: Select **Career Progression**. <br>

    > (4) Click **Continue** once complete.

    ![Change Salary Page 2nd page](images/image033.png)


16.  Note that Annualized Full-Time Salary and Compa-Ratio are no longer visible while Action Reason is now Visible.

    Now we will test the validation for the Adjustment Amount Percentage.

    > Enter an Adjustment Percentage that is greater than 15%.

    ![Change Salary Screen 2](images/image034.png)

17.  The system gives us a warning that the increase in salary is outside the worker’s salary range.  You will ignore this warning.

    > Click **Continue.**

    ![Change Salary Screen 2](images/image035.png)

18.  The system will not allow the user to continue because the Adjustment Percentage exceeds 15% due to the field validation we configured.

    ![Change Salary Screen 2 error message](images/image036.png)

    > Click on the **Home** ![home icon](images/icon017_home.png)  Icon.






19. Adventure awaits, click on the image, show what you know and rise to the top of the leader board!!!

    [![Checkpoint](images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:LOGIN_TEAM:::::CC:CIOADVENTURE)

## ERP & SCM: Update Suppliers (New) Listing Page

1. You will use Redwood, Oracle’s next-generation design system, to quickly and efficiently update the Suppliers (New) listing page providing more visibility to Procurement Managers. Suppliers (New) is a dynamic listing page that allows you to create role-based layouts based on configurable criteria.

    ![Configuration Objectives](images/configure_objs.png)

2. You will first navigate to the Suppliers (New) Listing Page.

    > From the application home page, click on the **Procurement** tab.

    ![Application Home Page](images/image101.png).

    > Click on **Suppliers (New)** under **Quick Actions**.

    ![My Team Page](images/image102.png)

    > Click on the **Supplier Type** to display the Filter and click into the Search box **Supplier Type**.

    ![My Team Page](images/image103.png)

    > Click and select **Supplier (187)** to display list of suppliers.

    ![My Team Page](images/image104.png)

    > Click anywhere in the page away from the search filter **Supplier (187)**

    ![My Team Page](images/image105.png)




3. Now you will enter the Suppliers (New) Page that displays lists of suppliers.


    > (1) Click on drop-down icon to expand a specific supplier row.

    ![Change Salary Page](images/image106.png)

4.  You can see the supplier information displayed is limited. We will update the page to display more fields for procurement managers. <br><br>Now you will leverage Visual Builder Studio to update the Suppliers (New) page.


    > (1) Click on the ![picture image](images/icon102_co.png) **Image** in the top right corner of the screen.  <br>

    > (2) Then select Edit Page in Visual Builder Studio from the drop down options.


    ![Change Salary Page](images/image107.png)


5. The following image appears as Visual Builder Studio is loading.

    ![Change Salary Page 2nd page](images/image108.png)

6. Welcome to Oracle Visual Builder Studio (VB Studio), a robust application development platform that helps your team effectively plan and manage your work throughout all stages of the application development lifecycle: design, build, test, and deploy. <br><br> Now we will use VB Studio to make the required changes to the Suppliers (New) page.


    > Click on **Configure Fields and Regions**. <br>

       ![Select Project](images/image109.png)



7.  First we will create a new role-based form rule for Suppliers (New) page

    > Click on the ![+ Icon](images/icon105_plus.png) **Icon** to add a new form rule.

    ![Fields and Regions](images/image110.png)

    > (1) Enter **procurementManagerLayout** in label. <br>

    > (2) Click on **Create**.

    ![Fields and Regions](images/image111.png)


8.  Note that rules are based on a hierarchy.  The rules on top supersede the rules below .

    > Click on the **Edit button.**

    ![Fields and Regions](images/image112.png)



9.  Now we will add the conditions that applies this rule to all Procurement Managers.

    > Click on the **Condition button**.

    ![Fields and Regions, Conditions](images/image113.png)

  In the first box, enter **Roles** and select **Roles** from the drop-down.

    ![Fields and Regions, Conditions](images/image114.png)

    > (1) Enter **Procurement Manager** in the right most box of the **User Roles** row.       <br>

    > (2) Select the first **Procurement Manager** role from the drop-down list.

    ![Fields and Regions, Conditions](images/image115.png)


10. Now you want to add and hide fields.

    > Click on the ![dropdown](images/icon103_dropdown.png)  Icon to the left of Supplier Details to expand the section.

    ![Fields and Regions](images/image116.png)

11. First you want to the configure the page  to display the **Creation Source**.

    > (1) Click in the Box in the **Hidden Column** for **Creation Source Field** row.    <br>

    > (2) Then select **Visble** from the options that appear.

    ![Validation](images/image117.png)


12.  Now repeat the above steps for fields Creation Date, Parent Supplier Number and Tax Payer Country to make them visible.

    > (1) Click the Box in the **Hidden Column** for **each of these** rows.    <br>

    > (2) Then select **Visible** from the options that appear.

![Validation 2](images/image118.png)


13. Well done. You have configured a new role-based page layout for Procurement Managers. Redwood offers a quick way to review your changes as they appear in the application.

    > (1) Click on the **Preview** ![Fields and Regions, Conditions](images/icon104_preview.png) icon in the upper right of the screen<br>

    > (2) A new windows will pop up in a new browser tab.

    ![Validation 2](images/image119.png)

14. You have reentered the Suppliers (New) page. Let’s review the changes.

    Click on the **Supplier Type** to display the Filter and click into the Search box **Supplier Type**.

![Validation 2](images/image120.png)

15.  You need to select the search filter Supplier (187) again.

> Click and select **Supplier (187)** to display list of suppliers.

![Validation 4](images/image121.png)


>  Click anywhere in the page away from the search filter **Supplier (187)**

 ![Change Salary Screen 2](images/image122.png)

16.  Now you will enter the Suppliers (New) Page that displays lists of suppliers.

    > Click on **drop-down icon** to expand a specific supplier row

    ![Change Salary Screen 2](images/image123.png)

17.  You can see all the changes we just configured for displaying additional fields to Procurement Managers.

    > Click on the **Home** ![Home Icon](images/icon107_home.png) Icon.


18. Adventure awaits, click on the image, show what you know and rise to the top of the leader board!!!

    [![Checkpoint](images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:LOGIN_TEAM:::::CC:CIOADVENTURE)

## Summary

Oracle Redwood is Oracle Fusion’s new design system that enhances the user experience through a visually stimulating, easy-to-use interface. By uniting customer-inspired design philosophies with industry-leading technology solutions, Oracle Redwood helps companies reduce costs, foster efficiency, revitalize the customer journey, and evolve continuously toward the future.


**You have successfully completed the Activity!**

## Learn More


* [Overview of Redwood Application Extension](https://docs.oracle.com/en/cloud/saas/human-resources/24d/fauvb/overview-of-redwood-application-extensions.html)
* [Configuring and Extending Applications](https://docs.oracle.com/en/cloud/saas/applications-common/24d/oaext/overview-of-using-visual-builder-studio.html#s20072861)
* [Oracle Documentation](http://docs.oracle.com)


## Acknowledgements
* **Author** - Charlie Moff, Distinguished Cloud Technologist, Advanced Technology Services; Casey Doody, Cloud Technologist , Advanced Technology Services
* **Contributors** -  Sajid Saleem, Master Principal Cloud Technologist, Advanced Technology Services
* **Last Updated By/Date** - Casey Doody, April 2025



