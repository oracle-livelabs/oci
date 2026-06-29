# View the published metrics in OCI Monitoring

## Introduction

This lab shows how to visualize the published metrics in Metrics Explorer from the Oracle Cloud Console.

Estimated Lab Time: 15 minutes

### Objectives

In this lab, you will:

* View the published metrics in OCI Monitoring

## Task 1: View the published metrics in OCI Monitoring

1. From the Oracle Cloud Console, navigate to **OCI Console >> Observability & Management**. Under **Monitoring**, click **Metrics Explorer**.

    ![Metrics Explorer Menu](https://oracle-livelabs.github.io//common/images/console/metrics-explorer-icon.jpg)

2. From the **Metrics Explorer** landing page, click **Add Query**.

    ![Metrics Explorer Landing Page](images/metrics-explorer-landing-page.png)

3. Enter name as `gdk-query-1`. Select your workshop compartment from the **Compartment** drop down list. Select the **Metric namespace** as `gcn_metrics_oci`. Select the **Metric name** as `microserviceBooksNumber.latest_value`. Leave the other default values unchanged. Click **Add query**.

    ![Metrics Explorer - Add Query Form](images/metrics-explorer-add-query-form.png)

4. Visualize the selected metric.

    ![Metrics Chart](images/view-metrics-chart.png)

Congratulations! You've successfully completed this lab. You can visualize the metrics published by the sample application in the OCI Metrics Explorer.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
