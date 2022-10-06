# Pre-requisites

## Introduction

In this lab, you will focus on understanding the pre-requisites and setting up your tenancy for the subsequent creation and operation of the OCI Vision model.

Estimated Time: 15 minutes

### Objectives

In this lab, you will:
- Create a Compartment
- Create a Group
- Create Dynamic Group
- Create a Policy

## Task 1: Create Compartment

In this task, you will create a dedicated compartment for this live lab.

1. In the Oracle Cloud Console, click the main menu icon to open the side menu.
2. Click **Identity & Security** and select **Compartments**.

   ![Select Compartments](../images/oci_menu_compartments.png)

4. Click **Create Compartment**.
5. Provide *vision-livelab* as **Name**, a **Description** of your choice, and leave the root level as Parent.
6. Click **Create Compartment**.

   ![Creation of vision-livelab compartment](../images/create_compartment.png)

## Task 2: Create Group

1. In the Oracle Cloud Console, click the main menu icon to open the side menu.
2. Click **Identity & Security** and select **Domains**. 

   ![Select Domains](../images/oci_menu_domains.png)

4. Select the domain listed as *Current domain*.
5. On the left menu, select **Groups**.
6. Select **Create group**.
7. Provide *vision-group* as **Name**, add a **Description** of your choice, and select your User to add your account to the Group.
8. Click **Create**.

## Task 3: Create Dynamic Group

1. In the Oracle Cloud Console, click the main menu icon to open the side menu.
2. Click **Identity & Security** and select **Domains**. 

   ![Select Domains](../images/oci_menu_domains.png)

4. Select the domain listed as *Current domain*.
5. On the left menu, select **Dynamic groups**.
6. Select **Create dynamic group**.
7. Provide *dls-dynamic-group* as **Name**, add a **Description** of your choice, and add the following matching rule:

   ```html
   <copy>ALL { resource.type = 'datalabelingdataset' }
   ```
   
   ![Create dynamic group](../images/create_dynamic_group.png)
   
9. Click **Create**.

## Task 4: Policy setup

In this task, you will create the required OCI IAM policy.

1. In the Oracle Cloud Console, click the main menu icon to open the side menu.
2. Click **Identity & Security** and select **Policies**. 

   ![Select Policies](../images/oci_menu_policies.png)
   
3. Click **Create Policy**.
4. Provide *vision-policy* as **Name** and add a **Description** of your choice.
5. Set the **Compartment** to the root compartment.
6. Click **Show manual editor** and paste the content below in the editor.

   ```html
   <copy>allow group vision-group to use ai-service-vision-family in compartment vision-livelab
      
   allow group vision-group to read buckets in compartment vision-livelab
   allow group vision-group to manage objects in compartment vision-livelab
   allow group vision-group to read objectstorage-namespaces in compartment vision-livelab
   allow group vision-group to manage data-labeling-family in compartment vision-livelab
      
   allow dynamic-group dls-dynamic-group to read buckets in compartment vision-livelab
   allow dynamic-group dls-dynamic-group to read objects in compartment vision-livelab
   allow dynamic-group dls-dynamic-group to manage objects in compartment vision-livelab where any {request.permission='OBJECT_CREATE'}
   ```

6. Click **Create**.
   ![Creation of vision-policy policy](../images/create_policy.png)

## Acknowledgements

* **Authors** - Nuno Gonçalves, Jason Monden, Mark Heffernan
* **Last Updated By/Date** - Nuno Gonçalves, September 2022
