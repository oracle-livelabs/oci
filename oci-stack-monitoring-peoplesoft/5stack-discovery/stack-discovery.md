# Resource discovery using Stack Monitoring

## Introduction

In this lab, we will discover all the PeopleSoft resources configured earlier as part of the previous labs.

Estimated Time: 45 minutes


### Objectives

* Configuration options for distributed PSFT systems
* License Options within Stack Monitoring
* Resource discovery of PSFT components



### Prerequisites

*  Access to OCI Stack Monitoring page for the user.


## Task 1: Configuration options for distributed PSFT systems

 This workshop is based on discovering a PeopleSoft application with database, hosted on a single compute VM on OCI. So the application RMI ports, process scheduler RMI ports, webserver ports, database ports have not be opened through a firewall. The agent is also installed on the same compute VM.

 One of the many scenarios has been listed here, customers need to be aware of what ports need to be opened, when the application tiers (Application server, webserver, process scheduler server, database and elastic servers) are installed and configured in a distributed system.



 **Scenario 1**

 Monitoring agent is located on one of the PeopleSoft hosts itself and application tier spread across different VMs.
   
   ![Agent on PSFT and distributed system](./images/agent-psft1.png " ") 


 **Scenario 2**

 Monitoring agent is located on different host and application tier spread across different VMs

   ![Agent on PSFT and distributed system](./images/agent-psft2.png " ") 



## Task 2: License Options within Stack Monitoring

 OCI Stack Monitoring includes 2 types of licensing - Standard & Enterprise Licensing.
  By Default, when we discover the application, enterprise license option is selected. Enterprise option comes with a lot of added features but if customer wants to disable it, they can follow the below configuration.

 **Configure Licensing for Resource-Specific Features:**

 Resource license assignment can done at the individual resource level during discovery or after discovery within the Licensing UI.

 Note: License changes applied to a composite will apply to all children (e.g. When applying Enterprise Edition License to a WebLogic Domain, all WebLogic Servers associated to the domain will also receive the Enterprise Edition)

 **Configure Licensing for Resource-Specific Features during Discovery**

 During discovery, you may assign a license to the resource by selecting the corresponding radio button.

   ![Configure license option](./images/stack-license.png " ") 


 **Configure Licensing for Resource-Specific Features after Discovery:**

 A resource license can also be modified after a resource has been discovered using the License UI. For example, to upgrade a Standard Edition resource to Enterprise Edition, navigate to the License UI and click the edit button within the Standard Edition box. The page will filter to only show resources with a Standard Edition license. Click the action button of the resource to upgrade and select Enterprise from the drop down. Continue this process for the remaining resources to upgrade from Standard to Enterprise Edition, finally select apply changes. When applying license changes, remain on the page until all updates have been applied.


   ![Configure license option](./images/stack-license1.png " ") 


## Task 3: Resource discovery of PSFT components

1. On the Oracle Cloud Infrastructure Console Home page, click the Navigation Menu in the upper-left corner, select Observability & Management, and then click on Stack Monitoring.

   ![From OCI home page, under O&M, click on Stack Monitoring](./images/oci-stack-monitor.png " ")

 On the OCI Stack Monitoring page, click on Resource discovery.

   ![From OCI home page, under Stack Monitoring, click resource discovery](./images/oci-stack-resource.png " ")

 On the resource discovery page, click on discover new resource.

   ![From OCI home page, under Stack Monitoring, click resource discovery](./images/oci-stack-resource-new.png " ")

 As part of the discovery, we will first discover the Oracle database and then followed by the PeopleSoft application. Within Oracle database, we will first discover CDB database (if there is a multi-tenant architecture) and then followed by the PDB database.

2. Select Oracle Database from the resource type and provide the required information for discovery of the CDB database.


   ![Fill the CDB database information](./images/cdb-discovery.png " ")

   We need to select the management agent from the dropdown list.

   ![Fill the CDB database information](./images/cdb-discovery1.png " ")

   Enter the database credentials for monitoring

   ![Fill the CDB database information](./images/cdb-discovery2.png " ")

   For this workshop, we are not using ASM and disable the option. For discovery, we are selecting Stack Monitoring only, License option as Standard and click on discover new resource.

   ![Fill the CDB database information](./images/cdb-discovery3.png " ")


    The CDB resource discovery is started.

   ![CDB discovery in progress](./images/cdb-discovery4.png " ")

    The CDB resource discovery is completed.

   ![CDB discovery in completed](./images/cdb-discovery5.png " ")


3. Select Oracle PDB Database from the resource type and provide the required information for discovery of the PDB database.

   Give a name for the PDB and the CDB information is retrieved from the earlier discovery
   
   ![Fill the PDB database information](./images/pdb-discovery.png " ")

   We need to select the management agent from the dropdown list.

   ![Fill the PDB database information](./images/pdb-discovery1.png " ")

   Enter the database credentials for monitoring

   ![Fill the PDB database information](./images/pdb-discovery2.png " ")

   For discovery, we are selecting Stack Monitoring only, License option as Standard and click on discover new resource.

    The PDB resource discovery is started.

   ![PDB discovery in progress](./images/pdb-discovery3.png " ")

    The PDB resource discovery is completed.

   ![PDB discovery in completed](./images/pdb-discovery4.png " ")


4. Select PSFT Application from the resource type and provide the required information for discovery of the PeopleSoft application.

   We need to select the management agent from the dropdown list. Discover Process Monitor and select Yes as part of the discovery

   ![Fill the PSFT Application information](./images/app-discovery.png " ")

   Enter the Database host, service name, port and protocol
   
   ![Fill the PSFT Application information](./images/app-discovery1.png " ")

   Enter the database credentials for monitoring

   ![Fill the PSFT Application information](./images/app-discovery2.png " ")


   Provide the Application server, Process scheduler and webserver user credentials configured as part of previous lab (Lab 2)

   ![Fill the PSFT Application information](./images/app-discovery3.png " ")
   
   For discovery, we are selecting Stack Monitoring only, License option as Standard and click on discover new resource.

   ![Fill the PSFT Application information](./images/app-discovery4.png " ")

    The PSFT Application resource discovery is started.

   ![PSFT Application discovery in progress](./images/app-discovery5.png " ")

    The PSFT Application resource discovery is completed.

   ![PSFT Application discovery in completed](./images/app-discovery6.png " ")


## Summary

In this lab, we discovered the PeopleSoft application components using stack monitoring.

You may now **proceed to the next lab.**


## Acknowledgements

* **Authors** - Deepak Kumar M, Principal Cloud Architect
* **Contributors** -

    * Aaron Rimel, Principal Product Manager
    * Devashish Bhargava, Principal Cloud Architect
* **Last Updated By/Date** - Deepak Kumar M, Principal Cloud Architect, February 2024

