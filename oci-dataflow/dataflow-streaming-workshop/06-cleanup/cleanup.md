# Clean up the workshop environment

## Introduction

In this lab, you will clean up the workshop environment resources used for manufacturing application.

Estimated time: 20 minutes

### Objectives

* Remove the lab configurations and setups

### Prerequisites

* Completion of preceding labs in this workshop.

## Task1: Stop Data Flow Runs

1. Go to OCI Data Flow Console (aka. hamburger menu) in the Oracle Cloud console, and select **Analytics & AI ** > **Data Flow**.

   ![Oracle Cloud console, Dataflow](images/dataflow-menu.png " ")

2. Select dataflow-labs compartment and select Runs.
   ![Oracle Cloud console, Dataflow](images/runs_compartment.png " ")

3. Click on RealtimeRULPredictor and click on STOP.
   ![Oracle Cloud console, Dataflow](images/predictor_stopping.png " ")

4. Confirm stopping RealtimeRULPredictor.
   ![Oracle Cloud console, Dataflow](images/confirm_predictor_stop.png " ")

5. Click on SensorDataSimulator and click on STOP.
   ![Oracle Cloud console, Dataflow](images/simulator_stopping.png " ")

6. Confirm stopping SensorDataSimulator.
   ![Oracle Cloud console, Dataflow](images/confirm_simulator_stop.png " ")

7. Confirm all the running apps are stopped.
   ![Oracle Cloud console, Dataflow](images/stop-runs.png " ")



## Task2: Delete Object Storage Buckets

1. From the navigation menu in the Oracle Cloud console, select **Storage** > **Bucket**.

    ![Oracle Cloud, Object Storage](images/object%20storage%20menu.png " ")

2. In the **Object Storage Details** page, click **Delete** on dataflow-labs-logs. In the confirmation window, click **Delete**.

   ![Oracle Cloud, Object Storage](images/delete_logs_bucket.png " ")   

3. Deletion of the delete dataflow_labs_logs buckets starts and completes.

    ![Oracle Cloud, Cloud console](images/delete_logs_success.png " ")    

4. In the **Object Storage Details** page, click **Delete** on dataflow-labs. In the confirmation window, click **Delete**.

   ![Oracle Cloud, Object Storage](images/delete_dataflow_labs.png " ")

5. Deletion of the delete dataflow_labs_logs buckets starts and completes.

   ![Oracle Cloud, Cloud console](images/delete_dataflow_labs_success.png " ")



## Task3: Destroy Manufacturing Stack to clean up other resources

1. From the navigation menu in the Oracle Cloud console, select **Developer Services** > **Stacks**. 

    ![Oracle Cloud, Cloud console](images/stack-menu.png " ")       

2. Click destroy on the manufacturing stack and confirm the destruction of stack.

    ![Oracle Cloud, Cloud console](images/destroy_click.png " ")    

3. Wait for successful destruction of manufacturing stack

   ![Oracle Cloud, Cloud console](images/destroy_progress.png " ")

4. Wait for successful destruction of manufacturing stack

   ![Oracle Cloud, Cloud console](images/destroy_succeeded.png " ")

## Acknowledgements
- **Author** -  Sivanesh Selvanataraj, Senior Software Engineer, OCI Data Flow
- **Contributors** - Sujoy Chowdhury, Senior Principal Product Manager, OCI Data Flow
- **Last Updated By/Date** - Sivanesh Selvanataraj, September 2022
