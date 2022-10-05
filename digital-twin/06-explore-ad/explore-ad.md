# (Advanced) Explore Anomaly Detection - Access Anomaly Detection service with REST API 

## Introduction
   Our anomaly detection services also support to use Command Line Interface (CLI) tool oci and Software Development Kits (SDKs) with different programming languages to make REST API calls to perform model and data operations.

   In this lab session, we will show you how to set up authentication method in order to use the Python SDK to integrate with our service endpoints;

   You can set up those configurations and execute those codes in the [Oracle Cloud Infrastructure (OCI) Data Science Platform](https://www.oracle.com/artificial-intelligence/data-science/).

### Data Science Service Concepts
Review the following concepts and terms to help you get started with the Data Science service.

* **Project**: Projects are collaborative workspaces for organizing and documenting Data Science assets, such as notebook sessions and models.
* **Notebook Session**: Data Science notebook sessions are interactive coding environments for building and training models. Notebook sessions come with many pre-installed open source and Oracle developed machine learning and data science packages.

*Estimated Time*: 45 minutes

### Objectives

* Learn how to set up API Signing Key and Configure file
* Learn to use OCI Data Science
* Learn to use Python SDK to communicate with OCI anomaly detection service endpoints


### Prerequisites

* Familiar with Python programming is required
* Log into the tenancy using an administrator account.
* A tenancy that is configured to work with the Data Science service.


## Task 1: Setup API Signing Key
We need to generate proper authentication configuration (API Signing Key pair) in order to use Python SDK to communicate properly to the services on your behalf.

1. Open User Settings

Open the Profile menu (User menu icon) in the top right corner and click **User Settings**.

![OCI console](./images/console.png)


2. Open API Key

Navigate to **API Keys** and then click **Add API Key**.

![user profile](./images/user_profile_console.png)


3. Generate API Key

In the dialog, select **Generate API Key Pair**. Click **Download Private Key** and save the key to your local computer, and we will upload it later to the OCI Data Science.

You can rename this pem file as `oci_api_key.pem`

Then click the **Add** button.

![add api key](./images/add_api_key.png)


4. Generate Config File

After click the Add button, a configuration file window pop up. 
Copy the values shown on the console, and save in notepad in your local computer, again later it will be used in the OCI Data Science.

![configuration preview](./images/configuration_file_preview.png)

The configuration content will be like the following:

>[DEFAULT]<br>
user=ocid1.user.oc1..aaaaaaaa......<br>
fingerprint=11:11:11:11:11:11:11:11<br>
tenancy=ocid1.tenancy.oc1..aaaaaaaa......<br>
region=us-ashburn-1<br>
key_file=< path to your private keyfile> # TODO

To know more about API key and config file, please visit [Generating API KEY](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm) and [SDK and CLI Configuration File](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/sdkconfig.htm#SDK_and_CLI_Configuration_File)


## Task 2: Activate Data Science Platform and Configuration

1. Create a Project
Click navigation icon ![Image alt text](./images/navigation_icon.png) at the top left of page, select **Analytics & AI**, then select **Data Science**. This will open the Projects page.

![menu navigator](./images/menu_navigator.png)

Select the compartment where the project is to be created. Click **Create Project**.

![project console](./images/project_console.png)

Enter a unique name (255-character limit) for the project. If you do not provide a name, a name is automatically generated for you.
Then click **Create**. 

![create project](./images/creating_project.png)

This creates Data Science project and opens the project page.

![project page](./images/project_page.png)

2. Create a Notebook Session
>Notebook sessions provide access to a JupyterLab serverless environment that is managed by the Data Science service. 
Data Scientist and developer can use notebook sessions for building data science workloads, developing and running python code.

Click **Create Notebook Session**. 

![create nb session](./images/create_notebook_button.png)

Select the compartment that you want to contain the notebook session.

(Optional, but recommended) Enter a unique name for the notebook session (limit of 255 characters). If you do not provide a name, a name is automatically generated for you.

![create nb page1](./images/create_nb_page1.png)


Select a VM shape. For this lab, it is recommended that you use an Intel VM.Standard3.Flex. 
Click the **Select** button in compute shape. This will open the select shape window. 
To choose the shape, click **Intel**, then check the box beside **VM.Standard3.Flex**. 
Put 2 for Number of OCPUs, the amount of memory will automatically update proportionately. Then click Select shape. 

![select compute](./images/select_compute_shape.png)


Enter the block storage in GB. The suggested size is 100 Gb or larger.

In the networking resources section, select the default networking option.

Click **Create**.

![create nb page2](./images/create_nb_page2.png)

> A notebook session is associated with compute instance, VCN, subnet, and block storage. 
> There are two block storage drives that are associated with a notebook session. 
> There is a boot volume that is initialized each time the notebook session is activated. 
> Any data on the boot volume is lost when the notebook session is deactivated or terminated. 
> There is an additional block storage that is persisted when a notebook session is deactivated, but it is not persisted when a notebook session is terminated. 
> This block volume is mounted in the /home/datascience directory and it is where the JupyterLab notebooks, data files, installed custom software, and other files should be stored.

While the notebook session is being created, you can view the resource status on the console. 
When the notebook session is up and running, you'll see the status turn to ACTIVE. 

![nb session creating](./images/nb_session_CREATING.png)

![nb session ACTIVE](./images/nb_session_ACTIVE.png)

Generally it will take few minutes for notebook session turning into ACTIVE. 
While waiting, please download this [Python notebook](./files/AD_DigitalTwin_notebook.ipynb).

Once the notebook is in an ACTIVE state, click **Open**. 

Now that JupyterLab is open. 
By default, the left side has the file browser open but it can change based on what navigation icons are selected on the far left side of the screen. 
The right side of the screen contains the workspace. It will have a notebook, terminal, console, launcher, Notebook Examples, etc.

![jupyterlab](./images/jupyterLab.png)


3. Install Data Science conda

A conda environment is a collection of libraries, programs, components and metadata. 
It defines a reproducible set of libraries that are used in the data science environment. 

Click on **Environment Explorer**

![environment explorer button](./images/EnvironmentExplorer_button.png)


Search for the "General Machine Learning for CPUs on Python 3.7" Conda environment. 
Open the details by clicking on the down arrow at the right. 
Copy the installation command to the clipboard by clicking on the Copy button.

![ds conda](./images/DS_conda.png)




Open a terminal window by clicking on **File**, **New** and then **Terminal**.

![open terminal](./images/open_terminal.png)


Paste the command from the clipboard: 
`odsc conda install -s generalml_p37_cpu_v1` 

You will receive a prompt related to what version number you want. 
Press Enter to select the default. 
Wait for the conda environment to be installed.

![conda install terminal](./images/conda_install_terminal.png)

This will take about 5 minutes. You can proceed to the next step while the conda pack is installing.



4. Add OCI Config file 

Open a new terminal window by clicking on **File**, **New** and then **Terminal**.

Run the following command. This will create a hidden folder _.oci_ in the home directory.

```
<copy>mkdir -p ~/.oci</copy>
```

Run
```
<copy>vi ~/.oci/config</copy>
```

This will create a new file ~/.oci/config and open vi editor.

![vi config](./images/vi_config.png)

![vi empty](./images/empty_vi.png)

Press **i** to enter insert mode.

Copy and paste the content of configuration file created from Task 1: Setup API Signing Key. 

Update the last TODO line as 
>_key_file=~/.oci/oci_api_key.pem_

![config insert](./images/config_insert.png)

Press **Esc** key to exit the insert mode. 

Type **:wq** to save the updates and quit out of vi editor.

![config save](./images/config_save.png)

You can review the ~/.oci/config file by run the command:

```
<copy>cat ~/.oci/config</copy>
```

![config cat](./images/cat_config.png)


5. Add API private key

Run the following command in terminal.


```
<copy>vi ~/.oci/oci_api_key.pem</copy>
```


Press **i** to enter insert mode.

Open the _oci_api_key.pem_ that you downloaded from Task 1: Setup API Signing Key in notepad. 
Copy and Paste the whole content to vi editor. 

![api key](./images/api_private_key.png)

Press **Esc** key to exit the insert mode. 

Type **:wq** to save the updates and quit out of vi editor.



6. Upload Python notebook

If you haven't done so, download this [python notebook](./files/AD_DigitalTwin_notebook.ipynb) which contains the python code snippet for this lab. 
Upload the notebook to JupyterLab by dragging it to the left panel. 

![drag file](./images/drag_file.png)



## Task 3 Python SDK Code Snippets

1. Start the notebook

Click the `AD_DigitalTwin_notebook.ipynb` to open in a new tab. Choose kernel by clicking the Python kernel, then select `generalml_p37_cpu_v1` kernel from the drop-down list.

![select kernel](./images/select_kernel_1.png)
 
![select kernel](./images/select_kernel_2.png)

Read through the notebook. When you encounter a chunk of code, click in the cell and press _shift + enter_ to execute it. 
Or click the run button.

![run button](./images/run_button.png)

When the cell is running, a [*] will appear in the top left corner of the cell. When it is finished, a number will appear in [ ], for example [1]. 

![code run](./images/code_run1.png)

![code run](./images/code_run2.png)

Always make sure that the last command has finished running before running another cell.

Execute the cells in order. If you run into problems and want to start over again, click the **restart** button then click **Restart**. 

![restart kernel](./images/restart_kernel1.png)

![restart kernel](./images/restart_kernel2.png)


<details>
<summary><font size="2">Training Data requirements</font></summary>
    
- Can only contain timestamps and other numeric attributes that typically represent sensor or signal readings.
- Must be anomaly free (without outliers) and contain observations that have normal business conditions only.
- Covers all the normal business scenarios that contain the full value ranges on all attributes.
- Can be well related, belong to the same system or asset, or not. This is because the Anomaly Detection service uses both univariate and multivariate analysis methods.
</details>




## Acknowledgements

* **Author** - Jiayuan Yang, - Senior Cloud Engineer
* **Contributors** -  
* **Last Updated By/Date** - Jiayuan, Sep 2022


















