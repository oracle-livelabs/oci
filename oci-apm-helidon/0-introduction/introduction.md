# Introduction

## About this Workshop

This workshop walks you through how to:

* Enable OpenTracing for a Java microservice-based Helidon SE application using Oracle Application Performance Monitoring (APM)
* Trace the workflow within a service and across multiple services
* Use the Helidon SE application and its build instructions, described in the **[Helidon SE Tracing Guide](https://helidon.io/docs/v4/se/guides/tracing)**.

Estimated Workshop Time: 40 minutes

## Task 1: Know before you run

### About Oracle Cloud Infrastructure Application Performance Management (OCI APM)

The diagram below provides an overview of the OCI APM Service, its features, components, and some of the other OCI services it integrates with.

  ![APM Architectuure](images/apm_diagram.png " ")

Among other capabilities, OCI APM includes an implementation of a Distributed Tracing system. It collects and processes transaction trace data (spans) from the monitored application and makes it available for viewing, dashboarding, exploration, alerts, etc. For more information on APM and Trace Explorer please refer to Application Performance Monitoring > **[Use Trace Explorer](https://docs.oracle.com/en-us/iaas/application-performance-monitoring/doc/use-trace-explorer.html)** section in the OCI Documentation.

In the workshop, you will learn how to add an APM tracer to a Maven project, and the specific required configuration for Helidon. You will also learn how to create an APM domain and use Trace Explorer to search and view traces/spans in the APM User Interface.



### Objectives

In this workshop, you will:
* Create OCI compartment and APM domain
*	Build and deploy a Java microservice-based application using the Maven project and Helidon framework
*	Configure APM tracer on the application
*	Use APM Trace Explorer to view traces, spans, and verify span dimensions


### Prerequisites

* An Oracle Cloud Account

### Reference
*  Helidon SE Tracing Guide, Helidon Documentation Version:(4.1.5), URL: https://helidon.io/docs/v4/se/guides/tracing


### More APM Workshops

* Please visit: **[APM LiveLabs workshops](https://livelabs.oracle.com/pls/apex/f?p=133:100:111996377805307::::SEARCH:application+Performance+monitoring)**.


You may now **proceed to the next lab**.

## Acknowledgements

- **Author** - Yutaka Takatsu, Product Manager, Enterprise and Cloud Manageability
- **Contributors** - Steven Lemme, Senior Principal Product Manager,    
Anand Prabhu, Sr. Member of Technical Staff,  
Avi Huber, Vice President, Product Management
- **Last Updated By/Date** - Yutaka Takatsu, December 2024
