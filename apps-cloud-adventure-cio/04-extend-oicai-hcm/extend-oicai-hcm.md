# Extend your SaaS Applications

## HCM: Guided Journey for Compensation Info

### Introduction

In this activity you will learn how easily extend Fusion SaaS application to include external content to guide users to better decisions.

Guided Journeys allow you to configure business processes to support user tasks by providing guidance, such as additional information, tutorials, company policies, best practices and more. The User Defined Content feature of a Guided Journey Task allows users to define guided journey tasks and connect to a user defined REST API. The user defined REST API can retrieve data from external sources based on the context information passed from the calling user interface.

As a Pit Crew member and the Oracle SaaS Business Process and Configuration expert for your organization, you’re up to the task.

### Objectives

In this lab, you will use HCM Guided Journey Task with User Defined Content and Visual Builder Studio to: <br>

   &emsp;  • Configure HCM Guided Journey and a Task with User Defined Content <br>
   &emsp;  • Link the Guided Journey Task with User Defined Content with a pre-configured Generative AI endpoint <br>
   &emsp;  • Configure HCM Compensation Info Page to include the configured Guided Journey <br>
   &emsp;  • Preview your changes <br>

![Journey Process Flow](../04-extend-oicai-hcm/images/hcmllmobjs.jpg)

Estimated Time: 15 minutes

As you follow along, do not forget to think about the Adventure Check Point questions you'll answer at the end of this adventure!

### Begin Exercise

1. You'll start by going to the Guided Journey screen.

    > (1) Enter **Guided Journey** in the search field at the top of the home page.  <br>
    > (2) Select **Guided Journey** from the resulting dropdown search results.

    ![Guided Journey Navigate](../04-extend-oicai-hcm/images/hcmimage001.jpg)
<br>

2. The first step is to configure a Task for the Guided Journey. We’ve already setup Guided Journeys for each Cloud Adventure User, so you'll start by searching for your specific template.

    > (1) Enter **CA&#95;##** in the **search** field, **where ## is your assigned user number**. <br>
    ![View Caution](../04-extend-oicai-hcm/images/cautionaboutusernumbers.png)

    > (2) Click the **Magnifying Glass** ![Magnifying Glass Icon](../04-extend-oicai-hcm/images/icon10_searchdark.png) icon or press the **Enter** key to execute the search.

    ![Search Guided Journey](../04-extend-oicai-hcm/images/hcmimage002.jpg)
<br>

3.
   > Click your **Guided Journey name** (e.g. **CA&#95;##**) to open the journey.

   ![Open Guided Journey](../04-extend-oicai-hcm/images/hcmimage003.jpg)
<br>

4. You can see the general information for your Guided Journey, including Name, Code and Description.  We'll use the Code later in this adventure.  You’re now ready to add a Task.

    > **Click** on the **+ Add** button under the **Tasks** header.

    ![View Guided Journey](../04-extend-oicai-hcm/images/hcmimage004.jpg)
<br>

5. You can now define your new task and leverage the task type User Defined Content. This will allow you to reference the REST Integration that was discussed at the beginning of the adventure.  It will link to a pre-configured Generative AI LLM endpoint.

   > Complete the following fields as shown: <br>
   > &emsp;&#8226;&emsp;Name(1): Type **Get Additional Compensation Info**<br>
   > &emsp;&#8226;&emsp;Task Type(2): Select **User Defined Content** from the dropdown<br>
   > &emsp;&#8226;&emsp;Configuration(3): Select **HCM&#95;GJ&#95;GenAI&#95;OCILlama3&#95;Endpoint** from the dropdown <br>
   > &emsp;&#8226;&emsp;(4) Click the **Save** button.

   ![Enter Task Info](../04-extend-oicai-hcm/images/hcmimage005.jpg)
<br>

6. The next step is the configuration the Compensation Info UI to leverage your Guided Journey. To do that, you can head back to the home page.

   > Click on the **Home** ![Home Icon](../04-extend-oicai-hcm/images/icon13_home.png)  icon on the top icon bar.

   ![Go Home](../04-extend-oicai-hcm/images/hcmimage006.jpg)
<br>

7. You can configure the Compensation Info page directly from within the application.

   > (1) Enter **Compensation Info** into the **search** field at the top of the page. <br>
   > (2) Select **Compensation Info** from the resulting **dropdown** list.

   ![Open Compensation Info](../04-extend-oicai-hcm/images/hcmimage007.jpg)
<br>

8. There are no matching workers, so you can unselect Direct reports to broaden our search.

   > Click the ![X Icon](../04-extend-oicai-hcm/images/icon14_x2.png) next to Direct Reports under the search field.

   ![Remove Direct Reports Filter](../04-extend-oicai-hcm/images/hcmimage008.jpg)
<br>

9. You can search for a worker and make the configuration directly from their Compensation Info page.  Note that even though you’re searching for a specific user, this will be a system-wide configuration.

   > (1) Enter **Emily Heather** in the **Search** field. <br>
   > (2) Select **Emily Heather** from the resulting **dropdown** list.

   ![Search for a person](../04-extend-oicai-hcm/images/hcmimage009.jpg)
<br>

10. You will now use the embedded Visual Builder Studio tool to configure this page. The configuration will allow you to reference your previously defined Guided Journey and Task. Visual Builder is the tool that Oracle uses to develop Fusion Cloud Application screens.  Customers can use these same tools to perform configurations or, as we saw in other adventures, create new screens using the same look and feel as the delivered applications.


   > (1) Click the **User Photo/User ID icon** on the top right corner of the screen. <br>
   > (2) Select **Edit Page in Visual Builder Studio** from the resulting dropdown list.

   ![Open Visual Builder](../04-extend-oicai-hcm/images/hcmimage010.jpg)
<br>

11. You’re now in Visual Builder – Express Mode.  This allows you to easily configure application screens.  In this scenario, you’ll be referencing the Guided Journey/Task that you created earlier.

   > (1) Enter **Salary** in the **Page Properties Filter** field on the right.  This will narrow the list of Page Properties available. <br>
   > (2) Enter **CA&#95;##** in the **CompensationInfoSalaryGuidedJourneyCode** field and press the **Enter** key.  Be careful to enter this into the correct field as there are several similar fields available.  If you searched as described in Step 1, it’s likely the 1st field listed below the filter.

   ![Search properties](../04-extend-oicai-hcm/images/hcmimage011.jpg)
<br>

12. You will now see the Get Additional Compensation Info link available on the screen.  If you recall, this was the name of the Task we defined earlier and is your link to the User Defined Configuration call to the LLM.

   > (1) Confirm (don't click, just confirm) that the **Get Additional Compensation Info** link now appears on the bottom left of the screen.
   > (2) Click the **Preview** ![Preview](../04-extend-oicai-hcm/images/icon16_preview.png) icon in the top right of the screen.

   ![Preview](../04-extend-oicai-hcm/images/hcmimage012.jpg)
<br>

13. The Preview should open in a new browser tab.  You can now see our screen in Preview Mode.  It shows the standard screen layout, but also includes your Guided Journey configuration.  Please note that these configurations are automatically maintained during the Oracle Release Update process.  These are not Customizations.

   > (1) Click the **Get Additional Compensation Info** link.

   ![Get Additional Compensation Info](../04-extend-oicai-hcm/images/hcmimage013.jpg)
<br>

14. The Guided Journey Task has called your User Defined Content integration.  As discussed in the introduction to this adventure, it calls Oracle Integration to gather additional prompt information, such as Position and New York, prior to our Generative AI call to the external LLM.  The results are then formatted and displayed as shown.

   > (1) When finished reviewing the result, you can close your browser tabs and exit the Oracle Cloud Application UI.

   ![Finish](../04-extend-oicai-hcm/images/hcmimage014.jpg)
   <br>

15. Adventure awaits, click on the image and show what you know, and rise to the top of the leader board!!!

    [![Cloud Adventure](../gen-images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:LOGIN_TEAM:::::CC:CIOADVENTURE)


## Summary

This Extension adventure introduced you to a few of the capabilities that customers can leverage to extend Oracle Fusion Cloud applications.  These features allow you to fine tune your Oracle Fusion Cloud Applications for peak performance, business processes tailored to you requirements, and fast, efficient usage.

 You learned how to setup and defined a Guided Journey, which provides your users with the real-time, inline guidance and information required to complete their tasks.

You also learned how to leverage 3rd party Generative AI capabilities by leveraging external LLMs directly from the Guided Journey feature of Oracle Fusion Cloud Applications.

So, check your with you team, double-check your racing harness and get ready for our next Adventure.

## Learn More

- [Extending Oracle Cloud Applications with Visual Builder Studio](https://docs.oracle.com/en/cloud/paas/visual-builder/visualbuilder-building-appui)
- [Overview of Guided Journeys](https://docs.oracle.com/en/cloud/saas/human-resources/faijh/overview-of-guided-journeys.html)
- [Configure User Defined Content Task Type for a Journey](https://docs.oracle.com/en/cloud/saas/human-resources/faijh/configure-user-defined-content-task-type-for-a-journey.html)
- [Oracle Documentation](http://docs.oracle.com)

## Acknowledgements

- **Author** - Charlie Moff, Distinguished Cloud Technologist; Stephen Chung, Principal SaaS Cloud Technologist; Sajid Saleem, Master Principal SaaS Cloud Technologist
- **Contributors** - The AI Adventure Team (Gus, Kris, Sajid, Casey, Stephen, Jamil, Sohel, Xavier, Nate, Charlie)
- **Last Updated By/Date** - Sajid Saleem, November 2025