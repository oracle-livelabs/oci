# Exploring a pre-built agent team

## Introduction

In this lab we will copy an existing agent template and get an understanding of the various components and the prompts that instruct the large language model (LLM) how to execute the agent team.

Estimated Time: 15 minutes

### Objectives

Understand the structure of a pre-built agent template and agent tools in AI Agent Studio

### Usage Notes

   [](include:initial_hints)

## Task 1: Locate and copy the pre-existing Purchase Requisition Status Advisor agent template

1. First you will log in and navigate to AI Agent Studio.

   > Login to the lab environment using the credentials provided. Make sure to use your assigned user.
   </br>

2. Next you will locate and copy the Purchase Requisition Status Advisor agent template.

3. Go to the **Tools** tab and Click on the tile for **AI Agent Studio**:

   ![Application Home](images/image001.png " ")

4. Search for **requisition** in the search box:

   ![Template Search](images/image003.png " ")

5. Click on **Copy Template** for the Purchase Requisition Status Advisor.<br/>

   If you do not see **Copy Template**, click on the 3 dots in the bottom right corner of the Purchase Requisition Status Advisor box.<br/>

   >![Caution](images/caution.png =50x*)  ***IMPORTANT!*** <br/>
   > ***DO NOT CLICK*** on **Use Template**<br/>
   > **DO CLICK** on **Copy Template**.

   ![Copy Template](images/image005.png " ")

6. In the Agent Team Suffix box, enter ***YOUR INITIAL CODE***.<br/>

   Click on the **Continue** button.<br/>
   If you get a message that a component with that name already exists, make sure you are using a unique code.  Add a number if required.  Just be sure to use that code throughout the rest of the lab.

   ![Copy Template Suffix](images/image007.png " ")

7. Next you will save your agent team copy and ensure that you can locate it.

   Click the **Save and Close** button in the top right of the screen:

   ![Agent Team save and close](images/image008.png " ")

8. On the tab bar on the bottom of the screen, Click on **Agent Teams**:

   ![Agent Teams tab](images/image009.png " ")

9. Enter ***YOUR INITIAL CODE*** in the search box and hit **ENTER**:

   ![Agent Teams search](images/image010.png " ")

10. Select the **DRAFT** button (your agent team will be in draft status).  You should see your newly-created agent team:

   ![Agent Teams search result](images/image011.png " ")

   >![Check](images/check.png =90x*) ***STATUS CHECKPOINT*** <br/>
   > If you do not see your agent team, return to step 2 [above](#task1locateandcopythepreexistingpurchaserequisitionstatusadvisoragent)

   **You have successfully completed Task 1!**

## Task 2: Examine the pre-built Purchase Requisition Status Advisor Agent template components

1. Open your copy of the Purchase Requisition Status Advisor Agent Team template.

   Click on the pencil icon to open your newly created agent team:

   ![open agent team](images/image012.png " ")

2. Let's take a closer look at the components of the Purchase Requisition Status Advisor Agent Team template.

   Notice that this agent consists of 3 tools and 1 topic:

   ![agent team tool count](images/image013.png " ")

3. Expand the Tools box to expose the 3 included tools:

   ![agent team tool expand](images/image014.png " ")

4. Hover on the first tool (Purchase Requisition Detail), click on the 3 dots in the corner, then select **View Details**:

   ![agent BO tool more details](images/image015.png " ")

5. Notice that this tool retrieves data from the Purchase Requisitions Business Object.  Notice the multiple functions that allow searches by different parameters, as well as functions to create new purchase requisitions:

   ![agent BO tool functions](images/image016.png " ")

6. Click on the **X** on the upper right to close this tool.<br/><br/ >
7. Hover on the second tool (View Purchase Requisition Details Deep Link), click on the 3 dots in the corner, then select **View Details**:

   ![agent deep link tool functions](images/image017.png " ")

8. Notice that this tool provides a deep link to allow the user to navigate directly to a specific purchase requisition in the application.<br/><br/>
   Click on the **X** in the upper right corner to close this tool.<br/><br/>
9. Expand the Topics box to expose the included topic.<br/>
   Hover on the Purchase Requisition Status topic, click on the 3 dots in the corner, then select **View Details**:

   ![agent topic view details](images/image018.png " ")

10. Topics provide a reusable prompt – basically a set of instructions to the Large Language Model (LLM).  Pre-built topics provide a best-practices example of an LLM prompt:

   ![agent topic dialog](images/image019.png " ")

11. Click on the **X** in the upper right corner to close the topic.<br/><br/>
12. Finally, hover on the Agent header, click on the 3 dots in the corner, then select **View Details**:

   ![agent header details](images/image020.png " ")

13. Notice the pre-built prompt.  Unlike the prompt provided in the topic, this prompt is specific to this agent.  Agent prompts and topics are combined to provide instructions to the LLM:

   ![agent header details tab](images/image021.png " ")

14. Select the **LLM** tab.  Review the Summarization prompt.<br/>
    Worker agents provide a default summarization prompt to provide a simple answer to the user.  This summarization can be modified if specific instructions or output format is desired:

   ![agent header LLM tab](images/image022.png " ")

15. Click on the **X** in the upper right corner to close the Worker Agent Summary.<br/><br/>
16. Click on **Save and Close** button saving your copy of the Purchase Requisition Status Advisor agent:

   ![agent header save and close](images/image023.png " ")

   **You have successfully completed Module 1!**

   
## Summary

You should now have a basic understanding of the tools and prompts provided by the pre-built Purchase Requisition Status Advisor agent template.<br/>
In the next lab we will create a custom agent to expand the capabilities of this agent team.

[Proceed to the next lab](#next)

## Acknowledgements
* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)