# Assemble and Test an AI Agent Team

## **Assemble and Test an AI Agent Team using AI Agent Studio**

### **Introduction**

AI Agent Studio for Fusion Applications is a comprehensive platform for creating, extending, deploying and managing AI Agents and Agent Teams across the enterprise. Oracle AI Agent Studio delivers easy-to-use tools, including advanced testing, robust validation, and built-in security, that helps Oracle Fusion Applications customers and partners create and manage AI agents. Leveraging the same technology that Oracle uses to create AI agents, Oracle AI Agent Studio enables users to easily extend pre-packaged agents and/or create new agents and then deploy and manage them.


### **Objectives**

In this activity you will use Oracle Fusion AI Agent Studio to
* Assemble an Agent Team using your previously created Benefits Advisor Agent and seeded FMLA Absence Agent.
* Test the Agent Team

### **Begin Exercise**

1. In this activity you will learn the power and ease building Agentic AI with the Oracle AI Agent Studio

    ![AI Agent Team](../05d-pre-agent-team-hcm/images/pre-agent-team-hcm-image001.jpg)

2. The first step is to navigate to AI Agent Studio.

    > (1) Click on the **Tools** tab <br>
    > (2) Select the **AI Agent Studio** tile

    ![Navigate to AI Agent Studio](../05d-pre-agent-team-hcm/images/pre-agent-team-hcm-image002.jpg)

3. You’ve previously created your first Agent.  Now, you'll assemble an Agent Team with a Supervisor Agent and Worker Agents.<br>
An Agent team is a group of AI agents collaborating on tasks, where a supervisor agent manages, coordinates, and monitors the activities of the other agents to ensure cohesive team performance.

    >  (1) Click the **Agent Teams** button/tab ![Agent Teams](../gen-images/agentteams.jpg) at the bottom of the page

    ![Open tools](../05d-pre-agent-team-hcm/images/pre-agent-team-hcm-image003.jpg)


4. Select your assigned Agent Team.

    >  (1) Enter **XX** in the Search Bar, where XX is replaced with your user number, press the **<****Enter****>** key or select **XX** from the resulting dropdown.<br>
    
    >  (2) Click on the **Draft** button ![Draft Button](../gen-images/draft-button.png).<br>

    >  (3) Click the **Pencil** icon to edit the **CIOXX Benefits Agent Team** where **XX** is replaced with your user number.

    ![Create Agent Team](../05d-pre-agent-team-hcm/images/pre-agent-team-hcm-image004.jpg)

5. Next you'll add some worker agents to the Agent Team.  You can scroll through the list of available agents or use the Ask Oracle field to filter the results.  You'll do the latter.

    >  (1)  Enter **XX**, where XX is replaced with your user number, in the Ask Oracle field and press the **<****Enter****>** key or select **XX** from the resulting dropdown.<br>
    >  (2)  Click the ![Plus Icon](../gen-images/plusicon.jpg) icon next to **CIOXX Benefits Advisor Agent**, where XX is replaced with your user number.<br>

    ![Add Tool](../05d-pre-agent-team-hcm/images/pre-agent-team-hcm-image005.jpg)

6. You can review the details of the agent before adding.

    >  (1) Click the ![Add Button](../gen-images/addb.jpg) button on the bottom right of the screen.

    ![Add Tools Complete](../05d-pre-agent-team-hcm/images/pre-agent-team-hcm-image006.jpg) <br>

7. You'll add one more worker agent.

    >  (1) Delete your previous Ask Oracle filter and enter **F1** in the Ask Oracle Filter and press the **<****Enter****>** key or select **F1 FMLA** from the resulting dropdown.<br>

    >  (2) Click the ![Plus Icon](../gen-images/plusicon.jpg) icon next to **F1 FMLA Absence Agent.**, you may need to click the plus icon twice.<br>

    ![Add Tool](../05d-pre-agent-team-hcm/images/pre-agent-team-hcm-image007.jpg)

8. You can review the details of the agent.

    >  (1) Click the **Add** button ![Add Button](../gen-images/addb.jpg).

    ![Add Tools Complete](../05d-pre-agent-team-hcm/images/pre-agent-team-hcm-image008.jpg) <br>

9. Your Agent Team, with a Supervisor Agent and two Worker Agents, is complete.  We can now hide the left Agents panel to see our full Agent Team.

    >  (1) Click the **Agents** icon ![debug icon](../gen-images/agenticon.jpg) on the top left of the screen.  You can see that the left panel is now hidden and you can see the entire Agent Team

    ![start debug](../05d-pre-agent-team-hcm/images/pre-agent-team-hcm-image009.jpg) <br>


10. Feel free to admire your Agent Team. Time to test it and see how it responds to your requests.

    >  (1) Click the **Debug** icon ![debug icon](../gen-images/debugarrow.jpg) on the top left of the screen.  It's the one that looks like the Play arrow.

    ![start debug](../05d-pre-agent-team-hcm/images/pre-agent-team-hcm-image010.jpg) <br>

11. The Agent is now ready for your questions.

    >  (1) In the **Ask Oracle** dialog box at the bottom of the screen, type **Please summarize available health benefits** and hit the **<****Enter****>** key or click the **Up Arrow** icon ![up arrow icon](../gen-images/uparrow.jpg)

    ![agent dialogue 1](../05d-pre-agent-team-hcm/images/pre-agent-team-hcm-image011.jpg) <br>

12. The Agent will respond with information.  In this Debug mode, the Agent will also show you source and processing information (yellow boxes).  These will not be available to end-users once deployed.

    > The Agent responds with information, so we’ll ask an additional question.

    >  (1) In the **Ask Oracle** dialog box on the bottom right of the screen, enter **Tell me more about FMLA benefits** and hit the **<****Enter****>** key or click the **Up Arrow** icon ![up arrow icon](../gen-images/uparrow.jpg)

    ![agent dialogue 2](../05d-pre-agent-team-hcm/images/pre-agent-team-hcm-image012.jpg) <br>

13. The Agent checks with HCM Cloud and confirms existing leave requests, if any.  It also offers to create a new request for you if you provide the requested start and end dates.

    You decide to tell the Agent that you’re interested in creating an FMLA absence, but you do so without initially providing the requested dates.

    >  (1) In the **Ask Oracle** dialog box on the bottom right of the screen, enter **Yes, please submit a new FMLA absence with a start date of 2026-05-18 and an end date of 2026-05-2216** and hit the return key or click the **Up Arrow** icon ![up arrow icon](../gen-images/uparrow.jpg)

    ![agent dialogue 3](../05d-pre-agent-team-hcm/images/pre-agent-team-hcm-image013.jpg) <br>

14. The agent confirms that your request has been created.

    >  (1) Review AI Agent Response<br>
    >  (2) Click the x icon in the upper right to close the debug screen.

    ![agent dialogue 3](../05d-pre-agent-team-hcm/images/pre-agent-team-hcm-image014.jpg) <br>

15. Let’s go back to the homepage so we can confirm the creation of our absence.

    >  (1) Click the Home  **Ask Oracle** icon ![home icon](../gen-images/icon012_home.png) on the top right.

    ![agent dialogue 3](../05d-pre-agent-team-hcm/images/pre-agent-team-hcm-image015.jpg) <br>

16. The AI Agent has created your absence request and now you want to find it.

    >  (1) In the Search field, type **existing absences** and select **Existing Absences - Me** from the resulting dropdown.

    ![agent dialogue 3](../05d-pre-agent-team-hcm/images/pre-agent-team-hcm-image016.jpg) <br>

17. There it is!  ![up arrow icon](../gen-images/checkeredflag.jpg)

    ![agent dialogue 3](../05d-pre-agent-team-hcm/images/pre-agent-team-hcm-image017.jpg) <br>


18. Adventure awaits, click on the image, show what you know and rise to the top of the leader board!!!

    [![Cloud Adventure](../gen-images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:LOGIN_TEAM:::::CC:CIOADVENTURE)

### Summary

As you have seen here, AI Agent Studio puts customers in the driver’s seat, helping empower you to design the future of AI in your organizations on top of a bedrock of trust and safety. AI Agent Studio includes a built-in testing environment, validation, and traceability tools to confirm accuracy. Oracle maintains the same data controls at a user level, which means no individual sees data or AI recommendations that they’re not permitted to see.

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
* **Last Updated By/Date** - Charlie Moff; Sajid Saleem, February 2026