# Get started with CD3 Automation Toolkit setup

## **Introduction**

To set up the CD3 Toolkit container and connecting it to OCI, please follow the step-by-step instructions outlined in this lab.

The CD3 container can either be launched in a OCI VM using single click RM stack deployment or it can be launched in user's Local system. 

Follow the below steps to launch the container in either OCI or Local **(Task1 or Task2)** and then connect the container to the tenancy following **Task3**


Estimated Time: 10 minutes

### Objectives

The objectives of this lab are:

- Launch CD3 container in OCI 
- Launch CD3 container in Local System.
- Connect CD3 container to OCI tenancy


### Prerequisites


- IAM policy to allow user/instance principal to manage the services that need to be created/exported using the toolkit.

- Minimum requirement is to have read access to the tenancy.

<br>

## Task 1: Launch CD3 container in OCI- Single Click deployment:


 1. **Prerequisites:**

    The user deploying the stack should have access to launch OCI Resource Manager Stack, Compute Instance and Network resources.


2. Click on below button to directly navigate to Resource Manager Stack in the OCI Tenancy. This Stack creates a CD3 WorkVM in OCI.


   [![Deploy_To_OCI](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/oracle-devrel/cd3-automation-toolkit/archive/refs/heads/develop.zip)



3. After accepting the terms and conditions, fill in the details like the Network, Compartment, VM name, shape etc., for the workVM to be created.  

   Most of the parameter values are pre-populated. You can also choose from the values in dropdowns. 

   >Note: If you opted to create a new VCN for the VM, you can choose the Source IP/CIDR  from where CD3 Automation Toolkit WorkVM will be accessed. (Rule will be created in NSG to allow ssh on port 22 and jenkins on port 8443)

   >Important !:  It is recommended to refrain from using 0.0.0.0/0 as Source CIDR to maintain a secure environment. Instead just provide the specific IP/CIDR from where you are going to access the VM.

4. Review the values, Check the "Run Apply" box at the bottom and click on "Create".

5. After the Apply job is successful, click on the Job and scroll down to the end of logs and find the details for the created VM, commands to be executed to login to the toolkit container.

    ![rmstackoutput](./images/rmstackoutput.png)


    Here are the commands for reference: 

    ```
    To verify docker image run command - sudo docker image ls
    To verify docker container run command - sudo docker ps
    To connect to container run command- sudo docker exec -it oci_toolkit bash

    ```

    After executing the above, jump to [Task 3](#task-3-connect-container-to-oci-tenancy) to connect this container to OCI tenancy.

<br>

## Task 2: Launch CD3 container in Local System

Make sure the [prerequisites](#prerequisites) are met before proceeding.


1. Clone the CD3 repository to a local folder from your terminal suing below command:

```bash

git clone https://github.com/oracle-devrel/cd3-automation-toolkit
```

2. Change the directory to *'cd3-automation-toolkit'* (i.e. the cloned repo in your local) and  execute 

```bash
docker build --platform linux/amd64 -t cd3toolkit:$'<image_tag>' -f Dockerfile --pull --no-cache . 
```
<br>

>**Note:**'$<image_tag>' should be replaced with suitable tag as per your requirements/standards. The period (.) at the end of the docker build command is required.

<br>

3. Run the CD3 container using below command:

```bash
    docker run --platform linux/amd64 -it -d -v '<directory_in_local_system_where_the_files_must_be_generated>':/cd3user/tenancies '<image_name>':'<image_tag>'
```
    
   <br>

  ![docker_run](./images/docker_run.png "docker run command example")

 <br> 

4. Verify the container using 

```bash
docker ps
```
Note down the container ID from the above command and execute:

```bash
docker exec -it <container_id> bash
```


## Task 3: Connect container to OCI tenancy

1.  **Choose Authentication Mechanism:**

    You can configure one of the authentication mechanisms for OCI SDK from below. Click on each option for the corresponding steps. For the scope of this tutorial, we will use API-Key authentication. Follow the next steps to configure the same.
  
    - [API Key-based authentication]()
    - [Session token-based authentication]()
    - [Instance Principal]()

    
2. Navigate to 

```bash
cd /cd3user/oci_tools/cd3_automation_toolkit/user-scripts/
```

**2.1** 

RSA key pair in PEM format (minimum 2048 bits) is needed to use OCI APIs. If the key pair does not exist, create them by executing *createAPIKey.py* under *'user-scripts'* folder:

     ``` 
     python createAPIKey.py 
     ```

    This will generate the public/private key pair at /cd3user/tenancies/keys/
   
    ```
    oci_api_public.pem and oci_api_private.pem
    ```

    In case you already have the keys, you should copy the private key file inside the container and rename it to below.
    
    ```
    oci_api_private.pem
    ```

**2.2** 

Upload the Public key to "APIkeys" under user settings in OCI Console. Pre-requisite to use the complete functionality of the Automation Toolkit is to have the user as an administrator to the tenancy.

a. Open the *Console*, and sign in as the user.
b. View the details for the user who will be calling the API with the *key pair*.

c. Open the Profile menu (User menu icon) and click *User Settings*.

d. Click *Add Public Key*.

e. Paste the contents of the *PEM public key* in the dialog box and click *Add*.


<br>

3. Open *tenancyconfig.properties* file and fill in details in the **Required parameters** and **Auth Details Parameters** sections. Below are the sample values for API_Key Auth mechanism. 


<br>

   
   ```bash

   ##################################################################################################################
                            ## Required Parameters ##
    ##################################################################################################################

    # Friendly name for the Customer Tenancy eg: demotenancy; The generated .auto.tfvars files will be prefixed with this
    # customer_name.
    customer_name=demo_tenancy

    tenancy_ocid=ocid1.tenancy.oc1.....niuea

    # Example: us-phoenix-1
    region=us-phoenix-1

    # Auth Mechanism for OCI APIs - api_key,instance_principal,session_token
    # Please make sure to add IAM policies for user/instance_principal before executing createTenancyConfig.py
    auth_mechanism=api_key

    ##################################################################################################################
                                ## Auth Details Parameters ##
    # Required only for ${auth_mechanism} as api_key; Leave below params empty if 'instance_principal' or 'session_token'
    # is used
    ##################################################################################################################

    user_ocid=ocid1.user.oc1....4avq
    #Path of API Private Key (PEM Key) File; Defaults to /cd3user/tenancies/keys/oci_api_private.pem when left empty
    key_path=
    fingerprint= 9d:20:...:45:c8
   
   ```
<br>

>Note:  If you selected Instance Principal or session token method for authentication, follow the commented guidelines in the *tenancyconfig.properties* file or [Auth Mechanisms]() page and proceed accordingly.


4. Under **Deployment Parameters** section, Leave the default value for **outdir_structure_file** parameter if you wish to group your generated terraform auto.tfvars files for each service.

If you wish to keep all the generated terraform auto.tfvars files directly under the region folder, comment the parameter with the default outdirectory structure file path and uncomment the one above to get it into action.


**ssh_public_key** is an optional parameter used to add SSH keys for your launched instances.


5. The **Advanced parameters for DevOps** should be configured if you plan to use the toolkit with Jenkins. If you plan to use the toolkit with CLI, skip this section.

To use the toolkit with Jenkins, the following OCI resources are required:

- **OCI Object Storage Bucket**- for remote terraform state file management
- **OCI DevOps Project/Repo** - To store generated terraform files. Jenkins fetches the required terraform files for reosurce creation from here.
- **OCI Notification Topic** - To notify about the OCI DevOps repo changes.

You can either use existing resources for above or create new ones by setting the parameter values to "yes" like shown below. 

You can provide a name for these resources. If left blank, the resources will be created with the names in the format specified in the comments for each parameter.

```bash

##################################################################################################################
                            ## Advanced Parameters for DevOps ##
# Below OCI Objects - Remote State Bucket Name and DevOps Project/Repo and a Notification Topic will be created/fetched
# from region specified in ${region} above.
# These values are required to be set as "yes" for Jenkins Configuration.
##################################################################################################################


# Compartment OCID where Bucket and DevOps Project/repo will be created; defaults to root if left empty.
compartment_ocid=ocid1.compartment.oc1....z3a

# Remote state configuration
# Enter yes if remote state needs to be configured, else tfstate will be stored on local filesystem.
use_remote_state=yes

# Specify bucket name if you want to use existing bucket else leave empty.
# If left empty, Bucket with name ${customer_name}-automation-toolkit-bucket will be created/reused in ${region}.
remote_state_bucket_name=

# OCI DevOps GIT configuration
# Enter yes if generated terraform_files need to be stored in OCI DevOps GIT Repo else they will be stored on local
# filesystem. Will enforce 'yes' for use_remote_state in case below is set to 'yes'
use_oci_devops_git=yes

# Specify Repo name if you want to use existing OCI Devops GIT Repository else leave empty Format: <project_name/repo_name>
# If left empty, DevOps items  with names ${customer_name}-automation-toolkit-project/repo/topic will be created/reused
# in ${region}.
oci_devops_git_repo_name=


```


Since we are using API-key Auth mechanism, the User details section can be skipped. The details are automatically fetched from above provided values. 

For users using Instance-Principal or session token, provide the user-ocid and key path following the guidelines in the comments.


6. Initialise your environment to use the Automation Toolkit:

```bash

python createTenancyConfig.py tenancyconfig.properties

```

You should see an output similar to below:


![tenancyconfigoutput](./images/tenancyconfigoutput.png)


After the createTenancyConfig.py script is successfully executed, customer specific files get created under 
   
   ```bash
    /cd3user/tenancies/<customer_name>
   ```
with the <customer_name> provided in tenancyconfig.properties as prefix
   

You have now successfully setup the CD3 toolkit container and connected it to OCI tenancy.


What's next? Check out the next labs to create/export your OCI resources in minutes !!


## Acknowledgements

- __Author__ - Lasya Vadavalli
- __Contributors__ - Murali N V, Suruchi Singla, Dipesh Rathod
- __Last Updated By/Date__ - Lasya Vadavalli, June 2023
