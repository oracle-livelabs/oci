# Examine APM Monitors

## Introduction

In this lab, you will review the status and performance of the entire enterprise from the Stack Monitoring Enterprise Summary page, identify the number of resources in a down state and identify the list of Oracle Databases in a Not Reporting state. Review the performance metrics of the various tiers (e.g. E-Business Suite, PeopleSoft, WebLogic Server, Oracle Database, and Host). Finally, modify the Tablespace Utilization table, under the Oracle Database tier. 

Estimated time: 10 minutes

### Objectives

* Identify a list of resources in a down state across the enterprise
* Identify a list of Oracle Databases in a Not Reporting state
* Review all open alarms within an enterprise
* Review the performance of resources by tier (e.g. E-Business Suite, PeopleSoft, WebLogic Server, Oracle Database, and Host)
* Replace the Oracle Database table metric, Storage Utilization by Tablespace, with the metric FRA Utilization

### Prerequisites

* Completion of the preceding labs in this workshop

## Task 1: Identify a list of resources in a down state across the enterprise

1. Open the navigation menu in the Oracle Cloud console, select **Observability & Management** > **Stack Monitoring** under **Application Performance Monitoring**.

	![Oracle Cloud console Menu](images/1-0-menu.png " ")

2. Stack Monitoring Enterprise Summary page opens. Locate the **Status summary** chart on the left side of the page. You can see a count of resources by status across the enterprise. 

	![Oracle Cloud console, APM Home](images/1-1-home.png " ")

	Find the **Down** label in the Status summary chart.  Clicking **Down**, invokes a slide out reporting all of the resources in a down state. The slide out filter can be changed to quickly view all resources in any given state. This list can be sorted by name, status, and type. You can also search by name to quickly view the status of any given resource.  Click on the **Close** button to return to the Enterprise Summary.

	![Oracle Cloud console, APM Home](images/1-2-monitor.png " ")

3. Locate the **Status by resource type** chart at the top center of the page. This chart provides a count of resources by resource type across the enterprise. Clicking **Not Reporting**, 

## Task 2: Inspect the performance charts in the Monitor dashboard

1. **Monitors** dashboard opens. Notice that the **WineStore-E2E** is pre-selected in the **Monitor** field. The Monitors dashboard shows performance and error summary information of multiple, or specific Monitors.

 	![Oracle Cloud console, APM Home](images/1-3-monitor.png " ")

2. Locate the **Run by Vantage Point** bar chart.

	APM Monitor is an automated test periodically run by APM on an application. The monitor can be run from multiple OCI sites, called **Vantage Points**. In this chart, each bar represents a Vantage point.  Hover the mouse on bars and observe the location and number of runs.

 	![Oracle Cloud console, APM Home](images/1-4-monitor.png " ")

	>**Note:** The example screenshot above does not have errors, but the chart also shows errors for any failure runs.
	 	![Oracle Cloud console, APM Home](images/1-4-2-monitor.png " ")


3. Right to the Vantage point chart, you will see the **Load and Execution Time** chart. Spot a few spikes indicating slow executions in the chart. These likely caused an Alarm we saw earlier. Hover the mouse over the data points to see details.

 	![Oracle Cloud console, APM Home](images/1-5-monitor.png " ")


4. Scroll down to locate the **Load Time Breakdown** chart. You can see that the Ajax wait time is taking a large portion of the load time, which is typically waiting for a backend response.
 	![Oracle Cloud console, APM Home](images/1-6-monitor.png " ")

5. Find the **Connect Time Breakdown** chart on the right side. In the screenshot example, there is no connection related slow down you can see in the chart. However, in cases there are failures in monitor runs, the chart helps you to analyze the root cause. For example, the failed runs can be caused by the SSL not being resolved or an issue in DNS. Also, a longer execution time may be caused by the delay in connection.

 	![Oracle Cloud console, APM Home](images/1-7-monitor.png " ")


6. Scroll down the page and locate the Monitors section. Click on the **WineStore-E2E** monitor.

 	![Oracle Cloud console, APM Home](images/1-8-monitor.png " ")

	This will open the Monitor details page. In the next lab, we will look at the details of the Monitor to see what additional information is available.

 	![Oracle Cloud console, APM Home](images/1-9-monitor.png " ")

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - Yutaka Takatsu, Product Manager, Enterprise and Cloud Manageability
- **Contributors** - Steven Lemme, Senior Principal Product Manager,  
Anand Prabhu, Sr. Member of Technical Staff,  
Avi Huber, Vice President, Product Management
* **Last Updated By/Date** - Yutaka Takatsu, August 2022
