# Create a Workflow Agent along with Business Object and Deep Link Tools using AI Agent Studio

## Introduction

AI Agent Studio for Fusion Applications is a comprehensive platform for creating, extending, deploying and managing AI Agents and Agent Teams across the enterprise. Oracle AI Agent Studio delivers easy-to-use tools, including advanced testing, robust validation, and built-in security, that helps Oracle Fusion Applications customers and partners create and manage AI agents. Leveraging the same technology that Oracle uses to create AI agents, Oracle AI Agent Studio enables users to easily extend pre-packaged agents and/or create new agents and then deploy and manage them.

### Objectives

In this activity you will use Oracle Fusion AI Agent Studio to
* Create a Business Object Tool that provides query and creation access to Absences.
* Create a Deep Link Tool to provide drill down to absences
* Create Benefits Absence Agent that leverages the above tools and a delivered User Details tool,

Estimated Time: 10-15 minutes

## Pre-requisite

![Alert Flat](../gen-images/cautionflagextrasmalltransparent2.png)
As a pre-requisite for this adventure, please download following files
1. Agent Role file to your local desktop as below.
<br>
[Right-click here and select Download Linked File as OR Save Link as OR Save File as.](../05b-bo-agent-hcm/files/role-bo-agent-hcm.txt)
<br>
2. Prompt file for the AI Agent
<br>
[Right-click here and select Download Linked File as OR Save Link as OR Save File as.](../05b-bo-agent-hcm/files/prompt-bo-agent-hcm.txt)


## Begin Exercise



1. Create FMLA/Benefits Business Object Agent

    ![Adventure Flow](images/bo-agent-hcm-image1.jpg)

2. Open AI Agent Studio

    > (1): Click the **Tools** menu tab<br>
    > (2): Click the **AI Agent Studio** tile

    ![Springboard page](images/bo-agent-hcm-image2.jpg)

3. Expand Menu

    > (1): Click the **Expand** Menu

    ![Expand Menu](images/bo-agent-hcm-image3.jpg)

4. Open Resources

    > (1): Click the **Resources** Menu Option

    ![Open Resources](images/bo-agent-hcm-image4.jpg)

5. View Tools

    > (1): Click the **Tools** tab at the top of the screen.

    ![View Tools](images/bo-agent-hcm-image5.jpg)

6. Add Tool

    > (1): Click the **Add** button to create a new Tool

    ![Create Tool](images/bo-agent-hcm-image6.jpg)

7. Add New Tool Details

    > (1): Enter the following fields as shown:
    * Tool Type:  Select **Business Object** from the dropdown
    * Tool Name:  CIOXXYYY Absence BO Tool, where XX is replaced with your user number and YYY is replaced with your initials.
    * Family:  Select **HCM** from the dropdown* Product:  Select **Absences** from the dropdown<br>
    > (2): Press the **Generate** button to generate description information. <br>
    > (3): Press the **Go** button to accept the generated description.

    ![Enter Tool Details](images/bo-agent-hcm-image7.jpg)

8. Select Business Object

    > (1): Type **AIA** in the **Search business objects** field and select **AIA FMLA Absence** from the resulting dropdown.

    ![Select BO](images/bo-agent-hcm-image8.jpg)

9. Add New Tool Details

    > (1): Click the **Checkbox** next to both **getFMLAAbsences** and **submitFMLAAbsence** to enable them for use in this tool. <br>
    > (2): Click the **Create and Close** button on the bottom toolbar.

    ![Select BO Functions](images/bo-agent-hcm-image9.jpg)

10. Add Another tool

    > (1): Note that your first Tool has been created.  You may need to scroll to see yours as this will show all tools created by attendees. <br>
    > (2): Click the **Add** button to create a new Tool

    ![Add Tool](images/bo-agent-hcm-image10.jpg)

11. Add New Tool Details

    > (1): Enter the following fields as shown:
    * Tool Type:  Select **Deep Link** from the dropdown
    * Tool Name:  CIOXXYYY Absence Deep Link Tool, where XX is replaced with your user number and YYY is replaced with your initials.
    * Family:  Select **HCM** from the dropdown* Product:  Select **Absences** from the dropdown<br>

    > (2): Press the **Generate** button to generate description information. <br>
    > (3): Press the **Go** button to accept the generated description.

    ![Enter Tool Details](images/bo-agent-hcm-image11.jpg)

12. Select Deep Link Tool

    > (1): Type **AIA** in the **Search by deep link name, code, family, or product** field and select **AIA Existing Absences** from the resulting dropdown.

    ![Select Deep Link](images/bo-agent-hcm-image12.jpg)

13. Confirm and Create

    > (1): Note the message that will display to allow the customer to use the Deep Link. <br>
    > (2): Click the **Create and Close** button on the bottom toolbar.

    ![Select Deep Link](images/bo-agent-hcm-image13.jpg)

14. View Agents

    > (1): Click the **Agents** tab at the top of the screen.

    ![View Agents](images/bo-agent-hcm-image14.jpg)

15. Add Agent

    > (1): Click the **Add** button to create a new Agent

    ![Create Agent](images/bo-agent-hcm-image15.jpg)

16. Add Agent Settings Details

    > (1): Enter the following fields as shown:
    * Agent Name:  **CIOXXYYY Absence Agent**, where XX is replaced with your user number and YYY is replaced with your initials.
    * Family:  Select **HCM** from the dropdown* Product:  Select **Absences** from the dropdown* Description: **Absence Benefit Agent*** Maximum Interactions: **5**<br>

    > (2): Press the **Generate** button to generate description information.

    ![Enter Tool Details](images/bo-agent-hcm-image16.jpg)

17. Generate Description

    > (1): Press the **Go** button to accept the generated description.

    ![Generate Description](images/bo-agent-hcm-image17.jpg)

18. Review Description and Go To Prompts

    > (1): Note the generated description<br>
    > (2): Press the **Generate** button to generate description information.

    ![Begin prompts](images/bo-agent-hcm-image18.jpg)

19. Multi Agent Prompt

    > (1): Enter the value for the **Agent Role**: **As a FMLA Leave of Absence Agent, your role is to efficiently ask whether the user is interested in applying for FMLA Leave and providing existing leave of absences**<br>
    > (2): Enter the value for the **Prompt**.   Please note that the Prompt is a critical part of the Agent Definition as it provides guidance for the Agent. To streamline this step, we've pre-created the prompt. The prompt text is available in the copy block below.

    ![Multi Agent Prompt](images/bo-agent-hcm-image19.jpg)

**Agent Role**:
```
<copy>
As a FMLA Leave of Absence Agent, your role is to efficiently ask whether the user is interested in applying for FMLA Leave and providing existing leave of absences
 </copy>
```

**Prompt**:
```
<copy>
FMLA Absence Agent

ROLE
As a FMLA Leave of Absence Agent, your role is to help workers view their existing FMLA leave absences or submit a new FMLA leave absence accurately and securely 

Your role is to:

* Determine whether the user wants to submit a new FMLA leave of absence.
* Retrieve and provide information about the user’s existing leave of absence.
* Provide actionable guidance when the user wants to submit a new leave of absence.
* Submit a new leave of absence only after all required information has been collected.

INITIALIZATION

At the beginning of the conversation, retrieve the logged-in user’s Person ID.

Required tool call:

* Tool: ORA_HCM_PER_FETCH_LOGGED_IN_USER_DETAILS
* Function: Get_Employee_Person_ID

Store the returned Person ID and use it for leave of absence retrieval and submission.

If the Person ID cannot be retrieved, explain that the request cannot be completed until the worker’s identity is available. Do not attempt absence retrieval or submission without it.

FMLA ABSENCE RETRIEVAL

When the user asks to view, check, or ask about existing leave absences:

Required tool call:

* Tool: AIA_FMLA_ABSENCE_BO_TOOL
* Function: getFMLAAbsences

Use the logged-in user’s Person ID as the basis for retrieving the user’s absences.

Answer questions using only the data returned by the tool.

Do not fabricate, infer, or assume absence details that were not returned by the tool.

NEW LEAVE OF ABSENCE SUBMISSION

When the user wants to create or submit a new leave of absence:

1. Ask for Start Date and End Date 
2. Convert valid dates to YYYY-MM-DD before submission
3. If a date is ambiguous, incomplete, invalid, or the End Date is earlier than the Start Date, ask the user to correct it.
4. Submit the FMLA leave of absence using:
    Tool: AIA_FMLA_ABSENCE_BO_TOOL
    Function: submitFMLAAbsence

After submission, report the result strictly based on the tool response.

TOOL USAGE RULES

* Retrieve the user’s Person ID first using ORA_HCM_PER_FETCH_LOGGED_IN_USER_DETAILS.Get_Employee_Person_ID.
* For questions about existing leave of absence, call AIA_FMLA_ABSENCE_BO_TOOL.getFMLAAbsences before answering.
* For new leave of absence, collect the required information before calling AIA_FMLA_ABSENCE_BO_TOOL.submitFMLAAbsence.
* Always format Start Date and End Date as YYYY-MM-DD before submission.
* Never fabricate tool results, requisition numbers, statuses, dates, quantities, links, or other business data.
* Never claim that an operation succeeded unless the corresponding tool confirms success.

RESPONSE GUIDELINES

* Be concise, factual, and professional.
* Base factual answers strictly on retrieved tool data.
* Clearly distinguish between information retrieved from the system and information provided by the user.
* Ask only for information that is necessary to complete the requested action.
* When a request cannot be completed because required information is missing, state what information is needed.
* Do not make assumptions about missing values.
* When presenting multiple leave of absence, use a clear, readable format.

BEHAVIOR EXAMPLES

Existing FMLA Leave of Absence

User: “Show me my existing absences.”

Action:

1. Get the logged-in user’s Person ID.
2. Call AIA_FMLA_ABSENCE_BO_TOOL.getFMLAAbsences using that Person ID.
3. Present the returned absences concisely.

Submit a new FMLA Leave of Absence

User: “I want to submit a leave of absence.”

Action:

1. Ask for Start Date and End Date.
2. Convert the Start Date and End Date to YYYY-MM-DD.
3. Call AIA_FMLA_ABSENCE_BO_TOOL.submitFMLAAbsence.
4. Report the result returned by the tool. </copy>
```

20. Add Tools to your Agent

    > (1) In the **Search by name, description, or code** field type **CIOXXYYY Absence Agent**, where XX is replaced with your user number and YYY is replaced with your initials. <br>
    > (2) Hover over the Tool tile named **CIOXXYYY Absence Deep Link Tool** and a **+** sign will appear.  **Click** the **+** sign.

    ![Add Add Tools to your Agent](images/bo-agent-hcm-image20.jpg)

21. Add Tools to your Agent

    > (1) Hover over the **CIOXXYYY Absence BO Tool, where XX is replaced with your user number and YYY is replaced with your initials, and click the **+** sign.

    ![Add Add Tools to your Agent](images/bo-agent-hcm-image21.jpg)

22. Add More Tools to your Agent

    > (1) In the **Search by name, description, or code** field type **Fetch Logged**. <br>
    > (2) Hover over the Tool tile named **Fetch Logged in user details** and a **+** sign will appear.  **Click** the **+** sign.

    ![Add More Tools to your Agent](images/bo-agent-hcm-image22.jpg)

23. That’s it.  You’ve created your Agent with 3 tools.  One standard tool, one pre-created, and one you just created today.

    > (1) Click the **Create & Close** button on the bottom toolbar.

    ![Create and Close](images/bo-agent-hcm-image23.jpg)

24. There it is

    > (1) Make note of your new Agent.  You may have scroll it will lists agents created by all of today’s attendees.

    ![List of agents](images/bo-agent-hcm-image24.jpg)

25. Congratulations!  ![checkered flag](../gen-images/checkeredflag.jpg)

    > **You've completed this Adventure**. Please close this tab.

### Summary

As you have seen here, AI Agent Studio puts customers in the driver’s seat, helping empower you to design the future of AI in your organizations on top of a bedrock of trust and safety. AI Agent Studio includes a built-in testing environment, validation, and traceability tools to confirm accuracy. Oracle maintains the same data controls at a user level, which means users only see data and/or AI recommendations permitted by their roles.

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
* **Contributors** - The AI Adventure Team (Gus, Sajid, Casey, Stephen, Sohel, Xavier, Charlie, Ray)
* **Last Updated By/Date** - Sajid Saleem/Charlie Moff, September 2026
