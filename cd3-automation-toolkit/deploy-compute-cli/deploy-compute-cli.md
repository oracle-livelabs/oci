# Deploy OCI resources using CD3 Toolkit - CLI

## Introduction

This is a continuation of the lab 2 : **Add resource parameter values in Excel file**

As a recap, in the previous lab we added resource parameters values in excel file for Compartments, VCN, Subnets, Compute, Block Volume and ATP.

Estimated time: 10 minutes

### Objectives

In this lab, you will:

- Execute the *setUpOCI.py* script to generate terraform files.
- Execute terraform commands from the respective service folders. 

### Prerequisites

- Please follow the previous lab till the last step. Once you are ready with excel template. You are all set to continue with this lab.

# Create Resources using CLI 

## Task 1: Add Excel path to 'prefix_setUpOCI.properties'
    
    Note: Please check the tenancyconfig.properties file for prefix information

1. Add the Excel file path for "cd3file" parameter. You can find a file in below location.

    ```
    /cd3user/tenancies/<prefix>_setUpOCI.properties
    ```

2. Set below parameter to *create_resources*, since we are creating new resources, and not modifying any existing ones.

    ```
    workflow_type = create_resources
    ```

3. Save the file.


## Task 2: Execute setUpOCI.py

1. Run setUpOCI.py script to create the Terraform files for our resources.

2. Navigate to below path and execute the command.
        
    ```
    cd /cd3user/oci_tools/cd3_automation_toolkit/
    python setUpOCI.py /cd3user/tenancies/<prefix>/<prefix>_setUpOCI.properties
    ```
## Task 3: Generate terraform files and create our resources in OCI

1. Select option 1 from *setUpOCI.py* output menu. 

    >**Note:** Identity--> 1: Add/Modify/Delete Compartments. 

2. Navigate to identity directory under home region directory after Terraform files are created.

    ```               
    cd /cd3user/tenancies/<prefix>/terraform_files/<home_region>/identity
    ```

3. Execute terraform init, plan and apply to create the compartment.

    >**Note:** Since we are creating all resources in the *democompartment*, we should first create the compartment in OCI and run fetch compartments again. This way the variables file has the *compartment* entry and other resources can be created in it.

4. Go back to the below folder and execute the setUpOCI.py again as shown in *Task 3* and select *fetch compartments*.

    ```
    /cd3user/oci_tools/cd3_automation_toolkit/
    ```

    >**Note:** This option will update OCID of newly created compartments in TF file.

5. Select: 3,4,5,6 options to create terraform files for Network, Compute, Storage and Database respectively from the *setUpOCI.py* output menu.

    - Under *Network*: Select- Options 1,3,4 
    - Under *Compute*: Select- Option 2
    - Under *Storage*: Select- Option 1
    - Under *Database*: Select- Option 3

    >**Note:** Terraform files are generated under the respective Service directories of the Region directory.

6. Once the Terraform files are created from above step, navigate to below path for each of the services: Network, Compute, Database and Block volume.

    ```
    /cd3user/tenancies/<prefix>/terraform_files/<region>/<services>
    ```

7. Enter into each of the required service folders (network, compute, database) and execute the below terraform commands to provision the resources in OCI.

    ```
    terraform init
    terraform plan 
    terraform apply 
    ```

    >Note: We are using terraform commands to provision resources in this lab. We will also leverage this terraform code in resource manager in upcoming lab.  

8. Review the terraform output and the created resources can be viewed on the OCI console.

    ![TFAPPLY](./images/apply-output.png "Terraform Output")

In this lab, we have learnt how to execute setUpOCI.py to create terraform files and create OCI resources using those terraform files.

You may now __proceed to the next lab__.

## Acknowledgements

- __Author__ - Lasya Vadavalli
- __Contributors__ - Murali N V, Suruchi Singla, Dipesh Rathod
- __Last Updated By/Date__ - Dipesh Rathod, Mar 2024
