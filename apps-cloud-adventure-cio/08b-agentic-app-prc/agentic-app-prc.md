# Create an Agentic App for Procurement using existing Workflow Agents and App specific configurations

## Introduction

AI Agent Studio for Fusion Applications is a comprehensive platform for creating, extending, deploying and managing AI Agents and Agent Teams across the enterprise. Oracle AI Agent Studio delivers easy-to-use tools, including advanced testing, robust validation, and built-in security, that helps Oracle Fusion Applications customers and partners create and manage AI agents. Leveraging the same technology that Oracle uses to create AI agents, Oracle AI Agent Studio enables users to easily extend pre-packaged agents and/or create new agents and then deploy and manage them.

### Objectives

In this activity you will use Oracle Fusion AI Agent Studio to
* Create an Agentic Application
* Define Agentic App sections to display various output formats (eg. graphics)
* Create Drilldown Action

Estimated Time: 10-15 minutes


## Begin Exercise

1. Create Agentic App including Actions and Testing

    ![Adventure Flow – Agent App Command Center](images/agentic-app-prc-image1.jpg)

2. Navigate to AI Agent Studio

    > (1): Click on **Tools**<br>

    > (2): Click on **AI Agent Studio**

    ![Springboard](images/agentic-app-prc-image2.jpg)

3. AI Agent Studio Home Screen

    > (1): Click on the **Expand** Icon.

    ![expand Menu](images/agentic-app-prc-image3.jpg)

4. Navigate to Agentic Applications

    > (1): Click on the **Applications** Icon.

    ![Open Resources](images/agentic-app-prc-image4.jpg)

5. Create a New Agentic Application

    > (1): Click on the **Add** Icon.

    ![Add Application](images/agentic-app-prc-image5.jpg)

6. Create a name and add a description to your agentic app.

    > (1): Enter **CIO XX YYY Agentic App Command Center** as a name.  **XX** is your assigned account for this lab and **YYY*** is your initials.  Copy and paste the name into description. <br>

    > (2): Click on **Create**.

    ![Application Name](images/agentic-app-prc-image6.jpg)

7. Assign an agent to Ask Oracle.

    > (1): Hover your mouse arrow inside the **Ask Oracle** Box. <br>

    > (2): Click on **Assign Custom Agent**. <br>

    > (3): Type in **Ask Oracle** in the search window<br>

    > (4): Select the **Supplier Negotiations Ask Oracle** Agent.

    ![Assign Ask Agent](images/agentic-app-prc-image7.jpg)

8. Assign an agent to Summary.

    > (1): Hover your mouse arrow inside the **Summary** Box. <br>

    > (2): Click on **Assign Custom Agent**. <br>

    > (3): Type in **workload** in the search window<br>

    > (4): Select the **Negotiations Workload Monitor** Agent.

    ![Assign Summary Agent](images/agentic-app-prc-image8.jpg)

9. Format the Agent Section into 2 columns.

    > (1): Click on the **Gear** Icon. <br>

    > (2): Scroll down a little. <br>

    > (3): Click on the 2 equal columns image.

    ![Page Options](images/agentic-app-prc-image9.jpg)

10. Add the Negotiations Award Advisor Agent to the Agentic App.

    > (1): Click on **Add Section**. <br>

    > (2): Type in **award** in the search window<br>

    > (3): Select the **Negotiations Award Advisor** Agent.

    ![Add Section](images/agentic-app-prc-image10.jpg)

11. Rename the New Panel to Negotiations Award Advisor

    ![Rename the New Panel to Negotiations Award Advisor](images/agentic-app-prc-image11.jpg)

12. Rename the New Panel to Negotiations Award Advisor

    > (1): Type **Negotiations Award Advisor** in the text box. <br>

    ![Rename the New Panel to Negotiations Award Advisor](images/agentic-app-prc-image12.jpg)

13. Add the In-Progress Negotiations Monitor Agent to the Agentic App.

    > (1): Click on **Add Section**. <br>

    > (2): Type in **In-** in the search window<br>

    > (3): Select the **In-Progress Negotiations Monitor Agent ** Agent.

    ![Add Another Section](images/agentic-app-prc-image13.jpg)

14. Rename the New Panel to In-Progress Negotiations Monitor

    > (1): Click on the **Pencil** icon.

    ![Edit Panel](images/agentic-app-prc-image14.jpg)

15. Rename the New Panel to In-Progress Negotiations Monitor

    > (1): Type **In-Progress Negotiations Monitor** in the text box. <br>

    > (2): Type on the **Check** icon.

    ![Rename Panel](images/agentic-app-prc-image15.jpg)

16. Add the Supplier Negotiations Ask Oracle Agent to the Agentic App.

    > (1): Scroll down a little<br>

    > (2): Click on **Add Section**. <br>

    > (3): Type in **Ask Oracle** in the search window<br>

    > (4): Select the **Supplier Negotiations Ask Oracle ** Agent.

    ![Add third section](images/agentic-app-prc-image16.jpg)

17. Rename the New Panel to Supplier Negotiations Summary

    > (1): Click on the **Pencil** icon.

    ![Edit Panel](images/agentic-app-prc-image17.jpg)

18. Rename the New Panel to Supplier Negotiations Summary

    > (1): Type **Supplier Negotiations Summary** in the text box.<br>

    > (2): Type on the **Check** icon.

    ![Rename Panel](images/agentic-app-prc-image18.jpg)

19. Configure the Supplier Negotiations Summary Panel to show a stacked bar chart of negotiations by business unit and status.

    ![Configure the Supplier Negotiations Summary Panel](images/agentic-app-prc-image19.jpg)

20. Add Actions to the Agentic App

    > (1): Click on the **XXX*** icon.<br>

    > (2): Click on the **+*** icon to add an action

    ![Create Document Template](images/agentic-app-prc-image20.jpg)

21. Name and configure the Action

    > (1): Type in **navigateToNegotiation** in **Code**, **Display Name**, and **Description**.<br>

    > (2): Click on **Add Step**. <br>

    ![Name and configure the Action](images/agentic-app-prc-image21.jpg)

22. Configure Navigate to App

    > (1): Type in **neg** in the search window<br>

    > (2): Click on **Negotiation Details**.

    ![Action app code](images/agentic-app-prc-image22.jpg)

23. Configure Navigate to App

    ![Configure Navigate to App](images/agentic-app-prc-image23.jpg)

24. Add a PDF Document Template

    > (1): Click on the **XXX*** icon.<br>

    > (2): Click on the **+*** icon to add a Document Template<br>

    > (3): Click on the **PDF*** icon

    ![PDF Template](images/agentic-app-prc-image24.jpg)

25. Configure the PDF Document Template

    > (1): Click the **On*** Button to configure the presentation of this section.<br>

    > (2): Copy and Paste the following into the **What do you want in this section** box

    - Report Title: “Negotiation Summary"
    - Date: (from the dataset)
    - One-line Executive Summary
    - Visual representation of any charts/graphs
    - List of items<br>


    > (3): Enter **Generated detailed, bulleted list where possible** into **Presentation Instructions**.

    ![Template layout](images/agentic-app-prc-image25.jpg)

26. Congratulations!  ![checkered flag](../gen-images/checkeredflag.jpg)

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
* **Last Updated By/Date** - Casey Doody, Sajid Saleem/Charlie Moff, September 2026
