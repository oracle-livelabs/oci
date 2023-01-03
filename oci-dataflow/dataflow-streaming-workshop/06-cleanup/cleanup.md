# Clean up the workshop environment

## Introduction

In this lab, you will clean up the workshop environment resources used for the manufacturing applications in OCI Data Flow.

Estimated time: 20 minutes

### Objectives

* Remove the lab configurations and setups

### Prerequisites

* Completion of preceding labs in this workshop.

## Task 1: Stop Data Flow runs

1. Go to OCI Data Flow Console (aka. hamburger menu) in the Oracle Cloud console, and select **Analytics & AI ** &gt; **Data Flow**.

   ![Oracle Cloud console, Dataflow](images/dataflow-menu.png " ")

2. Select the dataflow-labs compartment and select Runs.
   ![Oracle Cloud console, Dataflow](images/runs-compartment.png " ")

3. Click on RealtimeRULPredictor and click on STOP.
   ![Oracle Cloud console, Dataflow](images/predictor-stopping.png " ")

4. Confirm stopping RealtimeRULPredictor.
   ![Oracle Cloud console, Dataflow](images/confirm-predictor-stop.png " ")

5. Click on SensorDataSimulator and click on STOP.
   ![Oracle Cloud console, Dataflow](images/simulator-stopping.png " ")

6. Confirm stopping SensorDataSimulator.
   ![Oracle Cloud console, Dataflow](images/confirm-simulator-stop.png " ")

7. Confirm all the running apps are stopped.
   ![Oracle Cloud console, Dataflow](images/stop-runs.png " ")



## Task 2: Delete Object Storage buckets

1. From the navigation menu in the Oracle Cloud console, select **Storage** &gt; **Bucket**.

    ![Oracle Cloud, Object Storage](images/object-storage-menu.png " ")

2. On the **Object Storage Details** page, click **Delete** on dataflow-labs-logs. In the confirmation window, click **Delete**.

   ![Oracle Cloud, Object Storage](images/delete-logs-bucket.png " ")   

3. Deletion of the delete dataflow_labs_logs buckets starts and completes.

    ![Oracle Cloud, Cloud console](images/delete-logs-success.png " ")    

4. On the **Object Storage Details** page, click **Delete** on dataflow-labs. In the confirmation window, click **Delete**.

   ![Oracle Cloud, Object Storage](images/delete-dataflow-labs.png " ")

5. Deletion of the delete dataflow_labs_logs buckets starts and completes.

   ![Oracle Cloud, Cloud console](images/delete-dataflow-labs-success.png " ")



## Task 3: Destroy Manufacturing Stack to clean up other resources

1. From the navigation menu in the Oracle Cloud console, select **Developer Services** &gt; **Stacks**. 

    ![Oracle Cloud, Cloud console](images/stack-menu.png " ")       

2. Click destroy on the manufacturing stack and confirm the destruction of the stack.

    ![Oracle Cloud, Cloud console](images/destroy-click.png " ")    

3. Wait for successful destruction of manufacturing stack

   ![Oracle Cloud, Cloud console](images/destroy-progress.png " ")

4. Wait for successful destruction of manufacturing stack

   ![Oracle Cloud, Cloud console](images/destroy-succeeded.png " ")

## Acknowledgments
- **Created By** -  Sivanesh Selvanataraj, Software Engineer, OCI Data Flow
- **Contributors** - Sujoy Chowdhury, Product Manager, OCI Data Flow
- **Last Updated By/Date** - Sivanesh Selvanataraj, September 2022
