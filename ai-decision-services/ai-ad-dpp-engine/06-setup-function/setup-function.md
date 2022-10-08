Lab 6: Configure OCI Functions
=== 

## 1. Configure Virtual Cloud Network

- Go to Virtual Cloud Network and create a **VCN**. For IPv4 CIDR Blocks, the recommended one **10.0.0.0/16** can be used:  

  ![](./images/Set-Fn1.png)

- Inside the generated VCN, create a **subnet**. For IPv4 CIDR Block, the recommended one **10.0.0.0/24** can be used. For Subnet Access, choose Private Subnet.  
  ![](./images/Set-Fn2.png)

- Under the VCN, create a **Service Gateway**. Remember to choose **ALL <Region> Services In Oracle Service Network** under Services:  

  ![](./images/Set-Fn3.png)

- Under the VCN, go to **Route Tables** and click on **Default Route Table for <vcn-name>**. Choose **Add Route Rules**. Choose **Service Gateway** as the Target Type, **ALL <Region> Services In Oracle Service Network** as Destination Service, and choose the Service Gateway created in the previous step as Target Service Gateway.  

  ![](./images/Set-Fn4.png)
    

## 2. Create an OCI Functions Application

Go to **Functions** → **Applications**, and Create an *Application*. See screenshots below. Then go to **Getting Started** and use **Cloud Shell setup**. Follow the instructions on the pad and deploy the demo function. Verify that it can be invoked successfully.

![](./images/Set-Fn5.png)

![](./images/Set-Fn6.png)

![](./images/Set-Fn7.png)

```
$ fn invoke <func-name> <app-name>
Hello, World!
```

## 3. Configure OCI Function to invoke the Data Flow

- Update the Function body (func.py)

  Replace the Function body (func.py) with the content from [here](https://github.com/bug-catcher/oci-data-science-ai-samples/blob/415e072962940f51dd811875386ddb2c728a3af8/ai_services/anomaly_detection/data_preprocessing_examples/oci_data_flow_based_examples/example_code/end_to_end_example/func.py).

- Configure Function parameters with correct values

  In the code snippet below, specify values for *bucketName* (**training-data-bucket**), *config_bucket_name* (**training-config-bucket**) and *object_name* (**training-config.json**). These values were used in **Lab 3** and **Lab 4**.

  ```
  if bucketName == "<training_bucket_name>":
        config_bucket_name = "<training_config_bucket_name>"
        object_name = "<driver_config>.json"
        resp = get_object(namespace, config_bucket_name, object_name)
  ```

  In the code snippet below, specify values for *bucketName* (**inferencing-data-bucket**),  *config_bucket_name* (**inferencing-config-bucket**) and *object_name* (**inference-config.json**). These values were used in **Lab 3** and **Lab 4**.

  ```
  elif bucketName == "<inferencing_bucket_name>":
        config_bucket_name = "<inferencing_config_bucket_name>"
        object_name = "<driver_config>.json"
        resp = get_object(namespace, config_bucket_name, object_name)
  ```

  In the code snippet below, specify values for *compartment_id* (**OCI Compartment OCID**), *application_id* (**OCI Data Flow Application OCID**) and the logging Storage Bucket URI containing the *Bucket* name and *Namespace*.

  ```
  create_run_details=oci.data_flow.models.CreateRunDetails(
            compartment_id="<compartment-ocid>",
            application_id="<application-ocid>",
            arguments=[ "--response", response, "--phase", phase],
            display_name="complete-dpp-test",
            logs_bucket_uri="oci://bucket-name@namespace/")
  ```

- Update `requirements.txt` file

  Expand source

  ```
  fdk>=0.1.46
  oci>=2.2.18
  ```

- Enable Function Logs

  In the Function Application, under the **Resources** panel click on **Logs** and enable *Function Invocation Logs*.  This will be helpful for troubleshooting the Function if needed. See screenshot below.

  ![](./images/Set-Fn8.png)

## Useful Resources
Refer to the OCI documentation (link below) to learn more about OCI Functions.

- [OCI Functions](https://docs.oracle.com/en-us/iaas/Content/Functions/Concepts/functionsoverview.htm)
