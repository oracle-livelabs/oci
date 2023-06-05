## **Deploy OCI resources using CD3 Toolkit**

<br>

## **Introduction**

This is a continuation of the lab 2: [Setup the CD3 toolkit](/cd3-automation-toolkit/Setup%20the%20Toolkit/setup_the_toolkit.md)

As a recap, in the previous lab we cloned the cd3 repo, built an image, executed the CD3 container and connected it to the OCI tenancy. We were able to see the customer specific files getting generated in the outdirectory.

In this lab, we will go through the process of provisioning the following OCI resources using CD3: Compartments, VCN, Subnets, Compute, Block Volume, ATP.

Estimated lab time:15 minutes

<br>

## **Objectives**

In this lab, you will:

- Add required resource parameter values to the Excel sheet.
- Add the Excel file path in setupoci.properties file.
- Run the setUpoci.py script.
- Execute terraform commands from the respective service folders.

<br>

## **Prerequisites**

- Please follow the previous lab till the last step. Once you are be able to view the customer specific files in the outdirectory, you are all set to start with this lab.

<br>

## **Task 1: Add required resource parameter values in the Excel file**


- Choose CD3-CIS-template from [CD3 Excel templates](https://github.com/oracle-devrel/cd3-automation-toolkit/blob/main/cd3_automation_toolkit/documentation/user_guide/RunningAutomationToolkit.md#excel-sheet-templates). 


 >Note: Any template other than CIS Management services template can be used for these services.

- Add the required values in the below mentioned Excel worksheets to provision our OCI resources
    
    - Compartments
    - VCNs
    - SubnetsVLANs
    - RouteRulesinOCI, SecRulesinOCI    
    - Instances
    - BlockVolumes
    - ATP

- Refer to the blue section in each worksheet to fill the resource details in proper formats. Not all fields are mandatory. You can also refer to the cells below the \<END> tag to get example data. 

>Note: Please fill resources data before the \<END> tag. Any data below the \<END> tag will not be processed.



<br>

## **Task 1: Create Compartment:**

- Open the "Compartments" tab and add your compartment data with below image as example.

![screenshot](/cd3-automation-toolkit/deploy-compute/images/Excel.png)

<br>

## **Task 2: Create Network components**

- In this step, we will create a VCN, Subnets, Route rules and security rules attched to the subnets in sequence.

Add your network components parameters values following the images below as examples.

<br>

**First add details for a VCN:**


![vcnsheet](/cd3-automation-toolkit/deploy-compute/images/vcn.png)
<br>

**Add details for creating Subnets in the above VCN:**

![subnetssheet](/cd3-automation-toolkit/deploy-compute/images/subnetssheet.png)


**Add details for Route rules and Security rules**

![routerulessheet](/cd3-automation-toolkit/deploy-compute/images/routerulessheet.png)

<br>

![secrulessheet](/cd3-automation-toolkit/deploy-compute/images/secrulessheet.png)

<br>


## **Task 2:Add details for Compute VM and Block volume**

<br>

![instancessheet](/cd3-automation-toolkit/deploy-compute/images/instancessheet.png)
<br>

>Note: To add SSH keys to the vm, place them in variables.tf
<br>

![blockvolume](/cd3-automation-toolkit/deploy-compute/images/Blockvolumessheet.png)
<br>


## **Task 3: Add details for ATP** 
<br>

![atp](/cd3-automation-toolkit/deploy-compute/images/atpsheet.png)

<br>

## **Task 4: Add excel path to <customer_name>_setUpoci.properties**

- Once all the resource details are filled in the Excel sheets, save the file. Under /cd3user/tenancies/<customer_name>, open <customer_name>_setUpoci.properties, and add the Excel file path at the "cd3file" parameter. 

Since we are creating new resources, and not modifying any existing ones,
the *non_gf_tenancy* parameter should be set to **false**. 

Other values are automatically populated form running the createTenancy.py script in the previous lab.

Save the file.

Refer to the image below :

<br>

![setupoci](/cd3-automation-toolkit/deploy-compute/images/setupoci.png)

<br>


## **Task 4: Execute setUpOCI.py**

- To create the Terraform files for our resources, we should run the setUpOCI.py script.
- Navigate to  */cd3user/oci_tools/cd3_automation_toolkit/* and execute setUpOCI.py with setUpOCI.properties file as the parameter.
        
    
      python setUpOCI.py /cd3user/tenancies/<customer_name>/<customer_name>_setUpOCI.properties


Here is how the output looks like

![output](/cd3-automation-toolkit/deploy-compute/images/output1.png)

<br>

![output2](/cd3-automation-toolkit/deploy-compute/images/output2.png)


## **Execute Terraform commands**

- Once the terrfaorm files are created from above step, navigate to /cd3user/tenancies/<customer_name>/terraform_files/<region>/<services>

>Note: In the tenancyconfig.properties, we selected for a outdirectory structure fro the generated terraform files. Hence you should see all services directories under the <region> directory. 

- Enter each of the required services folders and execute terraform init, terraform plan and terraform apply to provision those resources on OCI.

Here is an image showing **identity** folder which contains the compartment data we provided

<br>

![terraformfiles](/cd3-automation-toolkit/deploy-compute/images/terraform%20files.png)
<br>

![terraformoutput](/cd3-automation-toolkit/deploy-compute/images/terraform%20output.png)
<br>

