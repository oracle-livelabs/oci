# Audit

## Introduction

AI Agent Studio is a design-time environment that empowers you to create, configure, validate, and deploy GenAI features and AI agents to meet your organization's needs. With AI Agent Studio, you can easily extend pre-configured agent templates, and even build new agents and multi-agent workflows from scratch. AI Agent Studio is fully integrated into Fusion Applications, providing secure and seamless access to the knowledge stores, tools, and APIs of Fusion Applications. This integration enables agents to be deployed directly into the workflow, ensuring an efficient process.

### **Objectives**

In this activity you will use Oracle Fusion AI Agent Studio to
•	Create a Document Tool to ingest company-specific procurement policy documents (PDF) 
•	Create an Agent that uses the Document Tool to respond to user queries
•	Create and assemble an Agent team that includes the created Agent and purchase requisition action agent.
•	Test the Agent team 


## Create Agents and an Agent Team using AI Agent Studio

1. In this activity you will learn the power and ease building Agentic AI with the Oracle AI Agent Studio 

    ![AI RAG Obectives](images/extendwithairag.jpg)

2. The first step is to navigate to AI Agent Studio. 

    > (1) Click on the **Tools** tab

    > (2) Select the **AI Agent Studio** tile

    ![Navigate to AI Agent Studio](images/poaimage002.jpg)

3. Next, we're going to create a Tool

    > Click the ![Tools](images/tools.jpg) icon at the bottom of the page

    ![Open tools](images/poaimage003.jpg)


4. Tool Creation

    > Click the ![add tool](images/plusadd.jpg) button to create a new tool

    ![Create Tool](images/poaimage004.jpg)

5. Here, you will define your first Tool, a Document Tool.  This will allow the Agent to use the content of the documents to respond to user questions.

    > (1) Enter the following fields:
      - **Tool Type**: select **Document** from the dropdown<br>
      - **Tool Name**: Enter **CIO## Procurement Policy Document Tool**, where **##** is replaced with your user number.<br>
      - **Family**: select **PRC** from the dropdown<br>
      - **Product**: select **Self Service Procurement** from the dropdown<br>
      - **Description**: Enter **Cloud Adventure Procurement Policy Document Tool** <br>

    > (2) Click the ![Add button](images/addw.jpg) button under **Documents**
    
    ![Edit Suppliers View](images/poaimage005.jpg)


6. **Note:** Now we’ll add the documents to our tool.  The documents you will add are located in the **Procurement Documents** folder on your laptop's Desktop.

    > (1) Enter the following fields:
      - **Name**: Enter **Procurement Policy Documents** <br>
      - **Status**: Select **Ready to publish** from the dropown<br>
      - **Description**: Enter **Procurement Policy Documents**<br>
    (2) Click on the ![Drag and Drop](images/dandd.jpg) region <br>
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

    > Click the  **Agents** icon [Agent Image](images/agenticon.jpg) at the bottom of the page.

    ![Get an audit report](images/poaimage009.jpg)


10. Here, you can see any existing agents.  But you want to create a new one.

    > Click the  **+ Add** button [Add Button Image](images/addw.jpg).

    ![Get an audit report](images/poaimage010.jpg)









    [![Cloud Adventure](images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:LOGIN_TEAM:::::CC:CIOADVENTURE)






## Summary

As you have seen, the Oracle SaaS applications may be configured to capture who updates select fields, when the update was performed, the previous value and the updated value. Having this level of auditing serves a critical role in providing governance and controls over your enterprise applications. As an administrator, you will implement the controls your company chooses to enforce. The combination of fine grained applications security and application data audit provide the end to end controls you will need.

This Cloud Adventure also featured the importance of having open REST interfaces for accessing and sharing data with external systems. In the case of audit data, you may want to send this data to a SIEM or data warehouse for analysis.

**You have successfully completed the Activity!**

* [Oracle Supply Chain & Manufacturing - APIs & Schema](https://docs.oracle.com/en/cloud/saas/supply-chain-and-manufacturing/24b/api.html)
* [Set Up Auditing for Oracle Fusion Applications](https://docs.oracle.com/en/cloud/saas/applications-common/24d/facia/set-up-auditing-for-oracle-fusion-applications.html)
* [Oracle Documentation](http://docs.oracle.com)O

## Acknowledgements
* **Author** - Jamil Orfali, Senior Cloud Technologist, Advanced Technology Services; Kris Holmgren, Senior Cloud Technologist, Advanced Technology Services.
* **Contributors** -
* **Last Updated By/Date** - Jamil Orfali, April 2025
