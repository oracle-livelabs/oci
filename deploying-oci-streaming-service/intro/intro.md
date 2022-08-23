
# Introduction

Estimated time: 40 minutes

The Oracle Cloud Infrastructure Streaming service provides a fully managed, scalable, and durable solution for ingesting and consuming high-volume data streams in real-time. Use Streaming for any use case in which data is produced and processed continually and sequentially in a publish-subscribe messaging model.

You can use Streaming for:

- **Messaging** - Use Streaming to decouple the components of large systems. Producers and consumers can use Streaming as an asynchronous message bus and act independently and at their own pace.

- **Metric and log ingestion** - Use Streaming as an alternative for traditional file-scraping approaches to help make critical operational data more quickly available for indexing, analysis, and visualization.

- **Web or mobile activity data ingestion** - Use Streaming for capturing activity from websites or mobile apps, such as page views, searches, or other user actions. You can use this information for real-time monitoring and analytics, and in data warehousing systems for offline processing and reporting.

- **Infrastructure and apps event processing** - Use Streaming as a unified entry point for cloud components to report their lifecycle events for audit, accounting, and related activities.

## Workshop agenda

The workshop makes use of OCI CLI but same can be done by making direct calls to the API or via using the Resource Manager. For making use of OCI CLI we can either configure this in our local environment or make use of already configured OCI CLI in the OCI cloud console, this will give us the pre configured environment and we can straight away jump to the Streaming stuff .

In this workshop we will look at

- How we can create, update and delete stream pools and streams. The configurations available for Stream Pools and Streams.

- Publishing of messages to the streams using OCI CLI

- Consuming messages as an individual consumer.

- Consuming in a group.

## Oracle Cloud Shell

Oracle Cloud Infrastructure Cloud (OCI) Shell is a web browser-based terminal accessible from the Oracle Cloud Console. Cloud Shell is free to use (within monthly tenancy limits), and provides access to a Linux shell, with a pre-authenticated Oracle Cloud Infrastructure CLI, a pre-authenticated Ansible installation, and other useful tools for following Oracle Cloud Infrastructure service tutorials and labs. Cloud Shell is a feature available to all OCI users, accessible from the Console. Your Cloud Shell will appear in the Oracle Cloud Console as a persistent frame of the Console, and will stay active as you navigate to different pages of the Console.

[](youtube:J51BXxlCbOY)


## Additional Recommended Resources

1. [OCI Training](https://cloud.oracle.com/en_US/iaas/training)
2. [Familiarity with OCI console](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm)
3. [Overview of Networking](https://docs.us-phoenix-1.oraclecloud.com/Content/Network/Concepts/overview.htm)
4. [Familiarity with Compartments](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/concepts.htm)

### Let's get Started

Click on the next lab in this workshop to get started.

## Acknowledgements

- **Author** - Nitin Soni
- **Contributors** - Oracle LiveLabs QA Team (Kamryn Vinson, QA Intern, Arabella Yao, Product Manager Intern, DB Product Management)
- **Last Updated By/Date** - Madhusudhan Rao, Apr 2022
