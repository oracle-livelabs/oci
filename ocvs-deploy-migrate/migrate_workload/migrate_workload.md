# Migrating the Virtual Machine with HCX 

## Introduction

Today, large-scale enterprises run their virtualized workloads in VMware Hypervisor in on- premises data centers. Customers are currently looking for enterprise cloud migration, Datacenter exit, or Hybrid Cloud Strategy aligning with their business objectives. Oracle Cloud VMware Solution enables organizations that have a significant investment in VMware infrastructure to take advantage of the benefits of public cloud. Oracle Cloud VMware Solution gives you a fully automated implementation of a VMware Software-Defined Datacenter (SDDC) within your own Oracle Cloud Infrastructure (OCI) tenancy, running on Oracle Cloud Infrastructure bare metal instances.

The Oracle Cloud VMware Solution offers VMware HCX advanced as part of the SDDC implementation along with vSphere, vSAN, and NSX-T. The Oracle Cloud VMware Solution also offers a VMware HCX Enterprise license for additional use cases. VMware HCX is a software suite focused on application mobility and designed for simplifying application migration, rebalancing workloads, and optimizing disaster recovery across data centers and clouds.

**Estimated Lab Time:** 15 minutes

### **Objectives**

In this lab, you will:

* Migrate VMware workloads on-premises to OCVS.

### **Prerequisites**

* Complete Lab 3: **Insert Lab 3 Name**

* This lab environment does not include an actual on-premises environment. You Must provide your own.

* It is assumed that the user possesses basic knowledge of HCX.

* It is assumed that you have either [VPN Site to Site](https://docs.public.oneportal.content.oci.oraclecloud.com/en-us/iaas/Content/Network/Tasks/workingwithIPsec.htm) or [Fastconnect](https://docs.oracle.com/en-us/iaas/Content/Network/Concepts/fastconnect.htm) already set up in your environment.


### Helpful information before you Begin: 

#### Lab Environment

* The Lab consists of simulated On-Premises environment in San Jose Region and the OCVS environment in Ashburn Region. Dynamic Routing Gateways are used to connect both OCI Regions using remote peering.

* The Lab covers a vMotion Migration strategy with HCX Manager pre-deployed along with Compute Profiles, Network Profiles created during the OCVS instantiation process.


####  Important Port Groups

Below are the VLANs/Port Groups used in the simulated On-Premises environment (San Jose):
* Port Group: vSphere
    * Description: This is the vSphere Management Port Group. vCenter, NSX-T manager, HCX Components will be in this Port Group.

    * Purpose: Management of vSphere, NSX-T and HCX Components. In Addition to this, HCX Components will use this Port Group to communicate with HCX Components in OCVS.

* Port Group: vMotion
    * Description: This is the vMotion Port-Group. In Addition to ESXi, HCX IX will also have one interface associated to this Port Group.

    * Purpose: This is used for vMotion Traffic.

* Port Group: Replication
    * Description: This is the Replication Port Group. In Addition to ESXi, HCX IX will also have one interface associated to this Port- Group. In Addition to ESXi, HCX IX will also have one interface associated to this Port Group.

    * Purpose: This is used for Replication Traffic. HCX IX uses this for bulk migration.

* Port Group: Management
    * Description: This is the ESXI Management Port Group.

    * Purpose: This is used for Managing ESXi Hosts.

* Port Group: HCX
    * Description: This is the HCX Uplink Port Group.

    * Purpose: HCX-IX and HCX NE will use this Port Group to communicate with on- premises HCX-IX and HCX NE respectively. In the On-premises environment, vds- sphere01 is used.

Below are the VLANs/Port Groups that are used in OCVS environment in Ashburn:

* Port Group: vSphere01
    * Description: This is the vSphere Management Port Group. vCenter, NSX-T manager, HCX Components will be in this Port Group.

    * Purpose: Management of vSphere, NSX-T and HCX Components. HCX Manager in OCVS will use this Port Group to communicate with HCX Connector hosted in on- premises environment.

* Port Group: vMotion
    * Description: This is the vMotion Port- Group. In Addition to ESXi, HCX IX will also have one interface associated to this Port Group.

    * Purpose: This is used for vMotion Traffic.

* Port Group: Replication
    * Description: This is the Replication Port- Group. In Addition to ESXi, HCX IX will also have one interface associated to this Port Group.

    * Purpose: This is used for Replication Traffic. HCX IX also uses this for bulk migration.

* Port Group: Management
    * Description: This is the ESXi Management Port Group.

    * Purpose: This is used for Managing ESXi Hosts.

* Port Group: HCX
    * Description: This is the HCX Uplink Port  Group.

    * Purpose: HCX-IX and HCX NE will use this Port Group to communicate with on- premises HCX-IX and HCX NE respectively. In the On- premises environment, vds- sphere01 is used.

#### Migrate of VM workloads from on- premises environment to OCVS using vMotion

* VMware HCX Interconnect integrates with ESXi to perform vMotion migrations for powered on virtual machines and with Cold Migration for powered off virtual machines.

* VMware HCX vMotion can transfer a live Virtual Machine from a VMware HCX-activated vCenter Server to a VMware HCX-activated destination site (or from the VMware HCX destination site towards the local site). 

* The vMotion transfer captures the virtual machine active memory, execution state, IP and MAC address. Migration duration depends on the connectivity, including both the bandwidth available and the latency between the two sites.

## Task 1: Login to simulated On-Premises Data Center

![]( "Photo of OCI Console showing where to select the Hybrid VNWare Solution Link")

1. After you have logged in and gone to the OCI home screen, select the **US West (San Jose)** region. Then click on the region menu in the upper right corner.

2.	In the upper left corner, click the hamburger menu icon.

3.	Navigate to **Hybrid**.

4.	Select Software-Defined Data Centers "SDDC" under the VMware Solution section.

    ![]( "Photo shows where you can find the SDDC you need to select")

5.	Click on your SDDC, e.g. ***SDDC-Lab001***.

    ![]("Photo showing where to find relevant SDDC info for next steps")

6.	Copy the **vSphere client URL**. Paste the **vSphere Client URL** into Notepad.

7.	Copy the **vCenter initial password**. Paste the vCenter initial password into your Notepad (Note: HCX will use the same password).

8.	Copy the **HCX Manager IP address**. Paste the **HCX Manager IP address** into a Notepad.


    ![](./images/newbrowsertab5.png "Photo demostrating a new tab in Firefox")

9.	In your browser, open a new tab.

10.	Paste your San Jose vCenter URL copied from the previous step, into the address bar.

    ![](./images/vspheresite6.png "Photo showing the initial screen when you open the vCenter link")

11.	Click the Launch vSphere Client (HTML5) button.

    ![](./images/vspherelogin7.png "Photo of an OCI architecture diagram featuring VMWare")

12. Enter the credentials:

* User name: ``administrator@vsphere.local``

* Password: (copy from Notepad)

* Select **Login**.

![](./images/vclientvmipaddress8.png "Photo Shoing the vClient web console and where to find the VM IP Addresses")

13. Open Web Console for the test VM.

14.	Expand the Datacenter oci-w01dc, then expand the cluster cluster01, and select the Virtual Machine LabVM-01.

15.	Take a note of the VM IP Address (feel free to add it to your Text Editor window for reference).

16. Click on **LAUNCH WEB CONSOLE**

![](./images/webconsoleterminal9.png "Photo showing the web console terminal and login steps")

17. Login to the test virtual machine using below credentials

    1. 	User name: ``root``

    2. 	Password: ``VMware1!``

18.  Enter command ``ping 192.168.2.1``

![](./images/vsphereclienthamburgerscreen10.png "Photo showing where to click in the vSphere Client")

9. On the HCX UI, in the left pane, under **Services**, Click **Migration**.

![](./images/migrationonvsphere11.png "Photo showing where to select Migration")

10. Click on **Migrate**.

![](./images/migratebutton12.png "Photo showing where to select the Migrate button")

11.	From the left hand inventory, locate the VM parent and select the virtual machine for migration from the right hand list and click **ADD.**

![](./images/selectvmlab13.png "Photo showing where to select the VM Lab")

12. Click on **(Mandatory: Compute Container)**, navigate to the destination host cluster and click **SELECT.**

![](./images/destinationcomputecontainer14.png "Photo shoing where to find the Mandatory: Compute Container")

13.  Click on **(Mandatory: Storage) Option**, navigate to the target datastore/datastore cluster for the VM and click **SELECT**.

![](./images/mandatorystorageoption15.png "Photo showing where to select the Mandatory Storage Option")


![](./images/destinationstorage16.png "Photo showing the datastore/clusters")


14. Select **vMotion** as the Migration Profile.

![](./images/migrationprofile17.png "Photo showing the migration profile location")

15.	Click on **Edit Extended Options**, Select **Migrate Custom Attributes**.

![](./images/extendedoptions18.png "Photo showing all of the extended options")

16. Select **Apply Options** and click **SAVE**.

![](./images/migratecustomattributes19.png "Photo showing the migrate custom attributes screen")

17. Click **OK** on the confirmation screen.

![](./images/extendedoptionsconfirm20.png "Photo showing the extended options confirmation screen")

18. Validate the configuration by selecting **VALIDATE** on the bottom right of the screen.

![](./images/validatebutton21.png.png "Photo showing the main HCX screen with the validate button on the bottom right")

19.	Once the Validation is successful. Click on the green **GO** button to start the migration.

![](./images/migrationcomplete22.png "Photo showing the migration comlete screen")

The migration will take around 7-10 minutes. Once completed it will show Migration Complete in the Status column.

**Congratulations!**

To gain an understanding of the steps taken during the migration you can:

1.	Expand the migration details by selecting the arrow next to the VM name.

2.	Click show previous 20 events to expand the steps even further.

## Task 2: Verify successful migration

Now that the migration has been reported as successful, you can verify that the machine has been relocated to the other cloud.

In the web browser, open a new tab.
1. Paste the **vSphere Client URL** that you had captured in the [SDDC Overview Task](#access-vmware-components) in the **WebURL** field and press **Enter**.
2. If you receive a warning that the connection is not private, ignore the warning and proceed.
3. Click the **Launch vSphere Client** (HTML5) button.

![vcenterurl](./images/vcenterurl.png)

4. On the authentication page, enter the following details for the **username** and **password**.
      - **Username** :
		```
		<copy>
    	administrator@vsphere.local
    	</copy>
		```
	  - **Password**: vCenter initial password captured in [SDDC Overview Task](#access-vmware-components)
5. Click **Login**

![vcenterlogin](./images/vcenterlogin.png)

6. Expand the vCenter Inventory and locate the migrated virtual machine.

![](./images/vsphereclientmainscreen24.png "Photo showing the vSphere Client main screen")

# Congratulations! 
# You may procede to the next lab!

## Learn More

## Acknowledgments

* **Author:** Vijay Kumar
, Cloud Engineering OCVS
* **Contributors:** 
    - Chris Wegenek, Cloud Engineering
    - Karthik Meenakshi Sundaram, Cloud Engineering
    - Germain Vargas, Cloud Engineering
    - Kelly Montgomery, Cloud Engineering

* **Last Updated By/Date:** Chris Wegenek, Cloud Engineering, February 2025