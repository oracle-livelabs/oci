# Analytics

## **Use AI to derive better business insight**

### **Introduction**

Oracle Fusion Data Intelligence Platform (FDI) is a family of prebuilt, cloud native applications for Oracle Cloud Applications that provides line-of-business users with ready-to-use insights to improve decision-making.

It is a Cloud application that delivers best-practice Key Performance Indicators (KPIs) and deep analyses to help decision-makers run their businesses and individual contributors to operate their businesses. Oracle Fusion Data Intelligence Platform is built on top of Oracle Analytics Cloud and Oracle Autonomous Data Warehouse. This packaged service starts with Oracle Fusion Cloud Applications which you can deploy rapidly, personalize, and extend. The service extracts data from your Oracle Fusion Cloud Applications and loads it into an instance of Oracle Autonomous Data Warehouse. Business users can then create and customize dashboards in Oracle Analytics Cloud. It empowers business users with industry-leading, AI-powered, self-service analytics capabilities for data preparation, visualization, enterprise reporting, augmented analysis, and natural language processing.

This activity guide helps business users to investigate and research data, ask relevant questions to understand Trends, Patterns and Outliers.

### **Objectives**

Use pre-built machine learning based sentiment analysis to analyze employee sentiment (positive, negative or neutral) and emotion from survey interaction data.

Estimated Time: 15 minutes

Do not forget to answer the Adventure Check Point questions at the end of the exercise!

### Begin Exercise**

1. In this activity, you will leverage pre-built machine learning capabilities (sentiment analysis) on survey data to understand employee sentiment.

    ![Analytics OBJs](../09-analytics-with-ai/images/aianalytics_objs)

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

    [![Cloud Adventure](../09-analytics-with-ai/images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:LOGIN_TEAM:::::CC:CIOADVENTURE)

### Summary

You discovered how effortlessly Fusion Analytics enables the creation of content and analysis of data. By integrating diverse data sources, you were able to delve deeper from summary information to detailed analysis, uncovering root causes. You then shared your discoveries with a broader audience, making the insights accessible and impactful.

**You have successfully completed the Activity!**

### Learn More

* [Get Started with Oracle Fusion Data Intelligence](https://docs.oracle.com/en/cloud/saas/analytics/24r3/index.html)
* [Oracle Documentation](http://docs.oracle.com)

## Acknowledgements

* **Author** - Sohel Jeelani, Analytics Solution Engineer, Advanced Technology Services
* **Contributors** -
* **Last Updated By/Date** - Xavier Ramirez, October 2025
