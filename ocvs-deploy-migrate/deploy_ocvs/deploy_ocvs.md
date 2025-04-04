# Lab 2: Deploy Oracle Cloud VMware Solution (OCVS)

## Introduction

In this lab you will deploy a single node OCVS SDDC Cluster.

**Estimated Time:** 15 Minutes

Note: Triggering the OCVS Deployment takes around 15 Minutes, However the actual infrastructure deployment takes around 3 Hours to complete.

### Prerequisites

It is assumed that you have access to or familiarity with following components:

- An Oracle account
- A compartment to deploy the solution in.
- Necessary user permissions to deploy and manage OCVS.
- Oracle VCN with an available subnet of size **/24**.
- Familiarity with Oracle Cloud Infrastructure (OCI) and VMware SDDC stack.
- Familiarity with basic networking terminology such as Subnet, VLAN, CIDR etc.

### Objectives

In this lab, you will;

- Identify networking requirements for OCVS deployment
- Generate an SSH Key pair for ESXi access
- Deploy an OCVS SDDC with single node cluster
- Review the SDDC details in OCI Console

## Task 1: Identify OCVS Subnet

OCVS cluster is deployed in a VCN in your tenancy. This allows you complete control over IP addresses, subnets, routing and security lists. Building the cluster in you VCN also puts the workloads closest to other OCI Native Services such as Object Storage, Block Volumes, Autonomous Database etc. This leads to increased performance and better throughput when access native OCI Services from workloads running in OCVS.

1. To start the deployment, you need an existing VCN with an IP address CIDR of /24 or larger available for running the cluster . The CIDR size depends on the number of nodes that you plan to add in the cluster. Following is an overview of CIDR sizes and number of nodes the CIDR can support.

	- CIDR block size **/24**, segment size **/28**, number of nodes in cluster **3-12**.
	- CIDR block size **/23**, segment size **/27**, number of nodes in cluster **3-28**.
	- CIDR block size **/22**, segment size **/26**, number of nodes in cluster **3-60**.
	- CIDR block size **/21**, segment size **/25**, number of nodes in cluster **3-64**.

2. For the lab deployment we will use the following subnet:

```
<copy>
172.16.2.0/24
</copy>
```

**Note** If you have created the VCN in Lab 1 with a different CIDR range or want to use an existing VCN, you can update the OCVS subnet accordingly.

## Task 2: Deploy Single Node OCVS Cluster

1. Open the **navigation** menu hamburger icon, select **Hybrid**, and then select **Software-Defined Data Centers** under **VMware Solution**.

![Hamburger Menu](./images/hambuger.png)


![SDDC](./images/hybridsddc.png)

2. Click **Create SDDC**.

![Create SDDC](./images/createsddc.png)

3. Provide basic information for the SDDC:
	- **SDDC name**
		```
		<copy>
		livelab-sddc
		</copy>
		```
	- **SDDC compartment**
  		Select the compartment where SDDC will be deployed.
	- **VMware software version**
  		8.0U3
	- **HCX**
  		Enabled
	- **HCX License Type**
  		Advanced
	- **Advanced Option**
  		Default
4. **SSH key**
   Provide the public key that we had created in [Lab-1 Task-3: Generate SSH Key](?lab=configure_networking#Task3:GenerateSSHKey).
5. Click **Next** to advance to the **Define Clusters** page.

![sddcbasic](./images/sddcbasicinfo.png)

6. Click **Define management cluster**

![Definemgmtcluster](./images/definemgmtcluster.png)

7. Provide following information for the cluster:
	- **Cluster name**
		```
		<copy>
		livelab-cluster
		</copy>
		```
	- **Availability domain**: Select the Availability domain in which to create the SDDC.
	- **Host type**: Single Host SDDC
	- **Prefix for ESXi hosts**
		```
		<copy>
		livelab
		</copy>
		```
	- **Capacity type**: On-demand capacity

![Definecluster](./images/definecluster.png)

8. Click on Change shape and Select **AMD** **BM.DenseIO.E4.128** and click **Select shape**.

![changeshape](./images/changeshape.png)

![selectamdshape](./images/selectamdshape.png)

9. Select 32 OCPU from the **Select number of OCPU cores** dropdown.

![selectocpu](./images/selectocpu.png)

10.  In the **Pricing interval commitment**, make sure to select **Hourly commitment** and confirm pricing with the checkbox.

**NOTE:** Cluster pricing cannot be changed after the deployment and you will be charged for the whole commitment period. Make sure to choose correct pricing interval on the step.

![pricinginterval](./images/pricinginterval.png)

11. Click **Next** to advance to the cluster's **Networking** page.
12. Select the **VCN** you had created in Lab 1 for OCVS.
	- Click **Create new subnet and VLANs**.
	- Enter the subnet details as follows.
		```
		<copy>
		172.16.2.0/24
		</copy>
		```
		**Note**: If you had selected a different subnet in Task 1, enter that subnet detail.
13. Enter the **cluster workload CIDR** to create an initial logical segment for the VMs.
		```
		<copy>
		192.168.1.0/24
		</copy>
		```

![clusternetworking](./images/clusternetworking.png)

14. Click **Next** to advance to the **Notifications** page.
15. Click **Next** to review the **cluster configuration summary** and Click **Submit**.

![clusterreview](./images/clusterreview.png)

16. Click **Next** to move to **Review and Create page** and click **Create SDDC**.

![sddcreview](./images/sddcreview.png)

The page shows the provisioning status of each resource.

**NOTE**: The deployment takes about 2.5 Hours to complete, you can monitor the status of the tasks in the work requests section.

## Task 3: Review OCVS SDDC

After OCVS deployment is complete, the SDDC overview page will show details related to the VMware components, Clusters, Hosts and Networking.

### **SDDC Overview**

If you are not already on the OCVS SDDC Details page;

1. Open the **navigation** menu hamburger icon, select **Hybrid**, and then select **Software-Defined Data Centers** under **VMware Solution**.

![Hamburger Menu](./images/hambuger.png)


![SDDC](./images/hybridsddc.png)

2. Select the **livelab-sddc** that we had created in last task. Make sure that the state of the SDDC is **Active**.

![SDDC](./images/livelabsddc.png)

3. On the SDDC overview page, you can see following details about the SDDC;
      - **vCenter information** - The vCenter information sections list the vCenter URL, IP Address, initial username and initial password.
      - **NSX manager information** - the NSX information sections list the NSX manager URL, IP Address, initial username and initial password.
      - **HCX Manager information** - this section lists the details about the HCX Manager including the URL, IP Address, initial username, password, license type and on-prem connector activation keys.
      - **vSphere Clusters** - This section lists all the clusters withing the SDDC, including the management and workload clusters. You can manage existing clusters by selecting the cluster name from this section or use the **Add a workload cluster** button to define and create a new workload cluster.

![SDDC](./images/ocvsoverview.png)

4. Click on the single management cluster **livelab-cluster** to view the cluster overview page.

![SDDC](./images/clusterlist.png)

5. The cluster overview page list the details of the individual cluster in following sections;
      - **Cluster Information** - This section has the basic details of the cluster deployment including the **OCID**, **VMware software version**, **Availability domain** where the cluster is deployed, **Workload CIDR** and **timestamps**.
      - **ESXi Hosts** - This section provides details of the individual hosts which are part of this cluster and include the **host Name**, **State**, **Availability Domain**, **Current** and **Next Pricing Interval**.

![SDDC](./images/clusteroverview.png)

6. **Click** on the **Cluster Networks** option in the **Resources** section in the left hand pane.
      - In the **Cluster networks** section you can;
        - View the details of SDDC **VLANs** including but not limited to **vSphere**, **vMotion**, **Management** and **vSAN** VLAN.
        - View the details of the **provisioning subnet** under the subnet section.

![SDDC](./images/vlanlist.png)

7. **Click** on the **ESXi Hosts** option in the **Resources** section in the left hand and **Click** on the **ESXi host name** to view the details about the ESXi host.

![SDDC](./images/hostslist.png)

8. On the **ESXi Host information** page, you can get detailed information about the ESXi Host instance, following information for the host is made available on the page;
      - Host OCID
      - Compartment
      - Availability Domain
      - Timestamps
      - Shape
      - OCPU Count
      - Capacity Reservation (if any)
      - Billing information

![SDDC](./images/hostdetails.png)

### **Retrieve Credentials for VMware Software**

If you are not already on the OCVS SDDC Details page;

1. Open the **navigation** menu hamburger icon, select **Hybrid**, and then select **Software-Defined Data Centers** under **VMware Solution**.

![Hamburger Menu](./images/hambuger.png)


![SDDC](./images/hybridsddc.png)

2. Select the **livelab-sddc** that we had created in last task. Make sure that the state of the SDDC is **Active**.

![SDDC](./images/livelabsddc.png)

3. On the SDDC overview page, copy the following details and save these in a notepad. We will need these in the next section to access the SDDC components.
      - Copy the **vSphere client URL** by clicking on the associated **Copy** Link and paste it in a notepad file for easy retrieval.
      - Copy the **vCenter initial username** paste it in a notepad file for easy retrieval.
      - You can also retrieve the **vCenter initial password** by clicking the associated Show or Copy option.

![SDDC](./images/vcentercreds.png)

4. **Repeat step 5** to get **access URL** and **credentials** for **NSX-T Manager** and **HCX Manager**.

![SDDC](./images/nsxcreds.png)

5. Copy the **HCX on-premises connector activation keys** by clicking on the **View** button in the **HCX manager information** section.

![SDDC](./images/hcxcreds.png)

## Task 4: Access SDDC Components

To build a secure and controlled environment and isolate the critical components from other workloads, we had deployed OCVS SDDC in a private subnet with limited access to the outside networks. We had also created a public subnet to allow access into the OCI environment from the public internet. Only SSH access is allowed in the public subnet to ensure complete control over network ingress.

To access the SDDC component, we will use the Linux Bastion host deployed in the public subnet and use port forwarding from the Bastion host to a Windows jump host in the private subnet. In the following sections we will create the SSH tunnel and RDP to the jump host.

### **Setup SSH Tunnel from Bastion to Jump Host**

1. In the upper left corner, click the **hamburger menu icon**

![hamburger](./images/hambuger.png)

2. Navigate to **Compute** ad click on **Instances**

![instancemenu](./images/instancemenu.png)

3. Verify that you are in the right compartment.
4. Locate the instance named - **bastion-host**
5. Copy the **Public IP** address of the bastion instance.
6. Locate the instance named - **jump-host**
7. Copy the **Private IP** address of the jump host.

![ipdetails](./images/ipdetails.png)

8. Click on the **jump-host** instance name.
9. On the **Instance details** page, under **Instance access** section, click **Copy** to copy the Windows instance initial password, keep this password sage this will be needed in next section to setup the RDP connection.

![instancecreds](./images/instancecreds.png)

**Mac Instructions**

1. Click on the **Launchpad** icon in the **dock**.

![SDDC](./images/mac-launcher.png)

2. Search for **Terminal** app and open a new terminal window.

![SDDC](./images/mac-terminal.png)

3. **Change directory** to the location where you have saved the private SSH key from [Lab-1 Task-3: Generate SSH Key](?lab=configure_networking#Task3:GenerateSSHKey).

	```
    <copy>
    cd <livelab_key_location>
    </copy>
    ```
**Note:** Change the directory path to your actual directory location.
4. Change the **file permission**

	```
    <copy>
    chmod 600 <bastion_private_key>
    </copy>
    ```
**Note:** Change the <bastion_private_key> to the actual private key file name that you had used when deploying the Bastion Host.

![SDDC](./images/changepermission.png)

5. Create the ssh tunnel by running the following command in the terminal.
   **Note:** Make sure to replace the <public_ip> address with the actual **public IP** of the bastion host and <private_ip> with the **private IP** of the Windows Jump server.

	```
    <copy>
    ssh -i <bastion_private_key> opc@<public_ip> -L 5000:<private_ip>:3389
    </copy>
    ```

![SDDC](./images/tunnel.png)

**Windows Instructions**

Windows operating system by default does not have an SSH client built in, so we will need to Download and install an SSH client such as Putty. If you already do not have the SSH Client installed, Follow the instruction at [www.putty.org](https://www.putty.org/) to download and install the client on your workstation.

Following instructions are only applicable if you are using PuTTY as the client. If you use a different SSH client, the instruction to setup SSH connection and remote port forwarding might be different. Refer to the documentation of your SSH Client to setup the connection and port forwarding.

**NOTE:** Putty only accepts private keys in ppk format. If your key is not ppk format, use the steps in following link to convert the key to ppk format before proceeding.

1. (Optional)[Private Key to PPK conversion](https://docs.oracle.com/en/cloud/paas/java-cloud/jscag/convert-private-key-putty.html)
2. **Click** on the **Windows** Icon on the workstation and search for **PuTTY**.
3. Open a new SSH connection window by clicking on the **PuTTY** icon.
4. In **Host Name** box, enter the **public IP** address of the Bastion Host in the following format
   
	```
	<copy>
	opc@<public_ip>
	</copy>
	```

![sship](./images/sship.png)

5. Confirm that the **Connection type** option is set to **SSH**.
6. In the Category tree, expand SSH and then click **Auth**
7. Click the **Browse** button next to the **Private key file for authentication** box and select the <bastion_private_key.ppk> file.

![sshauth](./images/sshkey.png)

8. In the Category tree, click **Tunnels**.
      - In the **Source Port** box, enter **5000**.
      - In the **Destination box**, enter the following IP and port combination.
			```
			<copy>
			<jump_host_private_ip>:3389
			</copy>
			```
      - Confirm that the **Local** and **Auto** options are set.
      - Click **Add** to forward the port.

![sshtunnel](./images/sshtunnel.png)

9. In the **Category** tree, click **Session**.
10.  In the **Saved Sessions** box, enter a name for this connection configuration. Then, click **Save**.
11. Click **Open** to open the connection.

![sshsession](./images/sshsession.png)

**NOTE** If this is the first time you are connecting to the Bastion, the PuTTY Security Alert window is displayed, prompting you to confirm the public key.

12. Click **Accept** to continue connecting.

![sshkeyaccept](./images/sshkeyaccept.png)

![sshconnection](./images/sshconnection.png)

### **Access Jump Host via RDP**

Once you have the SSH tunnel setup, we can RDP to the jump host from the local workstation. Follow the instruction below to connect to the Windows Server jump host based on your workstations' operating system.

**Mac Instructions**

1. If you do not have the **Windows App** already installed on the Workstation, then Go to the App Store and Install "**Windows App**" from Microsoft.

![SDDC](./images/windowsapp.png)

2. Click on the **Launchpad** icon in the **dock**.

![SDDC](./images/mac-launcher.png)

3. Search for **Windows App** and open the app by clicking on the app icon.
4. Click the **+** symbol and select the **add PC** option.

![SDDC](./images/addpc.png)

5. In **PC Name** field, enter the following **IP Address** and **Port**.

	```
	<copy>
    127.0.0.1:5000
    </copy>
	```

6. Click **Add** and launch the RDP connection by double-clicking on the RDP icon.

![SDDC](./images/addpcconfig.png)

![SDDC](./images/rdpicon.png)

7. Click **Add**
8.  Launch the RDP Connection by **double clicking** on the RDP Instance icon.
9.  When asked for the **credentials** enter following details;
   - **Username**: opc
   - **Password**: Enter the password for opc user that you had collected in the last task for the jump server.

![SDDC](./images/rdplogin.png)

**Windows Instructions**

1. Click on the **Windows** Icon on the workstation and search for **Remote Desktop Connection**.
2. Open the **Remote Desktop Connection** windows by clicking on the application icon.
3. In the **Computer** field, enter the following **IP Address** and **Port**

	```
	<copy>
    127.0.0.1:5000
    </copy>
	```

![SDDC](./images/winrdpwindows.png)

4. Click on **Show Options** to view the authentication details.
5. In the **User Name** field, enter the following username.

	```
	<copy>
    opc
    </copy>
	```

6. Click **Connect**

![SDDC](./images/winrdpdetails.png)

7. When asked for the opc password, enter the password for opc user that you had collected in last task for jump server.

![SDDC](./images/winrdplogin.png)

8. Press **Enter**

### **Access VMware Components**

Once you have the RDP connection to the Jump Host, the first thing we need to do is to install a Web Browser as the instance would only have Internet Explorer available by default and IE does not perform well for SDDC component web applications.

You can install any one of the following web browsers depending on your preference.

- Google Chrome
- Microsoft Edge
- Mozilla Firefox
- Apple Safari

After you install the browser, open a new browser window and follow the below steps to access the OCVS SDDC components.

**NOTE:** You will need the URLs and credentials for the SDDC components which we had captured in the [Review OCVS SDDC](?lab=deploy_ocvs#Task3:ReviewOCVSSDDC). If you have not captured the details. Please return to the [Review OCVS SDDC](?lab=deploy_ocvs#Task3:ReviewOCVSSDDC) and capture the mentioned details.

#### Access vCenter

1. In the web browser, open a new tab.
2. Paste the **vSphere Client URL** that you had captured in the [Review OCVS SDDC](?lab=deploy_ocvs#Task3:ReviewOCVSSDDC) in the **WebURL** field and press **Enter**.
3. If you receive a warning that the connection is not private, ignore the warning and proceed.
4. Click the **Launch vSphere Client** (HTML5) button.

![vcenterurl](./images/vcenterurl.png)

5. On the authentication page, enter the following details for the **username** and **password**.
      - **Username** :
		```
		<copy>
    	administrator@vsphere.local
    	</copy>
		```
	  - **Password**: vCenter initial password captured in [Review OCVS SDDC](?lab=deploy_ocvs#Task3:ReviewOCVSSDDC).
6. Click **Login**

![vcenterlogin](./images/vcenterlogin.png)

7. On the vCenter Home page, select **Hosts and Clusters**.
8. Expand the vCenter inventory in the left-hand pane.
9.  Review the details of the **cluster**, **host** and **management virtual machines**.

![vcenterinventory](./images/vcenterinventory.png)

#### Access NSX-T

1. In the web browser, open a new tab.
2. Paste the **NSX Manager URL** that you had captured in the [Review OCVS SDDC](?lab=deploy_ocvs#Task3:ReviewOCVSSDDC) in the **WebURL** field and press **Enter**.
3. If you receive a warning that the connection is not private, ignore the warning and proceed.
4. On the **authentication page**, enter the following details for the **username** and **password**.
      - **Username** :
		```
		<copy>
    	admin
    	</copy>
		```
	  - **Password**: NSX Manager initial password captured in [Review OCVS SDDC](?lab=deploy_ocvs#Task3:ReviewOCVSSDDC)
5. Click **Login**

![nsxlogin](./images/nsxlogin.png)

6. If you are logging in for the first time, you will get the EULA page, scroll to the bottom of the page and accept the License Terms.

![nsxeula](./images/nsxeula.png)

7. Next, Accept the CEIP offer.

![nsxceip](./images/nsxceip.png)

8. On the NSX-T Manager page, you can review the details of the **NSX Manager, Edges, Edge Cluster** and the **default segment**.

![nsxinventory](./images/nsxinventory.png)

#### Access HCX

1. In the web browser, open a new tab.
2. Paste the **HCX Manager URL** that you had captured in the [Review OCVS SDDC](?lab=deploy_ocvs#Task3:ReviewOCVSSDDC) in the **WebURL field** and press **Enter**.
3. If you receive a warning that the connection is not private, ignore the warning and proceed.
4. On the **authentication** page, enter the following details for the **username** and **password**.
      - **Username** :
		```
		<copy>
    	administrator@vsphere.local
    	</copy>
		```
	  - **Password**: HCX Manager initial password captured in [Review OCVS SDDC](?lab=deploy_ocvs#Task3:ReviewOCVSSDDC)

5. Click **Login**

![hcxlogin](./images/hcxlogin.png)

6. On the HCX Manager page, you can review the details of the **Site pairings, vCenter integrations, compute profiles, service meshes** etc.
7. At this stage, you will not see anything in the HCX Manager except the **vCenter integration** as we have not deployed the on-prem connector. We will deploy and configure the on-prem connector in the next lab.

![hcxinventory](./images/hcxinventory.png)

**Congratulations! You may proceed to the next lab**

## Learn More

- [Oracle Cloud VMware Solution (OCVS) Overview](https://www.oracle.com/in/cloud/compute/vmware/)
- [OCVS Networking - Getting Started](https://docs.oracle.com/en-us/iaas/Content/VMware/Tasks/ocvsmanagingl2net.htm)
- [OCVS Networking Reference Architecture](https://blogs.vmware.com/cloud/2021/04/28/oracle-cloud-vmware-solution-networking-reference-architecture/)
- [Getting Started with OCVS](https://docs.oracle.com/en-us/iaas/Content/VMware/Concepts/ocvsoverview.htm)
- [OCVS Solution Brief](https://www.oracle.com/a/ocom/docs/understanding-oracle-cloud-vmware-solution.pdf)

## Acknowledgements

* **Author:** Vijay Kumar
, Cloud Engineering OCVS
* **Contributors:**
    - Chris Wegenek, Cloud Engineering
    - Karthik Meenakshi Sundaram, Cloud Engineering
    - Germain Vargas, Cloud Engineering
    - Kelly Montgomery, Cloud Engineering

* **Last Updated By/Date:** Vijay Kumar, Cloud Engineering OCVS, February 2025