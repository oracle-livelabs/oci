# Analytics

## ERP: Create analytics across different lines of business to derive better business insight

### Introduction

Oracle Fusion AI Data Platform (Fusion AIDP) Platform delivers a unified, fully managed software-as-a-service experience for connecting, analyzing, and activating all your business data. With curated data, prebuilt analytics, and embedded artificial intelligence, organizations can gain deeper insights, drive innovation, and make faster, data driven decisions across the enterprise.

Built on Oracle AI Data Platform, the Fusion AIDP equips business leaders with unified analytics and built-in AI to connect enterprise data, surface deeper insights, and accelerate confident decisions.

This lab enables business users to explore data, leverage embedded AI capabilities, investigate trends, and uncover patterns or outliers, helping them turn insights into action.

### Objectives

In this activity, you will use Fusion AI Data Platform to
* Create analytics across different lines of business.
* Leverage embedded AI models to quickly implement, validate and operationalize AI.
* Review findings and visualize results.

### Begin Exercise

1. In this activity, you will Create analytics across different lines of business to derive better business insights.

    ![Analytics OBJs](../09-analytics-energy/images/analytics-energy-image001.png)

2. Oracle Fusion AI Data Platform is a family of prebuilt, cloud-native analytics applications for Oracle Cloud Applications that provide line-of-business users with ready-to-use insights to improve decision-making. 

    > (1) Click on the **‘Analytics’** tab. <br>
    > (2) Click on the **Fusion AI Data Platform** icon. <br>

    ![Login](../09-analytics-energy/images/analytics-energy-image002.png)

3. After a successful login, you will land on the Oracle Analytics home page.

    > (1) Enter assigned username and Fusion Analytics Password.  <br>

    > (2) Click on **Sign In** <br>

![Login](../09-analytics-energy/images/analytics-energy-image003.png)

4. We will take a look at the Margin Analysis KPI in the watchlist and open the workbook.

    > (1) Click on the **Open Workbook** ![Open Workbook Icon](../09-analytics-energy/images/icon001.png) icon.

    ![Analytics home](../09-analytics-energy/images/analytics-energy-image004.png)

5. Lets get the workbook into Edit mode to see the data behind it.

    > (1) Click on the Edit Icon  ![Edit Icon](../09-analytics-energy/images/icon002.png)  as shown in the image.  <br>

    ![Workbook Design Mode](../09-analytics-energy/images/analytics-energy-image005.png)


6. Once in Edit mode, we are now going to use AI generated Auto Insights based on the data available

    > (1) Click on the Auto Insights Icon  ![Auto Insights Icon](../09-analytics-energy/images/icon003.png)  as shown in the image.

    > (2) Ensure you are in the **Insights** Tab.  <br>

    > (3) Ensure you are in the **Energy ERP** Data Set.  <br>

![Workbook Design Mode](../09-analytics-energy/images/analytics-energy-image006.png)

7. Now we will select Top 10 Departments by Approvals Insight.

    > (1) Scroll down until you see the **Top 10 Department by Revenue** insight.  <br>

    > (2) Hover over the **Top 10 Department by Revenue** insight.  <br>

    > (3) Click the Add Icon  ![Add Icon ](../09-analytics-energy/images/icon006.png)  shown in the image. This will add the Insight to the Canvas.  <br>

    > (4) Click on the **X** sign to close the Insights pane.  <br>

    ![Auto insights view](../09-analytics-energy/images/analytics-energy-image007.png)

8. Lets take a look at rejected approvals.

    > (1)  Click on **Canvas 2**.  <br>

    ![Workbook Design Mode](../09-analytics-energy/images/analytics-energy-image008.png)

9. First thing we will look at is how Fusion AIDP can help us look at Reasons for Approvals using the explain functionality.

    > (1) Click on the down arrow to expand **Energy Department Master**.  <br>

    > (2) Right Click on **Reason Code**. <br>

    > (3) Click on **Explain Reason Code**. <br>

    ![Workbook Design Mode](../09-analytics-energy/images/analytics-energy-image009.png)

10. Lets focus in the explain functionality by looking at some basic facts section primarily on Reason Code for Rejections based on Number of Rejections

    > (1) You may have to scroll down.  <br>

    > (2) Hover over the **Approved Rejected** Bar Chart.  <br>

    > (3) Click on the Check Icon ![Check Icon ](../09-analytics-energy/images/icon010.png).

    . (4) Click on **Add Selected**.  <br>

    ![Explain Reason Code Menu](../09-analytics-energy/images/analytics-energy-image010.png)

11. We are now going to change the bar chart visualization into a tag cloud

> (1) Click on Horizontal Stack.  <br>

> (2) Click on the Tag Cloud ![Tag Cloud ](../09-analytics-energy/images/icon011.png) Icon.  <br>

![Horizontal Stack View](../09-analytics-energy/images/analytics-energy-image011.png)

12. Lets modify the tag cloud visualization by changing color of attributes.

> (1) Click and hold the **Reason Code** attribute from Category Box and drag it to **Color Box** and release.  <br>

![tag cloud chart](../09-analytics-energy/images/analytics-energy-image012.png)

13. Now we will focus on using an LLM to help us look at the history of approvals based on areas.

    > (1) Click on the Auto Insights Icon  ![Auto Insights Icon](../09-analytics-energy/images/icon003.png).<br>

    > (2) Click on the **Assistant** Tab to access the LLM.  <br>

![LLM Assistant View 1](../09-analytics-energy/images/analytics-energy-image013.png)

14. Now we will start interacting with the LLM to assist us in our analysis.

    > (1) Type in **Show me Approvals by Area** and hit Enter.  <br>

    ![LLM Assistant View 2](../09-analytics-energy/images/analytics-energy-image014.png)

15. We want to add months for the history of approvals and change to show each month showing all the areas as well.

   > (1) Type in **Add month and change to stacked bar chart** and hit Enter.  <br>

   ![LLM Assistant View 3](../09-analytics-energy/images/analytics-energy-image015.png)


16. Let’s add this chart to our canvas.

    > (1) Hover over the Chart.  <br>

    > (2) Click the Add Icon  ![Add Icon ](../09-analytics-energy/images/icon006.png)  shown in the image.  <br>

    ![LLM Assistant View 3](../09-analytics-energy/images/analytics-energy-image016.png)

17. Lets add another visualization showing Rejections by Manager and Area.

    > (1) Type in **Show me Rejected by Manager and Area** and hit Enter.  <br>

    ![LLM Assistant View 4](../09-analytics-energy/images/analytics-energy-image017.png)

18. We will change the chart type to treemap for better visualization.

    > (1) Type in **Change Chart Type to Treemap** and hit Enter.  <br>

    ![LLM Assistant View 5](../09-analytics-energy/images/analytics-energy-image018.png)

19. Now will add the treemap to our canvas.

    > (1) Hover over the treemap.  <br>

    > (2) Click the Add Icon  ![Add Icon ](../09-analytics-energy/images/icon006.png)  shown in the image. This will add the treemap to the Canvas.  <br>

    > (3) Click on **X** to close the LLM Assistant.  <br>

    ![LLM Assistant View 6](../09-analytics-energy/images/analytics-energy-image019.png)

20. Now will will reorganize our canvas.

    > (1)  Click and hold on the upper part of tag cloud, drag it to the left of the tree map until you see a  a blue line next to the treemap and then release.  <br>

    ![Workbook Design Mode View 2](../09-analytics-energy/images/analytics-energy-image020.png)

21. Lets build our last chart with dragging and dropping attributes.

    >(1) Click on the down arrow to the left of **Fiscal Date**.  <br>

    >(2) Drag the **Month, Approvals** and **Rejected** attributes to the right of the treemap until you see a blue line next to the tree map and release.  <br>

    ![Workbook Design Mode View 3](../09-analytics-energy/images/analytics-energy-image021.png)

22. Lets change line area chart to just line chart

    >(1) Click on **Auto (Stacked Area)**.  <br>

    >(2) Click on the line chart ![Line Chart Icon ](../09-analytics-energy/images/icon012.png) icon.

    ![Workbook Design Mode View 4](../09-analytics-energy/images/analytics-energy-image022.png)

23. Lets show Rejected measurement in a Y2 Axis for better visibility.

    >(1) Right click on **Rejected**.  <br>

    >(2) Select the **Y2 Axis**.  <br>

    ![Workbook Design Mode View 5](../09-analytics-energy/images/analytics-energy-image023.png)

24. Lets now add some forecasting to show how we are going to perform on approvals and rejections.

    >(1) Right click on **in the chart**.  <br>

    >(2) Click on **Add Statistics**.  <br>

    >(3) Click on **Forecast**.  <br>

    ![Workbook Design Mode View 6](../09-analytics-energy/images/analytics-energy-image024.png)

25. Here is your final dashboard showing approvals and rejections based on managers and areas.

    ![Workbook Design Mode View 7](../09-analytics-energy/images/analytics-energy-image025.png)

26. Adventure awaits, click on the image and show what you know, and rise to the top of the leader board!!!

    [![Cloud Adventure](../gen-images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:LOGIN_TEAM:::::CC:CIOADVENTURE)

### Summary

You discovered how effortlessly Fusion AI Data Platform enables content creation and data analysis. With the help of AI, you moved from high-level performance summaries to detailed energy approval/rejected insights, uncovering trends and opportunities for your managers.

**You have successfully completed the Activity!**

### Learn More
* [Get Started with  Fusion AI Data Platform](https://www.oracle.com/fusion-ai-data-platform/)
* [Oracle Documentation](http://docs.oracle.com)

## Acknowledgements
* **Author** - Xavier Ramirez, Senior Analytics Solution Engineer
* **Contributors** - The AI Adventure Team (Gus, Kris, Sajid, Casey, Stephen, Jamil, Sohel, Xavier, Nate, Charlie)
* **Last Updated By/Date** - Casey Doody, Sajid Saleem, February 2026
