# Embed AI Agents Teams in UI for End Users

## **Create a Guided Journey and embed your Agent**

### **Introduction**

AI Agent Studio for Fusion Applications is a comprehensive platform for creating, extending, deploying and managing AI Agents and Agent Teams across the enterprise. Oracle AI Agent Studio delivers easy-to-use tools, including advanced testing, robust validation, and built-in security, that helps Oracle Fusion Applications customers and partners create and manage AI agents. Leveraging the same technology that Oracle uses to create AI agents, Oracle AI Agent Studio enables users to easily extend pre-packaged agents and/or create new agents and then deploy and manage them.


### **Objectives**

In this activity you will embed your AI Agent Team in the application for use by end users.
* Create a Guided Journey and Task that references the AI Agent Team.
* Use Visual Builder Studio to Configure the My Maintenance Work page with the Guided Journey.
* Interact with your AI Agent


### **Begin Exercise**


1.  In this activity, you will embed your AI Agent Team in the application for use by end users.

    ![AI Embed Objectives](../06b-embed-agent-scm/images/scmimage001.jpg)

2. The first step will involve creating a Guided Journey.  A Guided Journey allows you to embed specific information in standard applications.  In addition to using a Guided Journey to embed an AI Agent (today's example), Guided Journeys can also embed documents, analytics, URLs, Learning, Videos and more.  And like all configurations, Guided Journey configurations are automatically maintained during the release update process.

    > (1) Enter **Guided Journey** in the search field<br>
    > (2) Select the **Guided Journey** from the resulting dropdown.

    ![Navigate to Guided Journeys](../06b-embed-agent-scm/images/scmimage002.jpg)

3. You'll create your Guided Journey here.  It's quite simple.

    > (1) Click the ![Plus create button](../06b-embed-agent-scm/images/plus-create.jpg) button.

    ![Open tools](../06b-embed-agent-scm/images/scmimage003.jpg)


4. Name your Guided Journey.

    > (1) Enter Name:  **CIOXX Guided Journey** where **XX** is replaced with your user number.<br>
    > (2) Click the ![create draft](../06b-embed-agent-scm/images/create-draft.jpg) button.

    ![Create Guided Journey Header](../06b-embed-agent-scm/images/scmimage004.jpg)

5. Next, you'll add a Task to this Guided Journey.  This is where we specify a Task Type of Agent and reference the Maintenance Agent Team you've assembled.

     > (1) Click the ![plus Add](../06b-embed-agent-scm/images/plusadd.jpg) button under the **Tasks** section.  This will pop out the New Task panel from the right. <br><br>

     > (2) Enter the fields as described below:
     * Task Name: **Maintenance Guided Journey** <br>
     * Task Description: **Maintenance Guided Journey Task** <br>
     * Add Instructions: **Enables Maintenance Agent Team in Application UI**<br>
     * Task Type:  **Agent** from the dropdown <br>
     * Agent Type: **Workflow Agent** from the dropdown<br>
     * Workflow Agent: **CIOXX Asset Maintenance Agent Team** where **XX** is your user number from the drop-down.<br>

    > (3) Click the **Save** button ![Create Button](../06b-embed-agent-scm/images/savedark.jpg) on the bottom right.
     ![enter guided journey task information](../06b-embed-agent-scm/images/scmimage005.jpg)


6. You’re almost done with the Guided Journey creation.  The last step is to Activate it to make it available for use.

     > (1) Click the Activate button ![Activate button](../06b-embed-agent-scm/images/activate.jpg) on the top right<br>

     > (2) Click the Home icon ![Home Button](../06b-embed-agent-scm/images/home.jpg) in the top toolbar to return to the application home page and get ready for the next step.

     ![activate the journey and go home](../06b-embed-agent-scm/images/scmimage006.jpg)

7. Now, you'll go to the screen where you will embed the AI Agent Team.

    > (1) Enter **My Maintenance Work** in the search field and select **My Maintenance Work** from the resulting dropdown.

    ![search for my maintenance work](../06b-embed-agent-scm/images/scmimage007.jpg)

8. You'll use Visual Builder to Edit the Page and enable the Guided Journey.

    >  (1)  Confirm that **M001 - Seattle Maintenance** is the organization selected in the My Maintenance Work dropdown at the top of the screen.  If not, select **M001 - Seattle Maintenance** from the dropdown.
    >  (2)  Click the **logged in user icon** icon next to the bell icon in the top right corner and then select **Edit Page in Visual Builder Studio** from the resulting dropdown.<br>

    ![launch visual builder studio](../06b-embed-agent-scm/images/scmimage008.jpg)

9. You may see multiple projects available.  This allows you to use Visual Builder for various projects, each with their own team and development lifecycle.

    > 1. If multiple projects are displayed, highlight the **Application Extensions** project and then click the Select button ![Select Button](../06b-embed-agent-scm/images/select.jpg) on the bottom right of the screen.

    ![select project](../06b-embed-agent-scm/images/scmimage009.jpg) <br>

10. You can now configure various aspects of the My Maintenance Work screen.  The Journey is simple as it's the first page property on the list. 

    >  (1) Enter **CIOXX\_GUIDED\_JOURNEY** in the **journeycode** field on the right **Page Properties** panel.<br>

    >  (2) Click the **Preview** icon ![Preview Button](../06b-embed-agent-scm/images/preview.png) on the toolbar on the top right of the page.  This will launch and new tab showing your newly configured screen in a full-functioning preview mode.<br>

    ![Configure Journey Property and Preview](../06b-embed-agent-scm/images/scmimage010.jpg)

11. You can see that the Guided Journey is displayed as an *Ask Oracle** banner.

    > 1. Click the **Ask Oracle** button ![Ask Oracle Button](../06b-embed-agent-scm/images/ask-oracle.jpg).

    ![Launch Ask Oracle](../06b-embed-agent-scm/images/scmimage011.jpg) <br>

12. The Agent appears in a panel pop-out from the right.  You can interact with your agent via the Ask Oracle field at the button of the pop-out panel.  Based on your defined agent, you can ask about Assets, Maintenance, Warranties and even have the Agent create a Maintenance Work Order for your asset.

    > 1. Interact with your agent via the **Ask Oracle** field at the bottom.  Type **What is the manufacturers maintenance schedule for asset CIOXX-RIDGELINE** where XX is the number in your user login and press enter or click the up arrow ![up arrow](../06b-embed-agent-scm/images/uparrow.jpg). 

    ![start debug](../06b-embed-agent-scm/images/scmimage012.jpg) <br>

13. You can check for recalls or any existing maintenance work orders.

    > 1. Type **Are there any outstanding recalls** and press enter or click the up arrow ![checkered flag](../06b-embed-agent-scm/images/uparrow.jpg). 

    ![start debug](../06b-embed-agent-scm/images/scmimage013.jpg) <br>

14. If there are any recalls, you can create a Maintenance Work order to take care of it.  Fortunately, the AI Agent is going to help you!

    > 1. Type **Yes, please create a maintenance work order for this recall** and press enter or click the up arrow ![checkered flag](../06b-embed-agent-scm/images/uparrow.jpg). 

    ![start debug](../06b-embed-agent-scm/images/scmimage014.jpg) <br>

15. The agent has created your Work Order, so you can query that to verify.

    > 1. Click the **x** in the upper right.

    ![start debug](../06b-embed-agent-scm/images/scmimage015.jpg) <br>

16. Congratulations. ![checkered flag](../06b-embed-agent-scm/images/checkeredflag.jpg)  You've finished the creation and deployment of the AI Agent Team, making it easy for your users to leverage the power of Oracle AI.


17. Adventure awaits, click on the image, show what you know and rise to the top of the leader board!!!

    [![Cloud Adventure](../06b-embed-agent-scm/images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:LOGIN_TEAM:::::CC:CIOADVENTURE)


## Summary

As you have seen here, AI Agent Studio puts customers in the driver’s seat, helping empower you to design the future of AI in your organizations on top of a bedrock of trust and safety. AI Agent Studio includes a built-in testing environment, validation, and traceability tools to confirm accuracy. Oracle maintains the same data controls at a user level, which means no individual sees data or AI recommendations that they’re not permissioned to see.

AI Agent Studio empowers enterprises to configure and build AI agents that extend their workforce and help achieve new levels of productivity. It allows you to harness the full potential of AI agents and transform the way work gets done in your organization.
AI Agent Studio is a design-time environment that provides a set of tools to create, customize, validate, and deploy GenAI features and AI agents to meet the specific needs of the organization. It is the same unified environment Oracle uses to internally build agents, made available now to customers and partners to customize and extend agents from Oracle-provided preconfigured templates or to create new agents and multi-agent workflows.

Like our AI capabilities, Oracle AI Agent Studio was built natively into Fusion Cloud Applications on our trusted, high performance Oracle Cloud Infrastructure (OCI), which means it can easily and securely access Fusion knowledge stores, tools, and APIs and allows agents to be deployed directly into the flow of work. This approach means maximum flexibility and customization without sacrificing reliability or performance.

**You have successfully completed the Activity!


### Learn More

* [AI Agent Studio Solution Brief](https://www.oracle.com/a/ocom/docs/applications/fusion-apps-ai-agent-studio-solution-brochure.pdf)
* [AI Agents for Fusion Applications](https://www.oracle.com/applications/fusion-ai/ai-agents/)
* [AI for Fusion Applications](https://www.oracle.com/applications/fusion-ai/)
* [Oracle Documentation](http://docs.oracle.com)

### Acknowledgements

* **Author** - Stephen Chung, Principal SaaS Cloud Technologist, Sajid Saleem, Master Principal SaaS Cloud Technologist, Charlie Moff, Distinguished SaaS Cloud Technologist, and the rest of the Cloud Adventure Team
* **Contributors** - The Cloud Adventure Team (Gus, Kris, Sajid, Casey, Stephen, Jamil, Sohel, Xavier, Nate, Charlie)
* **Last Updated By/Date** - Charlie Moff, August 2025
