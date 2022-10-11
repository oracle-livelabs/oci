Lab 8: Run the Anomaly Detection Solution
===

## 1. Download Model Training and Inferencing Datasets

Download the training and testing (/inference) data files. A sample training data set in Parquet format is also included for interested users, although this workshop will use data files provided in CSV format only.

| AD Dataset Type | Download Link | Use Case Description |
| ------------ | ------------- | ----------- |
| Univariate | [ad-diabetes-test.csv](./files/ad-diabetes-test.csv),[ad-diabetes-train.csv](./files/ad-diabetes-train.csv),[ad-diabetes-train.parquet](./files/ad-diabetes-train.parquet) | A sample univariate dataset which contains blood glucose level readings from a diabetes patient. The training data set will be used to train a model and inference data set will be used to detect anomalous values in blood glucose values. |
| Multivariate | [TestData.csv](./files/TestData.csv),[TrainData.csv](./files/TrainData.csv),[TrainData.parquet](./files/TrainData.parquet) | A sample multivariate dataset which contains tire pressure and temperature values. The training data set will be used to train a model and inference data set will be used to detect anomalous values in tire pressure and temperature values. |

## 2. Run Model Training Pipeline

Upload **ad-diabetes-train.csv** to **training-data-bucket**. If a Data Flow run is triggered successfully, and an Anomaly Detection model is trained successfully, then the training path is working.

The following steps can be used to verify the workflow or troubleshoot issues (if any)
- Look for a new Data Flow Run created under the application under **Analytics & AI** -> **Runs**.
- Wait for the Run status to change from *Accepted* to *In Progress* and then *Successful*. **NOTE**: The transition may sometimes happen before you navigate and check.
- If the Run moves to Failed status, check the stdout and stderr logs under the Logs tab. **NOTE**: the log may need a couple minutes to show up after the Run fails. Logs can also be downloaded from the log bucket in zip format.
- During the Run, Processed data will be saved in CSV format in **staging-bucket** under the folder specified in the driver configuration file, in a subdirectory named **training\_processed_data\_\<current datetime\>**. See sample screenshot below.

![](./images/Exp1.png)

- Once the Run succeeds, a new AD model should get trained successfully. 
  
  * If the logs contain an error indicating that model training has failed, search for the model OCID from the search box or by navigating to the Anomaly Detection project, and check the reason for failure.

- Model information will be written to a file named **model_info.** in **output-bucket**. A sample is shown below for your reference:

```
{
  "model_ids": [
      {
	  "model_id": "ocid1.aianomalydetectionmodel.oc1.phx.amaaaaaaor7l3jiavbwqxnwiqvikmrdjyeaq7e2bvrpbh3y5apq4iv4xmfga",
	  "columns": [
	      "timestamp",
	      "ReadingAM"
	  ]
      }
  ]
}
```

Details of the trained model such as FAP(False Alarm Probability) can be checked under **Anomaly Detection** or from the search panel.

![](./images/Exp2.png)

## 3. Run Inferencing Pipeline

The application assumes the user has succesfully performed model training using the pipeline prior to inference.

Similar to the previous section, upload the **ad-diabetes-test.csv** file in the bucket specified by **inferencing-data-bucket**. If the Data Flow run is triggered and is successful, and the result of Anomaly Detection shows up in the results bucket, then the inferencing path is working. 

Follow the instructions described in Step [2] (above) to monitor the pipeline and/or troubleshoot problems. In the last step, check the results folder for the inference results.

After a successful run, the results should be populated as shown in the screenshot below in the **output-bucket** under **inference_results**:

![](./images/Exp3.png)

Download the CSV file to view and verify the anomaly detection results. When the sample test data set provided in section/lab is used for inference, AD Service output will be as shown below.

```
{
  "detectionResults": [
    {
      "timestamp": "2022-02-15T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 96.0,
          "estimatedValue": 91.0,
          "anomalyScore": 0.37690758682864717
        }
      ]
    },
    {
      "timestamp": "2022-02-16T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 82.0,
          "estimatedValue": 91.0,
          "anomalyScore": 0.4976469775762252
        }
      ]
    },
    {
      "timestamp": "2022-02-17T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 76.0,
          "estimatedValue": 91.0,
          "anomalyScore": 0.434281319252915
        }
      ]
    },
    {
      "timestamp": "2022-02-18T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 87.0,
          "estimatedValue": 91.0,
          "anomalyScore": 0.4025705890947273
        }
      ]
    },
    {
      "timestamp": "2022-02-19T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 89.0,
          "estimatedValue": 91.0,
          "anomalyScore": 0.4156516208113309
        }
      ]
    },
    {
      "timestamp": "2022-02-20T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 117.0,
          "estimatedValue": 91.0,
          "anomalyScore": 0.4009422994146696
        }
      ]
    },
    {
      "timestamp": "2022-02-21T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 86.0,
          "estimatedValue": 91.0,
          "anomalyScore": 0.49893480940764984
        }
      ]
    },
    {
      "timestamp": "2022-03-08T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 91.0,
          "estimatedValue": 101.5,
          "anomalyScore": 0.12864263679083598
        }
      ]
    },
    {
      "timestamp": "2022-03-15T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 134.0,
          "estimatedValue": 133.0,
          "anomalyScore": 0.2956224890677405
        }
      ]
    },
    {
      "timestamp": "2022-03-16T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 85.0,
          "estimatedValue": 133.0,
          "anomalyScore": 0.321152260275695
        }
      ]
    },
    {
      "timestamp": "2022-03-17T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 88.0,
          "estimatedValue": 133.0,
          "anomalyScore": 0.3849829015940135
        }
      ]
    },
    {
      "timestamp": "2022-03-18T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 75.0,
          "estimatedValue": 133.0,
          "anomalyScore": 0.40372480285634194
        }
      ]
    },
    {
      "timestamp": "2022-03-19T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 95.0,
          "estimatedValue": 133.0,
          "anomalyScore": 0.3889211787150881
        }
      ]
    },
    {
      "timestamp": "2022-03-20T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 105.0,
          "estimatedValue": 133.0,
          "anomalyScore": 0.38714228904039555
        }
      ]
    },
    {
      "timestamp": "2022-03-21T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 70.0,
          "estimatedValue": 133.0,
          "anomalyScore": 0.46756882426063595
        }
      ]
    },
    {
      "timestamp": "2022-03-22T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 74.0,
          "estimatedValue": 133.0,
          "anomalyScore": 0.5349167597942206
        }
      ]
    },
    {
      "timestamp": "2022-03-23T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 84.0,
          "estimatedValue": 133.0,
          "anomalyScore": 0.5772437887505703
        }
      ]
    },
    {
      "timestamp": "2022-03-24T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 120.0,
          "estimatedValue": 133.0,
          "anomalyScore": 0.5859900515472147
        }
      ]
    },
    {
      "timestamp": "2022-03-25T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 125.0,
          "estimatedValue": 133.0,
          "anomalyScore": 0.5835673191706797
        }
      ]
    },
    {
      "timestamp": "2022-03-26T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 135.0,
          "estimatedValue": 133.0,
          "anomalyScore": 0.653997276182088
        }
      ]
    },
    {
      "timestamp": "2022-03-27T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 70.0,
          "estimatedValue": 133.0,
          "anomalyScore": 0.7325582187348826
        }
      ]
    },
    {
      "timestamp": "2022-03-28T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 77.0,
          "estimatedValue": 133.0,
          "anomalyScore": 0.7396172368080908
        }
      ]
    },
    {
      "timestamp": "2022-03-29T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 74.0,
          "estimatedValue": 133.0,
          "anomalyScore": 0.6181251478916525
        }
      ]
    },
    {
      "timestamp": "2022-03-30T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 140.0,
          "estimatedValue": 133.0,
          "anomalyScore": 0.6722535153480171
        }
      ]
    },
    {
      "timestamp": "2022-03-31T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 101.0,
          "estimatedValue": 133.0,
          "anomalyScore": 0.6494717606946078
        }
      ]
    },
    {
      "timestamp": "2022-04-01T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 96.0,
          "estimatedValue": 133.0,
          "anomalyScore": 0.6328353265591464
        }
      ]
    },
    {
      "timestamp": "2022-04-02T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 82.0,
          "estimatedValue": 133.0,
          "anomalyScore": 0.7702700093526221
        }
      ]
    },
    {
      "timestamp": "2022-04-03T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 76.0,
          "estimatedValue": 133.0,
          "anomalyScore": 0.7246277731427143
        }
      ]
    },
    {
      "timestamp": "2022-04-04T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 87.0,
          "estimatedValue": 133.0,
          "anomalyScore": 0.638119423800343
        }
      ]
    },
    {
      "timestamp": "2022-04-05T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 89.0,
          "estimatedValue": 119.64285714285714,
          "anomalyScore": 0.6056445854650343
        }
      ]
    },
    {
      "timestamp": "2022-04-06T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 117.0,
          "estimatedValue": 119.03571428571428,
          "anomalyScore": 0.5920893139738926
        }
      ]
    },
    {
      "timestamp": "2022-04-07T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 86.0,
          "estimatedValue": 118.42857142857142,
          "anomalyScore": 0.6853899096016128
        }
      ]
    },
    {
      "timestamp": "2022-04-08T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 91.0,
          "estimatedValue": 117.82142857142857,
          "anomalyScore": 0.6396418900702233
        }
      ]
    },
    {
      "timestamp": "2022-04-09T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 164.0,
          "estimatedValue": 133.0,
          "anomalyScore": 0.7316739609625484
        }
      ]
    },
    {
      "timestamp": "2022-04-10T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 75.0,
          "estimatedValue": 133.0,
          "anomalyScore": 0.714089010192655
        }
      ]
    },
    {
      "timestamp": "2022-04-24T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 225.0,
          "estimatedValue": 82.0,
          "anomalyScore": 0.9100000000000003
        }
      ]
    },
    {
      "timestamp": "2022-04-25T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 78.0,
          "estimatedValue": 82.0,
          "anomalyScore": 0.18809579197957738
        }
      ]
    },
    {
      "timestamp": "2022-04-26T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 86.0,
          "estimatedValue": 109.60000000000001,
          "anomalyScore": 0.18555529533522422
        }
      ]
    },
    {
      "timestamp": "2022-04-27T08:00:00.000+00:00",
      "anomalies": [
        {
          "signalName": "ReadingAM",
          "actualValue": 99.0,
          "estimatedValue": 118.8,
          "anomalyScore": 0.1634852924800992
        }
      ]
    }
  ]
}
```
The above result contains the estimated value of each data point along with its anomaly score. This can be visualized as shown below

![Visualization of Anomaly Detection result](./images/Exp4.jpg)

**Congratulations!**  You have successfully completed all labs in this workshop.
