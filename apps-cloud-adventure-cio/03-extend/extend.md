# Extend your SaaS Applications

## Introduction

In this activity, you will learn how to build a new simplified user interface for specific user populations.

Estimated Time: 15 minutes


### Objectives

In this lab, you will:

* Use Visual Builder to build a new Supplier Screen.

![New Screen Process Flow](images/SupplierScreenOBJs.png)


## Task 1: Create a simplified user interface using Redwood Design Patterns and Oracle Visual Builder.


1. We will now create a new application screen to allow editing of specific supplier information.  Oracle Cloud Applications include an embedded tool called Visual Builder.  Visual Builder is the same tool that Oracle uses to develop application screens and it's available for you to create additional screens.  These screens can leverage both Oracle Cloud Application data and, if necessary, data from external systems.

    > (1) **Click** on the **‘Configuration’** tab. <br> 

    > (2) **Click** on the **‘Visual Builder’** tile

    ![Open Visual Builder](images/image101.png)

2. We have pre-defined a Project.  A project collects all the people, tools, and processes you need to complete a unit of work.  You can use a project to host source code files, track issues, collaborate on code, and build and deploy your applications. If your team is extending Oracle Cloud Applications, you’ll probably want to set things up so that you have a single project dedicated to work with a single repository for each Application. 

    > **Click** on the **‘SupplierModelExtension’** project

    ![open project](images/image102.png)

3. Workspaces allow you to segregate units of work within a Project.

    > **Click** on the **‘Go to Workspaces’** button

    ![workspace](images/image103.png)

4. We'll create a new workspace for our simplified supplier screen

    > (1) **Click** on the **‘New’** ![New drop down](images/icon017_dropdown.png) dropdown <br>

    > (2) **Select** **‘New Application Extension’** from the resulting dropdown

    ![workspace](images/image104.png)

5. We'll name our new Extension.

    > (1) **Enter** **‘QuickSupplier#’** in the "'Extension Name'" field.<br>

    > (2) **Click** the **‘Create’** button

    ![create extension](images/image105.png)

6. We're now at the Visual Builder homepage.  We can configure existing screens, create new ones, or build whole new applications.  We can also leverage REST APIs to access Fusion SaaS Data.  Supplier data from Oracle ERP/SCM Cloud, so we'll leverage the embedded integration via REST APIs.

    > (1) **Click** the **‘Services’** ![Services Icon](images/icon018_services.png) icon on the left menu.

    ![add UI Screen](images/image106.png)

7. We can add services from Oracle Cloud Applications or other accessible data sources.

    > (1) **Click** on the **‘+ Service Connection’** button.

    ![create UI](images/image107.png)

8. There are multiple ways to reference a service.  We'll use the included catalog of Oracle Cloud Application services.

    > **Click** on the **‘Select from Catalog’** tile.

    ![view default screen template](images/image108.png)

9. Services are available for functionality across the Oracle Cloud Applications.

    > **Click** on the **‘‘Enterprise Resource Planning and Supply Chain’** tile.

    ![manage services](images/image109.png)

10. We'll use the Supplier Service from the ERP/SCM Catalog. 

    > (1) **Enter** ‘Suppliers’ in the 'Supplier Name' field. <br>
    > (2) Enter ‘Suppliers’ in the ‘Filter Objects/Endpoints’ field. <br>
    > (3) Click the ‘Checkbox’ next to ‘Suppliers’. <br>
    > (4) Click the ‘Create’ button. <br>

    ![create service connect](images/image110.png)

11. The resulting screen shows additional configuration options for our supplier service, but we'll just use the default settings.  Now we want to start creating our new screen.  

    > **Click** on the **‘App UIs’** ![App UIs Icon](images/icon019_apps_uis.png) icon in the left toolbar

    ![select from catalog](images/image111.png)

12. We're now at the Visual Builder APP UI Screen.  We can configure existing screens, create new ones, or build whole new applications.  We want to create a new UI screen.

    > **Click** on the **‘+ App UI’** button.

    ![select ERP/SCM](images/image112.png)

    > (1) **Enter** **‘QuickSupplierUI’** in the "'App UI Name'" field.<br>

    > (2) **Click** the **‘Create’** button.

    ![get supplier service](images/image113.png)

13. Visual Builder has automatically created a default UI leveraging the Oracle provided Redwood template.  Redwood is Oracle's design methodology and pre-defined templates, and design patterns are included in Visual Builder to allow you to create applications that look and function just like Oracle delivered applications.

    > **Double-Click** the **‘main-start’** object.

    ![create supplier service](images/image114.png)


14. Here we see our blank template and a list of some of the provided Redwood design components.  We want to start by adding some components to the screen to hold our data.  We’ll first add a Panel component.

    > (1) Confirm you’re in the **Components** tab. <br>

    > (2) Type **Panel** in the **‘filter’** field. <br>

    > (3) Drag **Panel** to first blue section (4) of the page as shown.

    ![create supplier service](images/image115.png)

15. We’ll now add a Table component to our new Panel.

    > (1) Type **Table** in the **‘filter’** field. <br>
    > (2) Drag **Table** to first blue section (3) of the page as shown.

    ![add supplier service to screen](images/image116.png)

16. We now have a table to hold our data. Next, we’ll add the Supplier data from our REST API. We can use the Quick Start feature to help with this task.

    > (1) Click the newly created **Table** region.<br>

    > (2) You should now see the Table Properties region appear on the right.

    ![table layout](images/image117.png)

17. The Quick Start features simply common tasks.  We can use the Add Data Quick Start feature to show data from our Supplier REST API.

    > (1) Click the **'Quick Start'** table in the Table Properties area. <br>

    > (2) Click the **'Add Data'** tile.

    ![select supplier fields](images/image118.png)

18. We can see the various Supplier related data available from the Supplier REST API.  We’ll just use the Suppliers data for this scenario.8
    > (1)  Click **'Suppliers'** to expand the Suppliers region. <br>

    > (2)  Click **'Suppliers'** tile. <br>

    > (3) Click the **Next** button.

    ![finish supplier fields](images/image119.png)

19. We’ll select a few fields to display on our new screen.  We want to use this to allow for quick update of a few pieces of Supplier Data, including Taxpayer ID, Alternate Name and Alias.  We’ll select those fields in additional to Supplier and Supplier Number..

    > (1)  Click **'Checkbox'** next to the following fields.  You’ll need to scroll the Endpoint Structure for the last 3 fields: <br>
           - Alias <br>
           - AlternateName<br>
           - Supplier<br>
           - SupplierNumber<br>
           - TaxpayerId<br><br>

    > (2)  Confirm the list of selected fields. <br>

    > (3) Click the **Next** button.

    ![widen screen handle](images/image120.png)

20. We can optionally add additional filter criteria.

    > (1) Note the ability to add additional criteria. <br>

    > (2) Click the **Finish** button.

    ![widen screen](images/image121.png)

21. Notice that the screen auto-queried Supplier Information.  We can easily move between Design, Live and Code views of our application.  But next, we want the ability to edit data.  So, we’ll use the Quick Start again to add an edit page.  

    > (1) Confirm that you're on the **Quick Start** tab. <br>

    > (2) Click the **Add Edit Page** tile.

    ![edit page quick start](images/image122.png)

22. We can select the same or different fields for out Edit Page.  We’ll just select the same list..

     > (1)  Click **'Checkbox'** next to the following fields.  Note that you may need to scroll the list of fields: <br>
           - Alias <br>
           - AlternateName<br>
           - Supplier<br>
           - SupplierNumber<br>
           - TaxpayerId<br><br>

    > (2)  Confirm the list of selected fields. <br>

    > (3) Click the **Finish** button.

    ![edit page quick start](images/image123.png)

23. Now that we've created our screen, we can test it.

    > Click the **Preview** ![Preview Icon](images/icon016_preview.png) icon on the top right of the screen.

    ![select edit page fields](images/image124.png)

24. A new browser tab is launched showing our completed application.  We now have a fully functioning screen that supports query and update capabilities.

    > (1) Select a **Supplier** to highlight a row. <br>    
    > (2) Click the **Edit Supplier** button.   

    ![finish edit page fields](images/image125.png)

25. We'll update and save a field.  Out new screen leverages the security and business rules of the application via the standard REST API. .

    > (1) Enter a value in the **Alternate Name** field. For example, enter "LeeSupp" as the Alternate Name for Lee Supplies.  <br>    
    > (2) Click the **Save** button.   


    ![preview](images/image126.png)


26. Our Supplier record update is now saved.

    > Note the message that the supplier record was successfully updated.

    ![selected supplier for edit](images/image127.png)	


27. Adventure awaits, click on the image and show what you know, and rise to the top of the leader board!!!
    
    [![Cloud Adventure](images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:LOGIN_TEAM:::::CC:CIOADVENTURE) 
 

## Summary

The two tasks of this Extension adventure introduced you to a few of the capabilities that customers can leverage to extend Oracle Fusion Cloud applications.  These features allow you to fine tune your Oracle Fusion Cloud Applications for peak performance, business processes tailored to you requirements, and fast, efficient usage.

You learned how to extend the applications using Oracle Visual Builder Studio to create new screens that leverage both Oracle and non-Oracle data. You also learned how to setup and defined a Guided Journey, which provides your users with the real-time, inline guidance and information required to complete their tasks.  

You also learned how to leverage 3rd party Generative AI capabilities by leveraging external LLMs directly from the Guided Journey feature of Oracle Fusion Cloud Applications.  

So, check your with you team, double-check your racing harness and get ready for our next Adventure.


## Learn More


* [Oracle Documentation](http://docs.oracle.com)
* [Extending Oracle Cloud Applications with Visual Builder Studio](https://docs.oracle.com/en/cloud/paas/visual-builder/visualbuilder-building-appui)
* [Overview of Guided Journeys](https://docs.oracle.com/en/cloud/saas/human-resources/24c/faijh/overview-of-guided-journeys.html)
* [Configure User Defined Content Task Type for a Journey](https://docs.oracle.com/en/cloud/saas/human-resources/24c/faijh/configure-user-defined-content-task-type-for-a-journey.html)

## Acknowledgements
* **Author** - Charlie Moff, Distinguished Cloud Technologist, Advanced Technology Services; Stephen Chung, Principal SaaS Cloud Technologist, Advanced Technology Services
* **Contributors** - Sajid Saleem, Master Principal SaaS Cloud Technologist, Advanced Technology Services  
* **Last Updated By/Date** - Charlie Moff, September 2024 