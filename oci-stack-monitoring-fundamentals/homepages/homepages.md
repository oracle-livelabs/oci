# Stack Monitoring's Resource Homepages

## Introduction

In this lab, you will become familiar with using Stack Monitoring resource homepages. 

Estimated time: 10 minutes

### Objectives

* Using the resource homepage
* Learn the Performance menu including, alarms, charts and tables
* Understand the configuration details of a resource
* View application topology

### Prerequisites

* Completion of the labs before this one

## Task 1: Become familiar with the layout of a resource homepage

1. Open the navigation menu in the Oracle Cloud console, and select **Observability & Management** > **Stack Monitoring** under **Application Performance Monitoring**.

	![Oracle Cloud console Menu](images/1-1-console.png " ")

	Once you arrive at the Enterprise Summary, select the compartment **OracleApps** under eStore.

	![OCI Compartment list, highlighting the OracleApps compartment](images/1-2-console.png " ")	

2. Navigate to a **Concurrent Manager** resource.

	The Enterprise Summary page opens. The concurrent manager is one of the key resources you should monitor to help maintain the service level of an E-Business Suite (EBS) application. In the last lab we discussed that when you are troubleshooting, the Enterprise Summary provides quick insight into the performance of your resources at a glance. The Enterprise Summary also provide easy navigation to all of your monitored resources. For instance, when reviewing the **E-Business Suite** tier of the Enterprise Summary, should you see any concern, click the plot point of the Concurrent Manager and a slide-out window will appear providing historical metric details.

	![Enterprise Summary highlighting the Concurrent Manager](images/1-1-home.png " ")

	With the slide-out open, you can review the percentage of successful completed requests over time. Now lets take a closer look at this concurrent manager by clicking its name **EBS04a\_ConcurrentProcessing** at the top of the page. This will navigate you to that concurrent manager's homepage.

	![Concurrent Manager performance chart slide-out](images/1-2-home.png " ")

3. Application specific key resource homepages

	From the Concurrent Manager homepage, you can easily review the health and performance of this resource. Each resource in Stack Monitoring has a homepage that provides a central place to review status, performance, alarms, configuration and topology. At the top of the page, Stack Monitoring reports the current status, (Up, Down, Not Reporting). The color and shape of the status indicator will update depending on the resource status and type. Should you find a resource in a down state, the homepage will display a large **red** box with the status of **Down**. Stack Monitoring also provides a **Current Status** date and time. For example, if this Concurrent Manager goes down, Stack Monitoring will provide a timestamp of when the status switched from **Up** to **Down**.

	If a resource has a child resource, the Related resources widget will report the status of each of the children. In this example, two resources are up, and one resource, Concurrent Processing CPNode does not have a status.

	We can see a count of open alarms by severity **1 Warning** and **1 Critical**. Clicking an alarm count will open the Alarms slide-out to give you more details including the latest value of the alarm breaching the threshold. We'll cover the **Alarms** slide-out in more detail later.

	Stack Monitoring also provides quick access to critical metrics, these metrics differ by resource type. Here we can see **Completed Concurrent Requests** with an Errored state occur at an average rate of .36, and that the Capacity Utilization of Concurrent Managers is 100%. 


	![Concurrent Manager homepage, highlighting current status, open alarms, and top metrics](images/1-3-home.png " ")

## Task 2: Review the Performance menu including, alarms, charts and tables

1. Review key metric

	A Concurrent Manager homepage provides a list of **Key metrics** curated for each resource type, for example here the EBS Concurrent Manger. Stack Monitoring provides a large set of metrics out-of-the-box and are collected immediately once the discovery completes. The performance charts by default display the **Last 60 Minutes**. When investigating issues, it helps to review the performance change over a longer period of time. To extend the time frame click the drop-down and choose **Last 24 Hours**. The time period shown can be further adjusted by **sliding the time picker throughout the time period** shown to dive deeper into a performance problem. In the image below we can see the time period is the 24 hours, however, once we identified the anomaly we further reduced the time period to show only data between 5-6:45PM.

	Imagine that you have identified a spike in the number of concurrent requests that have been completed with errors. Using the **Completed Concurrent Requests**, hover over a point in time within that chart. Stack Monitoring will display the metric, dimension, timestamp, and value. If the metric has anomaly detection enabled, and the metric has only one dimension, Stack Monitoring will display the upper and lower boundary and if the current value is anomalous. For metrics with more than one dimension, clicking a dimension in the chart legend will hide/show dimensions allowing you to view the baseline for each dimension. When hovering over a data point in a chart, Stack Monitoring will also show metric details of every other chart on the page during that timestamp. Should you identify another area of concern, highlighting the metric will display the value of all other metrics on the page at the same time. For example, when you need to troubleshoot and correlate two metrics like a spike in errors using **Completed Concurrent Requests** and **Capacity Utilization of Concurrent Managers** to determine if the concurrent manager has reached 100% capacity and related to the errors observed.

	The **Key metrics** can be reordered to prioritize the metrics that are important to you. To reorder the charts or hide a chart, click **Configure charts**. 

	![Concurrent Manager key metric charts, highlighting anomalous performance](images/2-1-home.png " ")

	Stack Monitoring uses **Tables** to report all dimensions of a metric. Let's navigate to tables to view all of the data points. Select the **Tables** tab. Charts provide a metrics highest utilized metric dimension. **Tables** provide the latest collection value for every dimension of a metric. In this example let's review the **Concurrent Processing Component Status**. Click the **triangle** to expand the row and display the metrics table. Here we see the count all dimensions of the metric Concurrent Processing Component Status. The dimensions include: Scheduled, Running, PendingStandBy, PendingNormal, InactiveOnHold, and InactiveNoManager. 

	![Configure Key Metric Charts](images/2-2-home.png " ")

	In the image below we can now see **User With Most Pending Requests** is listed first, and **Capacity Utilization of Concurrent Managers** is no longer shown on the charts. To put the metrics back in their original order, if you choose, once again click **Configure charts**.

	![Configure Key Metric Charts with udpated view](images/2-3-home.png " ")

2. Review all metrics

	Stack Monitoring uses **All metrics** to report all dimensions of a metric. Let's navigate to **All metrics** to view all of the data points. Select the **All metrics** tab. Key metrics provide either the top 5 or bottom 5 utilized metric dimensions. **All metrics** provide the latest collection value for every dimension of a metric. In this example let's review the **Concurrent Processing Component Status**. Click the **triangle** to expand the row and display the metrics table. Here we see the count all dimensions of the metric Concurrent Processing Component Status. The dimensions include: Scheduled, Running, PendingStandBy, PendingNormal, InactiveOnHold, and InactiveNoManager. 

	Select the **Alarms** link in the left menu.

	![Concurrent Manager all metrics, highlighting concurrent requests by status](images/2-4-home.png " ")

3. Review open alarms

	Select the **Alarms** tab. Using the **Alarms** view we can see a detailed list of open alarms that includes the alarm Severity, Trigger Time, Resource Name, Metric Name, Dimension of the metric, Alarm Name and **Current Value**. In the previous lab you learned that clicking an alarm **Name** will open a new tab within OCI's Monitoring Service. Now let's review the configuration details of a resource.

	![Concurrent Manager alarm slide-out](images/2-5-home.png " ")

## Task 3: Review configuration details of the resource

1. Locate **Configuration** in the left menu of the homepage.

	Using data provided within **Configuration** you can easily determine a resource's installation location. This can be helpful to quickly identify where to find log files. Stack Monitoring **Configuration** provides quick access to both general OCI properties and resource-specific properties. Using this Concurrent Manager as an example, the **Resource-specific properties** such as database service_name and the application schema name can help you quickly identify the database and schema that contains the EBS data.

	![Concurrent manager resource-specific properties](images/3-1-home.png " ")

## Task 4: Review application topology

1. Locate **Topology** under the Resources menu on the left side of the homepage.

	Now let's learn about the application topology capability within Stack Monitoring. From the left side menu, locate **Topology**. **Topology** provides quick access to all resources associated with this Concurrent Manager. This capability makes it easy to identify which EBS Application the Concurrent Manager belongs to. Additionally, you can identify which management agent monitors this concurrent manager. Identifying the monitoring agent is useful if the status of the resource is Not Reporting. Typically, if a resource has a status of Not reporting, the Management Agent is not uploading data.
	
	Topology can be updated by selecting **Add association**. This will invoke a slide-out where you can select a resource and its relationship with the current resource. We will review associations in **Lab 8: Importing OCI Services**. In this lab you will import an OCI load balancer in to Stack MOnitoring, then review the new home page and create the relationship with the WebLogic cluster that uses the load balancer. 

	![Concurrent Manager related resources](images/4-1-home.png " ")

	You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - Aaron Rimel, Principal Product Manager, Enterprise and Cloud Manageability
* **Contributors:** 
	* Ana McCollum, Senior Director of Product Management, Enterprise and Cloud Manageability,  
	* Steven Lemme, Senior Principal Product Manager,  
	* Anand Prabhu, Sr. Member of Technical Staff
* **Last Updated By/Date** - Aaron Rimel, June 2024
