# Create AI Agents and Agent Teams for your enterprise


## Introduction

AI Agent Studio for Fusion Applications is a comprehensive platform for creating, extending, deploying and managing AI Agents and Agent Teams across the enterprise. Oracle AI Agent Studio delivers easy-to-use tools, including advanced testing, robust validation, and built-in security, that helps Oracle Fusion Applications customers and partners create and manage AI agents. Leveraging the same technology that Oracle uses to create AI agents, Oracle AI Agent Studio enables users to easily extend pre-packaged agents and/or create new agents and then deploy and manage them.


### **Objectives**

In this activity you will use enable your Agent Team in the application for use by end users.
* Create a Guided Journey and Task, which will reference for Agent Team.
* Configure the My Maintenance Work pave using Visual Builder Studio to reference your Guided Journey.
* Use your Agent



## Create a Guided Journey and embed your Agent

1. In this activity you will now embed your Agent with the application for use by end users.

    ![AI Embed Objectives](images/scmimage001.jpg)

2. The first step will involve created a Guided Journey.  A Guided Journey allows you to embed specific information in standard applications.  In addition to using a Guided Journey to embed a AI Agent (today's example), Guided Journeys can also embed documents, analytics, URLs, Learning, Videos and more.  And like all configurations, Guided Journey configurations are automatically maintained during the release update process.

    > (1) Enter **Guided Journey** in the search field<br>
    > (2) Select the **Guided Journey** from the resulting dropdown.

    ![Navigate to Guided Journeys](images/scmimage002.jpg)

3. You'll create your Guided Journey here.  It's quite simple.

    > 1. Click the ![Plus create button](images/plus-create.jpg) button.

    ![Open tools](images/scmimage003.jpg)


4. A Here, you just need to name it.

    > 1. Enter ![end journey name] **CIOXX Guided Journey** there **XX** is replaced with your user number.
    > 2.  Click the ![create draft](images/create-draft.jpg) button.

    ![Create Guided Journey Header](images/scmimage004.jpg)

5. Next, you'll add a Task to this Guided Journey.  This is where we specify a Task Type of Agent and reference the Maintenance Agent Team you've assembled.

     > (1) Click the ![plus Add](images/plusadd.jpg) button under the **Tasks** section.  This will pop out the New Task panel from the right. <br><br>

     > (2) Enter the fields as described below:
     * Task Name: **Maintenance Guided Journey** <br>
     * Task Description: **Maintenance Guided Journey Task** <br>
     * Add Instructions: **Enables Maintenance Agent Team in Application UI**<br>
     * Task Type:  **Agent** from the dropdown <br>
     * Agent Type: **Workflow Agent** <br>
     * Workflow Agent: **CIOXX Asset Maintenance Agent Team** where **XX** is your user number.<br>

    > (3) Click the **Save** button ![Create Button](images/savedark.jpg) on the bottom right.
     ![enter guided journey task information](images/scmimage005.jpg)


6. You’re almost done with the Guided Journey creation.  The last step is to Activate it to make it available for use.

     > (1) Click the Activate button ![Activate button](images/activate.jpg) on the top right<br>

     > (2) Click the Home icon ![Home Button](images/home.jpg) in the top toolbar to return to the application home page and get ready for the next step.

     ![activate the journey and go home](images/scmimage006.jpg)

7. Now, you'll go to the screen where you want to embed the Agent.

    > (1) Enter **My Maintenance Work** in the search field and select **My Maintenance Work** from the resulting dropdown.

    ![search for my maintenance work](images/scmimage007.jpg)

8. You'll use Visual Builder to Edit the Page and enable the Guided Journey.

    >  (1)  Click on the  **user picture** in the top right corner and then select **Edit Page in Visual Builder Studio** from the  resulting dropdown.<br>

    ![launch visual builder studio](images/scmimage008.jpg)

9. You may see multiple projects available.  This allows you to use Visual Builder for various projects, each with their own team and development lifecycle.

    > 1. If multiple projects are displayed, highlight the **Application Extensions** project and then click the Select button ![Select Button](images/select.jpg) on the bottom right of the screen.

    ![select project](images/scmimage009.jpg) <br>

10. You can now configure various aspects of the My Maintenance Work screen.  The Journey is simple as it's the first page property on the list. 

    >  (1) Enter **CIOXX\_GUIDED\_JOURNEY** in the **journeycode** field on the right **Page Properties** panel.<br>

    >  (2) Click the **preview** icon ![Preview Button](images/preview.png) on the toolbar on the top right of teh page.  This will launch and new tab showing your newly configured screen in a full-functioning preview mode.<br>

    ![Configure Journey Property and Preview](images/scmimage010.jpg)

11. You can see that the Guided Journey is displayed as an *Ask Oracle** banner.

    > 1. Click the **Ask Oracle** button ![Ask Oracle Button](images/ask-oracle.jpg).

    ![Launch Ask Oracle](images/scmimage011.jpg) <br>

12. The Agent appears in a panel pop-out from the right.  You can interact with your agent via the Ask Oracle field at the button of the pop-out panel.  Based on your defined agent, you can ask about Assets, Maintenance, Warranties and even have the Agent create a Maintenance Work Order for your asset.

    > 1. Interact with your agent via the **Ask Oracle**. 

    ![start debug](images/scmimage012.jpg) <br>

13. Congratulations.  You've finished the creation and deployment of the Agent Team, making it easy for your users to leverage the power of Oracle AI capabilities.  ![checkered flag](images/checkeredflag.jpg)

    

14. Adventure awaits, click on the image, show what you know and rise to the top of the leader board!!!

    [![Cloud Adventure](images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:LOGIN_TEAM:::::CC:CIOADVENTURE)


## Summary

As you have seen here, AI Agent Studio puts customers in the driver’s seat, helping empower you to design the future of AI in your organizations on top of a bedrock of trust and safety. AI Agent Studio includes a built-in testing environment, validation, and traceability tools to confirm accuracy. Oracle maintains the same data controls at a user level, which means no individual sees data or AI recommendations that they’re not permissioned to see.

AI Agent Studio empowers enterprises to configure and build AI agents that extend their workforce and help achieve new levels of productivity. It allows you to harness the full potential of AI agents and transform the way work gets done in your organization.
AI Agent Studio is a design-time environment that provides a set of tools to create, customize, validate, and deploy GenAI features and AI agents to meet the specific needs of the organization. It is the same unified environment Oracle uses to internally build agents, made available now to customers and partners to customize and extend agents from Oracle-provided preconfigured templates or to create new agents and multi-agent workflows.

Like our AI capabilities, Oracle AI Agent Studio was built natively into Fusion Cloud Applications on our trusted, high performance Oracle Cloud Infrastructure (OCI), which means it can easily and securely access Fusion knowledge stores, tools, and APIs and allows agents to be deployed directly into the flow of work. This approach means maximum flexibility and customization without sacrificing reliability or performance.

**You have successfully completed the Activity!


## Learn More

* [AI Agent Studio Solution Brief](https://www.oracle.com/a/ocom/docs/applications/fusion-apps-ai-agent-studio-solution-brochure.pdf)
* [AI Agents for Fusion Applications](https://www.oracle.com/applications/fusion-ai/ai-agents/)
* [AI for Fusion Applications](https://www.oracle.com/applications/fusion-ai/)
* [Oracle Documentation](http://docs.oracle.com)

## Acknowledgements

* **Author** - Stephen Chung, Principal SaaS Cloud Technologist, Sajid Saleem, Master Principal SaaS Cloud Technologist, Charlie Moff, Distinguished SaaS Cloud Technologist, and the rest of the Cloud Adventure Team
* **Contributors** - The Cloud Adventure Team (Gus, Kris, Sajid, Casey, Stephen, Jamil, Sohel, Xavier, Nate, Charlie)
* **Last Updated By/Date** - Charlie Moff, August 2025
