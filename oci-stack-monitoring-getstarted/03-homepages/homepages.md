# Stack Monitoring's Resource Homepages

## Introduction

In this lab, you will become familiar with a resource's homepage. 

Estimated time: 15 minutes

### Objectives

* Become familiar with the layout of a resource homepage
* Review Performance menu including, alarms, charts, tables, and Stack View
* Review configuration details of the resource
* Identifying relationships between resources.
* Putting it all together
* Review E-Business Suite homepage
* Review Stack View

### Prerequisites

* Completion of the first lab

## Task 1: Become familiar with the layout of a resource homepage

1. Open the navigation menu in the Oracle Cloud console, select **Observability & Management** > **Stack Monitoring** under **Application Performance Monitoring**.

	![Oracle Cloud console Menu](images/1-1-console.png " ")

2. Navigate to a **Concurrent Manager** resource.

	The Enterprise Summary page opens. In the last lesson we discussed when you are troubleshooting, the Enterprise Summary provides quick insight into the performance of your resources at a glance. Located on the E-Business Suite (EBS) tier, the **Concurrent Manager requests** chart provides visibility into all concurrent managers in your enterprise. Should a concurrent manager need to be investigated further, such as the percentage of completed concurrent requests are low, navigating to that resource's homepage is easy. Let's click the dot within the **Concurrent Manager requests** chart to investigate. 

	![Oracle Cloud console, Stack Monitoring Homepages](images/1-1-home.png " ")

3. Resource homepages

	With the Concurrent Manager homepage loaded, we can easily review the health and performance of this resource. Stack Monitoring homepages have a consistent look and feel across all resource types. Each resource homepage is provided out-of-the-box immediately upon discovery of the resource. At the top of the page, Stack Monitoring reports the current status, (Up, Down, Not Reporting, Not Applicable). The color and shape of the status indicator will update depending on the resource status and type. Should you find a resource in a down state, the homepage will display a large **red** box with the status of **Down**. Stack Monitoring also provides a **Current Status** date and time. For example, if a database goes down, Stack Monitoring will provide a timestamp of when the database status switched from **Up** to **Down**.

	We can see a count of open alarms by severity, clicking an alarm count will open the Alarms tab below. We'll cover alarms when we discuss the **Alarms** tab in more detail later.

	![Oracle Cloud console, Stack Monitoring Homepages](images/1-2-home.png " ")

## Task 2: Performance Menu

1. Review performance charts

	When you navigate to a resource from the Enterprise Summary charts and tables, the homepage loads the **Charts** tab by default. A concurrent manager homepage provides a list of charts specially curated to the concurrent manger. These metrics are collected out-of-the-box and immediately begin collecting after the resource is discovered. By default the **Last 60 Minutes** is displayed. When investigating issues it may be good to see the performance change over a larger time period. To extend the time-frame click the drop-down and choose **Last 24 Hours**. All charts will now display data from the last 24 hours. Let's imagine we have identified a spike in the number of requests that have errored. Using the **Concurrent Requests by Status**, hover over a point-in-time within that chart. Stack Monitoring will display the metric, dimension, timestamp, and value. Stack Monitoring will also show metric details of every other chart on the page during that timestamp. Should you identify an area of concern, highlighting the metric displays the value of all other metrics on the page at the same time, in an effort to correlate the issue with other metrics. Charts provide the five highest or most utilized dimensions of a metric. Stack Monitoring uses **Tables** to report all dimensions of a metric. Let's navigate to tables to see all of the data points.

	![Oracle Cloud console, Stack Monitoring Homepages](images/2-1-home.png " ")

2. Review metric tables

	Select the **Tables** tab. Tables provide the latest collection value of every metric across all dimensions. Let's review **Concurrent Requests By Status**. Click the **triangle** to expand the table. Here we see the count of the concurrent requests by different status (i.e. Scheduled, Running, PendingStandBy, PendingNormal, InactiveOnHold, and InactiveNoManager). 

	![Oracle Cloud console, Stack Monitoring Homepages](images/2-2-home.png " ")

3. Review open alarms

	Select the **Alarms** tab. Using the **Alarms** view we can see a detailed list of open alarms that includes the alarm Name, Severity, and Last Triggered date/time. Clicking an alarm **Name** will open a new tab in your browser to investigate and work the alarm within Oracle Cloud Infrastructure's monitoring service. We'll review this workflow later in this lesson. For now, let's review configuration details of a resource.

	![Oracle Cloud console, Stack Monitoring Homepages](images/2-3-home.png " ")

## Task 3: Easily review a resource's details using **Configuration**

1. Locate **Configuration** in the left menu of the homepage.

	Configuration provides quick access to both general OCI properties and resource-specific properties. Using data provided within the **Configruation** you can easily identify the resource's installation location to locate log files. Other examples of resource properties include database service_name and the application schema name. Now let's learn about associations within Stack Monitoring.

	![Oracle Cloud console, Stack Monitoring Homepages](images/3-1-home.png " ")

## Task 4: Identifying a resource's relationships

1. Locate **Members** under the Resources menu on the left side of the homepage.

	**Members** show associations that are part of another resource. For instance, a Concurrent Processor **contains** a concurrent processing node. We can see that relationship here. When reviewing the performance charts, should a performance issue be identified, using a relationship link, such as Concurrent Processing Node, allows easy access up and down the application stack. We'll cover this a more detail later. Now lets review all relationships with this concurrent manager.

	![Oracle Cloud console, Stack Monitoring Homepages](images/4-1-home.png " ")

2. Locate **Related Resources** under the Resources menu on the left side of the homepage.

	Locate **Related Resources** in the left menu. Clicking **Related Resource** provides quick access to all resources that have a relationship with another resource. Using Related Resources we can easily identify which management agent monitors this concurrent manager. We again can see the concurrent manager processing node that runs within this concurrent manager. Finally we can easily identify the EBS Application this concurrent manager belongs to. Now let's put it all together.

	![Oracle Cloud console, Stack Monitoring Homepages](images/4-2-home.png " ")

## Task 5: Putting it all together

1. Identify an alarm

	![Oracle Cloud console, Stack Monitoring Homepages](images/5-1-home.png " ")

	Let's begin by clicking the count of open alarms in a **Warning** state at the top of the homepage. With the alarms tab opened, we can see an open alarm **Concurrent Manager Completed Request Count Low**. Clicking the alarm name opens a new tab in the OCI Monitoring Service. From this page we see this alarm is not flapping and has been active for quite some time. Let's close the tab and return to Stack Monitoring.

	![Oracle Cloud console, Stack Monitoring Homepages](images/5-2-home.png " ")

	Let's review the chart associated to this alarm by clicking the **Charts** tab. Once the page loads, find the chart **Completed Concurrent Requests**. Now let's expand the charts to show the **Last 14 Days**. We can see the percentage of requests that **Errored** has remained relatively stable, and the issue does not appear to be a sudden change. Now let's continue the investigation by reviewing the overall health and performance of the entire EBS application stack.

	![Oracle Cloud console, Stack Monitoring Homepages](images/5-3-home.png " ")

	To navigate to the EBS application, click **Related Resources**. Once the page loads, locate the resource **EBS_PROD_01** with the type **EBS**. Click the name of the resource **EBS_PROD_01** to navigate to the application's homepage.

	![Oracle Cloud console, Stack Monitoring Homepages](images/5-4-home.png " ")

3. Reviewing an EBS composite homepage

	We can see that an EBS homepage is very similar to a standard resource homepage with a few exceptions. Properties again show the type of resource and the OCID. Here we see an overall availability of resources related to this EBS application. Stack Monitoring again provides a summary of alarms by severity. 

	![Oracle Cloud console, Stack Monitoring Homepages](images/5-5-home.png " ")

	In the previous task we reviewed the **Alarms** tab. The alarms shown in the EBS homepage includes both the open alarms for the EBS application itself, but also includes open alarms for its members. The EBS homepage you can see a roll-up of all alarms for EBS and it's members, without navigating to multiple homepages. Here we can see the same alarm we  investigated within the Concurrent Manager homepage. 

	![Oracle Cloud console, Stack Monitoring Homepages](images/5-6-home.png " ")

	Clicking **Charts** provides quick visiblity into the health of the EBS application. We can continue our previous investigation by expanding the chart time displayed by again expanding from **Last 60 Minutes** to **Last 14 Days**. From this page nothing appears to standout as a cause for high number of jobs that have errored. Since we have already covered tables, let's move on to Stack View.

	![Oracle Cloud console, Stack Monitoring Homepages](images/5-7-home.png " ")

4.	Selecting the **Stack View** tab loads a unique feature to Stack Monitoring, the **Stack View**.

	Locate the tab **Stack View** from the available menu items. **Stack View** provides a holistic view of the health and performance of the entire EBS application by combining resource specific charts all in one place. Let's begin by expanding the time frame from **Last 60 Minutes** to **Last 14 Days**. With the time frame expanded, let's expand each tier. With each tier expanded, you can now get a holistic view of the performance of your EBS application.  

	![Oracle Cloud console, Stack Monitoring Homepages](images/5-8-home.png " ")

	Beginning with the **EBS Instance**, EBS admins are typically aware of the typical time it takes for a job to complete, and which jobs run long. Looking back we can identify if a particular program or several programs took longer to complete than is typical. Since EBS is a java application, Stack Monitoring provides details into the performance of the WebLogic (WLS)cluster, specifically OACORE, the heart of EBS. Using our alarm example of **Concurrent Manager Completed Request Count Low**, we can use the WebLogic tier to determine if WLS is contributing the errored program runs. From within this tier we can see that JVM Memory, both heap and non-heap, utilization is not at 100%. The number of active thread pool threads that are hogging are low. And finally, there does not seem to be any waiting JDBC Connections. Based on this information WLS does not appear to have contributed to the errored programs.

	![Oracle Cloud console, Stack Monitoring Homepages](images/5-9-home.png " ")

	Reviewing the **EBS Database** tier, we can review the number of transactions committed and rolled back. The count of rolled back sessions is quite low. Additionally, transaction wait times across dimensions remains low as well. As a result, the database does not appear to be spending much time waiting.

	Finally, we can review the health of the EBS hosts. Both the hosts CPU and memory are well below their maximum, thus ruling out host as a contributing factor. Based on the review of the EBS application stack using Stack View, we can rule out the application and infrastructure components as the cause of the errored programs.

	![Oracle Cloud console, Stack Monitoring Homepages](images/5-10-home.png " ")

## Conclusion

In this workshop, you have become familiar with Stack Monitoring and learned how to identify resources that are down and troubleshoot performance issues across an enterprise.

You can use the Enterprise Summary to identify resources that are down, and quickly review all open alarms. You have learned to navigate a resource homepage, to help you review performance problems and navigate up and down the application stack. Finally, you leveraged the Stack View to review performance across an EBS application.

For more information on Stack Monitoring, refer to the OCI documentation, **[Stack Monitoring](https://docs.oracle.com/en-us/iaas/stack-monitoring/index.html)**.

## Acknowledgements

* **Author** - Aaron Rimel, Principal Product Manager, Enterprise and Cloud Manageability
- **Contributors** - Ana McCollum, Senior Director of Product Management, Enterprise and Cloud Manageability
* **Last Updated By/Date** - Aaron Rimel, February 2023
