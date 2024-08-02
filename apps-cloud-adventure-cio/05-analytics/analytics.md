# Analytics
 
## Introduction (MISSING)
 



Estimated Time: 20 minutes


### Objectives

In this activity, you will Create analytics across different lines of business to derive better business insight
 


## Task 1: Create analytics across different lines of business to derive better business insight



1. Oracle Fusion Data Intelligence Platform is a family of prebuilt, cloud-native analytics applications for Oracle Cloud Applications that provide line-of-business users with ready-to-use insights to improve decision-making. 

    After a successful login, you will land on the Oracle Analytics home page. 

    > (1) Login to your Fusion Data Intelligence Portal using the URL provided.  <br>

    > (2) Open a web browser and enter the URL provided, then on the login screen, type in the Username and Password. Click Sign In.

    ![Login](images/image001.png)


2. A finance Watchlist comprising several Tiles is available on the home page. 

    One metric that draws my attention is Margin, which is trending low. 

    Two attributes that influence Margin are Revenue and Cost. Since revenue seems to be increasing, let's investigate Cost.

    > On the Margin Tile locate the Open Workbook Icon    on the top right corner and click on it.

    ![Analytics home](images/image002.png)


3.  This action expands the Tile and opens the workbook. 

    Let's now set the workbook to design mode so that we can add cost elements. 

    Instead of building manually, let's use the Auto Insights feature.

    > (1) Click on the Edit Icon  as shown in the image.  <br>

    > (2) Click on the Auto Insights Icon  as shown in the image.

    ![Workbook Design Mode](images/image003.png)


4.  Next, let’s expand the Auto Insights pane for better observability. 

    > Click on the Expand / Shrink Icon          as shown in the image.

    ![Workbook Design Mode](images/image004.png)


5.  Auto insights can be tuned to provide information necessary for our analysis, for example, Cost Analysis

    > Click the Settings Icon            as         shown in the image.

    ![Auto insights view](images/image005.png)


6.  On the Settings tab, we will choose the attributes that are important to the analysis, which is cost-related information. 

    ***Sohel, I recommend breaking this up into 2 slides due to Visual Studio Code formatting with bulleting inside click tracks**

    ![Auto insights view](images/image006.png)


7.  Placeholder for recommended changes in step 6


8.  The Auto Insights function has crawled the data set and brought expense-related information critical to our analysis. Let’s use the Top 10 Expenses by expense categories. 

    > (1) Locate the “Top 10 Expense Categories by Expenses” insight and click the Add        Icon shown in the image. This will add the Insight to the Canvas.  <br>

    > (2) Click on the **x** sign to close the Insights pane.

    ![Auto insights view](images/image007.png)


9.  Now, we can compare margin and cost side by side. 

    Payroll expenses emerge as the highest cost. We will delve deeper into payroll expenses to identify their components. 

    Our next step involves integrating Human Resources data into our analysis.

    ![Analytics view 1](images/image008.png)


10.  Combining datasets from multiple “Lines of Business” allows an individual to conduct a deep dive into the actual problems.

    > (1) Expand the HCM Core transactions data set from the Data Panel on the left.  <br>

    > (2) At the bottom of the Page, click the plus     icon to add another Canvas, **Canvas 2**. <br>

    > (3) While holding “Shift,” multi-select the Amount and Account columns and drag them onto Canvas 2.

    ![Analytics view 2](images/image009.png)

    > (1) Change the chart to a “Stacked Bar” type to visualize the data better.  <br>

    > (2) Follow steps 1 and 2 as shown in the picture 10.

    ![Analytics view 3](images/image0010.png)


11.  We need to perform trend analysis to understand when the expense anomaly started occurring and whether it is consistent across all expense types.

    > Drag the **Accounts** column from the Categories section into the Color section.

    ![Analytics view 4](images/image011.png)

    > Next, expand the Fiscal Date folder in the Data Panel, locate the **Month** column, and drag and drop it into the Categories section.

    ![Analytics view 5](images/image012.png)

12.  We can now see expense amounts displayed across time and expense categories.

    On analyzing the trend, it appears that while Base Salary and Wages have remained constant, overtime and contract labor have increased since May.

    Let's explore and find out why overtime and contract labor have increased.  

    ![Month by Month View](images/image013.png)

13. Overtime and Contract labor are typically associated with Turnover. Let's see if it had any impact.

    > (1) Expand the Fiscal Date folder in the Data Panel to locate the **Month** and **Turnover** columns.   <br>

    > (2) While holding “Ctrl,” multi-select the **Month** and **Turnover** columns and drag them below the current visual. 

    ![Analytics view 6](images/image0014.png)


14.  Another factor that impacts Overtime and Contract labor is employee absences. 

    > Drag the **Absences** column from the data panel and drop it in the values section below the **Turnover** column.

    ![Analytics view 6](images/image015.png)

15.  This brings all relevant columns onto the canvas. We can now co-relate several attributes and arrive at the correct conclusion. 

    ![Analytics view 8](images/image016.png)



16.  Let's change the chart type to understand trends and patterns better. 

    > (1) Select the line chart as shown in the Picture.   <br>

    > (2) Click on the inverted triangle  in the Properties panel and select Bar Chart.

    ![Analytics view 9](images/image017.png)


17.  We can now see the pattern clearly. Beginning in March, absences and turnover started increasing, which led to an increase in overtime and the hiring of contract labor.  This is ultimately reflected in the books of accounts in Finance. 

    > (1) Now that we have understood the root cause of the margin decline let's share our findings with others.  <br>

    > (2) Click on the Present button in the brown ribbon.

    ![Analytics view 10](images/image018.png)



18.  Oracle Analytics provides the ability to share your findings and content in a PowerPoint presentation mode.

    > (1) In the Workbook > Canvas Navigation toolbar on the left, click 'Style' and change from 'Bottom Tabs' to 'Navigation Bar'.  <br>

    > (2) Next, click on the  Play Icon in the top right corner to activate Present Mode. 

    ![Analytics view 11](images/image019.png)

19.  Once in Present mode, you can go forward or backward, add notes, filters, etc, to tell your story.

    ![Analytics view 12](images/image020.png)




20. Adventure awaits, click on the image and show what you know, and rise to the top of the leader board!!!
    
    [![Cloud Adventure](images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:20:::::QN:16) 



## Summary (MISSING)



**You have successfully completed the Activity!**


## Acknowledgements
* **Author** - Sohel Jeelani, Analytics Solution Engineer, Advanced Technology Services
* **Contributors** -  
* **Last Updated By/Date** - Sohel Jeelani, August 2024
