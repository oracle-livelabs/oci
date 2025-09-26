# Setup environment

## Introduction

In this lab, we will set up the required policies to run through the workshop as non-administrative users. However, you can skip most parts of this lab if you have administrative access.

### About OCI Policies

If you're just trying out Oracle Cloud Infrastructure or doing a proof-of-concept project with infrastructure resources, you may not need more than a few administrators with full access to everything. In that case, you can simply create any new users you need and add them to the Administrators group. The users will be able to do anything with any kind of resource. And you can create all your resources directly in the tenancy (the root compartment). You don't need to create any compartments yet, or any other policies beyond the Tenant Admin Policy, which automatically comes with your tenancy and can't be changed.

Please read more about [OCI Policies](https://docs.oracle.com/en-us/iaas/Content/Identity/Concepts/policygetstarted.htm) before creating or changing any OCI policies.

Estimated time: 30 minutes

### Objectives

In this lab, you will:

* Create OCI Bucket
* Create a new compartment
* Setup policies for Compartment management
* Setup policies for OCI Data Labeling
* Setup policies for OCI Vision service
* Setup policies for OCI Document Understanding Service
* Setup policies for OCI Speech
* Setup policies for OCI Anomaly Detection

### Prerequisites

This lab assumes:

* You have an Oracle Cloud account with OCI and Tenancy administration privileges to create policies and compartments. 

    > **Note 1:**  Policies are only required if you cannot create or use a OCI resources. If you are a tenancy administrator, you will have access to all the resources, and you can **optionally skip policy creations in this lab**. 
  
## Task 1: Log into OCI 

1. Login into OCI

    > **Note 2:**  Set up policies based only on the OCI Services that you want to use. For example, a policy on Anomaly Detection would not be required if you want to try a lab on OCI Speech AI.

    To setup environment, you need OCI administrator's privileges. If you've got these privileges, login into OCI at [cloud.oracle.com](https://www.oracle.com/cloud/sign-in.html). the below image indicates SSO Login as an administrative user. If you have administrative previleges and complete access over a tenancy then you need not create any of the policies below steps. 

    If you do not have administrative privileges into tenancy, you might have to login as federated user, that is the user created by the administrator  

    In case you haven't got OCI administrator's privileges, you should ask your OCI administrator to perform the rest of the tasks in this lab.

## Task 2: Create OCI Bucket
  
You need to upload the audio files into Oracle object storage, to be used in the transcription job(s) in next steps.

1. Create an Object Storage Bucket (This step is optional in case the bucket is already created)

    First, From the OCI Services menu, click Object Storage.
    ![Navigation menu window](./images/storage-nav.png " ")

    Then, Select Compartment from the left dropdown menu. Choose the compartment matching your name or company name. 

    Next click Create Bucket.
    ![Create bucket button](./images/create-bucket-newui.png " ")

    Next, fill out the dialog box:
    * Bucket Name: Provide a name <br/>
    * Storage Tier: STANDARD

    Then click **Create Bucket**  
    
## Task 3: Setup policies for Compartment management

You need to create a **policy** which grants manage privileges in a new compartment to the new OCI group.

1. Navigate to **Policies** page

    Once again use **Navigator** to navigate to **Identity & Security** and now choose **Policies**.

    ![Navigate to Policies](images/policy-nav.png)

2. Create a new policy

    In the **Policies** page click **Create Policy**.

    ![Create a new policy](images/create-policynewui.png =30%x*)

3. Define a new policy

    Provide a new Policy **Name** and **Description**.

    This policy is set at the *root* compartment level, therefore select the *root* compartment of your tenancy.

    In **Policy Builder** section, search for **Let compartment admins manage the compartment** in the **Common policy templates** pulldown list.

    Make sure **Groups** option is selected and then choose your newly created OCI Group from the list of available OCI Groups. For **Location**, select parent compartment which can also be *root* compartment.
 
    Your policy should look like this:

     ```text
     <copy>Allow group < group name > to manage all-resources in compartment < compartment name > </copy>
     ```
   
    for example, 

    ```text
     <copy>Allow group AIDEMOGroup to manage all-resources in compartment aidemo</copy>
    ```
  
## Task 4: Setup policies for OCI Vision service

Similarly to Data Labeling service, you will require some privileges to use OCI Vision service. 

> **Note:** Please refer [OCI AI Vision Policies](https://docs.oracle.com/en-us/iaas/vision/vision/using/about_vision_policies.htm) for more information related to this policy.

1. Navigate to **Policies** page. In the **Navigator** to navigate to **Identity & Security** and now choose **Policies**. 
2. Create a new policy

    In the **Policies** page click **Create Policy**. 
    
  
3. Define policies to access Vision service

    Provide a name of a new policy and description in **Create Policy** dialog page. In the **Policy Builder** section enable **Show manual editor** and enter the following policy, You can provide any name and description for this policy

    Policy statement 
 
    ```text
    <copy>allow group AIDEMOGroup to manage ai-service-vision-family in tenancy
    allow group AIDEMOGroup to manage object-family in tenancy</copy>
    ``` 
 

    Click **Create**. 

    You are now ready to start using OCI Vision service.
  
## Task 5: Setup policies for OCI Document Understanding Service

Before you start using OCI Document Understanding, OCI policies should be setup for allowing you to access OCI Document Understanding Service. Follow these steps to configure required policies.

> **Note:** Please refer [OCI Document Understanding Policies](https://docs.oracle.com/en-us/iaas/document-understanding/document-understanding/using/about_document-understanding_policies.htm#about_vision_policies) for more information related to this policy.

1. Navigate to **Policies** page. In the **Navigator** to navigate to **Identity & Security** and now choose **Policies**.
 
2. Create a new policy

    In the **Policies** page click **Create Policy**. 

3. Create Policy to grant users Document APIs access. Add the below statement to allow all the users in your tenancy to use document understanding:

    Policy statement -

    ```
    <copy>allow any-user to manage ai-service-document-family in tenancy</copy>
    ``` 
     
    If you want to limit access to a user group, create a policy with the below statement:

    ```
    <copy>allow group <group-name> to use ai-service-document-family in tenancy</copy>
    ```

4. Policy to access input document files in object storage 

  If your want to analyze documents stored in your tenancy's object storage bucket, add the below statement to grant object storage access permissions to the group:

    ```
    <copy>allow group <group_in_tenancy> to use object-family in tenancy</copy>
    ```
        
  If you want to restrict access to a specific compartment, you can use the following policy instead: 

    ```
    <copy>allow group <group_in_tenancy> to use object-family in compartment <compartment-ocid></copy>
    ```

6. Policy to access output location in object storage 

  Document Understanding Service stores results in your tenancy's object store. Add the following policy to grant object storage access permissions to the user group who requested the analysis to documents:

    ```
    <copy>allow group <group_in_tenancy> to manage object-family in compartment <compartment-ocid></copy>
    ```
   
## Task 6: Setup policies for OCI Speech

Before you start using OCI Speech, your tenancy administrator should set up the following policies by following below steps:

> **Note:** Please refer [OCI Speech Policies](https://docs.oracle.com/en-us/iaas/Content/speech/using/policies.htm) for more information related to this policy.

1. Create a new policy with the following statements:

    If you want to allow all the users in your tenancy to use speech service, create a new policy with the below statement:

    ```
    <copy>
    allow any-user to manage ai-service-speech-family in tenancy
    allow any-user to manage object-family in tenancy
    allow any-user to read tag-namespaces in tenancy
    allow any-user to use ons-family in tenancy
    allow any-user to manage cloudevents-rules in tenancy
    allow any-user to use virtual-network-family in tenancy
    allow any-user to manage function-family in tenancy
    </copy>
    ``` 
   
 For any other required policies please refer [OCI Policies documentation ](https://docs.oracle.com/en-us/iaas/Content/Identity/Concepts/policygetstarted.htm)

This concludes this lab. You can **proceed now to the next lab**.
   
## Learn More

* [OCI Documentation](https://docs.oracle.com/en-us/iaas/Content/home.htm) 
* [Configure OCI CLI](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliconfigure.htm)
* [OCI Speech Policies](https://docs.oracle.com/en-us/iaas/Content/speech/using/policies.htm)
* [OCI Object Storage](https://docs.oracle.com/en-us/iaas/Content/Object/Concepts/objectstorageoverview.htm) 
 
## Acknowledgements

* **Author** - Madhusudhan Rao B M, Principal Product Manager, Oracle Database

* **Last Updated By/Date** - 26th Sept, 2025.