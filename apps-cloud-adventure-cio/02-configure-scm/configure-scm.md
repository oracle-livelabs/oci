# Configure

## Introduction

Oracle offers hundreds of prebuilt pages, workflows and forms “out of the box” as part of the Oracle Fusion Cloud.  Many of our customers want to configure these pages and workflows to meet their specific business needs.  You can unify your experience in our applications by using Redwood.

Oracle Redwood is Oracle Fusion’s new design system that enhances the user experience through a visually stimulating, easy-to-use interface. By uniting customer-inspired design philosophies with industry-leading technology solutions, Oracle Redwood helps companies reduce costs, foster efficiency, revitalize the customer journey, and evolve continuously toward the future.   

In this exercise, you are the Redwood expert for your organization.  You will use Redwood, Oracle’s next-generation design system, to quickly and efficiently design the Update Suppliers (New) listing page.

Do not forget to answer the Adventure Check Point questions at the end of the exercise! 


Estimated Time: 15 minutes


### Objectives

In this activity, you will use Redwood to incorporate rules and define content surfaced in the application to tailor the user experience. 

![Configure  OBJs](images/configure_objs.png).



## Task 1: Update Suppliers (New) listing page

1. You will use Redwood, Oracle’s next-generation design system, to quickly and efficiently update **Suppliers (New) listing page providing more visibility to administrators**. Suppliers (New) is a dynamic listing page that allows you to create role-based layouts based on configurable criteria.

    You will first navigate to the Suppliers (New) Listing Page.

    > From the application home page, click on the **Procurement** tab.

    ![Application Home Page](images/image001.png).

    > Click on **Suppliers (New)** under **Quick Actions**.

    ![My Team Page](images/image002.png)

    > Click on the **Supplier Type** to display the Filter and click into the Search box **Supplier Type**.

    ![My Team Page](images/image003.png)

    > Click and select **Supplier (187)** to display list of suppliers.

    ![My Team Page](images/image004.png)

    > Click anywhere in the page away from the search filter **Supplier (187)** 

    ![My Team Page](images/image005.png)




2. Now you will enter the Suppliers (New) Page that displays lists of suppliers. 


    > (1) Click on drop-down icon to expand a specific supplier row.
    
    ![Change Salary Page](images/image006.png)

3.  You can see the supplier information displayed is limited. We will update the page to display more fields for procurement managers. <br><br>Now you will leverage Visual Builder Studio to update the Suppliers (New) page.


    > (1) Click on the ![picture image](images/icon02_co.png) **Image** in the top right corner of the screen.  <br>

    > (2) Then select Edit Page in Visual Builder Studio from the drop down options.


    ![Change Salary Page](images/image007.png)


4. The following image appears as Visual Builder Studio is loading.

    ![Change Salary Page 2nd page](images/image008.png)

5. Welcome to Oracle Visual Builder Studio (VB Studio), a robust application development platform that helps your team effectively plan and manage your work throughout all stages of the application development lifecycle: design, build, test, and deploy. <br><br> Now we will use VB Studio to make the required changes to the Suppliers (New) page.


    > Click on **Configure Fields and Regions**. <br>

       ![Select Project](images/image009.png)



6.  First we will create a new role-based form rule for Suppliers (New) page

    > Click on the ![+ Icon](images/icon05_plus.png) **Icon** to add a new form rule.

    ![Fields and Regions](images/image010.png)

    > (1) Enter **procurementManagerLayout** in label. <br>

    > (2) Click on **Create**.

    ![Fields and Regions](images/image011.png)


7.  Note that rules are based on a hierarchy.  The rules on top supersede the rules below .

    > Click on the **Edit button.**

    ![Fields and Regions](images/image012.png)



8.  Now we will add the conditions that applies this rule to all Procurement Managers.

    > Click on the **Condition button**.

    ![Fields and Regions, Conditions](images/image013.png)

  In the first box, enter **Roles** and select **Roles** from the drop-down.

    ![Fields and Regions, Conditions](images/image014.png)

    > (1) Enter **Procurement Manager** in the right most box of the **User Roles** row.       <br>

    > (2) Select the first **Procurement Manager** role from the drop-down list. .

    ![Fields and Regions, Conditions](images/image015.png)


9. Now you want to add and hide fields.

    > Click on the ![dropdown](images/icon03_dropdown.png)  Icon to the left of Supplier Details to expand the section.

    ![Fields and Regions](images/image016.png)

10. First you want to the configure the page  to display the **Creation Source**. 

    > (1) Click in the Box in the **Hidden Column** for **Creation Source Field** row.    <br>

    > (2) Then select **Visble** from the options that appear.

    ![Validation](images/image017.png)


11.  Now repeat the above steps for fields Creation Date, Parent Supplier Number and Tax Payer Country to make them visible.

    > (1) Click the Box in the **Hidden Column** for **each of these** rows.    <br>

    > (2) Then select **Visible** from the options that appear.

![Validation 2](images/image018.png)

 
12. Well done. You have configured a new role-based page layout for Procurement Managers. Redwood offers a quick way to review your changes as they appear in the application.

    > (1) Click on the **Preview** ![Fields and Regions, Conditions](images/icon04_preview.png) icon in the upper right of the screen<br>

    > (2) A new windows will pop up in a new browser tab.
    
    ![Validation 2](images/image019.png)

13. You have reentered the Suppliers (New) page. Let’s review the changes.

    Click on the **Supplier Type** to display the Filter and click into the Search box **Supplier Type**.

![Validation 2](images/image020.png)
   
14.  You need to select the search filter Supplier (187) again. 

    > Click and select **Supplier (187)** to display list of suppliers. 

![Validation 4](images/image021.png)


15. 

    >  Click anywhere in the page away from the search filter **Supplier (187)**

 ![Change Salary Screen 2](images/image022.png)

16.  Now you will enter the Suppliers (New) Page that displays lists of suppliers.

    > Click on **drop-down icon** to expand a specific supplier row

    ![Change Salary Screen 2](images/image023.png)

17.  You can see all the changes we just configured for displaying additional fields to Procurement Managers.

    > Click on the **Home** ![Home Icon](images/icon07_home.png) Icon.


18. Adventure awaits, click on the image, show what you know and rise to the top of the leader board!!!

    [![Checkpoint](images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:LOGIN_TEAM:::::CC:CIOADVENTURE) 




## Summary

Oracle Redwood is Oracle Fusion’s new design system that enhances the user experience through a visually stimulating, easy-to-use interface. By uniting customer-inspired design philosophies with industry-leading technology solutions, Oracle Redwood helps companies reduce costs, foster efficiency, revitalize the customer journey, and evolve continuously toward the future.   

Oracle Visual Builder Studio (or VB Studio, for short) is an integrated development platform that helps your team effectively plan and manage your work throughout the application's lifecycle. It combines the simplicity of a visual development environment with powerful management tools to streamline application development and deliver modern, innovative user experiences.

In this example, you used Redwood, Oracle’s next-generation design system, to quickly and efficiently enhance the Change Salary Form.


**You have successfully completed the Activity!**



## Acknowledgements
* **Author** - Casey Doody, Cloud Technologist, Advanced Technology Services
* **Contributors** -  Sajid Saleem, Master Principal Cloud Technologist, Advanced Technology Services
* **Last Updated By/Date** -Casey Doody, August 2024




[def]: images/image013.png