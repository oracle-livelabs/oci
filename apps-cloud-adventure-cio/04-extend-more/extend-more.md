# Extend your SaaS Applications

## Introduction

In this activity you will learn how easily extend Fusion SaaS application to include external content to guide users to better decisions.

Guided Journeys allow you to configure business processes to support user tasks by providing guidance, such as additional information, tutorials, company policies, best practices and more. The User Defined Content feature of a Guided Journey Task allows users to define guided journey tasks and connect to a user defined REST API. The user defined REST API can retrieve data from external sources based on the context information passed from the calling user interface.

As a Pit Crew member and the Oracle SaaS Business Process and Configuration expert for your organization, you’re up to the task.


### Objectives

In this lab, you will:

* Create a Guided Journey that leverages an external LLM

Estimated Time: 15 minutes

As you follow along, do not forget to think about the Adventure Check Point questions you'll answer at the end of this adventure!

## HCM: Guided Journey for Compensation Info

**Objectives**<br>
In this activity you will use HCM Guided Journey Task with User Defined Content and Visual Builder Studio to: <br>

   &emsp;  • Configure HCM Checklist Template with a Guided Journey Task with User Defined Content <br>
   &emsp;  • Link the Guided Journey Task with User Defined Content with a pre-configured Generative AI endpoint <br>
   &emsp;  • Configure HCM Compensation Info Page to include the configured Checklist Template <br>
   &emsp;  • Preview your changes <br>

![Journey Process Flow](images/hcmllmobjs.jpg)


1. You'll start by going to the Guided Journey screen.

    > (1) Enter **Guided Journey** in the search field at the top of the home page.  <br>
    > (2) Select **Guided Journey** from the resulting dropdown search results.

    ![Guided Journey Navigate](images/hcmimage001.jpg)
<br>

2. The first step is to configure a Task for the Guided Journey. We’ve already setup Guided Journeys for each Cloud Adventure User, so you'll start by searching for your specific template.

    > (1) Enter **CA&#95;##** in the **search** field, **where ## is your assigned user number**. <br>
    ![View Caution](images/cautionaboutusernumbers.png)

    > (2) Click the **Magnifying Glass** ![Magnifying Glass Icon](images/icon10_searchdark.png) icon or press the **Enter** key to execute the search.

    ![Search Guided Journey](images/hcmimage002.jpg)
<br>

3.

   > Click your **Guided Journey name** (e.g. **CA&#95;##**) to open the journey.

   ![Open Guided Journey](images/hcmimage003.jpg)
<br>

4. You can see the general information for your Guided Journey, including Name, Code and Description.  We'll use the Code later in this adventure.  You’re now ready to add a Task.

    > **Click** on the **+ Add** button under the **Tasks** header.

    ![View Guided Journey](images/hcmimage004.jpg)
<br>

5. You can now define your new task and leverage the task type User Defined Content. This will allow you to reference the REST Integration that was discussed at the beginning of the adventure.  It will link to a pre-configured Generative AI LLM endpoint.

   > Complete the following fields as shown: <br>
   > &emsp;&#8226;&emsp;Name(1): Type **Get Additional Compensation Info**<br>
   > &emsp;&#8226;&emsp;Task Type(2): Select **User Defined Content** from the dropdown<br>
   > &emsp;&#8226;&emsp;Configuration(3): Select **HCM&#95;GJ&#95;GenAI&#95;OCILlama3&#95;Endpoint** from the dropdown <br>
   > &emsp;&#8226;&emsp;(4) Click the **Save** button.

   ![Enter Task Info](images/hcmimage005.jpg)
<br>

6. The next step is the configuration the Compensation Info UI to leverage your Guided Journey. To do that, you can head back to the home page.

   > Click on the **Home** ![Home Icon](images/icon13_home.png)  icon on the top icon bar.

   ![Go Home](images/hcmimage006.jpg)
<br>

7. You can configure the Compensation Info page directly from within the application.

   > (1) Enter **Compensation Info** into the **search** field at the top of the page. <br>
   > (2) Select **Compensation Info** from the resulting **dropdown** list.

   ![Open Compensation Info](images/hcmimage007.jpg)
<br>

8. There are no matching workers, so you can unselect Direct reports to broaden our search.

   > Click the ![X Icon](images/icon14_x2.png) next to Direct Reports under the search field.

   ![Remove Direct Reports Filter](images/hcmimage008.jpg)
<br>

9. You can search for a worker and make the configuration directly from their Compensation Info page.  Note that even though you’re searching for a specific user, this will be a system-wide configuration.

   > (1) Enter **Emily Heather** in the **Search** field. <br>
   > (2) Select **Emily Heather** from the resulting **dropdown** list.

   ![Search for a person](images/hcmimage009.jpg)
<br>

10. You will now use the embedded Visual Builder Studio tool to configure this page. The configuration will allow you to reference your previously defined Guided Journey and Task. Visual Builder is the tool that Oracle uses to develop Fusion Cloud Application screens.  Customers can use these same tools to perform configurations or, as we saw in other adventures, create new screens using the same look and feel as the delivered applications.


   > (1) Click the **User Photo/User ID icon** on the top right corner of the screen. <br>
   > (2) Select **Edit Page in Visual Builder Studio** from the resulting dropdown list.

   ![Open Visual Builder](images/hcmimage010.jpg)
<br>

11. You’re now in Visual Builder – Express Mode.  This allows you to easily configure application screens.  In this scenario, you’ll be referencing the Guided Journey/Task that you created earlier.

   > (1) Enter **Salary** in the **Page Properties Filter** field on the right.  This will narrow the list of Page Properties available. <br>
   > (2) Enter **CA&#95;##** in the **CompensationInfoSalaryGuidedJourneyCode** field and press the **Enter** key.  Be careful to enter this into the correct field as there are several similar fields available.  If you searched as described in Step 1, it’s likely the 1st field listed below the filter.

   ![Search properties](images/hcmimage011.jpg)
<br>

12. You will now see the Get Additional Compensation Info link available on the screen.  If you recall, this was the name of the Task we defined earlier and is your link to the User Defined Configuration call to the LLM.

   > (1) Confirm (don't click, just confirm) that the **Get Additional Compensation Info** link now appears on the bottom left of the screen.
   > (2) Click the **Preview** ![Preview](images/icon16_preview.png) icon in the top right of the screen.

   ![Preview](images/hcmimage012.jpg)
<br>

13. The Preview should open in a new browser tab.  You can now see our screen in Preview Mode.  It shows the standard screen layout, but also includes your Guided Journey configuration.  Please note that these configurations are automatically maintained during the Oracle Release Update process.  These are not Customizations.

   > (1) Click the **Get Additional Compensation Info** link.

   ![Get Additional Compensation Info](images/hcmimage013.jpg)
<br>

14. The Guided Journey Task has called your User Defined Content integration.  As discussed in the introduction to this adventure, it calls Oracle Integration to gather additional prompt information, such as Position and New York, prior to our Generative AI call to the external LLM.  The results are then formatted and displayed as shown.

   > (1) When finished reviewing the result, you can close your browser tabs and exit the Oracle Cloud Application UI.

   ![Finish](images/hcmimage014.jpg)
   <br>

15. Adventure awaits, click on the image and show what you know, and rise to the top of the leader board!!!

    [![Cloud Adventure](images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:LOGIN_TEAM:::::CC:CIOADVENTURE)

## ERP & SCM: Guided Journey for PO Requisition Item Reviews


**Objectives**<br>
In this activity you will use a Guided Journey Task with User Defined Content and Visual Builder Studio.  You will:

   &emsp;  • Link the Guided Journey Task with User Defined Content with a pre-configured Generative AI endpoint <br>
   &emsp;  • Configure Self Service Procurement Shopping Cart to include the configured Checklist Template <br>
   &emsp;  • Preview your changes to see how you can now access real-time reviews from your cart.

![Journey Process Flow](images/pollmobj.jpg)


1. You'll start by going to the Guided Journey screen.

    > (1) Enter **Guided Journey** in the search field at the top of the home page.  <br>
    > (2) Select **Guided Journey** from the resulting dropdown search results.

    ![Guided Journey Navigate](images/poimage001.jpg)
<br>

2. The first step is to configure a Task for the Guided Journey. We’ve already setup Guided Journeys for each Cloud Adventure User, so you'll start by searching for your specific template.

    > (1) Enter **CA&#95;##** in the **search** field, **where ## is your assigned user number**. <br>
    ![View Caution](images/cautionaboutusernumbers.png)

    > (2) Click the **Magnifying Glass** ![Magnifying Glass Icon](images/icon10_searchdark.png) icon or press the **Enter** key to execute the search.

    ![Search Guided Journey](images/poimage002.jpg)
<br>

3.

    > Click your **Guided Journey name** (e.g. **CA&#95;##**) to open it.

    ![Open Guided Journey](images/poimage003.jpg)
<br>

4. You can see the general information for your Guided Journey, including Name, Code and Description.  We'll use the Code later in this adventure.  You’re now ready to add a Task.

    > **Click** on the **+ Add** button under the **Tasks** header.

    ![View Guided Journey](images/poimage004.jpg)
<br>

5. You can now define your new task, which will leverage the Task Type of User Defined Content. This will allow you to reference the REST Integration that was discussed at the beginning of the adventure.  It will link to a pre-configured Generative AI LLM endpoint.

   > Complete the following fields as shown: <br>
   > &emsp;&#8226;&emsp;Task Name(1): Type **Product Items Review**<br>
   > &emsp;&#8226;&emsp;Task Type(2): Select **User Defined Content** from the dropdown<br>
   > &emsp;&#8226;&emsp;Configuration(3): Select **SCM&#95;OCILlama3&#95;Endpoint** from the dropdown <br>
   > &emsp;&#8226;&emsp;(4) Click the **Save** button.

   ![Enter Task Info](images/poimage005.jpg)
<br>

6. You have successfully configured a new Guided Journey Task with User Defined Content. Now you are ready to include this new change in Self-Service Procurement.  The next step is to create a Requisition using Self-Service Procurement.  To start this you can head back to the home page.

   > Click on the **Home** ![Home Icon](images/icon13_home.png)  icon on the top icon bar.
   ![Go Home](images/poimage006.jpg)

<br>


7. To start creating a Purchase Requisition:

   > (1) Click the **Procurement** tab. <br>
   > (2) And then click the **Purchase Requisitions (New)** tile.

   ![Navigate to Procurement Self-Service Requisitions](images/poimage007.jpg)
<br>

8. You're going to purchase a couple of pieces of equipment for your office space.  You need a headset for phone calls and a new printer.  So, let's see what's available.

   > Click the **Office Technology** tile on the bottom right.

   ![Look for stuff to buy](images/poimage008.jpg)
<br>

9. You can see a variety of headsets available. Let's pick one.

   > Click the **Add to Cart** button for the **Logitech Zone Wireless Bluetooth Headset** tile. <br>

   ![Add to cart](images/poimage009.jpg)
<br>

10. You've now added that item to the cart.  You will receive a confirmation pop-up.  You have the option of waiting a few seconds for the confirmation pop-up to disappear or you can click the **X** icon on the **Confirmation** pop-up to close it.

   > Either wait for the pop-up to disappear or click the **X** icon on the **Confirmation** pop-up to close it.

   ![Confirm](images/poimage010.jpg)
<br>

11. You want to add one more thing to this requisition.  This time you'll use the search feature.

   > Enter **LasetJet** in the **Search for items or services** field and hit Enter.

   ![Search for stuff to buy](images/poimage011.jpg)
<br>

12. There are a lot of options, but you decide to go with the one of the LaserJet Pro printers.

   > Click the **Add to Cart** button for the **LaserJet Pro 400 M401n Laser Printer** tile. <br>

   ![Add to cart](images/poimage012.jpg)
<br>

13. You've now added that item to the cart.  You will receive a confirmation pop-up.  You have the option of waiting a few seconds for the confirmation pop-up to disappear or you can click the **X** icon on the **Confirmation** pop-up to close it.

   > Either wait for the pop-up to disappear or click the **X** icon on the **Confirmation** pop-up to close it.

   ![Confirm](images/poimage013.jpg)
<br>

14. You're now ready to view your cart.

   > Click the **Cart** icon on the bottom of the screen.

   ![View Cart](images/poimage014.jpg)
<br>

15. You will now use the embedded Visual Builder Studio tool to configure this page. The configuration will allow you to reference your previously defined Guided Journey and Task. Visual Builder is the tool that Oracle uses to develop Fusion Cloud Application screens.  Customers can use these same tools to perform configurations or, as we saw in other adventures, create new screens using the same look and feel as the delivered applications.


   > (1) Click the **User Photo/User ID icon** on the top right corner of the screen. <br>
   > (2) Select **Edit Page in Visual Builder Studio** from the resulting dropdown list.

   ![Open Visual Builder](images/poimage015.jpg)
<br>


16. You’re now in Visual Builder – Express mode.  This allows you to easily configure application screens.  In this scenario, you’ll be referencing the Guided Journey/Task that you created earlier.

   > (1) Enter **Journey** in the **Page Properties Filter** field on the right.  This will narrow the list of Page Properties available. <br>
   > (2) Enter **CA&#95;##** in the **Shopping Cart Guided Journey Code** field and press the **Enter** key.  Be careful to enter this into the correct field as there are several similar fields available.  If you searched as described in Step 1, it’s likely the 1st field listed below the filter.

   ![Link Guided Journey](images/poimage016.jpg)
<br>

17. You will now see the Product Items Review graphic on the screen.  This was defined in the Category Template at the beginning of this adventure.  You will now test this by running the screen in Preview mode.

   > Click the **Preview** ![Preview](images/icon16_preview.png) icon in the top right of the screen.

   ![Go to Preview](images/poimage017.jpg)
<br>

18. You are now back in Self-Service Procurement and you can see that your 2 items are in the cart.  So, you will now open your cart.

   > Click the **Cart** icon on the bottom of the screen.

   ![View Cart](images/poimage018.jpg)
<br>

19. The **Product Items Review** image is prominently displayed. Clicking it will call an external Gen AI Service to gather review information about the items in your cart.

   > Click the **Product Items Review** image.

   ![See Product Reviews](images/poimage019.jpg)
<br>

20. The Guided Journey Task has called your User Defined Content integration.  As discussed in the introduction to this adventure, it calls Oracle Integration to gather additional prompt information, such as Position and New York, prior to our Generative AI call to the external LLM.  The results are then formatted and displayed as shown.

   > (1) When finished reviewing the result, you can close your browser tabs and exit the Oracle Cloud Application UI.

   ![Finish](images/poimage020.jpg)

21. Adventure awaits, click on the image and show what you know, and rise to the top of the leader board!!!

    [![Cloud Adventure](images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:LOGIN_TEAM:::::CC:CIOADVENTURE)


## Summary

This Extension adventure introduced you to a few of the capabilities that customers can leverage to extend Oracle Fusion Cloud applications.  These features allow you to fine tune your Oracle Fusion Cloud Applications for peak performance, business processes tailored to you requirements, and fast, efficient usage.

 You learned how to setup and defined a Guided Journey, which provides your users with the real-time, inline guidance and information required to complete their tasks.

You also learned how to leverage 3rd party Generative AI capabilities by leveraging external LLMs directly from the Guided Journey feature of Oracle Fusion Cloud Applications.

So, check your with you team, double-check your racing harness and get ready for our next Adventure.


## Learn More


* [Oracle Documentation](http://docs.oracle.com)
* [Overview of Guided Journeys](https://docs.oracle.com/en/cloud/saas/human-resources/24d/faijh/overview-of-guided-journeys.html)
* [Configure User Defined Content Task Type for a Journey](https://docs.oracle.com/en/cloud/saas/human-resources/24d/faijh/configure-user-defined-content-task-type-for-a-journey.html)

## Acknowledgements
* **Author** - Charlie Moff, Distinguished Cloud Technologist, Advanced Technology Services; Stephen Chung, Principal Cloud Technologist, Advanced Technology Services
* **Contributors** - Sajid Saleem, Master Principal SaaS Cloud Technologist, Advanced Technology Services
* **Last Updated By/Date** - Charlie Moff, April 2025