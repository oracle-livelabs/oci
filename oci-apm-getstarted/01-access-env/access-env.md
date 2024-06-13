# Access APM Workshop environment

## Introduction

In this lab, you will use a username provided and log in to the workshop, then access an APM page in the Oracle Cloud console.

Estimated time: 5 minutes

### Objectives

* Access the workshop environment

### Prerequisites

* An Oracle event account, which you can use to sign in to the workshop tenancy.


## Task 1: Log in to the workshop tenancy

1. Click **View Login info** on **Get Started with Oracle Cloud Application Performance Monitoring** landing page to log in to the workshop tenancy in the Oracle Cloud.

   ![Oracle LiveLabs, Workshop page](images/1-0-login-info.png " ")

2. Reservation Information pane opens. Click the **Launch OCI** button. Click **Next**. 

   ![Oracle LiveLabs, Workshop page](images/1-1-launch-oci.png " ")
   ![Oracle LiveLabs, Workshop page](images/1-1-2-click-default.png " ")

3. A new browser tab opens and loads the Oracle Cloud Infrastructure Sign-In page. Copy the Password from the Reservation Information pane on the LiveLab screen.

  ![Oracle LiveLabs, Workshop page](images/1-2-copy-pwd.png " ")
  >***Note:*** In the example image, two browser screens are opened side by side.

4. Paste the copied password onto the OCI Sign-In screen. Note that your user name is already pre-set in the **Oracle Cloud Account Sign In** screen. Click **Sign In**.

   ![Oracle LiveLabs, Workshop page](images/1-3-enter-pwd.png " ")

5. **Reset your password** screen opens. Enter the new password that you can use to re-sign-in to the workshop tenancy, in case you closed your browser during the workshop reservation time. Click **Reset Password**.

   ![Oracle LiveLabs, Workshop page](images/1-4-change-pwd.png " ")

6. Follow the screen to enable secure verification. In this example, Mobile App is selected. Complete the steps and click **Done**.
![Oracle LiveLabs, Workshop page](images/1-6-two-factor-auth.png " ")


7. **Oracle Cloud Get started** page opens. You can proceed to the next task to begin the workshop.

   ![Oracle LiveLabs, Workshop page](images/1-5-oci-console.png " ")




 
## Task 2: Access APM home dashboard


1. Open the navigation menu from the top left corner (aka. hamburger menu) in the Oracle Cloud console, select **Observability & Management** > **Home** under **Application Performance Monitoring**.

   ![Oracle Cloud console, Home page](images/2-0-console-menu.png " ")


   ![Oracle Cloud console, Navigation Menu](images/2-1-menu-home.png " ")

   APM Home page opens.

2. On the APM Home page, select the following from the pulldown menus:
    - Compartment : **root/eStore/WineStore**
    - APM Domain : **Prod**
    - Time : Last **24 Hours**
    - Region: **US East (Ashburn)** (set by default)
   ![Oracle Cloud console, APM Home page](images/2-2-apm-home.png " ")
Make sure the data is loaded onto the charts in the Home dashboard.



You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - Yutaka Takatsu, Product Manager, Enterprise and Cloud Manageability
- **Contributors** - Steven Lemme, Senior Principal Product Manager,  
Anand Prabhu, Sr. Member of Technical Staff,  
Avi Huber, Vice President, Product Management
* **Last Updated By/Date** - Yutaka Takatsu, June 2024
