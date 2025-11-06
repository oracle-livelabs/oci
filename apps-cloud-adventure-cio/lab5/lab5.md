# Create Analytics

<!-- rem ## Path 1: Analytics -->

## **Path 1: ERP & HCM: Unify finance and workforce-related data to understand changing workforce dynamics and gain comprehensive insights**

### **Introduction**

Oracle Fusion Data Intelligence Platform (FDI) is a family of prebuilt, cloud native analytics applications for Oracle Cloud Applications that provides line-of-business users with ready-to-use insights to improve decision-making.

It is a Cloud application that delivers best-practice Key Performance Indicators (KPIs) and deep analyses to help decision-makers run their businesses and individual contributors to operate their businesses. Oracle Fusion Data Intelligence Platform is built on top of Oracle Analytics Cloud and Oracle Autonomous Data Warehouse. This packaged service starts with Oracle Fusion Cloud Applications which you can deploy rapidly, personalize, and extend. The service extracts data from your Oracle Fusion Cloud Applications and loads it into an instance of Oracle Autonomous Data Warehouse. Business users can then create and customize dashboards in Oracle Analytics Cloud. It empowers business users with industry-leading, AI-powered, self-service analytics capabilities for data preparation, visualization, enterprise reporting, augmented analysis, and natural language processing.

This activity guide helps business users to investigate and research data, ask relevant questions to understand Trends, Patterns and Outliers.

### **Objectives**

In this activity, you will Create analytics to unify finance and workforce-related data to understand changing workforce dynamics and gain comprehensive insight.

Estimated Time: 15 minutes

Do not forget to answer the Adventure Check Point questions at the end of the exercise!

### **Begin Exercise**

1. In this activity, you will Create analytics across different lines of business to derive better business insights.

    Cross-functional reporting analysis between ERP & HCM involves integrating data from core business operations finance with workforce-related data (such as employee performance, payroll, and workforce planning) providing comprehensive insights for decision-making, enabling organizations to align their human resource strategies with broader business objectives.

    ![Analytics OBJs](../09-analytics/images/analytics_objs1.png)

2. Oracle Fusion Data Intelligence Platform is a family of prebuilt, cloud-native analytics applications for Oracle Cloud Applications that provide line-of-business users with ready-to-use insights to improve decision-making.

    > (1) Click on the **‘Analytics’** tab <br>
    > (2) Click on **‘Fusion – Analytics Data Intelligence’** icon <br>

    ![Login](../09-analytics/images/image001.png)

3. After a successful login, you will land on the Oracle Analytics home page.

    > (1) Enter assigned username and Fusion Analytics Password  <br>

 > (2) Click on the ‘Sign In’ <br>

    ![Login](../09-analytics/images/image023.png)

4. A finance Watchlist comprising several Tiles is available on the home page.

    One metric that draws my attention is Margin, which is trending low.

    Two attributes that influence Margin are Revenue and Cost. Since revenue seems to be increasing, let's investigate Cost.

    > On the Margin Tile locate the **Open Workbook** ![Open Workbook Icon](../09-analytics/images/icon001.png) Icon on the top right corner and click on it.

    ![Analytics home](../09-analytics/images/image002.png)

5. This action expands the Tile and opens the workbook.

    Let's now set the workbook to design mode so that we can add cost elements.

    > Click on the Edit Icon  ![Edit Icon](../09-analytics/images/icon002.png)  as shown in the image.  <br>

    Instead of building manually, let's use the Auto Insights feature.


    > Click on the Auto Insights Icon  ![Auto Insights Icon](../09-analytics/images/icon003.png)  as shown in the image.

    ![Workbook Design Mode](../09-analytics/images/image003.png)

6.  Next, let’s expand the Auto Insights pane for better observability.

    > Click on the Expand / Shrink Icon  ![Expand / Shrink Icon ](../09-analytics/images/icon004.png)  as shown in the image.

    ![Workbook Design Mode](../09-analytics/images/image004.png)

7.  The Auto Insights function has crawled the data set and brought expense-related information critical to our analysis. Let’s use the Top 10 Expenses by expense categories.

    > (1) Locate the “Top 10 Expense Categories by Expenses” insight and click the Add Icon  ![Add Icon ](../09-analytics/images/icon006.png)  shown in the image. This will add the Insight to the Canvas.  <br>

    > (2) Click on the **x** sign to close the Insights pane.

    ![Auto insights view](../09-analytics/images/image007.png)

8.  Now, we can compare margin and cost side by side.

    Payroll expenses emerge as the highest cost. We will delve deeper into payroll expenses to identify their components.

    Our next step involves integrating Human Resources data into our analysis.

    ![Analytics view 1](../09-analytics/images/image008.png)

9.  Combining datasets from multiple “Lines of Business” allows an individual to conduct a deep dive into the actual problems.

    > (1) Expand the HCM Core transactions data set from the Data Panel on the left.  <br>

    > (2) At the bottom of the Page, click the plus icon  ![plus icon](../09-analytics/images/icon007.png)  to add another Canvas, **Canvas 2**. <br>

    > (3) While holding “Shift,” multi-select the Amount and Account columns and drag them onto Canvas 2.

    ![Analytics view 2](../09-analytics/images/image009.png)

    > (1) Change the chart to a “Stacked Bar” type to visualize the data better.  <br>

    > (2) Follow steps 1 and 2 as shown in the picture 10.

    ![Analytics view 3](../09-analytics/images/image010.png)

10.  We need to perform trend analysis to understand when the expense anomaly started occurring and whether it is consistent across all expense types.

    > Drag the **Accounts** column from the Categories section into the Color section.

    ![Analytics view 4](../09-analytics/images/image011.png)

    > Next, expand the Fiscal Date folder in the Data Panel, locate the **Month** column, and drag and drop it into the Categories section.

    ![Analytics view 5](../09-analytics/images/image012.png)

11.  We can now see expense amounts displayed across time and expense categories.

    On analyzing the trend, it appears that while Base Salary and Wages have remained constant, overtime and contract labor have increased since May.

    Let's explore and find out why overtime and contract labor have increased.

    ![Month by Month View](../09-analytics/images/image013.png)

12. Overtime and Contract labor are typically associated with Turnover. Let's see if it had any impact.

    > (1) Expand the Fiscal Date folder in the Data Panel to locate the **Month** and **Turnover** columns.   <br>

    > (2) While holding “Ctrl,” multi-select the **Month** and **Turnover** columns and drag them below the current visual.

    ![Analytics view 6](../09-analytics/images/image014.png)

13.  Another factor that impacts Overtime and Contract labor is employee absences.

    > Drag the **Absences** column from the data panel and drop it in the values section below the **Turnover** column.

    ![Analytics view 7](../09-analytics/images/image015.png)

    ![Analytics view 8](../09-analytics/images/image016.png)

14.  This brings all relevant columns onto the canvas. We can now co-relate several attributes and arrive at the correct conclusion.  We can now see the pattern clearly. Beginning in March, absences and turnover started increasing, which led to an increase in overtime and the hiring of contract labor.  This is ultimately reflected in the books of accounts in Finance.

15. Let’s understand how the trend looks like in the future. We will use the built in Statistical Analysis function like forecast to under the future

    > Right click anywhere in the **Turnover**, **Absences** Chart choose **Add Statistics** then **Forecast**

    ![Analytics view 11](../09-analytics/images/image021.png)

16. With a few simple clicks, you were able to forecast and understand the future trend.

    ![Analytics view 12](../09-analytics/images/image022.png)

17. Adventure awaits, click on the image and show what you know, and rise to the top of the leader board!!!

    [![Cloud Adventure](../gen-images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:LOGIN_TEAM:::::CC:CIOADVENTURE)

<!-- rem ## Path 2: Analytics with AI -->

## **Path 2: Use AI to derive better business insight**

### **Introduction**

Oracle Fusion Data Intelligence Platform (FDI) is a family of prebuilt, cloud native applications for Oracle Cloud Applications that provides line-of-business users with ready-to-use insights to improve decision-making.

It is a Cloud application that delivers best-practice Key Performance Indicators (KPIs) and deep analyses to help decision-makers run their businesses and individual contributors to operate their businesses. Oracle Fusion Data Intelligence Platform is built on top of Oracle Analytics Cloud and Oracle Autonomous Data Warehouse. This packaged service starts with Oracle Fusion Cloud Applications which you can deploy rapidly, personalize, and extend. The service extracts data from your Oracle Fusion Cloud Applications and loads it into an instance of Oracle Autonomous Data Warehouse. Business users can then create and customize dashboards in Oracle Analytics Cloud. It empowers business users with industry-leading, AI-powered, self-service analytics capabilities for data preparation, visualization, enterprise reporting, augmented analysis, and natural language processing.

This activity guide helps business users to investigate and research data, ask relevant questions to understand Trends, Patterns and Outliers.

### **Objectives**

Use pre-built machine learning based sentiment analysis to analyze employee sentiment (positive, negative or neutral) and emotion from survey interaction data.

Estimated Time: 15 minutes

Do not forget to answer the Adventure Check Point questions at the end of the exercise!

### **Begin Exercise**

1. In this activity, you will leverage pre-built machine learning capabilities (sentiment analysis) on survey data to understand employee sentiment.

    ![Analytics OBJs](../09-analytics-with-ai/images/aianalytics_objs2.jpg)

2. Oracle Fusion Data Intelligence Platform is a family of prebuilt, cloud-native analytics applications for Oracle Cloud Applications that provide line-of-business users with ready-to-use insights to improve decision-making.

    > (1) Click on the **‘Analytics’** tab. <br>

    > (2) (2) Click on **Fusion – Analytics Data Intelligence** icon. <br>

    ![Home Screen](../09-analytics-with-ai/images/aiimage001.jpg)

3. After a successful login, you will land on the Oracle Analytics home page.

    > (1) Enter your assigned username and Fusion Analytics Password.  <br>

    ![Sign-in Screen](../09-analytics-with-ai/images/aiimage001a.jpg)

4. From home page, click on create button on top right corner to start the data flow process for building model out.

    > (1) Click on the **Create Button**. <br>

    ![Analytics Home](../09-analytics-with-ai/images/aiimage009.jpg)

    > (1) Click on **Data Flow**. <br>

    ![Analytics Home](../09-analytics-with-ai/images/aiimage010.jpg)

5. Data Flow page pops up but also a dialog box asking to Add Data.

    > (1) Within the Search box, type in **Survey** . <br>

    > (2) Select Data set named **Survey Data**. <br>

    > (3) Click **Add**. <br>

    ![New Data Flow](../09-analytics-with-ai/images/aiimage011.jpg)

6. We will use pre-built machine learning based sentiment analysis to analyze Survey Data.

    > (1) Drag **Analyze Sentiment** on the left side until we get a blue box next to Survey Data. <br>

    ![New Data Flow](../09-analytics-with-ai/images/aiimage012.jpg)

7. Now that we have “Analyze Sentiment” we have to point the model as to what we want it to analyze, In this case we want to have a sentiment analysis on employees comments. The Sentiment Analysis will analyze the comments and assign a positive, neutral, or negative attribute to each comment.

    > (1) Click on **Select a Column** . <br>

    > (2) Scroll down until you see **EmployeeComment**. <br>

    > (3) Click on **EmployeeComment**. <br>

    ![New Data Flow](../09-analytics-with-ai/images/aiimage013.jpg)

8. We are ready to save the model data.

    > (1) drag over “**Save Dataset** to our data flow. <br>

    ![New Data Flow](../09-analytics-with-ai/images/aiimage014.jpg)

    > (1) Enter **Survey Sentiment CIOXX and your initials** in data set to name the data set. <br>

    > (2) Click the **Save** button. <br>

    ![New Data Flow](../09-analytics-with-ai/images/aiimage015.jpg)

9. A dialog box pops up asking name to save Data Flow As.

    > (1) Enter **Sentiment Data Flow CIOXX and your initials**. <br>

    > (2) Click on **Ok**. <br>

    ![New Data Flow](../09-analytics-with-ai/images/aiimage016.jpg)

10. Now you will run the data flow model.

    > (1) Click on the **Run** button. <br>

    ![Sentiment Data Flow](../09-analytics-with-ai/images/aiimage017.jpg)

11. Will take approximately 30 seconds to run. You can start going back to build out a workbook with the data set generated.

    > (1) Click on the **back** button. <br>

    ![Sentiment Data Flow](../09-analytics-with-ai/images/aiimage018.jpg)

12. Now that we have Sentiment Data Flow created, lets build some analysis with the model.

    > (1) Click on the **Create** button. <br>

    > (2) Click on **Workbook**. <br>

    ![Sentiment Data Flow](../09-analytics-with-ai/images/aiimage019.jpg)

13. Dialog pop up asking for what data we would like to Add.

    > (1) Enter **Survey** in the search bar. <br>

    > (2) Select the model you named with your initials. <br>

    > (2) Click on **Add to Workbook**. <br>

    ![New Workbook](../09-analytics-with-ai/images/aiimage022.jpg)

14. Notice that we have emotion as an attribute derived from sentiment analysis. We will start with analyzing head count based on emotion.

    > (1) Click and hold on ctrl, then select **emotion**. <br>

    > (2) Select **headcount** and drag both attributes into the canvas. <br>

    ![New Workbook](../09-analytics-with-ai/images/aiimage023.jpg)

15. Now we will move emotion to Color for better visualization

    > (1) Click and drag **emotion** onto color. <br>

    ![New Workbook](../09-analytics-with-ai/images/aiimage024.jpg)

    > (1) Drag over Department attribute to “Trellis Columns”. <br>

    ![New Workbook](../09-analytics-with-ai/images/aiimage025.jpg)

    > (1) While holding down the control key, select **emotion**. <br>

    > (2) Select **EmployeeComment**. <br>

    > (3) Drag both to the line below the current bar graph. <br>

    ![New Workbook](../09-analytics-with-ai/images/aiimage026.jpg)

16. We can bring in the comments and add some color emotion to them.

    > (1) Click and drag **emotion** onto color. <br>

    ![New Workbook](../09-analytics-with-ai/images/aiimage027.jpg)

    > (1) Click on the bar chart to reveal the filter icon. <br>

    > (2) Click on the **Filter Icon**. <br>

    > (3) Then click on the **Preview Icon**. <br>

    ![New Workbook](../09-analytics-with-ai/images/aiimage028.jpg)

17. We see the survey results across all departments.  Now we will use the filter feature to look at the different sentiments.

    > (1) Click on any **green bar** to view all positive comments. <br>

    ![New Workbook](../09-analytics-with-ai/images/aiimage029.jpg)

    > (1) Click on any **orange bar** to view all neutral comments. <br>

    ![New Workbook](../09-analytics-with-ai/images/aiimage030.jpg)

    > (1) Click on any **blue bar** to view all positive comments. <br>

    ![New Workbook](../09-analytics-with-ai/images/aiimage031.jpg)

    ![New Workbook](../09-analytics-with-ai/images/aiimage032.jpg)


23. Adventure awaits, click on the image and show what you know, and rise to the top of the leader board!!!

    [![Cloud Adventure](../gen-images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:LOGIN_TEAM:::::CC:CIOADVENTURE)

### Summary

You discovered how effortlessly Fusion Analytics enables the creation of content and analysis of data. By integrating diverse data sources, you were able to delve deeper from summary information to detailed analysis, uncovering root causes. You then shared your discoveries with a broader audience, making the insights accessible and impactful.

**You have successfully completed the Activity!**

### Learn More

* [Get Started with Oracle Fusion Data Intelligence](https://docs.oracle.com/en/cloud/saas/analytics/24r3/index.html)
* [Oracle Documentation](http://docs.oracle.com)

## Acknowledgements

* **Author** - Sohel Jeelani, Distinguished Analytics Solution Engineer; Xavier Ramirez, Senior Analytics Solution Engineer; Nate Weinsaft, Master Principal Solution Engineer
* **Contributors** - The Cloud Adventure Team (Gus, Kris, Sajid, Casey, Stephen, Jamil, Sohel, Xavier, Nate, Charlie)
* **Last Updated By/Date** - Sajid Saleem, November 2025