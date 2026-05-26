# Monitor and Evaluate AI Agents

## Evaluate AI Agents before you deploy them, to ensure they are ready for production

### **Introduction**

**Monitoring**: Monitor and gain insights into how your AI agents are performing, and also evaluate the agents for accuracy. You can also track the interactions with your agents, understand real-world usage patterns, identify common errors, and measure overall performance.
<br><br>
**Evaluation**: Evaluate agents before you deploy them, to ensure that they're ready for production. Test your agents for response correctness, response time, and token usage to meet your quality standards. You can also check the quality of answers generated through the document tool to assess how effectively agents utilize the retrieved context from the retrieval-augmented generation (RAG) metrics. After making any changes to your agent, or after a model update, rerun evaluations to confirm that your agent continues to perform as expected. This proactive approach helps you maintain high-quality experiences for your users.

### **Objectives**

In this activity you will use Oracle Fusion AI Agent Studio to evaluate agents before you deploy them
* Create Evaluation for AI Agent
* Run Evaluation to measure AI Agent's performance against key metrics

Estimated Time: 10 minutes

### **Pre-requisite**

![Alert Flat](../gen-images/cautionflagextrasmalltransparent2.png)
As a pre-requisite for this adventure, please download the **Benefits-Evaluation.csv** file to your local desktop as below.
<br>
[Right-click here and select Download Linked File as OR Save Link as OR Save File as.](../05e-agent-evaluation-hcm/files/Benefits-Evaluation.csv)

### **Begin Exercise**

1. In this activity you will create Evaluations for AI Agents and view results of evaluation runs.

    ![AI Agent Team](../05e-agent-evaluation-hcm/images/agent-evaluation-hcm-image001.jpg)

2. To begin, you will navigate to the Monitoring and Evaluation tab within the AI Agent Studio.

    > (1) Click on the **Monitoring and Evaluation** tab <br>

    ![Go to Monitoring and Evaluations](../05e-agent-evaluation-hcm/images/agent-evaluation-hcm-image002.jpg)

3. The Monitoring and Evaluation page shows existing runs.  You'll go to Manage Evaluations to setup a new one.

    > (1) Click on the **Manage Evaluations** button <br>

    ![Manage Evaluations](../05e-agent-evaluation-hcm/images/agent-evaluation-hcm-image003.jpg)

4. Create a new Evalution.

    > (1) Click the ![Plus Icon](../gen-images/plusicon.jpg) icon to create a new Evaluation <br>

    ![Create New Evaluation](../05e-agent-evaluation-hcm/images/agent-evaluation-hcm-image004.jpg)

5. You can define the information, including questions.  To simplify the question creation, you can use the pre-defined list of questions (CSV file) that is available for download in the Pre-Requisites section at the top of the lab.

    > (1) Enter the fields as described below:
     * Name: **CIOXX Benefits Agent Evaluation** where **XX** is replaced with your user number.<br>
     * Agent Team: Select **CIOXX Benefits Agent Team** from the dropdown, where **XX** is replaced with your user number. <br>
     * Description:  **CIOXX Benefits Agent Evaluation**<br>

    > (2) Select **Random** radio button under Run Mode.<br>

    > (3) Click the **Add from File** button ![Create Button](../gen-images/add_from_file.png).


    ![Enter Evaluation Data](../05e-agent-evaluation-hcm/images/agent-evaluation-hcm-image005.jpg)

6. For this step, you'll upload the pre-defined file with the list of questions.<br>

    ![Alert flag](../gen-images/cautionflagextrasmalltransparent2.png) As a pre-requisite for this step, please download **Benefits-Evaluation.csv** file to your local desktop if you have not already done so as below.<br>

    [Right-click here and select Download Linked File as OR Save Link as OR Save File as.](../05e-agent-evaluation-hcm/files/Benefits-Evaluation.csv)

    > (1) then select the file (Benefits Evaluation.csv) from your **Downloads** folder on your PC/Mac and click the **Open** button.<br>

    ![Load Questions File](../05e-agent-evaluation-hcm/images/agent-evaluation-hcm-image006.jpg)

7. You can see that the questions are now visible. You can optionally scroll down to see all the questions. Next, you'll work on the Metrics.

    > (1) Click the **Metrics** tab. <br>

    ![Navigate to Metrics tab](../05e-agent-evaluation-hcm/images/agent-evaluation-hcm-image007.jpg)

8. This shows the lists of Metrics available for this evaluation.

    > (1) **Review** the list of available metrics.  Note that you could use the Edit icon in the Actions column to make modifications.  This allows you to determine which metrics to include in the evaluation, whether threshold is enabled, and the condition of the threshold.  You'll use the defaults, so you won't make any edits.  <br>
    > (2) Click the Create button.  ![Create button](../gen-images/createw.jpg)

    ![Review and Create](../05e-agent-evaluation-hcm/images/agent-evaluation-hcm-image008.jpg)

9. Now that the Evaluation is defined, it's time to initiate a run.

    > (1) Click the icon ![dotdotdot button](../gen-images/dotdotdot.png) in the Actions column for the evaluation record you created (eg. **CIOXX Benefits Agent Evaluation** where **XX** is replaced with your user number) and select **Initiate Evaluation Run** from the resulting dropdown.

    ![Initiate Evaluation](../05e-agent-evaluation-hcm/images/agent-evaluation-hcm-image009.jpg)

10. The panel on the right side of the screen displays details about your evaluation run.

    > (1) Click the **Run** button ![run button](../gen-images/run_button.png).

    ![Run Evaluation](../05e-agent-evaluation-hcm/images/agent-evaluation-hcm-image010.jpg)

11. Now it's time to review the status and results of your evaluation run.

    > (1) Click the icon ![dotdotdot button](../gen-images/dotdotdot.png) in the Actions column for the evaluation record you created (eg. **CIOXX Benefits Agent Evaluation** where **XX** is replaced with your user number) and select **View Evaluation Runs** from the resulting dropdown.

    ![View Evaluation Run](../05e-agent-evaluation-hcm/images/agent-evaluation-hcm-image011.jpg)

12. The Evaluation Run screen shows the current Status.

    > (1) Click the **Refresh** button ![Refresh button](../gen-images/refresh_button.png).  If necessary, you can wait couple of minutes or repeat the refresh until the Status shows **Completed**.

    ![Refresh while awaiting completion](../05e-agent-evaluation-hcm/images/agent-evaluation-hcm-image012.jpg)

13. Now that the Evaluation Run is complete, it's time to view the results

    > (1) Click the icon ![dotdotdot button](../gen-images/dotdotdot.png) in the Actions column for the evaluation record you created (eg. **CIOXX Benefits Agent Evaluation** where **XX** is replaced with your user number) and select **View Run Results** from the resulting dropdown.

    ![View Evaluation Run](../05e-agent-evaluation-hcm/images/agent-evaluation-hcm-image013.jpg)

14. The Response performance screen can show a lot of information.  The first thing you'll do is resize the rows/columns to better show the data.

    > (1) **Right Click** on one of the row numbers and select **Resize to Fit** from the resulting dropdown.  You only need to do this for one row as it will resize the entire table. Repeat step if necessary.

    ![Resize table](../05e-agent-evaluation-hcm/images/agent-evaluation-hcm-image014.jpg)

15. You can see the expected and actual response. In addition, you have metrics related to Latency, Token Usage and Errors. If metrics do not meet the thresholds, they will be highlighted in Red.  Let's drill into a specific result for more details.

    > (1) Click the **URL** in the **Trace** column for **Row 4 (Are there FMLA benefits)**.

    ![View Trace](../05e-agent-evaluation-hcm/images/agent-evaluation-hcm-image015.jpg)

16. The Trace steps are color coded.  See the Legend above the table results.  Let's view the details of the F1 FMLA Absence Agent.

    > (1) Click the **Worker Agent** bar in the **F1 FMLA Absence Agent** row.

    ![View Agent Trace](../05e-agent-evaluation-hcm/images/agent-evaluation-hcm-image016.jpg)

17. The right side panel appears and displays Trace details of the Agent.  You can review detailed metrics of this specific step, including inputs and outputs.

    > (1) You can review detailed metrics of this specific step, including inputs and outputs.  Note additional tabs for **Prompt** and **Memory**. </br>
    > (2) When finished with your review, you can close the panel by clicking the icon ![dotdotdot button](../gen-images/dotdotdot.png) and selecting **Close** from the resulting dropdown.

    ![Review and Close Trace](../05e-agent-evaluation-hcm/images/agent-evaluation-hcm-image017.jpg)

18. You can review similar details for other steps within the Evaluation Trace, including LLM calls, Business Object calls, and other Tools used by your agent.  Close this page so you can return to your Evaluation Run screen.

    > (1) Click the **Cancel** button ![cancel button](../gen-images/cancel_button_brown.png).

    ![Review and Close Trace](../05e-agent-evaluation-hcm/images/agent-evaluation-hcm-image018.jpg)

19. Next, you can review Correctness results and complete this Adventure.

    > (1) Click the **Correctness** tab.  This tab shows correctness scores and LLM feedback for your various evaluation run questions.<br>
    > (2) Click the **Cancel** button ![cancel button](../gen-images/cancel_button_brown.png).

    ![Review and Close Trace](../05e-agent-evaluation-hcm/images/agent-evaluation-hcm-image019.jpg)

20. Adventure awaits, click on the image, show what you know and rise to the top of the leader board!!!

    [![Cloud Adventure](../gen-images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:LOGIN_TEAM:::::CC:CIOADVENTURE)

### Summary

**You have successfully completed the Activity!**

### Learn More

* [AI Agent Studio Solution Brief](https://www.oracle.com/a/ocom/docs/applications/fusion-apps-ai-agent-studio-solution-brochure.pdf)
* [AI Agents for Fusion Applications](https://www.oracle.com/applications/fusion-ai/ai-agents/)
* [Monitor and Evaluate AI Agents](https://docs.oracle.com/en/cloud/saas/fusion-ai/aiaas/monitor-and-evaluate-ai-agents.html)
* [AI for Fusion Applications](https://www.oracle.com/applications/fusion-ai/)
* [Oracle Documentation](http://docs.oracle.com)

## Acknowledgements

* **Author** - Charlie Moff, Distinguished SaaS Cloud Technologist; Sajid Saleem, Master Principal SaaS Cloud Technologist
* **Contributors** - The AI Adventure Team (Gus, Kris, Sajid, Casey, Stephen, Jamil, Sohel, Xavier, Nate, Charlie)
* **Last Updated By/Date** - Charlie Moff; Sajid Saleem, March 2026