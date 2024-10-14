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

2.  In the **Metrics Explorer**, scroll down to the **Query 1** section. Select your workshop compartment from the **Compartment** drop down list.

    ![Select compartment](images/metrics-query-compartment.jpg#input)

5. Select the **Metric namespace** as `gcn_metrics_oci`.

    ![Select Metric namespace](images/select-metric-namespace.jpg#input)

6. Select the **Metric name** as `microserviceBooksNumber.latest_value`.

    ![Select Metric name](images/select-metric-name.jpg#input)

7. Click **Update Chart** to visualize the selected metric.

    ![Update Chart](images/update-chart.jpg#input)

8. Scroll up to visualize the selected metric.

    ![Metrics Chart](images/updated-metrics-chart.png#input)


Congratulations! You've successfully completed this lab. You can visualize the metrics published by the sample application in the OCI Metrics Explorer.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
