# Deploy OCI resources using CD3 Toolkit

## Introduction

This is a continuation of the lab 1 : [Setup the CD3 toolkit](/cd3-automation-toolkit/Setup%20the%20Toolkit/setup_the_toolkit.md)

As a recap, in the previous lab we cloned the cd3 repo, built an image, executed the CD3 container and connected it to the OCI tenancy. 


### Objectives

In this lab, you will:

- Add required parameter values for Compartments, VCN, Subnets, Compute, Block Volume, ATP to the Excel file.
- Execute the *setUpOCI.py* script to generate terraform files.
- Execute terraform commands from the respective service folders. 

<br>

Estimated lab time: 20 minutes

### Prerequisites

- Please follow the previous lab till the last step. Once you are able to view the customer specific files in the outdirectory, you are all set to continue with this lab.

## Task 1:  Add required resource parameter values in the Excel file

1. Choose CD3-CIS-template from [CD3 Excel templates](https://github.com/oracle-devrel/cd3-automation-toolkit/blob/main/cd3_automation_toolkit/documentation/user_guide/RunningAutomationToolkit.md#excel-sheet-templates). 


> Note: Any template other than *CD3-CIS-ManagementServices-template* can be used to provision these services.

<br>
2. Refer to the blue section in each worksheet to fill the resource details in proper formats. Not all fields are mandatory. 

> Note: Please fill resources data before the \<END> tag. Any data below the \<END> tag will not be processed.

<br>
3. __Add details for Compartment:__

  - Open the **"Compartments"** tab and add your compartment data with below image as example.

   - If the parent compartment is not under root directly, then provide it in the below format:

      *Parent_compartment 1::Parent_compartment 2:: ... ::Parent_compartment n*

> Note: Provide your Tenancy's "home region" under the "Region" column. (same for all OCI Identity components).

Refer to the below image as example:
![Compartment](/cd3-automation-toolkit/deploy-compute/images/compartment.png)

<br>

4. __Add details for the VCN:__

  - Navigate to **"VCNs"** sheet and create a VCN with the following details:

  - Compartment name format: *parent_compartment1::parent_compartment2::child_compartmemt*

    Name: cd3_vcn

    CIDR: 10.110.0.0/24

    Refer to the below image as example:

   ![vcn](/cd3-automation-toolkit/deploy-compute/images/vcn.png)

   <br>

5. __Add DHCP details for cd3_vcn__

   - Navigate to **"DHCP"** sheet and create DHCP Options with the following details:

   - VCN: cd3_vcn

     DHCP-option: dhcp-internal

     ServerType: VcnLocalPlusInternet

     Search domain: oci.com

  Refer to the below image as example:

   ![dhcp](/cd3-automation-toolkit/deploy-compute/images/dhcp.png)

   <br>

6. __Add details for creating Subnets in cd3_vcn__

   - Navigate to **"SubnetsVLANs"** sheet and create subnets with the following details:


   - Name: subnet1, public subnet, CIDR: 10.110.0.0/26, Route table: RT1, Security list: SL1, Route to IGW.

     Name: subnet2, private subnet, CIDR: 10.110.0.64/26, Route table: RT2, Security list: SL2, Route to NGW.

  Refer to the below image as example:

  ![subnets](/cd3-automation-toolkit/deploy-compute/images/subnets.png)

  <br>

7. __Add details for Route rules__

  - Navigate to **"RouteRulesinOCI"** sheet and create Route rules with following details:


  - Name: RT1, Target:cd3_vcn_igw, Destination type: CIDR, Destination CIDR: 0.0.0.0/0

    Name: RT2, Target:cd3_vcn_ngw, Destination type: CIDR, Destination CIDR: 0.0.0.0/0

  Refer to the below image as example:

   ![routerules](/cd3-automation-toolkit/deploy-compute/images/routerules.png)

<br>

8. __Add details for Security rules__

   - Navigate to **"SecRulesOCI"** sheet and create Security rules with following details:


   - Name: SL1, STATEFUL, type: INGRESS, protocol:TCP, Source- 0.0.0.0/0, Destination port - 22

     Name: SL2, STATEFUL, type: INGRESS, protocol:TCP, Source- 0.0.0.0/0, Destination port - 1521, 1522

  Refer to the below image as example:

   ![secrule](/cd3-automation-toolkit/deploy-compute/images/secrules.png)

   <br>

9. __Add details for Compute VM__


   - Navigate to **"Instances"** sheet and create a Compute Instance with below details:

   - We will provision an **always-free** Instance in this lab.

   - Name: cd3_vm, subnet: cd3_vcn_subnet1 (format: *vcnname_subnetname*), Source details- image::Linux , shape: VM.Standard.E3.Flex::2, ssh_public_key to ssh into the instance,

> Note: To add SSH keys to the vm, place them in **variables.tf** under *ssh_public_key* variable.

 __Creating a simple web application__

   - Create a column **"Cloud Init Script"** in the **Instances** sheet before the *defined tags* column and enter its value as "web.sh" in the same row with cd3_vm instance details.
   - Create a bash file "web.sh" under /cd3user/tenancies/<customer_name>/terraform_files/<region_name>/compute/scripts.
   - Copy below sample script to enable Apache on the instance.

          #!/bin/bash
          sudo yum install -y httpd
          sudo systemctl enable httpd
          sudo systemctl restart httpd
          sudo systemctl stop firewalld
          sudo systemctl disable firewalld
          sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
          sudo iptables-save

 
>Note: Check logs under /var/lib/cloud/instance to ensure the correct data was passed.

<br>

  Refer to the below image as example:
  ![vm](/cd3-automation-toolkit/deploy-compute/images/vm.png)

<br>
10. __Add details for Block Volumes__

   - Navigate to **"Block Volumes"** sheet and create a Block Volume with below details:

   - cd3_blockvolume: 20 VPUs per GB, 150GB size, attached to *cd3_vm* using paravirtualized mode.

  Refer to the below image as example:

   ![blockvolumes](/cd3-automation-toolkit/deploy-compute/images/blockvolume.png)

   <br>

11. __Add details for ATP__

   - Navigate to **"ADB"** sheet and create an ATP service with the below details:

   - We will provision an **always-free** ATP for the lab.

   - cd3_ATP: subnet-cd3_vcn_subnet2, DB Name: adb123db, CPU Core Count-10, Data Storage Size in TB -100, LICENSE_INCLUDED.

  Refer to the below image as example:

  ![ATP](/cd3-automation-toolkit/deploy-compute/images/atp.png)

Once all the resource details are filled, save the Excel file. 

## Task 2: Add Excel path to <customer_name>_setUpoci.properties

1. Under /cd3user/tenancies/<customer_name>, open <customer_name>_setUpOCI.properties, and add the Excel file path at the "cd3file" parameter. 

2. Set *non_gf_tenancy* parameter to **false**, since we are creating new resources, and not modifying any existing ones. 

3. Save the file.


## Task 3: Execute setUpOCI.py

1. Run setUpOCI.py script to create the Terraform files for our resources.

2. Navigate to */cd3user/oci_tools/cd3_automation_toolkit/* and execute the below command.
        
    
      python setUpOCI.py /cd3user/tenancies/<customer_name>/<customer_name>_setUpOCI.properties


## Task 4: Generate terraform files and create our resources in OCI

1. Select option 1 from *setUpOCI.py* output menu. 
> Identity--> 1: Add/Modify/Delete Compartments. 

2. Navigate to identity directory under home region directory after Terraform files are created.
                  
      cd /cd3user/tenancies/<customer_name>/terraform_files/<home_region>/identity

3. Execute terraform init, plan and apply to create the compartment.

> Note: Since we are creating all resources in the **demo_compartment**, we should first create the compartment in OCI and run fetch compartments again. This way the variables file has the **demo_compartment** entry and other resources can be created in it.

4. Go back to the folder */cd3user/oci_tools/cd3_automation_toolkit/* and execute the setUpOCI.py again as shown in **Task 3** and select *fetch compartments*.

> This option will update OCID of newly created compartments in TF file.

5. Select: 3,4,5,6 options to create terraform files for Network, Compute, Storage and Database respectively from the *setUpOCI.py* output menu.

Under *Network*: Select- Options 1,3,4 

Under *Compute*: Select- Option 2

Under *Storage*: Select- Option 1

Under *Database*: Select- Option 3

> Terraform files are generated under the respective Service directories of the Region directory.

6. Once the Terraform files are created from above step, navigate to */cd3user/tenancies/<customer_name>/terraform_files/<region>/<services>* for each of the services: Network, Compute, Database. Block volume terraform files are generated under compute directory.

7. Enter into each of the required service folders (network, compute, database) and execute the below terraform commands to provision the resources in OCI.

```
 terraform init
 terraform plan 
 terraform apply 
 
 ```

8. The created resources can be viewed on the OCI console.

In this lab, we have learnt how to enter details in the CD3 Excel templates, execute setUpOCI.py to create terraform files and create OCI resources using those terraform files.

You may now __proceed to the next lab__.

## Acknowledgements

- __Author__ - Lasya Vadavalli
- __Contributors__ - Murali N V, Suruchi Singla, Dipesh Rathod
- __Last Updated By/Date__ - Lasya Vadavalli, June 2023
