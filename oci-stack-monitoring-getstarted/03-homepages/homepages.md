# Stack Monitoring's Resource Homepages

## Introduction

In this lab, you will become familiar with a resource's homepage. 

Estimated time: 15 minutes

### Objectives

* Become familiar with the layout of a resource homepage
* Review Performance menu including, alarms, charts, tables, and Stack View
* Review configuration details of the resource
* Review application topology
* Putting it all together

### Prerequisites

* Completion of the first lab

## Task 1: Become familiar with the layout of a resource homepage

1. Open the navigation menu in the Oracle Cloud console, select **Observability & Management** > **Stack Monitoring** under **Application Performance Monitoring**.

	![Oracle Cloud console Menu](images/1-1-console.png " ")

2. Navigate to a **Concurrent Manager** resource.

	The Enterprise Summary page opens. In the last lesson we discussed when you are troubleshooting, the Enterprise Summary provides quick insight into the performance of your resources at a glance. Located on the E-Business Suite (EBS) tier, the **Concurrent Manager requests** chart provides visibility into all concurrent managers in your enterprise. Should a concurrent manager need to be investigated further, such as the percentage of completed concurrent requests are low, navigating to that resource's homepage is easy. Let's click the dot within the **Concurrent Manager requests** chart to investigate. 

	![Oracle Cloud console, Stack Monitoring Homepages](images/1-1-home.png " ")

3. Resource homepages

	In the Concurrent Manager homepage, we can easily review the health and performance of this resource. Each resource in Stack Monitoring has a homepage that provides a central place to review status, performance, and alarms. At the top of the page, Stack Monitoring reports the current status, (Up, Down, Not Reporting). The color and shape of the status indicator will update depending on the resource status and type. Should you find a resource in a down state, the homepage will display a large **red** box with the status of **Down**. Stack Monitoring also provides a **Current Status** date and time. For example, if a database goes down, Stack Monitoring will provide a timestamp of when the database status switched from **Up** to **Down**.

	We can see a count of open alarms by severity. Clicking an alarm count will open the Alarms tab below. We'll cover alarms when we discuss the **Alarms** tab in more detail later.

	![Oracle Cloud console, Stack Monitoring Homepages](images/1-2-home.png " ")

## Task 2: Review Performance menu including, alarms, charts, tables, and Stack View

1. Review performance charts

	When you navigate to a resource from the Enterprise Summary charts and tables, the homepage loads the **Charts** tab by default. A concurrent manager homepage provides a list of charts specially curated to the concurrent manger. These metrics are collected out-of-the-box and immediately begin collecting after the resource is discovered. By default the **Last 60 Minutes** is displayed. When investigating issues it may be good to see the performance change over a larger time period. To extend the time-frame click the drop-down and choose **Last 24 Hours**. All charts will now display data from the last 24 hours. Let's imagine we have identified a spike in the number of concurrent requests that have erred. Using the **Concurrent Requests by Status**, hover over a point-in-time within that chart. Stack Monitoring will display the metric, dimension, timestamp, and value. Stack Monitoring will also show metric details of every other chart on the page during that timestamp. Should you identify an area of concern, highlighting the metric displays the value of all other metrics on the page at the same time. This is helpful when troubleshooting to correlate two metrics such as a spike in errors using **Concurrent Requests by Status** and the chart **Capacity Utilization of Concurrent Managers** to determine if the concurrent manager is reaching 100% capacity. Charts provide the five highest or most utilized dimensions of a metric. Stack Monitoring uses **Tables** to report all dimensions of a metric. Let's navigate to tables to see all of the data points.

	![Oracle Cloud console, Stack Monitoring Homepages](images/2-1-home.png " ")

2. Review metric tables

	Select the **Tables** tab. Tables provide the latest collection value of every metric across all dimensions. Let's review **Concurrent Requests By Status**. Click the **triangle** to expand the table. Here we see the count of the concurrent requests by different status (i.e. Scheduled, Running, PendingStandBy, PendingNormal, InactiveOnHold, and InactiveNoManager). 

	![Oracle Cloud console, Stack Monitoring Homepages](images/2-2-home.png " ")

3. Review open alarms

	Select the **Alarms** tab. Using the **Alarms** view we can see a detailed list of open alarms that includes the alarm Name, Severity, and Last Triggered date/time. Clicking an alarm **Name** will open a new tab in your browser to investigate and work the alarm within Oracle Cloud Infrastructure's monitoring service. We'll review this workflow later in this lesson. For now, let's review configuration details of a resource.

	![Oracle Cloud console, Stack Monitoring Homepages](images/2-3-home.png " ")

## Task 3: Review configuration details of the resource

1. Locate **Configuration** in the left menu of the homepage.

	Configuration provides quick access to both general OCI properties and resource-specific properties. Using data provided within the **Configuration** you can easily identify the resource's installation location to locate log files. Other examples of resource properties include database service_name and the application schema name. Now let's learn about associations within Stack Monitoring.

	![Oracle Cloud console, Stack Monitoring Homepages](images/3-1-home.png " ")

## Task 4: Review application topology

1. Locate **Related Resources** under the Resources menu on the left side of the homepage.

	Locate **Related Resources** in the left menu. Clicking **Related Resource** provides quick access to all resources associated with this resource. Using Related Resources we can also identify the EBS Application this concurrent manager belongs to. Additionally, we can identify which management agent monitors this concurrent manager. This is useful if the status of the EBS Concurrent Processing instance is Not Reporting, which is usually caused by problems with the agent uploading data. Now let's put it all together.

	![Oracle Cloud console, Stack Monitoring Homepages](images/4-2-home.png " ")

## Task 5: Putting it all together

1. Identify an alarm

	Let's begin by clicking the count of open alarms in a **Warning** state at the top of the homepage. 

	![Oracle Cloud console, Stack Monitoring Homepages](images/5-0-home.png " ")

	With the alarms tab opened, we can see an open alarm **EBS Concurrent Request with Errors**. Clicking the alarm name opens a new tab in the OCI Monitoring Service.

	![Oracle Cloud console, Stack Monitoring Homepages](images/5-1-home.png " ")

	From this page we see a chart with rate of requests over time, with an overlay of the alarm status noted in red within the chart. Using the color we can easily identify if this alarm is flapping. Let's close the tab and return to Stack Monitoring.

	![Oracle Cloud console, Stack Monitoring Homepages](images/5-2-home.png " ")

	Let's review the charts associated with this Concurrent Manager by clicking the **Performance** menu on the left side of the page. Next select the **Charts** tab. Now let's expand the charts to show the **Last 7 Days**. Reviewing the chart, **Completed Concurrent Requests**, we do not see a spike in jobs resulting in errors. The chart **Capacity Utilization of Concurrent Managers** does not show any concurrent managers nearing 100% capacity. Reviewing the other metrics, all recent activity appears stable. Now let's review the overall health and performance of the entire EBS application stack.

	![Oracle Cloud console, Stack Monitoring Homepages](images/5-3-home.png " ")

	Identifying and navigating to the EBS application associated with this Concurrent Manager is easy by clicking **Related Resources** on the left side of the page. Locate the resource **EBS_PROD_01** with the type **EBS**. Click the name of the resource **EBS_PROD_01** to navigate to the application's homepage.

	![Oracle Cloud console, Stack Monitoring Homepages](images/5-4-home.png " ")

3. Reviewing an EBS application homepage

	We can see that an EBS homepage is very similar to a standard resource homepage with a few additions. We see an overall availability of resources related to this EBS application, this includes resources such as the concurrent manager, notification mailer, and workflow manager, etc. Stack Monitoring also provides a summary of alarms for the EBS application and its members by severity. 

	![Oracle Cloud console, Stack Monitoring Homepages](images/5-5-home.png " ")

	In the previous task we reviewed the **Alarms** tab. The alarms shown in the EBS homepage includes both the open alarms for the EBS application itself, as well as open alarms for its members. The EBS homepage you can see a roll-up of all alarms for EBS and it's members, without navigating to multiple homepages. Here we can see the same alarm we investigated within the Concurrent Manager homepage, **EBS Concurrent Request with Errors**, as this alarm is rolled up to the application level. 

	![Oracle Cloud console, Stack Monitoring Homepages](images/5-6-home.png " ")

	Clicking **Charts** provides quick visibility into the health of the EBS application. We can continue our previous investigation by expanding the chart time displayed from **Last 60 Minutes** to **Last 7 Days**. From this page nothing appears to standout as a cause for high number of requests that have errored. The **Completed Requests by Application** and the number of **Active User Sessions** remain consistent. The remaining charts show periods of activity but no drastic changes are apparent. Since we have already covered tables, let's move on to Stack View.

	![Oracle Cloud console, Stack Monitoring Homepages](images/5-7-home.png " ")

4.	Selecting the **Stack View** tab loads a unique feature to Stack Monitoring, the **Stack View**.

	Locate the tab **Stack View** from the available menu items. **Stack View** provides a holistic view of the health and performance of the entire EBS application by combining resource specific charts all in one place. Let's begin by again adjusting the time frame from **Last 60 Minutes** to **Last 14 Days**. Now let's expand each tier. With each tier expanded, you can now get a complete view of the performance of your EBS application. 

	![Oracle Cloud console, Stack Monitoring Homepages](images/5-8-home.png " ")

	Beginning with the **EBS Instance**, EBS admins are typically aware of the typical time it takes for a request to complete, and which requests run long. Looking back we can identify if a particular program or several programs took longer to complete than is typical. We can again hover over a data point and look for any correlation across all charts on the page. Reviewing the charts show some variability, but no area of concern. 

	Since EBS is a java application, Stack Monitoring provides details into the performance of the WebLogic (WLS)cluster, specifically OACORE, the heart of EBS. Using our alarm example of **EBS Concurrent Request with Errors**, we can use the WebLogic tier to determine if WLS is contributing the errored program runs by investigating for memory exhaustion. From within this tier we can see that JVM Memory, both heap and non-heap, utilization is well below 100%. The number of active thread pool threads that are hogging are low. And finally, there does not seem to be any waiting JDBC Connections. From this review WLS appears to be stable and healthy.

	![Oracle Cloud console, Stack Monitoring Homepages](images/5-9-home.png " ")

	Reviewing the **EBS Database** tier, we can review the number of transactions committed and rolled back. The count of rolled back sessions is quite low. Additionally, transaction wait times across dimensions remains low as well. As a result, the database does not appear to be spending much time waiting, and the committed transaction count indicates the database is not busier than normal.

	Finally, we can review the health of the EBS hosts. Both the hosts CPU and memory are well below their maximum. Upon first look the host appears to be healthy and does not appear to be strapped for resources. 

	![Oracle Cloud console, Stack Monitoring Homepages](images/5-10-home.png " ")
	
	In this lesson we used a previously created alarm to alert the user if any concurrent manager jobs complete with errors. During the exercise we reviewed various performance metrics across the application stack. We leveraged Stack Monitoring's topology to navigate between resources to help triage the alert. We were not able to identify any apparent cause for the failures. At this time the next step would be to connect to the concurrent manager server and review the error messages written to the logs. 



## Conclusion

In this workshop, we learned that **Stack Monitoring** Stack Monitoring enables you to monitor the overall health of your applications and its underlying application stack including servers, databases, and hosts. You can use Enterprise Summary to immediately assess status and performance across each application stack tier, and its interactive design enables dynamic changes to any performance charts. Resource homepages provide a curated view of the health and performance of your resources through charts, tables, and **Stack View**. Additionally, homepages provides application topology. Using Stack Monitoring's associations allow you to easily triage performance issues across the application stack. And finally, we learned the **Stack View** provides the ability to research the health and performance of the entire EBS application stack from a single page using **Stack View** reducing incident times. 

For more information on Stack Monitoring, refer to the OCI documentation, **[Stack Monitoring](https://docs.oracle.com/en-us/iaas/stack-monitoring/index.html)**.

## Acknowledgements

* **Author** - Aaron Rimel, Principal Product Manager, Enterprise and Cloud Manageability
- **Contributors** - Ana McCollum, Senior Director of Product Management, Enterprise and Cloud Manageability
* **Last Updated By/Date** - Aaron Rimel, February 2023
