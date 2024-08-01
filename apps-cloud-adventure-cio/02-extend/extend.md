# Extend your SaaS Applications

## Introduction

In these activities, you will learn how to (1) easily extend for Fusion SaaS application to include external content to guide users to better decisions and (2) build a new simplified user interface for specific user populations

Estimated Time: 15 minutes


### Objectives

In this lab, you will:
* Create a Guided Journey that leverages an external LLM
* Use the embedded Visual Builder capabilities to build a new, simplified Supplier Screen.


## Task 1: Guided Journeys with User Defined Content


1. To see how you can create Guided Journeys to provide additional information, including external information, to your users..

    > Go to **Home Page**, then click on top right corner before the bell icon

    ![Home Page](images/image001.png)

2. Here’s where you can visualize all the Watchlist items based on your role. The list shows all the saved searches like unapproved journals, journals requiring attention etc	

    > Click on **‘Cloud Adventure JE Link’**

    ![watchlist items](images/image031.png)

3. Here you can see the Accrual Journal to review

    > Click on the journal link ‘**XX CA-1121-ACCRUAL-01 Accrual’** to review the journal

    ![journal view](images/image004.png)  

4. This opens the journal that was posted for rent accrual. Notice the Attachment which is the audit backup for the accrual. 
   
    > **Click** on the attachments **‘Accrual JE Support Nvov-21’**.
    **Click** on the file downloaded to the PC if it doesn’t open automatically

    ![open journal](images/image005.png)  

5. Here you can view the backup for the accrual and the associated calculation. This is important and will remain as an attachment to the journal for any future audit.

    ![view backup](images/image006.png)  


## Task 2: Create a simplified user interface using Redwood Design Patterns and Oracle Visual Builder.


1. We will now create a new application screen to allow editing of specific supplier information.  Oracle Cloud Applications include an embedded tool called Visual Builder.  Visual Builder is the same tool that Oracle uses to develop application screens and it's available for you to create additional screens.  These screens can leverage both Oracle Cloud Application data and, if necessary, data from external systems.

    > (1) **Click** on the **‘Configuration’** tab <br>

    > (2) **Click** on the **‘Visual Builder’** tab

    ![Open Visual Builder](images/image001.png)

2. We have pre-defined a Project.  A project collects all the people, tools, and processes you need to complete a unit of work.  You can use a project to host source code files, track issues, collaborate on code, and build and deploy your applications. If your team is extending Oracle Cloud Applications, you’ll probably want to set things up so that you have a single project dedicated to work with a single repository for each Application. 

    > **Click** on the **‘SupplierModelExtension’** project

    ![open project](images/image002.png)

3. Workspaces allow you to segregate units of work within a Project.

    > **Click** on the **‘Go to Workspaces’** button

    ![workspace](images/image003.png)

4. We'll create a new workspace for our simplified supplier screen

    > (1) **Click** on the **‘New’** dropdown <br>

    > (2) **Select** **‘New Application Extension’** from the resulting dropdown

    ![workspace](images/image004.png)

5. We'll name our new Extension.

    > (1) **Enter** **‘QuickSupplier#’** in the "'Extension Name'" field.<br>

    > (2) **Click** the **‘Create’** button

    ![create extension](images/image005.png)

6. We're now at the Visual Builder homepage.  We can configure existing screens, create new ones, or build whole new applications.  We can also leverage REST APIs to access Fusion SaaS Data.  Supplier data from Oracle ERP/SCM Cloud, so we'll leverage the embedded integration via REST APIs.

    > (1) **Click** the **‘Services’** icon on the left menu.

    ![add UI Screen](images/image006.png)

7. We can add services from Oracle Cloud Applications or other accessible data sources.

    > (1) **Click** on the **‘+ Service Connection’** button.

    ![create UI](images/image007.png)

8. There are multiple ways to reference a service.  We'll use the included catalog of Oracle Cloud Application services.

    > **Click** on the **‘Select from Catalog’** tile.

    ![view default screen template](images/image008.png)

9. Services are available for functionality across the Oracle Cloud Applications.

    > **Click** on the **‘‘Enterprise Resource Planning and Supply Chain’** tile.

    ![manage services](images/image009.png)

10. We'll use the Supplier Service from the ERP/SCM Catalog. 

    > (1) **Enter** ‘Suppliers’ in the 'Supplier Name' field. <br>
    > (2) Enter ‘Suppliers’ in the ‘Filter Objects/Endpoints’ field. <br>
    > (3) Click the ‘Checkbox’ next to ‘Suppliers’. <br>
    > (4) Click the ‘Create’ button. <br>

    ![create service connect](images/image010.png)

11. The resulting screen shows additional configuration options for our supplier service, but we'll just use the default settings.  Now we want to start creating our new screen.  

    > **Click** on the **‘App UIs’** icon in the left toolbar

    ![select from catalog](images/image011.png)

12. We're now at the Visual Builder APP UI Screen.  We can configure existing screens, create new ones, or build whole new applications.  We want to create a new UI screen.

    > **Click** on the **‘+ App UI’** button.

    ![select ERP/SCM](images/image012.png)

13. 

    > (1) **Enter** **‘QuickSupplierUI’** in the "'App UI Name'" field.<br>

    > (2) **Click** the **‘Create’** button.

    ![get supplier service](images/image013.png)

14. Visual Builder has automatically created a default UI leveraging the Oracle provided Redwood template.  Redwood is Oracle's design methodology and pre-defined templates, and design patterns are included in Visual Builder to allow you to create applications that look and function just like Oracle delivered applications.

    > **Double-Click** the **‘main-start’** object.

    ![create supplier service](images/image014.png)

15. Here we see our blank template and a list of some of the provided Redwood design components.  We want to start by adding some components to the screen to hold our data.  We’ll first add a Panel component.

    > (1) Confirm you’re in the **Components** tab. <br>

    > (2) Type **Panel** in the **‘filter’** field. <br>

    > (3) Drag **Panel** to first blue section (4) of the page as shown.

    ![create supplier service](images/image015.png)

16. We’ll now add a Table component to our new Panel.

    > (1) Type **Table** in the **‘filter’** field. <br>
    > (2) Drag **Table** to first blue section (3) of the page as shown.

    ![add supplier service to screen](images/image016.png)

17. We now have a table to hold our data. Next, we’ll add the Supplier data from our REST API. We can use the Quick Start feature to help with this task.

    > (1) Click the newly created **Table** region.<br>

    > (2) You should now see the Table Properties region appear on the right.

    ![table layout](images/image017.png)

18. The Quick Start features simply common tasks.We can use the Add Data Quick Start feature to show data from our Supplier REST API.

    > (1) Click the **'Quick Start'** table in the Table Properties area. <br>

    > (2) Click the **'Add Data'** tile.

    ![select supplier fields](images/image018.png)

19. We can see the various Supplier related data available from the Supplier REST API.  We’ll just use the Suppliers data for this scenario.

    > (1)  Click **'Suppliers'** to expand the Suppliers region. <br>

    > (2)  Click **'Suppliers'** tile. <br>

    > (3) Click the **Next** button.

    ![finish supplier fields](images/image019.png)

20. We’ll select a few fields to display on our new screen.  We want to use this to allow for quick update of a few pieces of Supplier Data, including Taxpayer ID, Alternate Name and Alias.  We’ll select those fields in additional to Supplier and Supplier Number..

    > (1)  Click **'Checkbox'** next to the following fields.  You’ll need to scroll the Endpoint Structure for the last 3 fields: <br>
           - Alias <br>
           - AlternateName<br>
           - Supplier<br>
           - SupplierNumber<br>
           - TaxpayerId<br><br>

    > (2)  Confirm the list of selected fields. <br>

    > (3) Click the **Next** button.

    ![widen screen handle](images/image020.png)

21. We can optionally add additional filter criteria.

    > (1) Note the ability to add additional criteria. <br>

    > (2) Click the **Finish** button.

    ![widen screen](images/image021.png)

22. Notice that the screen auto-queried Supplier Information.  We can easily move between Design, Live and Code views of our application.  But next, we want the ability to edit data.  So, we’ll use the Quick Start again to add an edit page.  

    > (1) Confirm that you're on the **Quick Start** tab. <br>

    > (2) Click the **Add Edit Page" tile.

    ![edit page quick start](images/image022.png)

23. We can select the same or different fields for out Edit Page.  We’ll just select the same list..

     > (1)  Click **'Checkbox'** next to the following fields.  Note that you may need to scroll the list of fields: <br>
           - Alias <br>
           - AlternateName<br>
           - Supplier<br>
           - SupplierNumber<br>
           - TaxpayerId<br><br>

    > (2)  Confirm the list of selected fields. <br>

    > (3) Click the **Finish** button.

    ![edit page quick start](images/image023.png)

24. Now that we've created our screen, we can test it.

    > Click the **Preview** icon on the top right of the screen.

    ![select edit page fields](images/image024.png)

25. A new browser tab is launched showing our completed application.  We now have a fully functioning screen that supports query and update capabilities.

    > (1) Select a **Supplier** to highlight a row. <br>    
    > (2) Click the **Edit Supplier** button.   

    ![finish edit page fields](images/image025.png)

26. We'll update and save a field.  Out new screen leverages the security and business rules of the application via the standard REST API. .

    > (1) Enter a value in the **Alternate Name*** field. For example, enter "LeeSupp" as the Alternate Name for Lee Supplies.  <br>    
    > (2) Click the **Save** button.   


    ![preview](images/image026.png)


27. Our Supplier record update is now saved.

    > Note the message that the supplier record was successfully updated.

    ![selected supplier for edit](images/image027.png)	


28. Adventure awaits, click on the image, show what you know and rise to the top of the leader board!!!
    
    [![Cloud Adventure](images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:20:::::QN:13) 


## Summary (MISSING)

**You have successfully completed the Activity!**

 
## Learn More (Are we adding this to live labs?)


* [Oracle Documentation](http://docs.oracle.com)
* [Extending Oracle Cloud Applications with Visual Builder Studio](https://docs.oracle.com/en/cloud/paas/visual-builder/visualbuilder-building-appui)

## Acknowledgements
* **Author** - Charlie Moff, Distinguished Sales Consultant, Advanced Technology Services
* **Contributors** -  
* **Last Updated By/Date** - Charlie Moff, August 2024