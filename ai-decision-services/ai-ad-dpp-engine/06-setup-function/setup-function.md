Lab 6: Configure OCI Functions
=== 

## 1. Configure Virtual Cloud Network

A *Virtual Cloud Network (VCN)* and a *Subnet* are required to provision an *OCI Functions* resource. Follow the instructions below to provision a VCN and a Subnet.

- Go to Virtual Cloud Network and create a **VCN**. For IPv4 CIDR Blocks, the recommended one **10.0.0.0/16** can be used. 

  ![](./images/Set-Fn1.png)

- Inside the generated VCN, create a **subnet**. For IPv4 CIDR Block, the recommended one **10.0.0.0/24** can be used. For Subnet Access, choose Private Subnet.  
  ![](./images/Set-Fn2.png)

- Under the VCN, create a **Service Gateway**. Remember to choose **ALL <Region> Services In Oracle Service Network** under Services.  

  ![](./images/Set-Fn3.png)

- Under the VCN, go to **Route Tables** and click on **Default Route Table for \<vcn-name>**. Choose **Add Route Rules**. Choose **Service Gateway** as the Target Type, **ALL <Region> Services In Oracle Service Network** as Destination Service, and choose the Service Gateway created in the previous step as Target Service Gateway.  

  ![](./images/Set-Fn4.png)
    

## 2. Create a OCI Functions Application

Go to **Functions** → **Applications**, and Create an *Application*. See screenshots below.

![](./images/Set-Fn5.png)

![](./images/Set-Fn6.png)

Next, go to **Getting Started** (under *Resources* panel on the left) and click **Cloud Shell setup**. Follow steps 1 through 10 and deploy the demo function (*hello-java*).

![](./images/Set-Fn7.png)

Lastly, run the demo function and verify that it can be invoked successfully. The function should print/output a message *Hello, World!* on the console as below.

```
$ fn invoke <func-name> <app-name>
Hello, World!
```

## 3. Configure OCI Function to invoke the Data Flow Application

An OCI Function serves as a *Driver* for invoking the Data Flow Application.

Download the Driver Function (`func.py`) from [here](https://objectstorage.us-phoenix-1.oraclecloud.com/p/l1H-kfulXPk6pPgLkQTqOgPXKtoW9Uvkhhufd108yYST9vwrwVUDoU1VWXh_z_bB/n/axaspnesarzr/b/driver-code-archive-bucket/o/func.py). Save the Function (Python program - `func.py`) to a local directory on your pc.

- Update the Function code

  Open `func.py` in a text editor and make the following updates.

  Search for the code snippet below. 

  ```python
  if bucketName == "<training_bucket_name>":
        config_bucket_name = "<training_config_bucket_name>"
        object_name = "<driver_config.json>"
        resp = get_object(namespace, config_bucket_name, object_name)
  ```

  Substitute, correct values for *place-holders* (Variable values) as per the table below.  These values were configured in Labs 3 and 4.

  | Place-Holder Name | Value |
  | ------------- | ----- |
  | <training_bucket_name> | *training-data-bucket* |
  | <training_config_bucket_name> | *training-config-bucket* |
  | <driver_config>.json | *training-config.json* |

  Search for the code snippet below.

  ```python
  elif bucketName == "<inferencing-data-bucket>":
        config_bucket_name = "<inferencing_config_bucket_name>"
        object_name = "<driver_config>.json"
        resp = get_object(namespace, config_bucket_name, object_name)
  ```

  Substitute, correct values for *place-holders* (Variable values) as per the table below.  These values were configured in Labs 3 and 4.

  | Place-Holder Name | Value |
  | ------------- | ----- |
  | <inferencing_bucket_name> | *inferencing-data-bucket* |
  | <inferencing_config_bucket_name> | *inferencing-config-bucket* |
  | <driver_config>.json | *inference-config.json* |

  Search for the code snippet below.

  ```python
  create_run_details=oci.data_flow.models.CreateRunDetails(
            compartment_id="compartment-ocid",
            application_id="application-ocid",
            arguments=[ "--response", response, "--phase", phase],
            display_name="complete-dpp-test",
            logs_bucket_uri="storage-bucket-uri")
  ```

  Substitute, correct values for *place-holders* (Variable values) as per the table below.  These values were configured in Labs 3 and 5.

  | Place-Holder Name | Description |
  | ------------- | ----- |
  | compartment-ocid | The Compartment OCID |
  | application-ocid | The Data Flow Application OCID |
  | storage-bucket-uri | The URI should be off the form - **oci://bucket-name@namespace/** where *bucket-name* is **logs-bucket** and *namespace* is the bucket's namespace |

  Save the updates to the Function (func.py) and close the editor.

- Create a new OCI Function (*DPF Driver*)

  Most of these steps can also be completed using **OCI Code Editor** accessible via the OCI Console.  CLI instructions are provided here for convenience.

  Open a OCI Cloud Shell or alternatively go to the **Getting started** page within the **Function Application** and click on the *Launch Cloud Shell* (Step 1).

  Run the commands in the snippet below.

  ```bash
  # Create the Function
  # Params:
  #   Function-Name: Use any name for the Function
  #
  $ fn init --runtime python3.9 <Function-Name>
  #
  # Switch into the Function directory. 'Function-Name' is used as the name of the function here (example).
  #
  $ cd Function-Name
  #
  ```

  Replace the contents of Function (`func.py`) with the updated program which was modified in the previous step. Save the Function.

- Edit `requirements.txt` file and update the following lines.

  ```
  fdk>=0.1.46
  oci>=2.2.18
  ```

- Deploy the Driver Function

  In the OCI Cloud Shell, execute the commands in the snippet shown below.

  ```bash
  # Deploy the Function.  Make sure you are in the Function directory!
  # Params:
  #   Function-Application-Name: Name of the Function Application from Step [2]
  #
  $ fn -v deploy --app <Function Application>
  #
  # Function should be deployed and ready to run.
  ```

## 4. Enable OCI Function Logs

   In the Function Application, under the **Resources** panel click on **Logs** and enable *Function Invocation Logs*.  This will be helpful for troubleshooting the Function if needed. See screenshot below.

   ![](./images/Set-Fn8.png)

## Useful Resources
Refer to the OCI documentation (link below) to learn more about OCI Functions.

- [OCI Functions](https://docs.oracle.com/en-us/iaas/Content/Functions/Concepts/functionsoverview.htm)

[Go to *Lab 5*](#prev) | [Go to *Lab 7*](#next)
