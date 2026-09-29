# Assemble and Test a Multi-Agent AI Workflow using AI Agent Studio

### Introduction

AI Agent Studio for Fusion Applications is a comprehensive platform for creating, extending, deploying and managing AI Agents and Agent Teams across the enterprise. Oracle AI Agent Studio delivers easy-to-use tools, including advanced testing, robust validation, and built-in security, that helps Oracle Fusion Applications customers and partners create and manage AI agents. Leveraging the same technology that Oracle uses to create AI agents, Oracle AI Agent Studio enables users to easily extend pre-packaged agents and/or create new agents and then deploy and manage them.

### Objectives

In this activity you will use Oracle Fusion AI Agent Studio to
* Assemble an Agent Workflow using a Multi Agent Type.  It will leverage your previously created FMLA Absence Agent and a seeded Benefits Advisor Agent.
* You will then test the Agent Workflow using the included Debug feature of AI Agent Studio.

Estimated Time: 10 minutes

## Pre-requisite

![Alert Flat](../gen-images/cautionflagextrasmalltransparent2.png)
As a pre-requisite for this adventure, please download following file
1. Prompt file for your Multi Agent Workflow
<br>
[Right-click here and select Download Linked File as OR Save Link as OR Save File as.](../05c-multi-agent-hcm/files/prompt-multi-agent-hcm.txt)

## Begin Exercise

1. Assemble an AI Agent Team, Debug and Test

    ![Adventure Flow](images/multi-agent-hcm-image1.jpg)

2. Open AI Agent Studio

    > (1): Click the **Tools** menu tab  <br>
    > (2): Click the **AI Agent Studio** tile

    ![Springboard page](images/multi-agent-hcm-image2.jpg)

3. Expand Menu

    > (1): Click the **Expand** Menu

    ![Expand Menu](images/multi-agent-hcm-image3.jpg)

4. Open Workflows

    > (1): Click the **Workflows** Menu Option

    ![Open Workflows](images/multi-agent-hcm-image4.jpg)

5. Add Workflow

    > (1): Click the **Add** button to create a new Workflow

    ![Create Workflow](images/multi-agent-hcm-image5.jpg)

6. Workflow Settings: Details

    > (1): Enter the following fields as shown:
    * Agent Team Name:  CIOXXYYY Benefits Workflow
    * Family:  HCM
    * Benefits:  Benefits

    > (2): Scroll Down

    ![Enter Workflow Settings Detail](images/multi-agent-hcm-image6.jpg)

7. Workflow Settings: Description

    > (1): Enter **Benefits and FMLA Workflow** in the **Description** field.  <br>
    > (2): Click in the blank space to the left (the Workflow Settings panel will be hidden)

    ![Enter Workflow Settings Description](images/multi-agent-hcm-image7.jpg)

8. Show Component Palette

    > (1): Click the  **Show Component Palette** in the bottom toolbar

    ![Show Component Palette](images/multi-agent-hcm-image8.jpg)

9. Drag to add first node

    > (1): Click the  **Black Circle Icon** under the play icon and drag to the **Dotted Rectangle** region below it.<br>
    > (2): Release the mouse once in the drag is complete.

    ![Show Component Palette](images/multi-agent-hcm-image9.jpg)

10. Select Multi Agent

    > (1): Select  **Multi Agent** from the dropdown list

    ![Multi-Agent Type Section](images/multi-agent-hcm-image10.jpg)

11. Enter Multi Agent Definition

    > (1): Enter the following fields as shown:
    * Name:  CIOXXYYY Benefits Agents, where XX is replaced with your user number and YYY is replaced with your initials.
    * Maximum Interactions:  5

    > (2): Scroll Down

    ![Enter Agent Info](images/multi-agent-hcm-image11.jpg)

12. Multi Agent Prompt

    > (1): Please note that the Prompt is a critical part of the Agent Definition as it provides guidance for the Agent. To streamline this step, we've pre-created the prompt. The prompt text is available in the copy block below.

    ![Enter Agent Info](images/multi-agent-hcm-image12.jpg)

```
<copy>
AGENT ROLE

You are a Supervisor Agent responsible for coordinating complex requests.

RESPONSIBILITIES

Analyze each request and break complex work into clear, manageable subtasks.

Delegate the entire request to exactly one specialist agent best suited to complete it.

Do not delegate work to multiple agents.

Provide the selected agent with clear objectives, relevant context, constraints, and expected output.

Review the delegated agent’s response and present a concise, coherent final answer to the user. </copy>
```


13. Add First Agent

    > (1): Click the  **Black Circle Icon** at the bottom of your newly created Multi-Agent and drag to the **open space** in the box below.<br>
    > (2): Release the mouse once in the drag is complete.

    ![Add First Agent](images/multi-agent-hcm-image13.jpg)

14. Select Agent

    > (1): Select  **Agent** from the dropdown list

    ![Add Agent](images/multi-agent-hcm-image14.jpg)

15. Name and Add Agent Information

    > (1): Enter **Benefits Advisor Agent** in the Name field.<br>
    > (2): Scroll Down

    ![Add Agent Info](images/multi-agent-hcm-image15.jpg)

16. Select Agent

    > (1): Enter the following fields as shown:
    * Family:  HCM* Product:  Benefits
    * Agent:  Type **AIA** and select **AIA Benefits Advisor Agent** from the resulting dropdown

    > (2): Click the **x** icon in the top right corner of the Agent panel.

    ![Select Agent](images/multi-agent-hcm-image16.jpg)

17. Add Second Agent

    > (1): Click the  **Black Circle Icon** at the bottom of your newly created Multi-Agent and drag to the **open space** in the box below.<br>
    > (2): Release the mouse once in the drag is complete.

    ![Add Second Agent](images/multi-agent-hcm-image17.jpg)

18. Select Agent

    > (1): Select  **Agent** from the dropdown list

    ![Add Agent](images/multi-agent-hcm-image18.jpg)

19. Name and Add Agent Information

    > (1): Enter **FMLA Absence Agent** in the Name field.<br>
    > (2): Scroll Down

    ![Add FMLA Agent Info](images/multi-agent-hcm-image19.jpg)

20. Select Agent

    > (1): Enter the following fields as shown:
    * Family:  HCM* Product:  Absences
    * Agent:  Type **CIOXXYY**, where XX is replaced with your user number and YYY is replaced with your initials, and select **CIOXXYYY Absence Agent** from the resulting dropdown

    > (2): Click the **x** icon in the top right corner of the Agent panel.

    ![Select Agent](images/multi-agent-hcm-image20.jpg)

21. Optionally clean up and start Debug

    > (1): Optionally click the **Prettify** icon on the top toolbar to clean-up the layout.<br>
    > (2): Optionally drag to reposition your visualization.  You can click individual items or click near the top to drag the whole diagram.> (3): Click the **Debug** button on the bottom toolbar.

    ![Prettify and Debug](images/multi-agent-hcm-image21.jpg)

22. Start Debug interaction

    > (1): Type **Please summarize my benefits** in the **Ask me anything** box on the bottom left and press the **Enter** key.

    ![Ask Debug](images/multi-agent-hcm-image22.jpg)

23. Explain Debug and Continue Conversation.

    > (1): Note the response to your question.  Scroll the response window, if necessary.> (2): Note that the diagram has highlighted (in green) the path that the Agent Workflow used to resolve the question. > (3): Click the **Benefits Advisor Agent** box to show the results information panel

    ![Debug Example](images/multi-agent-hcm-image23.jpg)

24. Explain Debug and Continue Conversation.

    > (1): Note the Results and Configuration tab on the pop-up panel.  This shows details about the agent execution.<br>
    > (2): Click the **x** icon on the top right of the pop-out panel<br>
    > (3): Type **do I have fmla benefits** in the **Ask me anything** box on the bottom left and press the **Enter** key.

    ![Debug Details](images/multi-agent-hcm-image24.jpg)

25. Continued Debug Discussion

    > (1): Note the response to your question.  Scroll the response window, if necessary.<br>
    > (2): Type **Do I have any existing FMLA absences** in the **Ask me anything** box on the bottom left and press the **Enter** key.

    ![Ask about absences](images/multi-agent-hcm-image25.jpg)

26. Get Absence Response and Ask to Create one

    > (1): Note the response to your question.  Scroll the response window, if necessary.  It will show you whether you have any existing absences.  Your individual response may vary.<br>
    > (2): Type **Please create a new FMLA leave** in the **Ask me anything** box on the bottom left and press the **Enter** key.

    ![Ask to Create](images/multi-agent-hcm-image26.jpg)

27. Provide Date

    > (1): Note that the agent has asked for start and end dates for your requested FMLA leave.<br>
    > (2): Type **Start Date of 11/2/26 and end date of 11/4/16** in the **Ask me anything** box on the bottom left and press the **Enter** key.  Feel free to select other dates for your start and end dates

    ![Provide Dates](images/multi-agent-hcm-image27.jpg)

28. Success!  ![checkered flag](../gen-images/checkeredflag.jpg)

    > (1): You have created a new absence and completed this Adventure.

    ![Success](images/multi-agent-hcm-image28.jpg)

### Summary

As you have seen here, AI Agent Studio puts customers in the driver’s seat, helping empower you to design the future of AI in your organizations on top of a bedrock of trust and safety. AI Agent Studio includes a built-in testing environment, validation, and traceability tools to confirm accuracy. Oracle maintains the same data controls at a user level, which means no individual sees data or AI recommendations that they’re not permitted to see.

AI Agent Studio empowers enterprises to configure and build AI agents that extend their workforce and help achieve new levels of productivity. It allows you to harness the full potential of AI agents and transform the way work gets done in your organization.

AI Agent Studio is a design-time environment that provides a set of tools to create, customize, validate, and deploy GenAI features and AI agents to meet the specific needs of the organization. It is the same unified environment Oracle uses to internally build agents, made available now to customers and partners to customize and extend agents from Oracle-provided pre-configured templates or to create new agents and multi-agent workflows.

Like our AI capabilities, Oracle AI Agent Studio was built natively into Fusion Cloud Applications on our trusted, high performance Oracle Cloud Infrastructure (OCI), which means it can easily and securely access Fusion knowledge stores, tools, and APIs and allows agents to be deployed directly into the flow of work. This approach means maximum flexibility and customization without sacrificing reliability or performance.

## Learn More

* [AI Agent Studio Solution Brief](https://www.oracle.com/a/ocom/docs/applications/fusion-apps-ai-agent-studio-solution-brochure.pdf)
* [AI Agents for Fusion Applications](https://www.oracle.com/applications/fusion-ai/ai-agents/)
* [AI for Fusion Applications](https://www.oracle.com/applications/fusion-ai/)
* [Oracle Documentation](http://docs.oracle.com)

## Acknowledgements

* **Author** - Stephen Chung, Principal SaaS Cloud Technologist; Sajid Saleem, Master Principal SaaS Cloud Technologist; Charlie Moff, Distinguished SaaS Cloud Technologist
* **Contributors** - The AI Adventure Team (Gus, Kris, Sajid, Casey, Stephen, Jamil, Sohel, Xavier, Nate, Charlie, Ray)
* **Last Updated By/Date** - Sajid Saleem, Charlie Moff September 2026
