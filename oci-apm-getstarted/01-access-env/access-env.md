# Analyze GenAI app with Inferencing app dashboard

## Introduction

IIn this lab, you will explore and analyze the performance, cost, and user experience of a GenAI application using the Inferencing App dashboard in Oracle Cloud APM.

Estimated time: 10 minutes

### Objectives

* Learn how to use the APM Inferencing app dashboard to analyze monitored GenAI app data and drill down into trace details

### Prerequisites

* An Oracle event account, which you can use to sign in to the workshop tenancy.

## Task 1: Open the Inferencing App dashboard

1. Open the navigation menu from the top left corner (aka. hamburger menu) in the Oracle Cloud console.

   ![Oracle Cloud console, Home page](images/1-0-console-menu.png " ")

   Select **Observability & Management** > **Dashboards** under **Management Dashboard**.
   ![Oracle Cloud console, Home page](images/1-1-console-menu.png " ")

2. On the **Dashboards** page, type **WineStore** in the **Compartment** field. Select one of the entries under the **eStore** compartment.

   ![Oracle Cloud console, Home page](images/1-2-console-dashboards.png " ")
3. Click the **Inferencing apps** link.
   ![Oracle Cloud console, Home page](images/1-3-console-dashboards.png " ")

4. The Inferencing apps dashboard opens. Make sure **WineStore** is selected in **Compartment**. Select **GenAI App** from the **APM domain** dropdown menu.

   ![Oracle Cloud console, Home page](images/1-4-infapp-dashboard.png " ")

5. Change the timeline to **Last 7 days**. 
   ![Oracle Cloud console, Home page](images/1-5-infapp-time.png " ")
6. Open the **Actions** menu, select **Autorefresh** then choose **off**.

   ![Oracle Cloud console, Home page](images/1-6-infapp-autorefresh.png " ")

## Task 2: Review End User Experience view

In the **End User Experience** tab, you can view an overview of the inferencing apps from the users' perspective.

1. Review the summary widgets, such as the number of sessions executed, user logins, and average invocations per session during the selected time period. The bar charts display invocation counts and wait times for each GenAI app. The **Apdex** and **User Feedback** pie charts provide insight into overall user satisfaction.

   ![Oracle Cloud console, Home page](images/2-1-infapp-enduser-tab.png " ")
2. Scroll down to explore top user sessions and queries with negative feedback.
   ![Oracle Cloud console, Home page](images/2-2-infapp-enduser-tab.png " ")

## Task 3: Review the Readme and Github download page

The **Readme** tab explains how to set up the dashboard, instrument apps with the APM agent, and describes GenAI attributes used. It also links to a GitHub page with more configuration details.

1. Click the **Readme** tab.
   ![Oracle Cloud console, Home page](images/3-1-infapp-readme-tab.png " ")
2. Review the setup instructions and attribute descriptions. Find **Inferencing app monitoring** which links to GitHub page. (do not click)
   ![Oracle Cloud console, Home page](images/3-2-infapp-readme-tab.png " ")
3. Right click the **Inferencing app mnitoring** link and choose to open in a new browser tab.
   ![Oracle Cloud console, Home page](images/3-3-infapp-readme-tab.png " ")
4. The GitHub page opens where you can download the dashboard files.
   ![Oracle Cloud console, Home page](images/3-4-github-page.png " ")

    >**Note:** The dashboard is already set up for lab use. When setting up a dashboard for your own purposes, download the dashboard file and import it into your APM domain. The GenAI attributes are documented in both the Readme tab and GitHub.  You can customize the widget queries based on your data. Token counts can be captured from the application’s service APIs or calculated using APM Span Enrichment. The image below shows an example of how token counts can be estimated using the length of input and output strings using an enrichment rule. This helps you measure the cost of each invocation, considering specific model pricing and the differences in input vs. output token rates from LLM providers.
     ![Oracle Cloud console, Home page](images/3-5-span-enrichment-rule.png " ")

## Task 4: Review the Cost analysis view

The **Cost analysis** tab provides insights into the cost spent on the GenAI applications.

1. Click the **Cost analysis** tab.
     ![Oracle Cloud console, Home page](images/4-1-cost-analysis-tab.png " ")

2. Review the cost related widgets, including total costs, average cost per session, cost by LLM model.
     ![Oracle Cloud console, Home page](images/4-2-cost-analysis-tab.png " ")

3. Scroll down to the **Top Users (by cost)** widget.
     ![Oracle Cloud console, Home page](images/4-3-cost-analysis-tab.png " ")
4. The widget displays tokens usage and the cost assocaited with for each user.
     ![Oracle Cloud console, Home page](images/4-4-cost-analysis-tab.png " ")

## Task 5: Review the Performance and Quality view

The **Performance & Quality** tab provides performance metrics and validate the GenAIs responses.

1. Click the **Performance and Quality** tab.
     ![Oracle Cloud console, Home page](images/5-1-perf-quality-tab.png " ")
2. Review the **Response time breakdown by GenAI service** widget, which provides a breakdown among the LLM processing time, Vector search time and embedding generation time. The example image shows that most time is spent on LLM.
     ![Oracle Cloud console, Home page](images/5-2-1-breakdown.png " ")
     Hover mouse cursor to view tooltips. 
     ![Oracle Cloud console, Home page](images/5-2-2-breakdown.png " ")
3. Scroll to the **Response Divergence** widget, which highlights drifted answers from the similar queries.  
     ![Oracle Cloud console, Home page](images/5-3-1-res-divergence.png " ")
 In this example, the first row shows 66 queries with 35 divergences. Click the number in the **Divergence** column.
     ![Oracle Cloud console, Home page](images/5-3-2-res-divergence.png " ")
4. Review the responsese made by the GenAI model. Click **Close** when done.
     ![Oracle Cloud console, Home page](images/5-4-drifts.png " ")
5. **Failed to answer** widget at the right side displays the failed responses categorizes by type. Click the title of the widget.
     ![Oracle Cloud console, Home page](images/5-5-1-failed-answers.png " ")
Review the actual answers. Click **Close**.
     ![Oracle Cloud console, Home page](images/5-5-2-failed-answers.png " ")
6. Scroll up to view the **GenAI invocation** bubble chart showing the outliers of the GenAI invocations.
     ![Oracle Cloud console, Home page](images/5-6-genai-invocations.png " ")
7. Change timeline to **Last 30 minutes** to show recent transactions. 
     ![Oracle Cloud console, Home page](images/5-7-genai-invocations-timechange.png " ")
8. Locate a small bubble icon at the top-right (an outlier), and click to view the trace information.
     ![Oracle Cloud console, Home page](images/5-8-genai-invocations.png " ")
9. Review the trace duration. In this example, their responses were more than 30 seconds. Click the arrow icon to drill down to the Trace Explorer to see the trace details.
     ![Oracle Cloud console, Home page](images/5-9-genai-invocations.png " ")

## Task 6: Analyze GenAI data in Trace Explorer


1. **Trace Explorer Trace Details** view opens. Click the triangle icon to close the **Topology** view.
     ![Oracle Cloud console, Home page](images/6-1-trace-ex.png " ")
2. In the waterfall (**Spans**) view, note that the **Invoke** spans were taking longer than **Embedding** and the **Vector search** spans. So the most time was spent on the conversation with LLM.
     ![Oracle Cloud console, Home page](images/6-2-trace-ex.png " ")
3. Click the invoke span to see the span details.
     ![Oracle Cloud console, Home page](images/6-3-trace-ex.png " ")
4.  Type **genai** in the search box. 
     ![Oracle Cloud console, Home page](images/6-4-1-span-details.png " ")
     This filters the list to show only GenAI related attributes.
     ![Oracle Cloud console, Home page](images/6-4-2-span-details.png " ")
5. Review attributes such as GenAI model used, prompt length, response length, and token count.
     ![Oracle Cloud console, Home page](images/6-6-genai-attributes.png " ")
6. Hover over **GenAI Cost** to see its exact decimal values.
     ![Oracle Cloud console, Home page](images/6-5-genai-attributes.png " ")
   Click **Close** to return to the waterfall view.
7.  To see the GenAI question the user made, click the parent span link.
     ![Oracle Cloud console, Home page](images/6-7-click-parentspan.png " ")
8. Filter again with **genai**, then review the query asked by the user, and app-generated response.
     ![Oracle Cloud console, Home page](images/6-8-parentspan-details.png " ")

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - Yutaka Takatsu, Product Manager, Enterprise and Cloud Manageability
- **Contributors** - Steven Lemme, Senior Principal Product Manager,  
Anand Prabhu, Sr. Member of Technical Staff,  
Avi Huber, Vice President, Product Management
* **Last Updated By/Date** - Yutaka Takatsu, June 2025
