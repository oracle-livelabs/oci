# Analytics

## Introduction

Oracle Fusion Data Intelligence Platform is a family of prebuilt, cloud native analytics applications for Oracle Cloud Applications that provides line-of-business users with ready-to-use insights to improve decision-making.

It is a Cloud application that delivers best-practice Key Performance Indicators (KPIs) and deep analyses to help decision-makers run their businesses and individual contributors to operate their businesses. Oracle Fusion Data Intelligence Platform is built on top of Oracle Analytics Cloud and Oracle Autonomous Data Warehouse. This packaged service starts with Oracle Fusion Cloud Applications which you can deploy rapidly, personalize, and extend. The service extracts data from your Oracle Fusion Cloud Applications and loads it into an instance of Oracle Autonomous Data Warehouse. Business users can then create and customize dashboards in Oracle Analytics Cloud. It empowers business users with industry-leading, AI-powered, self-service analytics capabilities for data preparation, visualization, enterprise reporting, augmented analysis, and natural language processing.

This activity guide helps business users to investigate and research data, ask relevant questions to understand Trends, Patterns and Outliers.

### Objectives

In this activity, you will Create analytics across different lines of business to derive better business insight

Estimated Time: 15 minutes

Do not forget to answer the Adventure Check Point questions at the end of the exercise!

## ERP & HCM: Unify finance and workforce-related data to understand changing workforce dynamics and gain comprehensive insights

1. In this activity, you will Create analytics across different lines of business to derive better business insights.

    Cross-functional reporting analysis between ERP & HCM involves integrating data from core business operations finance with workforce-related data (such as employee performance, payroll, and workforce planning) providing comprehensive insights for decision-making, enabling organizations to align their human resource strategies with broader business objectives.

    ![Analytics OBJs](images/analytics_objs1.png)

2. Oracle Fusion Data Intelligence Platform is a family of prebuilt, cloud-native analytics applications for Oracle Cloud Applications that provide line-of-business users with ready-to-use insights to improve decision-making.

    > (1) Click on the **‘Analytics’** tab <br>
    > (2) Click on **‘Fusion – Analytics Data Intelligence’** icon <br>

    ![Login](images/image001.png)

3. After a successful login, you will land on the Oracle Analytics home page.

    > (1) Enter assigned username and Fusion Analytics Password  <br>

 > (2) Click on the ‘Sign In’ <br>

    ![Login](images/image023.png)

4. A finance Watchlist comprising several Tiles is available on the home page.

    One metric that draws my attention is Margin, which is trending low.

    Two attributes that influence Margin are Revenue and Cost. Since revenue seems to be increasing, let's investigate Cost.

    > On the Margin Tile locate the **Open Workbook** ![Open Workbook Icon](images/icon001.png) Icon on the top right corner and click on it.

    ![Analytics home](images/image002.png)

5. This action expands the Tile and opens the workbook.

    Let's now set the workbook to design mode so that we can add cost elements.

    > Click on the Edit Icon  ![Edit Icon](images/icon002.png)  as shown in the image.  <br>

    Instead of building manually, let's use the Auto Insights feature.


    > Click on the Auto Insights Icon  ![Auto Insights Icon](images/icon003.png)  as shown in the image.

    ![Workbook Design Mode](images/image003.png)

6.  Next, let’s expand the Auto Insights pane for better observability.

    > Click on the Expand / Shrink Icon  ![Expand / Shrink Icon ](images/icon004.png)  as shown in the image.

    ![Workbook Design Mode](images/image004.png)

7.  The Auto Insights function has crawled the data set and brought expense-related information critical to our analysis. Let’s use the Top 10 Expenses by expense categories.

    > (1) Locate the “Top 10 Expense Categories by Expenses” insight and click the Add Icon  ![Add Icon ](images/icon006.png)  shown in the image. This will add the Insight to the Canvas.  <br>

    > (2) Click on the **x** sign to close the Insights pane.

    ![Auto insights view](images/image007.png)

8.  Now, we can compare margin and cost side by side.

    Payroll expenses emerge as the highest cost. We will delve deeper into payroll expenses to identify their components.

    Our next step involves integrating Human Resources data into our analysis.

    ![Analytics view 1](images/image008.png)

9.  Combining datasets from multiple “Lines of Business” allows an individual to conduct a deep dive into the actual problems.

    > (1) Expand the HCM Core transactions data set from the Data Panel on the left.  <br>

    > (2) At the bottom of the Page, click the plus icon  ![plus icon](images/icon007.png)  to add another Canvas, **Canvas 2**. <br>

    > (3) While holding “Shift,” multi-select the Amount and Account columns and drag them onto Canvas 2.

    ![Analytics view 2](images/image009.png)

    > (1) Change the chart to a “Stacked Bar” type to visualize the data better.  <br>

    > (2) Follow steps 1 and 2 as shown in the picture 10.

    ![Analytics view 3](images/image010.png)

10.  We need to perform trend analysis to understand when the expense anomaly started occurring and whether it is consistent across all expense types.

    > Drag the **Accounts** column from the Categories section into the Color section.

    ![Analytics view 4](images/image011.png)

    > Next, expand the Fiscal Date folder in the Data Panel, locate the **Month** column, and drag and drop it into the Categories section.

    ![Analytics view 5](images/image012.png)

11.  We can now see expense amounts displayed across time and expense categories.

    On analyzing the trend, it appears that while Base Salary and Wages have remained constant, overtime and contract labor have increased since May.

    Let's explore and find out why overtime and contract labor have increased.

    ![Month by Month View](images/image013.png)

12. Overtime and Contract labor are typically associated with Turnover. Let's see if it had any impact.

    > (1) Expand the Fiscal Date folder in the Data Panel to locate the **Month** and **Turnover** columns.   <br>

    > (2) While holding “Ctrl,” multi-select the **Month** and **Turnover** columns and drag them below the current visual.

    ![Analytics view 6](images/image014.png)

13.  Another factor that impacts Overtime and Contract labor is employee absences.

    > Drag the **Absences** column from the data panel and drop it in the values section below the **Turnover** column.

    ![Analytics view 7](images/image015.png)

    ![Analytics view 8](images/image016.png)

14.  This brings all relevant columns onto the canvas. We can now co-relate several attributes and arrive at the correct conclusion.  We can now see the pattern clearly. Beginning in March, absences and turnover started increasing, which led to an increase in overtime and the hiring of contract labor.  This is ultimately reflected in the books of accounts in Finance.

15. Let’s understand how the trend looks like in the future. We will use the built in Statistical Analysis function like forecast to under the future

    > Right click anywhere in the **Turnover**, **Absences** Chart choose **Add Statistics** then **Forecast**

    ![Analytics view 11](images/image021.png)

16. With a few simple clicks, you were able to forecast and understand the future trend.

    ![Analytics view 12](images/image022.png)

17. Adventure awaits, click on the image and show what you know, and rise to the top of the leader board!!!

    [![Cloud Adventure](images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:LOGIN_TEAM:::::CC:CIOADVENTURE)

## ERP & SCM: Unify finance and supply chain data to identify bottlenecks and optimize resource allocation

1. In this activity, you will Create analytics across different lines of business to derive better business insights.

    ERP & SCM cross-functional reporting combines data from business processes like finance with supply chain operations. By providing a unified view of supply chain and enterprise operations, cross-functional reporting helps identify bottlenecks, optimize resource allocation, and improve supply chain resilience. Such insights are crucial for aligning supply chain strategies with overall business goals and achieving operational excellence.

    ![Analytics OBJs](images/analytics_objs1.png)

2. Oracle Fusion Data Intelligence Platform is a family of prebuilt, cloud-native analytics applications for Oracle Cloud Applications that provide line-of-business users with ready-to-use insights to improve decision-making.

    > (1) Click on the **‘Analytics’** tab <br>
    > (2) Click on **‘Fusion – Analytics Data Intelligence’** icon <br>

    ![Login](images/image001.png)

3. After a successful login, you will land on the Oracle Analytics home page.

    > (1) Enter assigned username and Fusion Analytics Password  <br>
    > (2) Click on the ‘Sign In’ <br>

    ![Login](images/image023.png)

4. A finance Watchlist comprising several Tiles is available on the home page.

    One metric that draws my attention is Margin, which is trending low.

    Two attributes that influence Margin are Revenue and Cost. Since revenue seems to be increasing, let's investigate Cost.

    > On the Margin Tile locate the **Open Workbook** ![Open Workbook Icon](images/icon101.png) Icon on the top right corner and click on it.

    ![Analytics home](images/image102.png)

5. This action expands the Tile and opens the workbook.

    Let's now set the workbook to design mode so that we can add cost elements.

    > Click on the Edit Icon  ![Edit Icon](images/icon102.png)  as shown in the image.  <br>

    Instead of building manually, let's use the Auto Insights feature.

    > Click on the Auto Insights Icon  ![Auto Insights Icon](images/icon103.png)  as shown in the image.

    ![Workbook Design Mode](images/image103.png)

6. Next, let’s expand the Auto Insights pane for better observability.

    > Click on the Expand / Shrink Icon  ![Expand / Shrink Icon ](images/icon104.png)  as shown in the image.

    ![Workbook Design Mode](images/image104.png)

7. The Auto Insights function has crawled the data set and brought expense-related information critical to our analysis. Let’s use the Top 10 Expenses by expense categories.

    > (1) Locate the “Top 10 Expense Categories by Expenses” insight and click the Add Icon  ![Add Icon ](images/icon106.png)  shown in the image. This will add the Insight to the Canvas.  <br>
    > (2) Click on the **x** sign to close the Insights pane.

    ![Auto insights view](images/image107.png)

8. Let’s create a new Canvas to under the SCM issue

     > Locate the plus ![plus icon](images/cplus.png) icon at the bottom of the page and click it to create a new canvas. <br>

![new canvas](images/scm-001.png)

9. We will add Supply Chain data to the canvas

     > Expand the SCM Dataset by clicking on the Triangle   icon.  Expand the Fiscal Data folder and locate Month Column. <br>
     > Next locate Total Cost. While keeping the “CTRL ” key pressed drag and drop them on to the canvas.  <br>
     > Your canvas should look like the image on the right.<br>

    ![2 images](images/scm-002.png)

10. Total cost has been varying over time. We need to understand what is causing the increase and decrease

     > Expand the Fiscal Data folder and locate Month Column. <br>
     > Scroll down to locate Off Contract and Contract purchase columns. <br>
     > While keeping the “CTRL ” key pressed drag and drop them on to the canvas under the existing chart. <br>
     > Watch for the Green bar before you drop the columns. <br>

    ![expand Fiscal Data folder ](images/scm-003.png)

11. Change the visualization type

     > In the Properties panel in the center. Click on the inverted triangle ![inverted triangle](images/invtriangle.png) to expand the Analytics Type panel and choose Bar Type.<br>

    ![Properties panel  ](images/scm-004.png)

     > Move Contract Purchase from Color Section to Values section.<br>

    ![Properties panel  ](images/scm-005.png)

12. We need to understand what is causing the off contract purchasing.

     > Expand the Fiscal Data folder and locate Month Column. <br>
     > Scroll down to locate Received Late Quantity columns. <br>
     > While keeping the “CTRL ” key pressed drag and drop them on to the canvas under the existing chart.  <br>
     > Watch for the Green bar before you drop the columns.  <br>

    ![Fiscal Data folder ](images/scm-006.png)

     > In the Properties panel in the center. Click on the inverted triangle ![inverted triangle](images/invtriangle.png) to expand the Analytics Type panel and choose Bar Type.<br>

    ![Properties panel](images/scm-007.png)

13. Lets find out which supplier is responsible for the issue.

     > Locate supplier and drop it into the color section. <br>
     > Next delete Fiscal Data (Month) column <br>

    ![Supplier](images/scm-008.png)

     > In the Properties panel in the center. Click on the inverted triangle   to expand the Analytics Type panel and choose Treemap Type. <br>

    ![Properties panel](images/scm-009.png)

14. Two suppliers are the cause of the issue.

    ![Analytics view](images/scm-009.png)

15. Adventure awaits, click on the image and show what you know, and rise to the top of the leader board!!!

    [![Cloud Adventure](images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:LOGIN_TEAM:::::CC:CIOADVENTURE)

## Summary

You discovered how effortlessly Fusion Analytics enables the creation of content and analysis of data. By integrating diverse data sources, you were able to delve deeper from summary information to detailed analysis, uncovering root causes. You then shared your discoveries with a broader audience, making the insights accessible and impactful.

**You have successfully completed the Activity!**

## Learn More

* [Get Started with Oracle Fusion Data Intelligence](https://docs.oracle.com/en/cloud/saas/analytics/24r3/index.html)
* [Oracle Documentation](http://docs.oracle.com)

## Acknowledgements
* **Author** - Sohel Jeelani, Analytics Solution Engineer, Advanced Technology Services
* **Contributors** -
* **Last Updated By/Date** - Sohel Jeelani, April 2025
