# Stack Monitoring's Enterprise Summary

## Introduction

In this lab, you will review the status and performance of an entire enterprise. You will leverage the Stack Monitoring Enterprise Summary page to identify the number of resources in a down state, and the number of open alarms by severity. Additionally, you will identify the list of Oracle Databases in a Not Reporting state. Learn how to review performance metrics of the various tiers (e.g. E-Business Suite, PeopleSoft, WebLogic Server, Oracle Database, and Host). Finally, you will replace the Tablespace Utilization table, under the Oracle Database tier. 

Estimated time: 10 minutes

### Objectives

* Identify a list of resources in a down state across the enterprise
* Review resources by type and state
* Review open alarms by severity
* Reviewing the performance of resources across an enterprise
* Dynamic troubleshooting using the Enterprise Summary

### Prerequisites

* Completion of the preceding labs in this workshop

## Task 1: Identify a list of resources in a down state across the enterprise

1. Open the navigation menu in the Oracle Cloud console, select **Observability & Management** > **Stack Monitoring** under **Application Performance Monitoring**.

	![Oracle Cloud console Menu](images/1-1-console.png " ")

2. Identify resources in a **Down** state


	Stack Monitoring Enterprise Summary page opens. The Enterprise Summary pages is an out-of-the-box troubleshooting and summary page of resources across your enterprise. The troubleshooting begins with the **Status Summary**. Locate the **Status Summary** doughnut chart on the upper left side of the page. You can see a count of resources by status across the enterprise. This chart provides a quick visualization of how many resources are in a **Down** or **Not Reporting** state across your enterprise. Let's investigate which resources are **Down**. 

	![Oracle Cloud console, Enterprise Summary](images/1-1-ent-sum.png " ")

	Find the **Down** label in the Status summary chart.  Clicking **Down**, invokes a slide out reporting all of the resources in a down state. The slide out filter can be changed to quickly view all resources in any given state. This list can be sorted by name, status, and type. You can also search by name to quickly view the status of any given resource you may be concerned about.  Clicking a resource name, will navigate you to that resource's homepage to continue an investigation. We will cover resource homepages later in this lab.

	![Oracle Cloud console, Enterprise Summary](images/1-2-ent-sum.png " ")

3. Review all resources that are **Not Reporting**

	Now that we have identified resources in a down state, let's identify those that are **Not Reporting**. Using the Status filter located in the center of the fly-out, update the **Status** filter from **Down** to **Not reporting**. The table now displays all of the resources in a **Not Reporting** state. To return to the Enterprise Summary click the **Close** button in the lower left corner of the fly-out.

 	![Oracle Cloud console, Enterprise Summary](images/1-3-ent-sum.png " ")

## Task 2: Review resources by type and severity

1. Locate the **Status by resource type** chart at the top center of the page. 

 	![Oracle Cloud console, Enterprise Summary](images/2-1-ent-sum.png " ")

	The **Status by resource type** chart provides a quick view of the status of your resources by type across an enterprise. Each bar represents a total count of resources by type regardless of state. The reporting of an application stack, such as E-Business Suite and PeopleSoft, is unique. Each bar represents an application and it's components, this allows you to identify if any individual components of an application is down or not reporting. Should you identify an area of concern with an application, clicking the bar will navigate you to that resource's homepage. We'll review homepages in the next lesson.

2. Identify resources by resource type that are **Not Reporting**

 	Identifying which resources are down or not reporting by type across an enterprise is easy. Simply locate the chart legend at the top right of the **Status by resource type** chart, select **Not Reporting**. This will filter the chart to only show the count of resources by type in a **Not Reporting** state. 

 	![Oracle Cloud console, Enterprise Summary](images/2-2-ent-sum.png " ")

 	If we wish to see a more detailed list of hosts that are not reporting, click the host bar on the left side of the chart. This will invoke a slide-out and display a list of host names, status, and type. From this slide out it is simple to update the filter to see other states, resource types, or simply search for a resource by name. Clicking any resource name within the slide-out will navigate you to that resource's homepage for further troubleshooting. 

 	![Oracle Cloud console, Enterprise Summary](images/2-3-ent-sum.png " ")

	To return to the Enterprise Summary click the **Close** button in the lower left corner of the fly-out.

3. Reset Status by resource type chart
	
	With the slide-out closed, locate the **Show all** filter located within the **Status by resource type** chart's legend. Clicking **Show all** will reset the chart to the default state of showing all resources and states.

 	![Oracle Cloud console, Enterprise Summary](images/2-4-ent-sum.png " ")

## Task 3: Review open alarms by severity

1. Locate the **Alarms** chart at the top right of the Enterprise Summary. 

	Stack Monitoring makes it simple to identify any open alarms within your enterprise. The **Alarms** chart provides a total count of open alarms, as well as a count of alarms by severity. Clicking on a count of alarms invokes a slide-out. The slide-out provides greater details of the open alarms and is filtered by the severity count selected. 

	Let's review all of the open alarms within this enterprise. Begin by clicking the **Total** count of open alarms identified by the **blue** number in large font located under the chart title, Alarms.  

 	![Oracle Cloud console, Enterprise Summary](images/3-0-ent-sum.png " ")

	The alarm slide-out provides details of open alarms. These details include Alarm name, Severity, and Triggered time. The results can be ordered by selecting the column title.

 	![Oracle Cloud console, Enterprise Summary](images/3-1-ent-sum.png " ")

2. Refine the list of open alarms

 	Lets filter the list to focus on only the **Critical** alerts. Using the **Severity filter**, located above the column **Triggered time** change the severity from **All** to **Critical**. The table now displays only the open alarms with a severity of **Critical**. 

 	![Oracle Cloud console, Enterprise Summary](images/3-2-ent-sum.png " ")

 	Clicking an alarm name will open a new tab in your browser to investigate and work the alarm within Oracle Cloud Infrastructure's monitoring service.

 	![Oracle Cloud console, Enterprise Summary](images/3-3-ent-sum.png " ")

 	Once you have reviewed the alarm, close the browser tab to return to Stack Monitoring. Once again click **Close** at the bottom left of the slide out to return to the Enterprise Summary.

## Task 4: Review the performance of resources by tier (e.g. E-Business Suite, PeopleSoft, WebLogic Server, Oracle Database, and Host)

1. Enterprise Summary tiers

	The **Enterprise Summary** makes it easy to see the performance of nearly every resource within your enterprise. Stack Monitoring performance charts are organized by tier. The tiers are ordered in the same way troubleshooting is typically performed, with the Application specific tier at the top, web servers next, followed by database, and finally the hosts. Each chart provides the most recent value of the metrics collected. Scatter-plot charts display a value for every resource type that matches the tier, i.e. if you have 20 hosts, you will see 20 plots. Out-of-the-box, Tables provide the four highest consumed/utilized resources of a given metric. 

 	![Oracle Cloud console, Enterprise Summary](images/4-1-ent-sum.png " ")

	All performance charts and tables can be modified or replaced to help identify problems or troubleshooting a specific performance problem. Once you are have completed your investigation a saved chart or table can be reset to the default configuration with just a click. 

 	![Oracle Cloud console, Enterprise Summary](images/4-2-ent-sum.png " ")

	Alternatively any scatter-plot or table change can be saved as your default when viewing the Enterprise Summary, by clicking **Save as default**. 

2. Scatter-plots charts

	Charts provide a visual representation of every resource in your enterprise. Using the scatter-plot charts we can see how busy and heavily utilized all resources such as Oracle Databases are across the enterprise. This makes it easy to identify if one or more resources are performing differently than the others. For instance, an Oracle Database with a plot point at the top right corner represents a busy database, while a plot point at the bottom left is idle. Clicking on any plot point opens that resource's homepage. We'll review this workflow in the next lesson.

	Let's review memory and swap utilization of all hosts within this enterprise. Navigate to the **Memory and Swap** chart located under the **Host** tier at the bottom center of the Enterprise Summary. Every monitored host within Stack Monitoring is represented in this chart. The scatter-plot allows you to identify if a host(s) is performing differently than others. Here we can identify which host is utilizing the most memory and swap. We can also see the majority of hosts are using very little to no swap ruling out memory load as a contributing factor to any performance problems that may be occurring.

 	![Oracle Cloud console, Enterprise Summary](images/4-3-ent-sum.png " ")

2. Tables

 	Tables on the right hand side of the page allow you to quickly identify which resource has the most heavily used filesystems or tablespaces across your enterprise. By default Tables provide up to the four highest utilized or consumed resources of a given metric. The number of rows displayed can be updated from 4 to 10, 20, or all. Let's review the top 20 most heavily utilized tablespaces within the enterprise. Locate **Tablespace Utilization** chart on the right side under the **Oracle Database** tier. Click the pencil icon in the top right of chart. After clicking the pencil, enable the **Advanced** menu items by updating the **Advanced** flag. Enabling the Advanced menu, provides access to optional features of a table or chart. Click **Display records** to change the value of rows displayed from 4 to **20**. With the value updated to 20, click **Apply** in the lower left of the slide-out to return to the Enterprise Summary. 

 	![Oracle Cloud console, Enterprise Summary](images/4-4-ent-sum.png " ")

 	We can now see a list of the top 20 most heavily utilized tablespaces within the enterprise. Clicking any of the resource names will navigate you to that resource's homepage for further investigation. From the Oracle Database homepage additional you can then leverage the Tablespace Utilization chart to see the growth of the the tablespace over time. We'll review this navigation in the next lesson.

 	![Oracle Cloud console, Enterprise Summary](images/4-5-ent-sum.png " ")

## Task 5: Dynamic troubleshooting with the Enterprise Summary

1. Dynamic troubleshooting using the Enterprise Summary

	The Enterprise Summary provides an overall perspective of the health and performance of your enterprise. Knowing that each organization and user is unique, the Enterprise Summary charts, tables, and tier names are customizable to meet the individual needs of the user at any given time. If you choose to update or replace what is displayed on the Enterprise Summary, you can save your changes permanently as your default. This can be especially helpful if you make several changes to the charts and tables while investigating an incident. Saving the configuration allows you to leave the Enterprise Summary and return later to the page with your updated view in tact. Once you complete your investigation, simply click **Restore default** to return the Enterprise Summary to out-of-the-box configuration. Let's see how this is done.

	Updating a chart or table is easy, allowing you to investigate health and performance issues quickly. Let's imagine we have heard an EBS application is no longer processing. Using the upper tier of the Enterprise Summary we see the concurrent manager is no longer processing. Moving down the tier, we also see that the WebLogic tier is not longer processing. We identify that DB time is way up. Reviewing tablespace utilization, we see no tablespaces are full. Further down the stack, we identify a filesystem is full on the db host. These application performance symptoms could be explained if the Flash Recovery Area (FRA) has run out of space. Let's review the FRA across the enterprise using Stack Monitoring dynamic troubleshooting charts. To review the FRA utilization find the **Storage Utilization by Tablespace** under the Oracle Database tier. Begin by clicking the pencil icon in the top right of the table to invoke the slide-out. With the slide-out loaded, simply update the metric reported by selecting **FRA Utilization** (Fast Recovery Area) from the **Metric name** drop-down menu. With the metric updated to  FRA Utilization, select **Apply** in the lower left of the slide-out. 

 	![Oracle Cloud console, Enterprise Summary](images/5-1-ent-sum.png " ")

	We can now see the percent of FRA space used on databases with FRA enabled. Using the results of the table we can now determine whether FRA utilization played a role in causing performance issues across the stack we witnessed.

 	![Oracle Cloud console, Enterprise Summary](images/5-2-ent-sum.png " ")

	With our troubleshooting over, let's reset the Enterprise Summary to the default configuration. To reset the page locate the **Restore default** link in the left menu bar under **View**. Once clicked, the page will reset to the out-of-the-box configuration. 

 	![Oracle Cloud console, Enterprise Summary](images/5-3-ent-sum.png " ")

Congratulations! Let's **proceed to the next lab**.

## Acknowledgements

* **Author** - Aaron Rimel, Principal Product Manager, Enterprise and Cloud Manageability
- **Contributors** - Ana McCollum, Senior Director of Product Management, Enterprise and Cloud Manageability
* **Last Updated By/Date** - Aaron Rimel, February 2023
