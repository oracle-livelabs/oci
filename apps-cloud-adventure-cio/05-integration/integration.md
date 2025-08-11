# Audit

## Introduction

AI Agent Studio is a design-time environment that empowers you to create, configure, validate, and deploy GenAI features and AI agents to meet your organization's needs. With AI Agent Studio, you can easily extend pre-configured agent templates, and even build new agents and multi-agent workflows from scratch. AI Agent Studio is fully integrated into Fusion Applications, providing secure and seamless access to the knowledge stores, tools, and APIs of Fusion Applications. This integration enables agents to be deployed directly into the workflow, ensuring an efficient process.

### **Objectives**

In this activity you will use Oracle Fusion AI Agent Studio to
•	Create a Document Tool to ingest company-specific procurement policy documents (PDF) 
•	Create an Agent that uses the Document Tool to respond to user queries
•	Create and assemble an Agent team that includes the created Agent and purchase requisition action agent.
•	Test the Agent team 


## Create Policy Advisor Agent (RAG) and an Agent Team using AI Agent Studio

1. In this activity you will learn the power and ease building Agentic AI with the Oracle AI Agent Studio 

    ![AI RAG Obectives](images/extendwithairag.jpg)

2. The first step is to navigate to AI Agent Studio. 

    > (1) Click on the **Tools** tab
    > (2) Select the **AI Agent Studio** tile

    ![Navigate to AI Agent Studio](images/poaimage002.jpg)

3. Next, we're going to create a Tool

    > Click the ![Tools](images/tools.jpg) button/tab at the bottom of the page

    ![Open tools](images/poaimage003.jpg)


4. Tool Creation

    > Click the ![add tool](images/plusadd.jpg) button to create a new tool

    ![Create Tool](images/poaimage004.jpg)

5. Here, you will define your first Tool, a Document Tool.  This will allow the Agent to use the content of the documents to respond to user questions.

    > (1) Enter the following fields:
        - Tool Type: select **Document** from the dropdown<br>
        - Tool Name: Enter **CIO## Procurement Policy Document Tool**, where **##** is replaced with your user number.<br>
        - Family: select **PRC** from the dropdown<br>
        - Product: select **Self Service Procurement** from the dropdown<br>
        - Description: Enter **Cloud Adventure Procurement Policy Document Tool** <br>
    > (2) Click the ![Add button](images/addw.jpg) button under **Documents**
    
    ![Edit Suppliers View](images/poaimage005.jpg)


6. **Note:** Now we’ll add the documents to our tool.  The documents you will add are located in the **Procurement Documents** folder on your laptop's Desktop.

    > (1) Enter the following fields:
        - Name: Enter **Procurement Policy Documents** <br>
        - Status: Select **Ready to publish** from the dropown<br>
        - Description: Enter **Procurement Policy Documents**<br>
    > (2) Click on the ![Drag and Drop](images/dandd.jpg) region <br>
    Select all files from the **Procurement Documents** folder on the Desktop. Alternatively, drag and drop the files that folder to the Drag and Drop region.

    ![Add Documents](images/poaimage006.jpg)

7. After all 4 files/documents have been loaded, you can proceed with the Save.

    > Click the **Save** ![Home Icon](images/save.jpg) button on the botton right

    ![Suppliers View](images/poaimage007.jpg)

8. You're now ready to save your knew Document Tool.

    > Click the **Create button** ![Craete Button](images/createw.jpg)  on the near to the of the screen.

    ![Craete Tool](images/poaimage008.jpg)

    **Congratulations!  You’ve completed your first step and created a Policy Document Tool.**

    
9. Now, you'll create your first Agent!  You'll do that from the Agent screen within the AI Agent Studio.

    > Click the  **Agents** button/tab [Agent Image](images/agenticon.jpg) at the bottom of the page.

    ![Agents Page](images/poaimage009.jpg)


10. Here, you can see any existing agents.  But you want to create a new one.

    > Click the  **+ Add** button [Add Button Image](images/addw.jpg).

    ![Add Agent](images/poaimage010.jpg)

11. Define the Details of the Agent.

    > (1) First, you'll enter the fields as described below:
        - Agent Name: **CIO## Procurement Policy Advisor Agent** where ## is replaced with your user nnumber.<br>
        - Family: Select **PRC** from the dropown<br>
        - Product: Select  **Self Service Procurement** from the dropdown<br>
        - Maximum Interactions: **10** <br>
        - Description: **Cloud Adventure Procurement Policy Advisor Agent** <br>

    ![Alert Flat](images/cautionflagsmalltransparent2.png)  Please note that the Prompt is a critical part of the Agent Definition as it provides guidance for the Agent.  To streamline this step, we've pre-created the prompt.  It's available as described below.

        - Prompt: The value for the prompt field is available in the **Prompt – CA Procurement Policy Advisor.txt** file that is available in the **Procurement Prompt** folder on your desktop.  Please open this file and copy the contents into the Prompt field.  
    > (2) Click the Create Button ![Create Button](images/createb.jpg) <br>

    ![Create Agent](images/poaimage011.jpg)

12. You’ve now created your first Agent.  Now you’ll add Tools to the Agent.  You'll add a mix of standard tools, tools created earlier in the Cloud Adventure, and tools that you've just created.

    > Click the Tools icon ![Create Button](images/toolhammericon.jpg) on the left.
    
    ![Add Tools](images/poaimage012.jpg) <br>

13. Find the appropriate tool and add it to your agent.

    > (1) Enter **Procurement** in the Ask Oracle field and select **Procurement** from teh resulting dropdown.  This filters the list of tools for easier selection.
    > (2) Click the ![Plus Icon](images/plusicon.jpg) next to the tool name **CA Procurement Policy Document Tool**<br>

    ![Add tool](images/poaimage013.jpg)

14. You can review the details of the Tool, including the option to require human approval.

    > Click the Add button ![Add Button](images/addb.jpg).
    
    ![Add Tools Complete](images/poaimage014.jpg) <br>

15. That's it! Let's save this and continue.

    > Click the **Create** button ![Create Button](images/createw.jpg) on the top right.
    
    ![Add Tools Create](images/poaimage015.jpg) <br>

16. You’ve just created your first Agent, complete with added Tool(s).  Next, you’ll create an Agent Team with a Supervisory Agent and assign some worker agents.

    > Click the **Agent Teams** button/tab ![Agent Teams](images/agentteams.jpg) on the button of the page.
    
    ![Add Tools Create](images/poaimage016.jpg) <br>

17. Create an Agent Team.

    > Click the **+ Add** button ![Add Button](images/addw.jpg).
    
    ![Add Tools Create](images/poaimage017.jpg) <br>

18. Define the Agent Team.

     > (1) Enter the fields as described below:

        - Agent Team Name: **CIO## Procurement Requisition Agent Team** where ## is replaced with your user nnumber. <br>
        - Family: Select **PRC** from the dropown <br>
        - Product: Select  **Self Service Procurement** from the dropdown <br>
        - Maximum Interactions: **20** <br>
        - Description: **Purchase Requisition Agent Team leverages worker agents Procurement Policy Advisory and Purchase Requisition Agent.** <br>

     > (2) Click the Questions tab <br>
    
       ![Create Agent](images/poaimage018.jpg)

19. You can provide one or more starter questions to assist users in interacting with the Agent Team.

     > (1) In the Question 1 field, enter: **Hi, I can help you with questions related to purchases.  How can I help you today?**
     > (2) Click the **Create** button ![Create Button](images/createb.jpg) on the bottom right.
    
       ![Create Agent](images/poaimage019.jpg)

20. You’ve defined your Agent Team, so it’s time to add a Supervisor agent.


     > (1) Click the **Agents** icon ![Agent Icon](images/agenticon.jpg).
     > (2) Click the **+** icon ![Create Button](images/plusicon.jpg) next to **New Supervisor Agent**.
    
   ![Create Agent](images/poaimage020.jpg)

21. Define Supervisor Agent Details.

     > (1) Enter the fields as described below:
        - Agent Team Name: **CIO## Procurement Requisition Supervisor Agent** where ## is replaced with your user nnumber.<br>
        - Family: Select **PRC** from the dropown<br>
        - Product: Select  **Self Service Procurement** from the dropdown<br>
        - Maximum Interactions: **10** <br>
        - Description: **Cloud Adventure Purchase Requisitions Supervisor Agent** <br>
     > (2) Click the **Create** button ![Create Button](images/createb.jpg) on the bottom right.
    
       ![Create Agent](images/poaimage021.jpg)

22. Next you'll add some worker agents.

     > Click the **+** icon ![Plus Icon](images/plusicon.jpg) next to **CIO## Procurement Policy Advisor Agent**, where ## is replaced with your user number.
    
       ![Create Agent](images/poaimage022.jpg)

23. You can review the deatils of the agent.

    > Click the Add button ![Add Button](images/addb.jpg).
    
    ![Add Tools Complete](images/poaimage023.jpg) <br>

24. You'll add one more worker agent.

     > Click the **+** icon ![Plus Icon](images/plusicon.jpg) next to predefined **CA Purchase Requisitions Agent**.  Note that this is a shared Agent and not one that you created specifically with your user number.
    
     ![Create Agent](images/poaimage024.jpg)

25. You can review the deatils of the agent.

    > Click the **Add** button ![Add Button](images/addb.jpg).
    
    ![Add Tools Complete](images/poaimage025.jpg) <br>

26. Your Agent Team, with a Supervisory Agent and two Worker Agents, is now ready to test.

    > Click the **Debug** icon ![debug icon](images/debugarrow.jpg) on the top left of the screen.  It's the one that looks like the Play arrow.
    
    ![start debug](images/poaimage026.jpg) <br>

27. You can now begin a dialog with the Agent.  

    > In the **Ask Oracle** dialog box on the bottom right of the screen, enter **What is the laptop policy** and hit the return key or click the **Up Arrow** icon ![uparrow icon](images/uparrow.jpg)
    
    ![agent dialogue 1](images/poaimage027.jpg) <br>

28. The Agent will response with information.  In this Debug mode, the Agent will also show you source and processing information (yellow boxes).  These will not be available to end-users once deployed.

    > The agent provides a response. But we need more information, so we'll ask additional questions.
    > In the **Ask Oracle** dialog box on the bottom right of the screen, enter **What if I need to order a non-standard laptop** and hit the return key or click the **Up Arrow** icon ![uparrow icon](images/uparrow.jpg)
    
    ![agent dialogue 2](images/poaimage028.jpg) <br>    

29. You decide to not worry about requesting anything non-standard.  
 
    > So, ask the agent to proceed with the laptop order by typing **I am ready to order a laptop** in the **Ask Oracle** dialog box on the bottom right of the screen and hit the return key or click the **Up Arrow** icon ![uparrow icon](images/uparrow.jpg)
    
    ![agent dialogue 3](images/poaimage029.jpg) <br>      

30. The Agent may notice that you have some incomplete PO Requisitions and will request your my input.  
 
    > In the **Ask Oracle** dialog box on the bottom right of the screen, enter **Show my existing requisitions** and hit the return key or click the **Up Arrow** icon ![uparrow icon](images/uparrow.jpg))
    
    ![agent dialogue 3](images/poaimage030.jpg) <br>  

31. The agent will ask you to confirm.  
 
    > In the **Ask Oracle** dialog box on the bottom right of the screen, enter **Proceed with ordering a laptop** and hit the return key or click the **Up Arrow** icon ![uparrow icon](images/uparrow.jpg))
    
    ![agent dialogue 3](images/poaimage032.jpg) <br>  

32. The agent needs a little more information.
 
    > In the **Ask Oracle** dialog box on the bottom right of the screen, enter **Requested delivery data is Aug 31st, 2025 and the quantity is 1** and hit the return key or click the **Up Arrow** icon ![uparrow icon](images/uparrow.jpg))
    
    ![agent dialogue 3](images/poaimage033.jpg) <br>  

33. The agent has created your requisition.
 
    > In the **Ask Oracle** dialog box on the bottom right of the screen, enter **TAke me to my requisition** and hit the return key or click the **Up Arrow** icon ![uparrow icon](images/uparrow.jpg))
    
    ![agent dialogue 3](images/poaimage034.jpg) <br>  

34. The agent can link you directly to the Purchase Requisition screen.
 
    > Click the **here** link in the agent response.
    
    ![agent dialogue 3](images/poaimage035.jpg) <br>      

34. You’re now in Self-Service Procurement and can see the new Requisition that the Agent created.
 
    > Congratulations on completing this Cloud Adventure!
    
    ![agent dialogue 3](images/poaimage036.jpg) <br>      


35. Adventure awaits, click on the image, show what you know and rise to the top of the leader board!!!

    [![Cloud Adventure](images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:LOGIN_TEAM:::::CC:CIOADVENTURE)


## Summary

As you have seen, AI Agent Studio puts customers in the driver’s seat, helping empower you to design the future of AI in your organizations on top of a bedrock of trust and safety. AI Agent Studio includes a built-in testing environment, validation, and traceability tools to confirm accuracy. Oracle maintains the same data controls at a user level, which means no individual sees data or AI recommendations that they’re not permissioned to see.

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
* **Last Updated By/Date** - Charlie Moff, July 2025
