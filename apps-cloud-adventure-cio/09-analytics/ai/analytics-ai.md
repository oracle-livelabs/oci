# Analytics: Use AI for Margin Analysis

## Introduction

Oracle Fusion Data Intelligence (FDI) is a family of prebuilt, cloud native analytics for Oracle Cloud Applications that provides line-of-business users with ready-to-use insights to improve decision-making.

It is a Cloud application that delivers best-practice Key Performance Indicators (KPIs) and deep analyses to help decision-makers run their businesses and individual contributors to operate their businesses. Oracle Fusion Data Intelligence is built on top of Oracle Analytics Cloud and Oracle Autonomous Data Warehouse. This packaged service starts with Oracle Fusion Cloud Applications which you can deploy rapidly, personalize, and extend. The service extracts data from your Oracle Fusion Cloud Applications and loads it into an instance of Oracle Autonomous Data Warehouse. Business users can then create and customize dashboards in Oracle Analytics Cloud. It empowers business users with industry-leading, AI-powered, self-service analytics capabilities for data preparation, visualization, enterprise reporting, augmented analysis, and natural language processing.

This activity guide helps business users to investigate and research data, ask relevant questions to understand Trends, Patterns and Outliers.

### Objectives

Use machine learning and natural language conversational AI to analyze margin variance and identify the root cause.

Estimated Time: 15 minutes

## Predefined Copy Blocks
****Please Note**** For this adventure, we will do few steps using AI chat and prompts. To streamline typing and eliminate any typing errors, the prompts are shown in-line in the guide below and are also available in the following copy blocks.
**Prompt 1**:
```
<copy>
 Show me expense trend by quarter
 </copy>
```
**Prompt 2**:
```
<copy>
 Show me expenses by expense categories
 </copy>
```
**Prompt 3**:
```
<copy>
Change to horizontal bar and sort high to low
 </copy>
```
**Prompt 4**:
```
<copy>
 Show me similar information from HCM
</copy>
```
## Begin Exercise

1. Create Cross-Functional Analytics for Business Insights

    ![Analytics Flow](images/analytics-with-ai-image1.jpg)

2. On the landing page, we observe that Margin has been declining and require investigation. Two key drivers influencing Margin are Revenue and Cost. Because Revenue shows an upward trend, our focus shifts to investigating Cost.

    > (1) Hover over the tiles to see details. You can also expand them.

    ![FDI home page observe Margin](images/analytics-with-ai-image2.jpg)

3. The search function leverages AI capabilities to scan your datasets and retrieve the requested information.

    > (1) Enter **show me expense trend by quarter** into the search window and hit **enter** on your laptop.

    ![FDI home page enter prompt](images/analytics-with-ai-image3.jpg)

4. We will now start exploring the content to analyze various cost components using built-in platform AI capabilities to uncover the factors driving the increase

    > (1) Click on the **explore as workbook** icon as highlighted in red to open the analysis in edit mode.

    ![Prompt results page](images/analytics-with-ai-image4.jpg)

5. On the top right-hand corner, locate the AI icon which looks like stardust. This opens the AI panel which consist of Watchlists, Insights as well as Chat Assistant.

    > (1) Click on the **Auto Insights** icon.

    ![New Workbook](images/analytics-with-ai-image5.jpg)

6. We will use the AI Assistant to build our content.

    > (1) Click on the **Assistant** tab to start the chat. <br>

    > (2) Click on the **Maximize** icon to expand the chat.

    ![AI Assistant 1](images/analytics-with-ai-image6.jpg)

7. We know expenses are trending higher and the forecast suggests that they will stay high. So, let’s break down expenses and look at the next level. Which expense categories are causing the increase.

    > (1) Enter **show me expense by expense categories** in the chat and hit **enter** on your laptop.


    ![AI Assistant 2](images/analytics-with-ai-image7.jpg)

8. The chat assistant scans the dataset and creates a graph with relevant information.  Looks like Payroll expenses are trending high than the others and contributing to decreasing margins. Let’s organize the graph for better readability.

    > (1) Enter **Change to horizontal bar and sort high to low** in the chat and hit **enter** on your laptop.

    ![Bar chat of Total Expenses by Expense Category](images/analytics-with-ai-image8.jpg)

9. We can see the details about expenses, namely, which categories are causing it to increase.   It is **Payroll expenses** which is the highest and needs investigation.  Payroll details are part of HCM dataset

    We will use Chat assistant to keep building analysis. This time we will ask a complex question asking to fetch related data from different data store

    > (1) Enter **Show me similar information from HCM** in the chat and hit **enter** on your laptop.

    ![Horizontal Bar chat of Total Expenses by Expense Category](images/analytics-with-ai-image9.jpg)

10. The information presented is from Human Resources, which is from a different line of business, but it was very easy to co-relate. The account under Payroll expense category that is creating the most expense is Contract labor Why are we paying so much for contract resources?

    > (1) Click on the **back arrow** to go back to the landing page

    ![Horizontal Bar chat of additional HCM Expenses.](images/analytics-with-ai-image10.jpg)

11. Lets return to the main page

    > (1) Click on the **back arrow** to go back to the landing page

    ![Save changes screen](images/analytics-with-ai-image11.jpg)

12. Let’s also delete the previous analysis

    > (1) Click on the **Delete Results** Icon to close the analysis.

    ![delete previous analysis](images/analytics-with-ai-image12.jpg)

13. On the Home Page, locate the prebuilt Dashboard called HCM Talent Acquisition

    > (1) Click on the **HCM Talent Acquisitions** to open the dashboard

    ![FDI Home Screen access HCM Talent Acquisitions Dashboard](images/analytics-with-ai-image13.jpg)

14. All important metrics related to HR are shown here.  They provide us with a clue as to why Contract Labor is high. The time to fill attribute is three times the goal, indicating we are not able to source candidates.

    > (1) Click on the **Back Arrow** to exit the dashboard

    ![HCM Talent Acquisition Dashboard](images/analytics-with-ai-image14.jpg)

15. FDI has a critical component called **Data Flow** that provides ability to mashup data from external sources like LinkedIn and Glassdoor. The first steps is to connect to a data file that is stored in Object Storage

    > (1) Click on the **External_Candidate_Profile_DF-xxxxx*.

    ![FDI Home Screen access external data set](images/analytics-with-ai-image15.jpg)

16. Now we will run the Data Flow to generate new Data File.

    > (1) Click on the **Run Data Flow** icon.

    ![External Data Source 1](images/analytics-with-ai-image16.jpg)

17. We can work on other tasks while the data flow is running in the back ground.

    > (1) Click on the **Back Arrow** icon to navigate back to the home screen.

    ![External Data Source 2](images/analytics-with-ai-image17.jpg)

18. Create a new workbook

    > (1) Click on the **Create** button in the upper right corner.

    > (2) Click on **Workbook**.

    ![FDI Home Screen Create a new workbook](images/analytics-with-ai-image18.jpg)

19. Add Data

    > (1) Select **Fusion Data Model** by clicking on the checkbox.

    > (2) Click on the **Add to Workbook** button.

    ![Add Data](images/analytics-with-ai-image19.jpg)

20. Let us understand the existing turnover

    > (1) Close the Assistant by clicking on the **X** icon. <br>

    > (2) Click on the **>** Icon to expand the HCM Core transactions data set. <br>

    > (3) Click on **Job Role** and **Turnover while pressing the **Ctrl** key on your laptop.

    ![Configuring the new workbook](images/analytics-with-ai-image20.jpg)

21. Now we will choose best visualization

    > (1) Right click over either **Job Role** or **Turnover**. <br>

    > (2) Click on **Create Best Visualization**.

    ![choose best visualization](images/analytics-with-ai-image21.jpg)

22. We now see turnover by skills.  Let’s add the data file that we created

    > (1) Click on the **Menu** Icon to the left of the **Auto (Bar)**. <br>

    > (2) Click on **Add Data**.

    ![Add data file that we created](images/analytics-with-ai-image22.jpg)

23. Add Data

    > (1) Select the **External Candidate Profile data file** by clicking on the checkbox. <br>

    > (2) Click on the **Add to Workbook** button.

    ![Add Data](images/analytics-with-ai-image23.jpg)

24. Minimize the Fusion Data Set

    > (1) Select the **Down Arrow** to the left of **Fusion Data Model**.

    ![Minimize the Fusion Data Set](images/analytics-with-ai-image24.jpg)

25. We should compare this with the external candidates to find profiles that match

    > (1) Choose all columns while holding the **Shift** Key. <br>

    > (2) Right click over the columns you selected. <br>

    > (3) Select **Pick Visualization**.

    ![Configuring the new workbook](images/analytics-with-ai-image25.jpg)

26. Select Table View

    > (1) Click on the **Table** Icon

    ![Select Table View](images/analytics-with-ai-image26.jpg)

27. You will now see data side by side.

    > (1) Click on the columns with turnover.

    > (2) You will see relevant candidates that match the profile, <br>

    ![Turnover by Job role Dashboard](images/analytics-with-ai-image27.jpg)

28. Congratulations!  ![checkered flag](../../gen-images/checkeredflag.jpg)

    > **You've completed this Adventure**. Please close this tab.

### Summary

You discovered how effortlessly Fusion Data Intelligence enables the creation of content and analysis of data. By integrating diverse data sources, you were able to delve deeper from summary information to detailed analysis, uncovering root causes by leveraging AI Insights. You then shared your discoveries with a broader audience, making the insights accessible and impactful.

## Learn More

* [Get Started with Oracle Fusion Data Intelligence](https://docs.oracle.com/en/cloud/saas/analytics/26r3/index.html)
* [Fusion Data Intelligence](https://www.oracle.com/fusion-ai-data-platform/)
* [Oracle Documentation](https://docs.oracle.com)

## Acknowledgements

* **Author** - Sohel Jeelani, Distinguished Analytics Solution Engineer, Advanced Technology Services
* **Contributors** - The AI Adventure Team (Gus, Sajid, Casey, Stephen, Sohel, Xavier, Ray, Charlie)
* **Last Updated By/Date** - Sajid Saleem, October 2026