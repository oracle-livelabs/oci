# Explore APM Trace Data

## Introduction

In this lab, you will use the APM Trace Explorer to examine the traces and spans collected from the monitor run. You will inspect the Query view and learn how the parameters are carried over from the monitor page, how to use Topology and Waterfall views to analyze the traces and spans, and view span dimensions to identify the root cause of the problem. You will also use predefined and saved queries to analyze the trend and behavior of the span causing the performance issue.  


APM Trace Explorer lets you run queries and visualizations of APM data, including the following.
 - 	Traces (full transactions)
 - 	Spans (individual units of work which form a trace)


Estimated time: 5 minutes

### Objectives

* Examine the pre-configured query in Trace Explorer
* Understand relations of services and operations in the Topology view
* Drill down to the trace Details
* Inspect the SQL spans by executions
* Analyze the SQL spans with the histogram query

### Prerequisites

* Completion of the preceding labs in this workshop

## **Task 1**: Examine the pre-configured query in Trace Explorer

1.  In the end of the previous lab, you selected to launch the **Trace Explorer** from the **Monitor History** page. Traces that are listed in the **Traces** section are captured from the monitor run.

	![Oracle Cloud, Trace Explorer](images/1-0-tx.png " ")

2. Examine the **where clause** in the query. You will see the parameters **Monitor ID**, **Vantage point**, and the **MonitorRunId** carried over from the Monitor History page, and automatically constructed a query to show a list of traces for this particular monitor run.

	![Oracle Cloud, Trace Explorer](images/1-1-tx.png " ")

## **Task 2**: Understand relations of services and operations in the Topology view

1. Click the **Topology** Icon at the right hand side of the screen.

	![Oracle Cloud, Trace Explorer](images/1-2-tx.png " ")

2. The **Topology** diagram opens. This is the **Service topology** constructed from the flow of the 17 transactions executed by the Monitor.

	![Oracle Cloud, Trace Explorer](images/1-3-tx.png " ")

3. Examine the diagram by hovering the mouse over the nodes and arrows.

 	Hovering over a service shows the service name.

	![Oracle Cloud, Trace Explorer](images/1-5-tx.png " ")

	Hovering over an arrow shows the connection details between the services. Notice that the thicker the arrow, the longer the connection time. So the diagram helps you to identify where in the services the slowness has occurred.  

	![Oracle Cloud, Trace Explorer](images/1-4-tx.png " ")

4. Click the **Operations** button to see the operation level topology.

	![Oracle Cloud, Trace Explorer](images/1-6-tx.png " ")


5. Now the topology shows the operations. Click the **Show Diagram Controls** icon (icon with four bars).

	![Oracle Cloud, Trace Explorer](images/1-7-tx.png " ")

6. Click **Arrow Width** to open a pulldown. Then select **Max Span Duration**.

	![Oracle Cloud, Trace Explorer](images/1-8-tx.png " ")

7. Click **X** to close the pane.

	![Oracle Cloud, Trace Explorer](images/1-9-tx.png " ")

8. Find a path with thick arrows in the diagram to identify the slowness. In the screenshot below, a path involving the checkout is obviously taking a long time.

	![Oracle Cloud, Trace Explorer](images/1-10-tx.png " ")

9. Hover the mouse over the arrow between the last operation and database. A floating window shows information of the slow SQL executed.

	![Oracle Cloud, Trace Explorer](images/1-11-tx.png " ")


## **Task 3**: Drill down to the trace Details

1. Click the black triangle icon at the right side of the Query view. A list of queries used in the session will show in a pulldown. Select the previous query executed.

	![Oracle Cloud, Trace Explorer](images/1-12-tx.png " ")

2. Now you are back at the **Traces** section. Look at the transactions (traces) executed by the monitor, and locate the slow trace that is taking more than 15 seconds. In the screenshot below, there is a trace that is taking 18 seconds to complete. Click the link on the first column.

	![Oracle Cloud, Trace Explorer](images/1-13-tx.png " ")


3. The Trace detail page opens and displays the flow of action for the specific transaction, in **Topology** and **Waterfall** views.

	![Oracle Cloud, Trace Explorer](images/1-14-tx.png " ")

	>***Note :*** The operations in the topology are the spans that are seen in the waterfall view.

	In the **Topology** view, hover mouse over the icons. As you have already verified in the previous steps, the slowness is seen in the monitor when a checkout button is clicked by the synthetic user.

	![Oracle Cloud, Trace Explorer](images/1-15-tx.png " ")


4. Click the triangle icon next to the **Topology** label, to minimize the topology region.

	![Oracle Cloud, Trace Explorer](images/1-16-tx.png " ")


5. The waterfall view shows the spans invoked in the transaction. If the trace is spread across multiple services, spans in each service appear in a different color. Review the following.


	 - The view visualizes the workflow of the trace, and relation between the spans.
	 - Each bar represents a span, and the time length goes from left to right.
	 - The longer the bar, the more time was consumed to complete the operation.
	 - The bar at the top is a root span, and child-spans are nested below.
	 - Spans may wait for the next span to complete, or may not if it is an async call.


	 ![Oracle Cloud, Trace Explorer](images/1-17-tx.png " ")

	 	>***Note :*** The waterfall view is visualized in the form of a Gantt chart.

6. Look at the waterfall view, and try to identify the slow span. For example, in the screenshot below, **wsk-checkou:update** is clearly the bottleneck, blocking the payment service to process.

	![Oracle Cloud, Trace Explorer](images/1-18-tx.png " ")

	Click the link, or the bar of the span.

7. **Span details** page opens. In this page, span details are provided in the list of dimensions. Scroll down the list, and review the information of the span. E.g., App server name, type and the port it uses, Kubernetes node and pod names, and the information related to the host and Oracle Cloud. Because this span is a JDBC span, it also includes information from the database. These dimensions are provided out-of-the-box and can help you investigate a problem. You can also create custom dimensions.

	![Oracle Cloud, Trace Explorer](images/1-19-tx.png " ")

8. As scrolling down, locate the dimensions related to the database. In this case, you identified that the problem is a slow SQL. The dimensions provide the actual SQL, the time it took to execute, the DB Connection string and the SQLID.

	![Oracle Cloud, Trace Explorer](images/1-20-tx.png " ")

	Using the DB Connection string and the SQLID, you can drilldown to perfhub and/or Operations Insights service in Oracle Cloud, to investigate the issue with the database.

	>***Note :*** In context drill down to the database service is on the roadmap


9. Click **Close**, then click **Trace Explorer** link from the breadcrumb to go back to the Trace Explorer main page.

	![Oracle Cloud, Trace Explorer](images/1-21-tx.png " ")
	![Oracle Cloud, Trace Explorer](images/1-22-tx.png " ")


## **Task 4**: Inspect the SQL spans by executions


1. Now you are back at the Trace Explore main page. From the Quick Pick tab, click **SQLs**.

	![Oracle Cloud, Trace Explorer](images/1-23-tx.png " ")

2. Verify that the SQL comes at the top of the list, is the same SQL, which you found as a bottleneck in the previous steps. The view is sorted by the slowest average duration. Next, let's check whether the SQL is always slow or not. Click the **Count** column of the SQL on the top row.
	![Oracle Cloud, Trace Explorer](images/1-24-tx.png " ")

3. 	You can see each of the individual executions of the SQL. Confirm that the SQL is not always slow when executed. Scroll down the list as needed.

	![Oracle Cloud, Trace Explorer](images/1-25-tx.png " ")


## **Task 5**: Analyze the SQL spans with the histogram query

1. Another way to analyze the distribution is to use the histogram view. Click the three-dot icon under the **Run** button, then click **Open**.

	![Oracle Cloud, Trace Explorer](images/1-27-tx.png " ")

2. Type **histogram** in the search field. Select the query **SQL-Histogram**, then click **Open**.

	![Oracle Cloud, Trace Explorer](images/1-28-tx.png " ")


	>***Note :*** Alternatively, copy the text below, and paste into the **Query** view, then hit enter, or press the **Run** button.

	``` bash
	<copy>
	show spans histogram(spanDuration, 2000,10000,10) as Bucket, min(spanDuration) as "Min", max(spanDuration) as "Max", count(*) as count, avg(spanDuration) as Avg  where operationName='/frontStore/checkout' group by histogram(spanDuration, 2000,10000,10) order by max(spanDuration) asc
	</copy>
	```

3. Inspect the histogram view opened in the screen.

	![Oracle Cloud, Trace Explorer](images/1-29-tx.png " ")

  In the above screenshot, you can see the following.

  -  In 90% of the total executions (sum of the first 3 rows), the SQL runs under 3ms on average. in. So it is usually very fast.
    ![Oracle Cloud, Trace Explorer](images/1-30-tx.png " ")


  - However, in some cases it runs much slower. The 6% of the total executions shows the average duration of more than 17 seconds.
    ![Oracle Cloud, Trace Explorer](images/1-31-tx.png " ")


    > ***Note :*** The root cause of the issue is the lock contention in the database that the update statement is being blocked by another sql that is doing a select on the same table. That uses a lot of CPU and takes a long time to execute, and is causing the update statement that usually runs in ms while slows down intermittently.       

    You can further diagnose the issue in the PerfHub and use Operations Insights service to solve this problem in the database. For more details on the solution at the database, please watch the following video that demonstrates how the contention can be identified and how it can be resolved. In the demo, the issue was resolved by enabling the auto index feature to the autonomous database using the Operations Insights service in Oracle Cloud.

    [Demonstration, A New Platform for Multicloud Observability and Management](https://youtu.be/EnsQMOEhWjQ?t=1058)

    [![YouTube](images/1-32-tx.png)](https://youtu.be/EnsQMOEhWjQ?t=1058 "Redirect to YouTube")

## Conclusion

  In this workshop, you have learned how to use various APM features to detect a performance problem, analyze the data, and drill down to the cause of the problem.

  You can use the APM Home page and Alarm details page to understand the potential issue in your application, use Monitors dashboard page to examine the collected data, and use Monitor history page and the APM Trace Explorer to drill down to the cause of the problem.

  For more information on APM, refer to the OCI documentation, **[Application Performance Monitoring](https://docs.oracle.com/en-us/iaas/application-performance-monitoring/index.html)**.




## Acknowledgements

* **Author** - Yutaka Takatsu, Product Manager, Enterprise and Cloud Manageability
- **Contributors** - Steven Lemme, Senior Principal Product Manager,  
Avi Huber, Senior Director, Product Management
* **Last Updated By/Date** - Yutaka Takatsu, August 2022
