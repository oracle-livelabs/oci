# Analytics
 
## Introduction

Oracle Fusion Data Intelligence Platform is a family of prebuilt, cloud native analytics applications for Oracle Cloud Applications that provides line-of-business users with ready-to-use insights to improve decision-making.

It is a Cloud application that delivers best-practice Key Performance Indicators (KPIs) and deep analyses to help decision-makers run their businesses and individual contributors to operate their businesses. Oracle Fusion Data Intelligence Platform is built on top of Oracle Analytics Cloud and Oracle Autonomous Data Warehouse. This packaged service starts with Oracle Fusion Cloud Applications which you can deploy rapidly, personalize, and extend. The service extracts data from your Oracle Fusion Cloud Applications and and loads it into an instance of Oracle Autonomous Data Warehouse. Business users can then create and customize dashboards in Oracle Analytics Cloud. It empowers business users with industry-leading, AI-powered, self-service analytics capabilities for data preparation, visualization, enterprise reporting, augmented analysis, and natural language processing.

This activity guide helps business users to investigate and research data, ask relevant questions to understand Trends, Patterns and Outliers.
 


Estimated Time: 15 minutes


### Objectives

In this activity, you will Create analytics across different lines of business to derive better business insight
 
![Analytics OBJs](images/analytics_objs1.png)

## Task 1: Create analytics across different lines of business to derive better business insight



1. Oracle Fusion Data Intelligence Platform is a family of prebuilt, cloud-native analytics applications for Oracle Cloud Applications that provide line-of-business users with ready-to-use insights to improve decision-making. 

    Login to your Fusion Data Intelligence Portal using the URL provided.

    > Open a web browser and enter the URL provided, then on the login screen, type in the Username and Password. Click Sign In.

    ![Login](images/image001.png)

    After a successful login, you will land on the Oracle Analytics home page. 


2. A finance Watchlist comprising several Tiles is available on the home page. 

    One metric that draws my attention is Margin, which is trending low. 

    Two attributes that influence Margin are Revenue and Cost. Since revenue seems to be increasing, let's investigate Cost.

    > On the Margin Tile locate the **Open Workbook** ![Open Workbook Icon](images/icon001.png) Icon on the top right corner and click on it.

    ![Analytics home](images/image002.png)


3.  This action expands the Tile and opens the workbook. 

    Let's now set the workbook to design mode so that we can add cost elements. 

    > Click on the Edit Icon  ![Edit Icon](images/icon002.png)  as shown in the image.  <br>

    Instead of building manually, let's use the Auto Insights feature.


    > Click on the Auto Insights Icon  ![Auto Insights Icon](images/icon003.png)  as shown in the image.

    ![Workbook Design Mode](images/image003.png)


4.  Next, let’s expand the Auto Insights pane for better observability. 

    > Click on the Expand / Shrink Icon  ![Expand / Shrink Icon ](images/icon004.png)  as shown in the image.

    ![Workbook Design Mode](images/image004.png)




5.  The Auto Insights function has crawled the data set and brought expense-related information critical to our analysis. Let’s use the Top 10 Expenses by expense categories. 

    > (1) Locate the “Top 10 Expense Categories by Expenses” insight and click the Add Icon  ![Add Icon ](images/icon006.png)  shown in the image. This will add the Insight to the Canvas.  <br>

    > (2) Click on the **x** sign to close the Insights pane.

    ![Auto insights view](images/image007.png)


6. Let’s create a new Canvas to under the SCM issue

     > Locate the plus ![plus icon](images/cplus.png) icon at the bottom of the page and click it to create a new canvas. <br>

![new canvas](images/scm-001.png)

7. We will add Supply Chain data to the canvas

     > Expand the SCM Dataset by clicking on the Triangle   icon.  Expand the Fiscal Data folder and locate Month Column. <br>

     > Next locate Total Cost. While keeping the “CTRL ” key pressed drag and drop them on to the canvas.  <br>

     > Your canvas should look like the image on the right.<br>

    ![2 images](images/scm-002.png)


8. Total cost has been varying over time. We need to understand what is causing the increase and decrease

     > Expand the Fiscal Data folder and locate Month Column. <br>

     > Scroll down to locate Off Contract and Contract purchase columns. <br>

     > While keeping the “CTRL ” key pressed drag and drop them on to the canvas under the existing chart. <br>

     > Watch for the Green bar before you drop the columns. <br>

    ![expand Fiscal Data folder ](images/scm-003.png)

9. Change the visualization type

     > In the Properties panel in the center. Click on the inverted triangle ![inverted triangle](images/invtriangle.png) to expand the Analytics Type panel and choose Bar Type.<br>

    ![Properties panel  ](images/scm-004.png)

     > Move Contract Purchase from Color Section to Values section.<br>

    ![Properties panel  ](images/scm-005.png)


10. We need to understand what is causing the off contract purchasing. 

     > Expand the Fiscal Data folder and locate Month Column. <br>

     > Scroll down to locate Received Late Quantity columns. <br>

     > While keeping the “CTRL ” key pressed drag and drop them on to the canvas under the existing chart.  <br>

     > Watch for the Green bar before you drop the columns.  <br>

    ![Fiscal Data folder ](images/scm-006.png)

     > In the Properties panel in the center. Click on the inverted triangle ![inverted triangle](images/invtriangle.png) to expand the Analytics Type panel and choose Bar Type.<br>

    ![Properties panel](images/scm-007.png)

11. Lets find out which supplier is responsible for the issue.

     > Locate supplier and drop it into the color section. <br>

     > Next delete Fiscal Data (Month) column <br>

    ![Supplier](images/scm-008.png)

     > In the Properties panel in the center. Click on the inverted triangle   to expand the Analytics Type panel and choose Treemap Type. <br>

    ![Properties panel](images/scm-009.png)

12. Two suppliers are the cause of the issue. 

    ![Analytics view](images/scm-009.png)


13. Adventure awaits, click on the image and show what you know, and rise to the top of the leader board!!!
    
    [![Cloud Adventure](images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:LOGIN_TEAM:::::CC:CIOADVENTURE) 



## Summary

You discovered how effortlessly Fusion Analytics enables the creation of content and analysis of data. By integrating diverse data sources, you were able to delve deeper from summary information to detailed analysis, uncovering root causes. You then shared your discoveries with a broader audience, making the insights accessible and impactful.



**You have successfully completed the Activity!**


## Acknowledgements
* **Author** - Sohel Jeelani, Analytics Solution Engineer, Advanced Technology Services
* **Contributors** -  
* **Last Updated By/Date** - Sohel Jeelani, September 2024
