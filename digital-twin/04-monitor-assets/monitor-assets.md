# Monitor Asset

Monitoring asset uptime is key to any business that involves connected assets. Whether we monitor the asset on the board or off the board, we need a solution that can flexibly adapt to the business conditions. OCI anamaly detection service uses Oracle MSET-2 algorithm can detect the anomal signals sensitively.

## Introduction
In this session, we will show you how to and make predictions with new data using Anomaly Detection model, and how to generate notification message when there is anomaly detected by the model.

*Estimated Time*: 20 minutes

### Objectives
1. Use digital twin to 

### Task 1 Generate 



### Task 2 Generate anomaly




### Task 3 Verify the anomaly


##
**If you have NOT completed the Labs (01 and 02),**
- Download the **AD_testing.csv Dataset** https://objectstorage.us-ashburn-1.oraclecloud.com/p/L5-dC68rtjqN_oY1rqMqJs5vRa5Y0Rph12suyFhqaYN_2lvOlOp_vdCBZPh3OcOI/n/orasenatdpltintegration03/b/AD_bucket/o/AD_Testing.csv
##


### Task 4: Detect Anomalies with Anomaly Detection (AD) GUI



The results of Anomaly Detection can be viewed in a number of ways including the AD SDK. Using the AD UI is a visual method.

To start the process of anomaly detection, click on your model and select **Detect Anomalies** on the model listing page

![UI](./images/imageUI1.png " ")

Select  **AD_testing.csv** from local filesystem or drag-and-drop the desired file.
You can leave _Sensitivity_ **BLANK** for this demo. 
Once the test file is uploaded, click **Detect**.  

![UI](./images/imageUI2.png " ")
##

### Results Observation

Let's take a look what anomalies Anomaly Detection discovered in the data

![UI](./images/imageUI3.png " ")

>**Graph Explanation**
>
>Each signal in your detection data can be selected to show a separate graph.
>>
>In the graph, horizontal axis represents the timestamp (or indexes if no timestamp was provied), and the vertical axis represents sensor values.
>
>In each subgraph, 
>- orange line indicates the actual input value of a signal
>- purple line indicates the predicted value by the machine learning model
>- red line indicates anomaly being detected at that timestamp.
>
There are two additional subgraphs after sensor subgraphs:
>
>_The Anomaly Score Per Signal_ shows the significance of anomaly at individual signal level for a given timestamp. Not all the signals flag anomalies at the same time.
>_The Aggregated Anomaly Score_ indicates the significance of anomaly for a given timestamp by considering the anomaly from all signals together.
>You can move your mouse over the graph, the actual value & estimated value at a certain timestamp will show at the upper right corner of the graph.