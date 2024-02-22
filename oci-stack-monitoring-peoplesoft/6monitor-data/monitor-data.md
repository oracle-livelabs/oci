# Monitor the PeopleSoft Application resources

## Introduction

In this lab, you will monitor the PeopleSoft application resources  from the Enterprise UI summary page.

Estimated Time: 15 minutes


### Objectives

* Monitor the PeopleSoft Application resources

### Prerequisites


*  Access to OCI Stack Monitoring page for the user.

## Task 1: Monitor the PeopleSoft Application resources

1. On the Oracle Cloud Infrastructure Console Home page, click the Navigation Menu in the upper-left corner, select Observability & Management, and then click on Stack Monitoring.

   ![From OCI home page, under O&M, click on Stack Monitoring](./images/oci-stack-monitor.png " ")


   The Stack Monitoring Enterprise Summary page provides an overall health and performance of your entire enterprise.

   ![On Stack Monitoring, Enterprise summary page](./images/enterprise-summary.png " ")

   The newly discovered PeopleSoft application resources show up on the dashboard, let's dive into each application resources. Click on the PSFT-HCM application 

   ![On Stack Monitoring, Enterprise summary page](./images/enterprise-summary1.png " ")

    Within the PSFT-HCM application, four application resources report as Up and available

   ![On Stack Monitoring, Enterprise summary page](./images/stack-resource.png " ")

    Click on Stack View tab, to monitor the current status of each of the application components
    
    ![On Stack Monitoring, Enterprise summary page](./images/stack-view.png " ")

    Application Server domain current status

    ![On Stack Monitoring, Enterprise summary page](./images/stack-view-app.png " ")

    Process Scheduler Server domain current status

    ![On Stack Monitoring, Enterprise summary page](./images/stack-view-prcs.png " ")

    PIA domain and Process Monitor current status

    ![On Stack Monitoring, Enterprise summary page](./images/stack-view-pia.png " ")

    Weblogic Server current status

    ![On Stack Monitoring, Enterprise summary page](./images/stack-view-web.png " ")


    Database Server current status

    ![On Stack Monitoring, Enterprise summary page](./images/stack-view-db.png " ")


    This is just a  preview of the current monitoring status page for the PSFT application.  For detailed monitoring of the application and to get better insights on the resources usage, refer to the stack monitoring document for more information, link  [here](https://docs.oracle.com/en-us/iaas/stack-monitoring/doc/using-stack-monitoring.html).

## Summary

In this lab, you monitored the PeopleSoft application using Enterprise Summary & the Out of Box dashboards.




## Acknowledgements

* **Authors** - Deepak Kumar M, Principal Cloud Architect
* **Contributors** -

    * Aaron Rimel, Principal Product Manager
    * Devashish Bhargava, Principal Cloud Architect
* **Last Updated By/Date** - Deepak Kumar M, Principal Cloud Architect, February 2024


