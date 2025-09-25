# Create AI Agents and Agent Teams for your enterprise


## Introduction

AI Agent Studio for Fusion Applications is a comprehensive platform for creating, extending, deploying and managing AI Agents and Agent Teams across the enterprise. Oracle AI Agent Studio delivers easy-to-use tools, including advanced testing, robust validation, and built-in security, that helps Oracle Fusion Applications customers and partners create and manage AI agents. Leveraging the same technology that Oracle uses to create AI agents, Oracle AI Agent Studio enables users to easily extend pre-packaged agents and/or create new agents and then deploy and manage them.


### **Objectives**

In this activity you will use Oracle Fusion AI Agent Studio to
* Create a Benefits Advisor Agent that leverages an existing Document Tool and its related Benefit Policy documents.
* Create and assemble an Agent Team that includes the created Benefits Advisor Agent and an Absence Agent.
* Test the Agent team 



## Create Policy Advisor Agent (RAG) and an Agent Team using AI Agent Studio

1. In this activity you will learn the power and ease building Agentic AI with the Oracle AI Agent Studio

    ![AI RAG Objectives](images/extendwithairag.jpg)

2. The first step is to navigate to AI Agent Studio.

    > (1) Click on the **Tools** tab
    > (2) Select the **AI Agent Studio** tile

    ![Navigate to AI Agent Studio](images/hcmimage002.jpg)

3. Next, you’ll create our first Agent.

    > Click the ![Agents](images/agenticon.jpg) button/tab at the bottom of the page

    ![Open tools](images/hcmimage003.jpg)


4. We can see a list of available Agents, but you're going to create a new one.

    > Click the ![add tool](images/plusadd.jpg) button to create a new Agent

    ![Create Tool](images/hcmimage004.jpg)

5. Here, you can enter the details of your Agents.

    > (1) Enter the following fields:
    * Agent Name: **CIOXX Benefits Advisor Agent**, where **XX** is replaced with your user number.<br>
    * Family: select **HCM** from the dropdown<br>
    * Product: select **Absences** from the dropdown<br>
    * Description: Enter **Cloud Adventure Benefits Advisor Agent** <br>
    * Prompt: Enter the following text in the prompt field

<pre><p style="font-size:8px">
 <copy>AGENT ROLE

    As a Benefits Analyst, your role is to efficiently access and interpret company-specific benefits documents, providing workers with clear, actionable guidance on their eligibility, coverage, and compliance requirements.

    RESPONSIBILITIES

    Your responsibilities include:

    Benefit Policies:

    - Clearly explain the eligibility, coverage, and compliance requirements outlined in the company benefits policies.

    - Use the CA_Benefits_Document_Tool tool to retrieve policy details when answering questions.
    IMPORTANT GUIDELINES

  - Provide concise, factual answers based strictly on the data retrieved.
  - Never fabricate or assume information.
  - Format your responses clearly and professionally for easy readability. </copy></pre></p>

``` bash
<p style="font-size:8px">
 <copy>AGENT ROLE

    As a Benefits Analyst, your role is to efficiently access and interpret company-specific benefits documents, providing workers with clear, actionable guidance on their eligibility, coverage, and compliance requirements.

    RESPONSIBILITIES

    Your responsibilities include:

    Benefit Policies:

    - Clearly explain the eligibility, coverage, and compliance requirements outlined in the company benefits policies.

    - Use the CA_Benefits_Document_Tool tool to retrieve policy details when answering questions.
    IMPORTANT GUIDELINES

  - Provide concise, factual answers based strictly on the data retrieved.
  - Never fabricate or assume information.
  - Format your responses clearly and professionally for easy readability. </copy> 
```
   > (2) Click the ![Add button](images/addw.jpg) button under **Documents**
   ![Edit Suppliers View](images/poaimage005.jpg)


6. That's all we need for creating the Agent.

    > Click the **Create button** ![Create Button](images/createw.jpg)  on the near the bottom of the screen.

    ![Add Documents](images/hcmimage006.jpg)

7. Now that you have the Agent, you need to add Tools to it.

    > Click the **Tools** ![Tool Icon](images/toolhammericon.jpg) button on the left icon bar.

    ![Suppliers View](images/hcmimage007.jpg)

8. You can scroll through the list of available tools, or use the Ask Oracle field to filter the results.  You'll do the latter.

  > Enter **Benefits** in the Ask Oracle field and press the **<enter>** key or select **Benefits** from the resulting dropdown.

    ![Add Tool](images/hcmimage008.jpg)
  

9. Now you can easily add from the list of available Tools.

    > Click the ![Agent Image](images/plusicon.jpg) icon next to the CA Benefits Document Tool.

    ![Agents Page](images/hcmimage009.jpg)


10. You can confirm the details of tool and continue

    > Click the **+ Add** button ![Add button Image](images/addb.jpg).

    ![Add Agent](images/hcmimage010.jpg)

11. You can confirm the details of tool and continue

    > Click the ![Create button Image](images/createw.jpg) button on the top right.

    ![Add Agent](images/hcmimage011.jpg)

12. You’ve just created your first Agent.  Next, you’ll create an Agent Team with a Supervisory Agent and assign some worker agents.

    > Click the **Agent Teams** button/tab ![Agent Teams](images/agentteams.jpg) on the button of the page.

    ![Add Tools Create](images/hcmimage012.jpg) <br>

13. Create an Agent Team.

    > Click the **+ Add** button ![Add Button](images/addw.jpg).
    > ![Add Tools Create](images/hcmimage013.jpg)

14. Define the Agent Team.

     > (1) Enter the fields as described below:
     * Agent Team Name: **CIOXX Benefits Agent Team** where XX is replaced with your user number. <br>
     * Family: Select **HCM** from the dropdown <br>
     * Product: Select  **Benefits** from the dropdown <br>
     * Maximum Interactions: **10** <br>
     * Description: **Cloud Adventure Benefits Agent Team leveragds the Benefits Advisor Agent to respond to questions related to benefits and the FMLA Absence Agent to view existing absences and submit a new FMLA absence request** <br>

     > (2) Click the Questions tab <br>

       ![Create Agent](images/hcmimage014.jpg)

15. You can provide one or more starter questions to assist users in interacting with the Agent Team.  You'll enter two.

     > (1) Enter the following questions
     * In the Question 1 field, enter: **Please summarize benefits available to me** <br>
     * In the Question 2 field, enter: **I have a question about a specific benefit** <br>
     > (2) Click the **Create** button ![Create Button](images/createb.jpg) on the bottom right.

       ![Create Agent](images/hcmimage015.jpg)

16. You’ve defined your Agent Team, so it’s time to add a Supervisor agent.

     > (1) Click the ![Agent Icon](images/agenticon.jpg)

       ![Create Agent](images/hcmimage016.jpg)

17. You’ve add a Supervisor agent.

     > (1) Click the **+** icon ![Create Button](images/plusicon.jpg) next to **New Supervisor Agent**.

   ![Create Agent](images/hcmimage017.jpg)

18. Define Supervisor Agent Details.

     > (1) Enter the fields as described below:
    * Agent Team Name: **CIOXX Benefits Supervisor Agent** where XX is replaced with your user number.<br>
    * Family: Select **HCM** from the dropdown<br>
    * Product: Select  **Benefits** from the dropdown<br>
    * Maximum Interactions: **10** <br>
    * Description: **This agent supervises the Benefits Advisor and FMLA Absence agents** <br>

     > (2) Click the **Create** button ![Create Button](images/createb.jpg) on the bottom right.

       ![Create Agent](images/hcmimage018.jpg)

19. Next you'll add some worker agents.  You can scroll through the list of available tools, or use the Ask Oracle field to filter the results.  You'll do the latter.

    > Enter **Benefits** in the Ask Oracle field and press the **<enter>** key or select **Benefits** from the resulting dropdown.

    ![Add Tool](images/hcmimage019.jpg)

20. Now we can select our agent.

     > (1) Click the **+** icon ![Create Button](images/plusicon.jpg) next to **CIOXX Benefits Advisor Agent**, where XX is replaced with your user number.

   ![Create Agent](images/hcmimage020.jpg)


21. You can review the details of the agent before saving.

    > Click the Add button ![Add Button](images/addb.jpg).

    ![Add Tools Complete](images/hcmimage021.jpg) <br>

22. You'll add one more worker agent.  First, you'll filter on something different.

   > Click in the Filter field and click the **X** next to **Benefits** to remove our previous filter.
    ![Add Tool](images/hcmimage022.jpg)

23. Now we'll look for the FMLA Agent that will, when appropiate, create you leave request.

    > Enter **FMLA** in the Ask Oracle field and press the **<enter>** key or select **Benefits** from the resulting dropdown.

    ![Add Tool](images/hcmimage023.jpg)

24. Let's add it.

     > Click the **+** icon ![Plus Icon](images/plusicon.jpg) next to predefined **CA FMLA Absence Agent**.  Note that this is a shared Agent and not one that you created specifically with your user number.

     ![Create Agent](images/hcmimage024.jpg)

25. You can review the details of the agent.

    > Click the **Add** button ![Add Button](images/addb.jpg).

    ![Add Tools Complete](images/hcmimage025.jpg) <br>

26. Your Agent Team, with a Supervisory Agent and two Worker Agents is complete.  We can now hide the left Agents panel to see our full Agent Team..

    > Click the **Agents** icon ![debug icon](images/agenticon.jpg) on the top left of the screen.  You can see that the left panel is now hidden and you can see the entire Agent Team

    ![start debug](images/hcmimage026.jpg) <br>


27. Feel free to admire your newly created Agent Team. Time to test it and see how it responds to your requests.

    > Click the **Debug** icon ![debug icon](images/debugarrow.jpg) on the top left of the screen.  It's the one that looks like the Play arrow.

    ![start debug](images/hcmimage027.jpg) <br>

28. You can now begin a dialog with the Agent.  The Agent proposes a couple of starter questions.  You can choose one of these or type in a question or your own.

    > 1. Click the **Please summarize benefits available to me** question under the "How can I help you?" dialog. 

    ![agent dialogue 1](images/hcmimage028.jpg) <br>

29. The Agent will response with information.  In this Debug mode, the Agent will also show you source and processing information (yellow boxes).  These will not be available to end-users once deployed.

    > The Agent responds with information, so we’ll ask an additional question.

    > 1. In the **Ask Oracle** dialog box on the bottom right of the screen, enter **What about FMLA benefits** and hit the return key or click the **Up Arrow** icon ![up arrow icon](images/uparrow.jpg)

    ![agent dialogue 2](images/hcmimage029.jpg) <br>

30. The Agent says checks with HCM Cloud and confirms existing leave requests, if any.  It also offers to create a new request for you if you provide the requested start and end dates.

    You decide to tell the Agent that you’re interested in creating an FMLA absence, but you do with without provided the requested dates.

    > 1. In the **Ask Oracle** dialog box on the bottom right of the screen, enter **I would like to create FMLA absence** and hit the return key or click the **Up Arrow** icon ![up arrow icon](images/uparrow.jpg)

    ![agent dialogue 3](images/hcmimage030.jpg) <br>

31. The Agent reminds you that you need to provide start and end dates before the Agent can create the absence request.

    > In the **Ask Oracle** dialog box on the bottom right of the screen, enter **Start Date is 2025-08-28 End Date is 2025-08-29** and hit the return key or click the **Up Arrow** icon ![uparrow icon](images/uparrow.jpg)

    ![agent dialogue 3](images/hcmimage031.jpg) <br>

32. The agent confirms that your request has been created.

    > 1. Review Agent Response
    > 2. Click the x icon in the upper right to close the debug screenIn the **Ask Oracle** dialog box on the bottom right of the screen, enter **Proceed with ordering a laptop** and hit the return key or click the **Up Arrow** icon ![up arrow icon](images/uparrow.jpg)

    ![agent dialogue 3](images/hcmimage032.jpg) <br>

33. Let’s go back to the homepage so we can confirm the creation of our absence.

    > Click the Home  **Ask Oracle** icon ![up arrow icon](images/icon012_home.png) on the top right.

    ![agent dialogue 3](images/hcmimage033.jpg) <br>

34. The agent has created your requisition.

    > In the Search field, type existing absence and select Existing Absences - Me from the resulting dropdown.

    ![agent dialogue 3](images/hcmimage034.jpg) <br>

35. There it is!

    > ![agent dialogue 3](images/hcmimage035.jpg) <br>

36. Adventure awaits, click on the image, show what you know and rise to the top of the leader board!!!

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
