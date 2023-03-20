 # Import PeopleSoft Environment into Peoplesoft Cloud Manager

 ## Introduction

 In this lab, we'll import all components(Application, Process Schedulers, Web Server and ELK) of PeopleSoft Environment into PeopleSoft Cloud Manager.

 ### Prerequisites

 * A user with access to import PeopleSoft environment into PeopleSoft Cloud Manager
 * A user with read only access to OCI console to obtain OCID's of servers and DB system
 * A user called psadm1 in all PeopleSoft Linux servers who owns PS_HOME folder
 * A user called psadm2 in all PeopleSoft Linux servers who owns PS_CFG_HOME folder and read & execute access to PS_HOME
 * A user called psadm3 in all PeopleSoft Linux servers who owns PS_APP_HOME folder
 * Document reference is https://support.oracle.com/epmos/faces/DocumentDisplay?id=2763578.1&displayIndex=22 


 ## Task 1: Import PeopleSoft Database System to PeopleSoft Cloud Manager

 In this part of the lab, we begin with the import of PeopleSoft DB system running on Database as a Service (DbaaS) platform to PeopleSoft Cloud Manager.

 1. Login to PeopleSoft Cloud Manager as a user who have access to import PeopleSoft environments. Click on Environments tile.

  ![Click on Environments tile](./images/environment-tile.png " ")

 2. Click on Import Environment.

  ![Click on Import Environment](./images/import-environment.png " ")

 3. Enter the Environment Name and Environment Description.

  ![Enter Environment Name and Environment Description](./images/environment-details.png " ")

 4. Click on Add Node.

  ![Click on Add Node](./images/add-node.png " ")

 5. Click on Instance Type dropdown and select DB Systems. For the database system node, all the values are mandatory. Update the values accorndingly and click on OK.

  ![Click on Instance Type dropdown and select DB Systems](./images/db-system.png " ")

   Definition of each fields is below. 

  **Field or Control** | **Description**
  ---------------- | ----------- 
  Exadata | Select Yes if the DB System is Exadata. An additional field for Container Database Name will be added.
  Database System OCID | Database System OCID for the target database
  Database OCID | Database OCID for the target database
  Private IP Address | Private IP address for the target the Database environment
  ssh User | ssh user on the database system being imported
  PeopleSoft Operator ID | PeopleSoft Operator  ID
  PeopleSoft Operator Password | PeopleSoft Operator Password
  PeopleSoft Connect ID | PeopleSoft Connect ID
  PeopleSoft Connect Password | PeopleSoft Connect Password
  PeopleSoft Access ID | PeopleSoft Access ID
  PeopleSoft Access Password | PeopleSoft Access Password
  DB Administrator Password | DB Administrator Password
  PDB Name | Pluggable Database Name
  Container Database Name | For Exadata DB systems enter the container database name

 ![DB-System-Update](./images/db-system-update.png " ")

 ## Task 2: Import PeopleSoft Application Server Tier

 1. You will now comeback to below page. Click on + icon to import Application Server component of Peoplesoft.

 ![Click on + icon to add additional components of Peoplesoft](./images/db-system-done.png " ")

 2. We will now discover Application Server tier component. Click on Instance Type dropdown and select Middle Tier.

 ![Click on Instancy Type dropdown and select Middle Tier.](./images/app-tier-discovery.png " ")

 3. Enter the OCID of Application Server VM and click on Discover.

 ![Enter OCID of Application Server VM and click on Discover.](./images/app-tier-discovery2.png " ")

 4. The discovery operation has discovered the deployment type as Application Tier. Please fill the required blank fields with correct values of Integration Broker Gateway Admin ID and Admin Password.

 ![Enter values of Integration Broker Gateway Admin ID and Admin Password.](./images/app-tier-discovery3.png " ")

 Example screenshot is below.

 ![Example screenshot is below.](./images/app-tier-gateway.png " ")

 5. Click on OK.You will come back to Import page.

 ## Task 3: Import PeopleSoft Process Scheduler Server Tier Running on Linux

 1. Click on + icon to import Linux Process Scheduler component of Peoplesoft.

 ![Click on + icon to import Process Scheduler component of Peoplesoft.](./images/add-prcs-node.png " ")

 2. Click on Instance Type dropdown and select Middle Tier.

 ![Click on Instancy Type dropdown and select Middle Tier.](./images/select-prcs.png " ")
 
 3. Enter the OCID of Linux Server hosting PeopleSoft Process Scheduler Domain. Click on Discover.

 ![Enter OCID of Linux Server of PeopleSoft Process Scheduler Domain.](./images/discover-prcs.png " ")

 4. The discovery operation has discovered the deployment type as Process Scheduler Tier. Click on OK.

 ![PeopleSoft Process Scheduler Tier Discovery.](./images/prcs-discovery.png " ")

 5. You will come back to Import page.

 ## Task 4: Import PeopleSoft Web Server Tier

 1. Click on + icon to import Web Server component of Peoplesoft.

 ![Click on + icon to import Web Server component of Peoplesoft.](./images/add-web-node.png " ")

 2. Click on Instance Type dropdown and select Middle Tier.

 ![Click on Instance Type dropdown and select Middle Tier.](./images/web-tier-discovery.png " ")

 3. Enter the OCID of Linux Server hosting Web Server Domain. Click on Discover.

 ![Enter OCID of Linux Server hosting Web Server Domain.](./images/discover-web.png " ")

 4. The discovery operation has discovered the deployment type as Web Server Tier. Click on OK.

 ![PeopleSoft Web Server Tier Discovery.](./images/web-tier-discovery2.png " ")

 5. Enter Weblogic Admin User, Weblogic Admin Password, Webprofile User (PTWEBSERVER) Password. Clcik on OK.

 ![PeopleSoft Web Server Credentials Update.](./images/web-tier-update.png " ")

 6. You will come back to Import page.

 ## Task 5: Import PeopleSoft ELK Tier

 1. Click on + icon to import ELK component of Peoplesoft.

 ![Click on + icon to import ELK component of Peoplesoft.](./images/add-elk-node.png " ")

 2. Click on Instance Type dropdown and select Middle Tier.

 ![Click on Instance Type dropdown and select Middle Tier.](./images/elk-tier-discovery.png " ")

 3. Enter the OCID of ELK server and click on Discover.

 ![Enter OCID of ELK server and click on Discover.](./images/discover-elk.png " ")

 4. The discovery operation has now discovered the deployment type as Elastic Server Tier. Click on OK.

 ![ELK Discovery.](./images/elk-tier-discovery2.png " ")

 5. Enter Elastic Search Administrator Password, Elastic Search Proxy Password. 
 
 6. Edit Discovery Hostname field and remove double quotes and retain only 127.0.0.1 entry as below.Click on OK.

 ![ELK Update.](./images/elk-update.png " ")

 6. You will come back to Import page.

  ## Task 6: Start the PeopleSoft Environment Import Process

 1. Click on Done to start the import of PeopleSoft Environment.

 ![Click on Done to start the import of PeopleSoft Environment.](./images/start-import.png " ")

 2. The import process is started and its in running status.

 ![The import process is started and its in running status.](./images/import-start.png " ")

 3. Click on dropdown action button and click on Details to monitor the progress of the import operation.

 ![import-details](./images/import-status2.png " ")

 4. Click on Import to view the status of the PeopleSoft environment import process.

 ![import-status](./images/import-status.png " ")

 5. Import of PeopleSoft environment completed with no errors.

 ![import-complete](./images/import-completed.png " ")

 6. You can now see the status of the imported environment as Running.

 ![running-status](./images/env-running.png " ")


 ## Summary

 In this lab, PeopleSoft Environments components such as DB System, Application Server, Linux Process Scheduler Server, Web Server, Windows Process Scheduler Server, ELK are imported into PeopleSoft Cloud Manager.

 ## Acknowledgements
 * **Author** - Vinay Shivanna, Principal Cloud Architect
 * **Contributor** - Vinay Shivanna, Principal Cloud Architect
 * **Last Updated By/Date** - Vinay Shivanna, Principal Cloud Architect, March 2023


