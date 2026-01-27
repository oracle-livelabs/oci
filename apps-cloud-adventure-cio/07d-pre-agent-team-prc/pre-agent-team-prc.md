# Assemble and Test an AI Agent Team

## **Assemble and Test an AI Agent Team using AI Agent Studio**

### Introduction

AI Agent Studio for Fusion Applications is a comprehensive platform for creating, extending, deploying and managing AI Agents and Agent Teams across the enterprise. Oracle AI Agent Studio delivers easy-to-use tools, including advanced testing, robust validation, and built-in security, that helps Oracle Fusion Applications customers and partners create and manage AI agents. Leveraging the same technology that Oracle uses to create AI agents, Oracle AI Agent Studio enables users to easily extend pre-packaged agents and/or create new agents and then deploy and manage them.


### **Objectives**

In this activity you will use Oracle Fusion AI Agent Studio to
* Assemble an Agent Team using previously created Procurement Policy Advisor Agent and seeded Purchase Requisition Action Agent.
* Test the Agent Team

### **Begin Exercise**

1. In this activity you will learn the power and ease building Agentic AI with the Oracle AI Agent Studio

    ![AI Agent Team](../07d-pre-agent-team-prc/images/poaimage001.jpg)

2. The first step is to navigate to AI Agent Studio.

    > (1) Click on the **Tools** tab <br>
    > (2) Select the **AI Agent Studio** tile

    ![Navigate to AI Agent Studio](../07d-pre-agent-team-prc/images/poaimage002.jpg)

3. You've previously created your first Agent.  Now, you'll assemble an Agent Team with a Supervisor Agent and Worker Agents.<br>
An Agent team is a group of AI agents collaborating on tasks, where a supervisor agent manages, coordinates, and monitors the activities of the other agents to ensure cohesive team performance.

    > (1) Click the **Agent Teams** button/tab ![Agent Teams](../gen-images/agentteams.jpg) at the bottom of the page

    ![Open tools](../07d-pre-agent-team-prc/images/poaimage003.jpg)

4. Select your assigned Agent Team.

    >  (1) Click on **Draft**.

    >  (2) Enter **XX** in the Search Bar, where XX is replaced with your user number, press the **<****Enter****>** key or select **XX** from the resulting dropdown.<br>

    >  (3) Click the pencil button to edit the CIOXX Purchase Requisition Agent Team with your user number.

    > ![Add Tools Create](../07d-pre-agent-team-prc/images/poaimage004.jpg)

5. Next you'll add some worker agents. You can scroll through the list of available agents or use the Ask Oracle field to filter the results.  You'll do the latter.

    >  (1)  Enter **XX**, where XX is replaced with your user number, in the Ask Oracle field and press the **<****Enter****>** key or select **XX** from the resulting dropdown.<br>
    >  ![Caution Flag](../gen-images/cautionflagextrasmalltransparent2.png) Note that Steps 2 and 3 below are the same.  The first click activates that region and the second actually adds the agent.<br>
    >  (2)  Click the ![Plus Icon](../gen-images/plusicon.jpg) icon next to **CIOXX Procurement Policy Advisor Agent**, where XX is replaced with your user number.<br>
    >  (3)  You may need to click the ![Plus Icon](../gen-images/plusicon.jpg) icon a second time.

    ![Create Agent](../07d-pre-agent-team-prc/images/poaimage005.jpg)

6. You can review the details of the agent before adding.

    > (1) Click the Add button ![Add Button](../gen-images/addb.jpg).

    ![Add Tools Complete](../07d-pre-agent-team-prc/images/poaimage006.jpg) <br>

7. You'll add one more worker agent.

    >  (1) Delete your previous Ask Oracle filter and enter **F1** in the Ask Oracle Filter and press the **<****Enter****>** key or select **F1** from the resulting dropdown.<br>

    >  ![Caution Flag](../gen-images/cautionflagextrasmalltransparent2.png) Note that Steps 2 and 3 below are the same.  The first click activates that region and the second actually adds the agent.<br>

    >  (2) Click the ![Plus Icon](../gen-images/plusicon.jpg) icon next to **F1 Purchase Requisitions Agent.**<br>

    >  (3) You may need to click the ![Plus Icon](../gen-images/plusicon.jpg) icon a second time.<br>


    ![Create Agent](../07d-pre-agent-team-prc/images/poaimage007.jpg)

8. You can review the details of the agent.

    > (1) Click the **Add** button ![Add Button](../gen-images/addb.jpg).

    ![Add Tools Complete](../07d-pre-agent-team-prc/images/poaimage008.jpg) <br>

9. Your Agent Team, with a Supervisor Agent and two Worker Agents, is now ready to test.

    > (1) Click the **Debug** icon ![debug icon](../gen-images/debugarrow.jpg) on the top left of the screen.  It's the one that looks like the Play arrow.

    ![start debug](../07d-pre-agent-team-prc/images/poaimage009.jpg) <br>

10. You can now begin a dialog with the Agent.

    > (1) In the **Ask Oracle** dialog box on the bottom right of the screen, enter **What is the laptop policy** and hit the return key or click the **Up Arrow** icon ![up arrow icon](../gen-images/uparrow.jpg)

    ![agent dialogue 1](../07d-pre-agent-team-prc/images/poaimage010.jpg) <br>

11. The Agent will respond with information.  In this Debug mode, the Agent will also show you source and processing information (yellow boxes).  These will not be available to end-users once deployed. The agent provides a response. But we need more information, so we'll ask additional questions.
    > (1) In the **Ask Oracle** dialog box on the bottom right of the screen, enter **What if I need to order a non-standard laptop** and hit the return key or click the **Up Arrow** icon ![up arrow icon](../gen-images/uparrow.jpg)

    ![agent dialogue 2](../07d-pre-agent-team-prc/images/poaimage011.jpg) <br>

12. You decide to not worry about requesting anything non-standard.

    > (1) So, ask the agent to proceed with the laptop order by typing **I am ready to order a laptop** in the **Ask Oracle** dialog box on the bottom right of the screen and hit the return key or click the **Up Arrow** icon ![up arrow icon](../gen-images/uparrow.jpg)

    ![agent dialogue 3](../07d-pre-agent-team-prc/images/poaimage012.jpg) <br>

13. The agent queries for any incomplete PO Requisitions previously submitted by you and may request your input.

    > (1) In the **Ask Oracle** dialog box on the bottom right of the screen, enter **Create a new requisition now** and hit the return key or click the **Up Arrow** icon ![up arrow icon](../gen-images/uparrow.jpg)

    ![agent dialogue 3](../07d-pre-agent-team-prc/images/poaimage013.jpg) <br>

14. The agent needs a little more information.

    > (1) In the **Ask Oracle** dialog box on the bottom right of the screen, enter **Requested delivery date is Feb 28th, 2026, the quantity is 1 and it is the same model** and hit the return key or click the **Up Arrow** icon ![up arrow icon](../gen-images/uparrow.jpg)

    ![agent dialogue 3](../07d-pre-agent-team-prc/images/poaimage014.jpg) <br>

15. The agent has created your requisition.

    > (1) In the **Ask Oracle** dialog box on the bottom right of the screen, enter **Take me to my requisition** and hit the return key or click the **Up Arrow** icon ![up arrow icon](../gen-images/uparrow.jpg)

    ![agent dialogue 3](../07d-pre-agent-team-prc/images/poaimage015.jpg) <br>

16. The agent can link you directly to the Purchase Requisition screen.

    > Click the **here** link in the agent response.

    ![agent dialogue 3](../07d-pre-agent-team-prc/images/poaimage016.jpg) <br>

17. You’re now in Self-Service Procurement and can see the new Requisition that the Agent created.

    > Congratulations on completing this Cloud Adventure!

    ![agent dialogue 3](../07d-pre-agent-team-prc/images/poaimage017.jpg) <br>


18. Adventure awaits, click on the image, show what you know and rise to the top of the leader board!!!

    [![Cloud Adventure](../gen-images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:LOGIN_TEAM:::::CC:CIOADVENTURE)


### Summary

As you have seen here, AI Agent Studio puts customers in the driver’s seat, helping empower you to design the future of AI in your organizations on top of a bedrock of trust and safety. AI Agent Studio includes a built-in testing environment, validation, and traceability tools to confirm accuracy. Oracle maintains the same data controls at a user level, which means no individual sees data or AI recommendations that they’re not permissioned to see.

AI Agent Studio empowers enterprises to configure and build AI agents that extend their workforce and help achieve new levels of productivity. It allows you to harness the full potential of AI agents and transform the way work gets done in your organization.
AI Agent Studio is a design-time environment that provides a set of tools to create, customize, validate, and deploy GenAI features and AI agents to meet the specific needs of the organization. It is the same unified environment Oracle uses to internally build agents, made available now to customers and partners to customize and extend agents from Oracle-provided pre-configured templates or to create new agents and multi-agent workflows.

Like our AI capabilities, Oracle AI Agent Studio was built natively into Fusion Cloud Applications on our trusted, high performance Oracle Cloud Infrastructure (OCI), which means it can easily and securely access Fusion knowledge stores, tools, and APIs and allows agents to be deployed directly into the flow of work. This approach means maximum flexibility and customization without sacrificing reliability or performance.

**You have successfully completed the Activity!**


### Learn More

* [AI Agent Studio Solution Brief](https://www.oracle.com/a/ocom/docs/applications/fusion-apps-ai-agent-studio-solution-brochure.pdf)
* [AI Agents for Fusion Applications](https://www.oracle.com/applications/fusion-ai/ai-agents/)
* [AI for Fusion Applications](https://www.oracle.com/applications/fusion-ai/)
* [Oracle Documentation](http://docs.oracle.com)

## Acknowledgements

* **Author** - Stephen Chung, Principal SaaS Cloud Technologist; Sajid Saleem, Master Principal SaaS Cloud Technologist; Charlie Moff, Distinguished SaaS Cloud Technologist
* **Contributors** - The AI Adventure Team (Gus, Kris, Sajid, Casey, Stephen, Jamil, Sohel, Xavier, Nate, Charlie)
* **Last Updated By/Date** - Casey Doody; Sajid Saleem, January 2026