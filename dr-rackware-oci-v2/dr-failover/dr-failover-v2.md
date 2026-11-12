# Complete DR Configuration & Perform Failover

## Introduction

The final lab in this workshop will help you connect to the backup database and connect to the APEX instance replicated by RackWare (RMM).

Estimated Lab Time: 30-45 minutes

### Objectives

* Connect the target APEX instance to the backup database
* Failover to the backup database
* Connect to the replicated APEX instance

### Prerequisites

* Successful completion of all previous labs in this workshop

## Task 1: Connect the new instance to the Backup database

1. Start an ssh connection to the newly created instance.
1. Navigate to the root compartment and edit the *defaults.xml* file

    ```
    opc@<target-machine>$ sudo su -
    root@<target-machine>$ vi /home/oracle/conf/ords/defaults.xml
    ```

1. Change the db.hostname entry to reflect the IP of the backup database
    ![Defaults db](./images/defaults-db.PNG)

1. Update the db.hostname in *ords_params.properties* file to reflect the IP of the backup database

    ```
    root@<target-machine>$ vi /home/oracle/params/ords_params.properties
    ```

    ![Params db](./images/params-db.PNG)
1. Start the ORDS server on the target machine *(You must complete this step after each sync)*

    ```
    root@<target-machine>$ sudo su - oracle
    oracle@<target-machine>$ ./start_ords.sh
    ```

1. Create a .txt file with the following two lines and save to your local machine:
    ![Excl](./images/excl.PNG)
1. From the RackWare GUI, locate the wave you replicated and click the blue name.
    ![Rack wave](./images/rack-wave.PNG)
1. Click the blue edit box on the row of your host machine.
    ![Edit](./images/edit.PNG)
1. Under **Sync Options**, select the **Browse** button under **Upload local File** & add the .txt file created in step 6. Click **Modify**
    ![Sync](./images/sync.PNG)
    *(This will make sure the new instance points to the backup database after every sync)*


## Task 2: Conduct the failover operation to activate the backup database

1. Navigate to the standby database
    ![Db nav](./images/db-nav.PNG)
1. Click the database name under the backup DB System
    ![Db name](./images/db-name.PNG)
1. Under **Resources** on the left, choose Data Guard Associations. Click the three dots on the right and select **Failover**
    ![Failover](./images/failover.PNG)
1. Enter the database password and click OK. The failover operation will take a few minutes to complete.
    ![Db pass](./images/db-pass.PNG)
1. Navigate back to the StandbyDatabase DB system and look at the Peer Role under Data Guard Associations. It shows Disabled Standby which also reaffirms that the failover was successful.
    ![Pr role](./images/pr-role.PNG)

## Task 3: Verify the APEX application changes in the new Instance

1. Navigate to the new APEX instance through a web browser i.e. https://\<target-public-ip>:8888/ords/drpdb
1. Login with the same workspace & admin credentials created in step 3 & 5 of the lab **Configure APEX instance for DR**
    ![Login](./images/login.PNG)
1. Select the **App Builder** icon.
    ![App build](./images/app-build.PNG)
1. Run the **Sample Database Application** by pressing the play button next when you hover over the applications.
    ![Hover](./images/hover.png)
1. Navigate to the **Products** using the shopping cart icon on the left to verify the "Hat" product was added.
    ![Hat2](./images/hat2.PNG)

## Task 4: Cleanup Process

1. First navigate to OCI Console and terminate the Standby database and once the termination is successful then run the following command

1. Select **Destroy** from the dropdown menu.
    ![Resourcemanager destroy](./images/resourcemanager-destroy.png)

1. Wait until the icon turns green.
    ![Resourcemanager destroy 2](./images/resourcemanager-destroy-2.png)

    **Congratulations! If you see the change reflected in the new instance, you have successfully created a Disaster Recovery setup using RackWare on OCI!**

## Acknowledgements

* **Author** - Will Bullock
* **Last Updated by/date** Will Bullock, November 2020

