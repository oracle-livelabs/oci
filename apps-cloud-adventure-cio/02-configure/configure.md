# Configure

## **Configure the Change Salary Experience**

### **Introduction**

Oracle offers hundreds of prebuilt pages, workflows and forms “out of the box” as part of the Oracle Fusion Cloud.  Many of our customers want to configure these pages and workflows to meet their specific business needs.  You can unify your experience in our applications by using Redwood.

Oracle Redwood is Oracle Fusion’s new design system that enhances the user experience through a visually stimulating, easy-to-use interface. By uniting customer-inspired design philosophies with industry-leading technology solutions, Oracle Redwood helps companies reduce costs, foster efficiency, revitalize the customer journey, and evolve continuously toward the future.

### **Objectives**

In this lab, you will use Redwood to quickly and efficiently improve the user experience in Oracle Fusion Cloud.

Estimated Time: 15 minutes

Do not forget to answer the Adventure Check Point questions at the end of the exercise!

### **Begin Exercise**

1. You will use Redwood, Oracle’s next-generation design system, and Visual Builder to quickly and efficiently update Change Salary Page for Non-HR managers.

    ![Configuration Objectives](../02-configure/images/configure_objs_hcm.png)

2. You will first navigate to the Change Salary Page.

    > (1) From the application home page, click on the **My Team** tab.

    ![Application Home Page](../02-configure/images/hcmconfigimage002.jpg).

3. You can access Change Salary from an individual worker record, from the search bar, or via the Quick Actions feature.

    > (1) Click on **Change Salary** under **Quick Actions**.

    ![My Team Page](../02-configure/images/hcmconfigimage003.jpg)

4. By default this screen shows information on any Direct Reports.  Since you don't have any, you can remove this filter.

    > (1) Click on the ![x icon](../02-configure/images/icon011_x.png)  **Icon** to remove the Direct Reports Filter because your user does not have any direct reports.  This action allows you to see other people.

    ![My Team Page](../02-configure/images/hcmconfigimage004.jpg)


5. Now you will enter the Change Salary Form so we can make the required changes using Visual Builder Studio.  Now you will select a person so you can enter the Change Salary form.

    > (1) Search for **Barrett Reed** in the search field. <br>

    > (2) Select **Barrett Reed** in the drop down. <br>

    ![Change Salary Page](../02-configure/images/hcmconfigimage005.jpg)

6.  You have entered the Change Salary Form.  Now you will quickly review the current configuration of the Change Salary Form.  You need to enter in some information to access the form


    > (1) When does the salary will start?: Type a **future date** <br>

    > (2) What is the action name?: Select **Change Salary**. <br>

    > (3) Why you are changing the salary?: Select **Career Progression**. <br>

    > (4) Click **Continue** once complete.

    ![Change Salary Page](../02-configure/images/hcmconfigimage006.jpg)


7. You will now create new rule that hides Annualized Full-Time Salary because it is repetitive.  You will also hide Compa-Raito since this is mainly used by HR.  You also want to show the action reason in this section of the Change Salary Form.  We can make these configuration changes by leveraging the embedded Vision Studio Builder capabilities.

    > (1) No action is required for Step 1.  Just note that the Annualized Full-Time Salary and Compa-Ratio fields are visible. <br>
    > (2) Click the **logged in user icon** icon ![co image](../02-configure/images/icon012_co.png) next to the bell icon in the top right corner of the screen and select **Edit Page in Visual Builder Studio** from the resulting drop-down.

    ![Change Salary Page 2nd page](../02-configure/images/hcmconfigimage007.jpg)


8.  Welcome to Oracle Visual Builder Studio (VB Studio), a robust application development platform that helps your team effectively plan and manage your work throughout all stages of the app dev lifecycle: design, build, test, and deploy. Now we will use VB Studio to make the required changes to the Change Salary Form.

    > (1) Click on **Configure Fields and Regions** button.

    ![VB Studio](../02-configure/images/hcmconfigimage008.jpg)


9. First we will create a new form rule for change salary.

    > (1) Click on the ![plus icon](../02-configure/images/icon015_plus.png)  **Icon** to add a new form rule.

    ![Fields and Regions](../02-configure/images/hcmconfigimage009.jpg)


10. You can name your new rule and optionally include a description.

    > (1) Label: Type **Change Salary Non-HR**. <br>

    > (2) Click the **Create** button.

    ![Fields and Regions](../02-configure/images/hcmconfigimage010.jpg)


11.  You will add the Conditions for this rule to apply to all non-HR personnel.

    > (1) Click on the **Edit button.**

    ![Fields and Regions](../02-configure/images/hcmconfigimage011.jpg)

12.  You can complete the additional fields in User Roles condition in the first line. This configuration displays this version of the Change Salary Form to all people who are not assigned to the Human Resource Manager Role.

    > (1) For 2nd column in the **User Roles** row, select **does not contain** from the drop down.  <br>

    > (2) For 3nd column in the **User Roles**, type **Human Resource Manager** and select **Human Resource Manager** from the resulting dropdown.<br>

    > (3) Click on the **Drop Down** ![drop down icon](../02-configure/images/icon013_dropdown.png)  Icon to the left of Salary to expand the salary section

      ![Fields and Regions](../02-configure/images/hcmconfigimage012.jpg)


13.  Now you want to add and hide fields.

     > (1) Action Reason: select **Visible**     <br>

     > (2) Annualized Full-Time Salary: select **Hidden**   <br>

     > (3) Compa-Ratio: select **Hidden**  <br>

     > (4) Click the ![done icon](../02-configure/images/icon_done.png) icon to complete the definition of this rule.<br>

     > (5) Click the ![x icon](../02-configure/images/icon101_x.png) to close the Fields and Regions section.

     ![Salary Fields and Regions](../02-configure/images/hcmconfigimage013.jpg)


14. Now you will add a validation step for the Adjustment Percentage.  You do not want users to enter in a Salary Percentage Greater than 15%

    > (1) Click on **Configure Validations**

    ![Fields and Regions](../02-configure/images/hcmconfigimage014.jpg)

15. You can see any existing Validations and/or create new ones.

    > Click on **+ Validation**

    ![Validation](../02-configure/images/hcmconfigimage015.jpg)

16. Your first step is the name your Validation.

    > (1) Label: type **Adjustment Percentage**.    <br>

    > (2) Click the **Create** button.

    ![Validation](../02-configure/images/hcmconfigimage016.jpg)


17.  Now you will set the conditions for this rule so that the form will not accept any adjustment percentage greater than 15%.

     > (1) Click on **Edit**.

     ![Create Validation](../02-configure/images/hcmconfigimage017.jpg)

18.  Instead of using the pre-define condition rows, you'll create a new one.

     > (1) Click on **+ Condition**.

     ![Create Condition](../02-configure/images/hcmconfigimage018.jpg)

19.  For the first field on the condition, you'll want to use the Adjustment Percentage.  <br>![caution](../02-configure/images/cautionflagextrasmalltransparent2.png)**Note:** **Adjustment Percentage** will appear multiple times in the list of values, so be sure to select the correct one as described below.

     > (1) Type **Adjustment Percentage** in the box and select the 1st **# Adjustment Percentage** under **Salary Details** from the resulting list of values.    <br>

     ![Create Validation](../02-configure/images/hcmconfigimage019.jpg)

20.  For the second field on the condition, you'll specify the operator.

     > (1) Select **greater than** from the dropdown.   <br>

     ![Create Validation](../02-configure/images/hcmconfigimage020.jpg)

21.  For the third field on the condition, you'll specify the comparison value. <br>![caution](../02-configure/images/cautionflagextrasmalltransparent2.png)**Note:** if the 3rd data entry field is obscured by the list of values, press the esc key on the upper left of your laptop keyboard.

    > (1) Type **15**

    ![Create Validation](../02-configure/images/hcmconfigimage021.jpg)

22. Now you will configure the error message users will see if they enter an Adjustment Percentage greater than 15%.

     > (1) Summary: type **Adjustment Percentage is too high**.    <br>

     > (2) Severity:  Select **Error**. <br>

     > (3) Detail:  type **The Adjustment Percentage must be lower than 15%**. <br>

     > (4) Click the ![done icon](../02-configure/images/icon_done.png) icon to complete the definition of this rule.<br>

     > (5) Click the ![x icon](../02-configure/images/icon101_x.png) to close the Validations section.

     ![Create Validation](../02-configure/images/hcmconfigimage022.jpg)


23.  Well done.  You have configured a new rule for Non-HR personnel.  You can quickly review your changes as they appear in the application.

    > (1) Click on the **Preview** ![preview icon](../02-configure/images/icon014_preview.png) icon in the top right of the screen.
       <br>![caution](../02-configure/images/cautionflagextrasmalltransparent2.png)**Note:** This will open the application in a new browser tab.<br>

       ![Create Validation](../02-configure/images/hcmconfigimage023.jpg)

24.  You have re-entered the Change Salary Form.  Let’s review the changes.  You need to enter the required information before you can move to the next screen.

    > (1) When does the salary will start?: Type a **future date** <br>

    > (2) What is the action name?: Select **Change Salary**. <br>

    > (3) Why you are changing the salary?: Select **Career Progression**. <br>

    > (4) Click **Continue** once complete.

     ![Change Salary Page 2nd page](../02-configure/images/hcmconfigimage024.jpg)


25.  Note that Annualized Full-Time Salary and Compa-Ratio are no longer visible and Action Reason is now Visible. Now you will test the validation for the Adjustment Amount Percentage.

    > (1) Enter an Adjustment Percentage that is greater than 15% and either **tab** out of the field or press the **Enter** key on the keybord.

    ![Change Salary Screen 2](../02-configure/images/hcmconfigimage025.jpg)

26.  The system will not allow the user to continue because the Adjustment Percentage exceeds 15%!

    ![Change Salary Screen 2 error message](../02-configure/images/hcmconfigimage026.jpg)

27.  Congratulations!  ![checkered flag](../02-configure/images/checkeredflag.jpg)

    > You've completed this Adventure.  Please close this tab and the Visual Builder tab and get ready for your next Adventure.

27. Adventure awaits, click on the image, show what you know and rise to the top of the leader board!!!

    [![Cloud Adventure](../00-introduction/images/adventure-checkpoint.png)](https://apex.oracle.com/pls/apex/f?p=159406:LOGIN_TEAM:::::CC:CIOADVENTURE)

### Summary

In this adventure you experience the power of application configuration, including the ability to define rules, control screen content, and define validation rules.  This adventure leveraged Visual Builder, the same tool that Oracle uses to build the application. Visual Builder allows you to configure the application and also create new application screens that can leverage both Oracle and non-Oracle data. These features allow you to fine tune your Oracle Fusion Cloud Applications for peak performance, business processes tailored to you requirements, and fast, efficient usage.

And remember, application configurations are automatically maintained during the release update process.

So, check your with you team, double-check your racing harness and get ready for our next Adventure.

### Learn More


* [Overview of Redwood Application Extension](https://docs.oracle.com/en/cloud/saas/human-resources/24d/fauvb/overview-of-redwood-application-extensions.html)
* [Configuring and Extending Applications](https://docs.oracle.com/en/cloud/saas/applications-common/24d/oaext/overview-of-using-visual-builder-studio.html#s20072861)
* [Oracle Documentation](http://docs.oracle.com)





## Acknowledgements
* **Author** - Charlie Moff, Distinguished Cloud Technologist, Advanced Technology Services; Casey Doody, Cloud Technologist , Advanced Technology Services
* **Contributors** -  Sajid Saleem, Master Principal Cloud Technologist, Advanced Technology Services
* **Last Updated By/Date** - Casey Doody, October 2025



