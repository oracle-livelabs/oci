# Analytics

## **Analytics AI for Margin Analysis**

### **Introduction**

Oracle Fusion AI Data Platform (FDI) is a family of prebuilt, cloud native analytics for Oracle Cloud Applications that provides line-of-business users with ready-to-use insights to improve decision-making.

It is a Cloud application that delivers best-practice Key Performance Indicators (KPIs) and deep analyses to help decision-makers run their businesses and individual contributors to operate their businesses. Oracle Fusion AI Data Platform is built on top of Oracle Analytics Cloud and Oracle Autonomous Data Warehouse. This packaged service starts with Oracle Fusion Cloud Applications which you can deploy rapidly, personalize, and extend. The service extracts data from your Oracle Fusion Cloud Applications and loads it into an instance of Oracle Autonomous Data Warehouse. Business users can then create and customize dashboards in Oracle Analytics Cloud. It empowers business users with industry-leading, AI-powered, self-service analytics capabilities for data preparation, visualization, enterprise reporting, augmented analysis, and natural language processing.

This activity guide helps business users to investigate and research data, ask relevant questions to understand Trends, Patterns and Outliers.

### **Objectives**

Use machine learning and natural language conversational AI to analyze margin variance and identify the root cause.

Estimated Time: 15 minutes

### **Pre-requisite**

****Please Note**** For this adventure, we will do few steps using AI chat and prompts. To streamline typing and eliminate any typing errors, the prompts are shown in-line in the guide below and are also available in the Prompt-CrossFunctional-Analysis.txt.
<br><br>
![Alert Flat](../gen-images/cautionflagextrasmalltransparent2.png)
As a pre-requisite for this adventure, please download following file to your local desktop

1. Prompt file for the Analytics AI Agent **(Prompt-CrossFunctional-Analysis.txt)**
<br>
[Right-click here and select Download Linked File as OR Save Link as OR Save File as.](../09-analytics-with-ai/files/Prompt-CrossFunctional-Analysis.txt)

### **Begin Exercise**

1. This activity guide helps business users to investigate and research data, ask relevant questions to understand Trends, Patterns and Outliers.

    ![Analytics OBJs](../09-analytics-with-ai/images/analytics-with-ai-image001.jpg)

2. Oracle Fusion AI Data Platform is a family of prebuilt, cloud-native analytics applications for Oracle Cloud Applications that provide line-of-business users with ready-to-use insights to improve decision-making.

    > (1) Click on the **‘Analytics’** tab. <br>

    > (2) Click on **Fusion AI Data Platform** icon. <br>

    ![Home Screen](../09-analytics-with-ai/images/analytics-with-ai-image002.jpg)

3.  You can now login to Analytics with your assigned username and password.  Customers will typically leverage single sign-on capabilities to eliminate this step during implementation.

    > (1) Type your assigned username <br>
    > (2) Type the Fusion Analytics Password (this can be copied from the AI Adventure start page) <br>
    > (3) Click the **Sign In**  ![Plus create button](../gen-images/sign_in_button.png) button

    ![Sign-in Screen](../09-analytics-with-ai/images/analytics-with-ai-image003.jpg)

4. After a successful login, you will land on the Oracle Analytics home page.  From the home page, you can review key business metrics and trends.

    > (1) Hover over the tiles to see additional information.
    ![Caution Flag](../gen-images/cautionflagextrasmalltransparent2.png) **Notice** that Margin has been going down and need to investigate the reason. Two attributes that influence Margin are Revenue and Cost. Since revenue seems to be increasing, let's investigate Cost.

    ![Analytics Home](../09-analytics-with-ai/images/analytics-with-ai-image004.jpg)

5. To further investigate costs, you caņ use the Universal Search feature at the top of the screen.  This search facilitates both data and object search.

    > (1) Within the Search box, type in **show me expenses by quarter** and press **SHIFT + ENTER** keys or select click the **Press SHIFT+ENTER or click ti visualize data using "show me expenses by quarter" from the resulting dropdown.

    ![Search for Info](../09-analytics-with-ai/images/analytics-with-ai-image005.jpg)

6. The search function uses AI capability to scan through your datasets and brings back information as requested. In addition to building a visual it also creates a narrative.  You will now start exploring the content.

    > (1) Click on the **Explore as Workbook** ![Expore as Workbook](../gen-images/explore_as_workbook.png) icon as highlighted in red to open the analysis in edit mode.

    ![Explore as Workbook](../09-analytics-with-ai/images/analytics-with-ai-image006.jpg)

7. In this step, you can familiarize yourself with the the environment, features and components of the New Workbook page.

    > (Blue) The Blue Box on the left is the data panel. This is where you will see all datasets. <br>

    > (Yellow) The Yellow box in the middle is the grammar pane which has all finer visualization properties. <br>

    > (Orange) The Orange panel on the right is the canvas used to build dashboards. <br>

    > (Green) The green boxes have menus to carry out various functions.

    ![Review components of page](../09-analytics-with-ai/images/analytics-with-ai-image007.jpg)

8. You can see that there is a consistent upward trend for the last three quarters and would like to determine if this will continue in the future as well.  To understand this trend, you can use built-in forecasting features.

    > (1) **Highlight** a data point on the line graph and **Right Click**. <br>

    > (2) Select **Add Statistics** from the resulting dropdown list. <br>

    > (3) Select **Forecast** from the resulting list of options.

    ![Forecast](../09-analytics-with-ai/images/analytics-with-ai-image008.jpg)

9. The resulting forecast shows that the upward trend is going to continue for some time, hence it is important that we understand the root cause of this increase.

    > (1) Note the general upward trend of the forecast.

    ![forecast trends up](../09-analytics-with-ai/images/analytics-with-ai-image009.jpg)

10. You can now investigate the various aspects of cost to understand the drivers contributing to the increase. On the top right-hand corner, locate the AI icon which looks like stardust. This opens the AI panel which consist of Watchlists, Insights as well as Chat Assistant.

    > (1) Click on the **AI Icon** ![Caution Flag](../gen-images/ai_icon.jpg) in the top toolbar. <br>

    ![AI Icon](../09-analytics-with-ai/images/analytics-with-ai-image010.jpg)

11. You can use chat to build out your content.

    > (1) Click on the **Assistant** tab. <br>

    ![AI Assistant](../09-analytics-with-ai/images/analytics-with-ai-image011.jpg)

12. You know expenses are trending higher and the forecast suggests that they will stay high. So, you want to break down expenses and look at the next level to hopefully see which expense categories are causing the increase.

     ![Caution Flag](../gen-images/cautionflagextrasmalltransparent2.png) **Please Note** that the following interactions leverage AI chat and prompts.  The prompts are shown in-line below, but are also available in the Prompt-CrossFunctional-Analysis.txt document.  [Right-click here and select Download Linked File as OR Save Link as OR Save File as.](../09-analytics-with-ai/files/Prompt-CrossFunctional-Analysis.txt)

    > (1) Copy and paste **show me expense by expense categories** into the chat, as shown.

    ![Show me expenses](../09-analytics-with-ai/images/analytics-with-ai-image012.jpg)

13. Chat assistant scans the dataset and creates a graph with relevant information.  You can organize the graph for better readability.

    > (1) Copy and paste **Change to horizontal bar and sort high to low** into the chat.

    ![horizontal bar](../09-analytics-with-ai/images/analytics-with-ai-image013.jpg)

14. You think that looks good and decide to add it to the canvas.

    > (1) Hover over the chart area to expose the submenu and then **click** the  ![Caution Flag](../gen-images/plusicon.jpg) icon to add the graph to the canvas <br>

    ![Add to canvas](../09-analytics-with-ai/images/analytics-with-ai-image014.jpg)

15. Your new chart, Expenses by Expense Categories, has been added to the canvas.

    > (1) No actions required here.  Just confirm the addition of the new chart **Expenses by Expense Categories** to the left of the AI Assistant.  Also note that the AI Assistant sliding window is still available and waiting further interaction.

    ![Review Canvas](../09-analytics-with-ai/images/analytics-with-ai-image015.jpg)

16. You can see the details about expenses, including which categories are causing it to increase. The Payroll expense is the highest and needs investigation.  Payroll details are part of HCM dataset, but that's not a issue as Analytics has access to all Fusion SaaS Application data and external data if necessary.  You will use the **Chat Assistant** to keep building analysis. This time we will ask a complex question asking to fetch related data from different data store

    > (1) Copy and paste **show me similar information from HCM - Core Transactions data** into the chat.

    ![Add HCM Data](../09-analytics-with-ai/images/analytics-with-ai-image016.jpg)

17. You can see the response, but prefer another format.

    > (1) Copy and paste **change to vertical bar** into the chat.

    ![Vertical Bar](../09-analytics-with-ai/images/analytics-with-ai-image017.jpg)


18. The format looks better, but You need a little more information to better understand the trend, so you decide to add a time period.

    > (1) Copy and paste **Add month from HCM - Core Transactions data** into the chat.

    ![Add Month](../09-analytics-with-ai/images/analytics-with-ai-image018.jpg)

19. Your new graph looks like this. That's the data you'd like to see, but feel it would be better in a more readable format.

    > (1) Copy and paste **Change to a Stacked Bar** into the AI Assistant chat.

    ![Stacked Bar](../09-analytics-with-ai/images/analytics-with-ai-image019.jpg)

20. You think that's better, but realize it needs to be sorted by month to better understand any chronological trends.

    > (1) Copy and paste **Sort month low to high** into the chat.

    ![change sort](../09-analytics-with-ai/images/analytics-with-ai-image020.jpg)

21. This visual provides the information you are looking for, so you decide to add iţ to the canvas.

    > (1) Hover over the chart area to expose the submenu and then **click** the  ![Plus icon](../gen-images/plusicon.jpg) icon to add the graph to the canvas <br>

    ![Add to canvas](../09-analytics-with-ai/images/analytics-with-ai-image021.jpg)

22. You decide to focus on the information on the canvas and close the Assistant for now.

    > (1) **Click** the  ![X Icon](../gen-images/icon011_x.png) icon to the right of the **Assistant** tab to close it.<br>

    ![Close AI Assistant](../09-analytics-with-ai/images/analytics-with-ai-image022.jpg)

23. On the main canvas you will now see the entire dashboard. You want to add legend to the Stacked Bar

    > (1) Select the Stacked Bar and while it is in highlighted, please click on the Tuner icon  ![AI Tuner Icon](../gen-images/ai_tuner_icon.png) as shown in the image<br>

    ![Tuner Icon](../09-analytics-with-ai/images/analytics-with-ai-image023.jpg)

24. You decide to add the Legend to the bottom of the graph.

    > (1) Find the **Legend Position** int he list of available options, as shown. <br>
    > (2) Select the **Legend Position**. <br>
    > (3) Select **Bottom** from the resulting dropdown.

    ![Change Legend](../09-analytics-with-ai/images/analytics-with-ai-image024.jpg)

25. Deeper analysis shows that while Base Salaries & Wages has been high, it is also constant. What has increased in the last few quarters is the overtime and the contract labor .

    > You conclude that the current canvas property clarifies your concern.  Increasing expenses seem to be a continuing trend and, within your largest expense category of Payroll Expenses, Contract Labor has been consistently increasing and likely needs further investigate.

    ![Note Results](../09-analytics-with-ai/images/analytics-with-ai-image025.jpg)

23. Adventure awaits, click on the image and show what you know, and rise to the t
op of the leader board!!!

    [![Cloud Adventure](../gen-images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:LOGIN_TEAM:::::CC:CIOADVENTURE)

### Summary

You discovered how effortlessly Fusion AI Data Platform enables the creation of content and analysis of data. By integrating diverse data sources, you were able to delve deeper from summary information to detailed analysis, uncovering root causes by leveraging AI Insights. You then shared your discoveries with a broader audience, making the insights accessible and impactful.

**You have successfully completed the Activity!**

### Learn More

* [Get Started with Oracle Fusion AI Data Platform](https://docs.oracle.com/en/cloud/saas/analytics/25r4/index.html)
* [Fusion AI Data Platform](https://www.oracle.com/fusion-ai-data-platform/)
* [Oracle Documentation](https://docs.oracle.com)

## Acknowledgements

* **Author** - Sohel Jeelani, Distinguished Analytics Solution Engineer, Advanced Technology Services
* **Contributors** - The Cloud Adventure Team (Gus, Kris, Sajid, Casey, Stephen, Jamil, Sohel, Xavier, Nate, Charlie)
* **Last Updated By/Date** - Charlie Moff, Sajid Saleem; May 2026