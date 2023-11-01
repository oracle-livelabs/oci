Lab 8: Run the Anomaly Detection Solution
===

## 1. Download Model Training and Inferencing Datasets

Download the training and testing (/inference) data files. A sample training data set in Parquet format is also included for interested users, although this workshop will use data files provided in CSV format only.

| AD Dataset Type | Download Link | Use Case Description |
| ------------ | ------------- | ----------- |
| Univariate | [network\_svc\_usage\_test.csv](./files/network_svc_usage_test.csv),[network\_svc\_usage\_train.csv](./files/network_svc_usage_train.csv),[network\_svc\_usage\_train.parquet](./files/network_svc_usage_test.parquet) | A sample univariate dataset which contains the amount of data transferred at various times from a network log. The training data set will be used to train a model, and the inference data set will be used to detect anomalous values in the log. |
| Multivariate | [TestData.csv](./files/TestData.csv),[TrainData.csv](./files/TrainData.csv),[TrainData.parquet](./files/TrainData.parquet) | A sample multivariate dataset which contains tire pressure and temperature values. The training data set will be used to train a model and inference data set will be used to detect anomalous values in tire pressure and temperature values. |

## 2. Run Model Training Pipeline

Upload **network\_svc\_usage\_train.csv** to **training-data-bucket**. If a Data Flow run is triggered successfully, and an Anomaly Detection model is trained successfully, then the training path is working.

The following steps can be used to verify the workflow or troubleshoot issues (if any)
- Look for a new Data Flow Run created under the application under **Analytics & AI** -> **Runs**.
- Wait for the Run status to change from *Accepted* to *In Progress* and then *Successful*. **NOTE**: The transition may sometimes happen before you navigate and check.
- If the Run moves to Failed status, check the stdout and stderr logs under the Logs tab. **NOTE**: the log may need a couple minutes to show up after the Run fails. Logs can also be downloaded from the log bucket in zip format.
- During the Run, Processed data will be saved in CSV format in **staging-bucket** under the folder specified in the driver configuration file, in a subdirectory named **training\_processed_data\_\<current datetime\>**. See sample screenshot below.

![](./images/exp1.png)

- Once the Run succeeds, a new AD model should get trained successfully. 
  
  * If the logs contain an error indicating that model training has failed, search for the model OCID from the search box or by navigating to the Anomaly Detection project, and check the reason for failure.

- Model information will be written to a file named **model_info.** in **output-bucket**. A sample is shown below for your reference:

```
{
    "model_ids": [
        {
            "model_id": "ocid1.aianomalydetectionmodel.oc1.iad.amaaaaaa4rfml3iafgr5ghwrdk47cporuwhqg5fnr6xl4qsirdlvdsv46qoa",
            "columns": [
                "timestamp",
                "value"
            ]
        }
    ]
}
```

Details of the trained model such as FAP(False Alarm Probability) can be checked under **Anomaly Detection** or from the search panel.

![](./images/exp2.png)

## 3. Run Inferencing Pipeline

The application assumes the user has succesfully performed model training using the pipeline prior to inference.

Similar to the previous section, upload the **network\_svc\_usage_test.csv** file in the bucket specified by **inferencing-data-bucket**. If the Data Flow run is triggered and is successful, and the result of Anomaly Detection shows up in the results bucket, then the inferencing path is working. 

Follow the instructions described in Step [2] (above) to monitor the pipeline and/or troubleshoot problems. In the last step, check the results folder for the inference results.

After a successful run, the results should be populated as shown in the screenshot below in the **output-bucket** under **inference_results**:

![](./images/exp3.png)

Download the CSV file to view and verify the anomaly detection results. When the sample test data set provided in section/lab is used for inference, AD Service output will be as shown below.

```
{
  "detectionResults": [
    {
      "timestamp": "2021-03-18T00:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "value",
          "actualValue": 3132364.34206113,
          "estimatedValue": 818404.8901145846,
          "anomalyScore": 0.91
        }
      ]
    },
    {
      "timestamp": "2021-03-18T01:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "value",
          "actualValue": 1980697.672616325,
          "estimatedValue": 951127.7037798172,
          "anomalyScore": 0.5438586438042919
        }
      ]
    }
  ]
}
```
The above result contains the estimated value of each data point along with its anomaly score. OCI Anomaly Detection results can also be visualized using OCI Console as shown below.

![Visualization of Anomaly Detection result](./images/exp4.jpg)

**Congratulations!**  You have successfully completed all labs in this workshop.

## Useful Resources

Read about [Visualizing Anomaly Detection results](https://docs.oracle.com/en-us/iaas/Content/anomaly/using/det-anomaly.htm#det-anomaly)

