# Lab 2: Deploy Oracle Cloud VMware Solution (OCVS)

**Introduction**

In this lab you will deploy a single node OCVS SDDC Cluster.

Estimated Time: 15 Minutes

Note: Triggering the OCVS Deployment takes around 15 Minutes, However the actual infrastructure deployment takes around 3 Hours to complete.

**Prerequisites**

It is assumed that you have access to or familiarity with following components:

- An Oracle account
- A compartment to deploy the solution in.
- Necessary user permissions to deploy and manage OCVS.
- Oracle VCN with an available subnet of size **/24**.
- Familiarity with Oracle Cloud Infrastructure (OCI) and VMware SDDC stack.
- Familiarity with basic networking terminology such as Subnet, VLAN, CIDR etc.

**Objectives**

In this lab, you will;

- Identify networking requirments for OCVS deployment
- Generate an SSH Key pair for ESXi access
- Deploy an OCVS SDDC with single node cluster
- Review the SDDC details in OCI Console

## Task 1: Identify OCVS Subnet

OCVS cluster is deployed in a VCN in your tenancy. This allows you complete control over IP addresses, subnets, routing and security lists. Building the cluster in you VCN also puts the workloads closest to other OCI Native Services such as Object Storage, Block Volumes, Autonomous Database etc. This leads to increased performance and better throughput when access native OCI Services from workloads running in OCVS.

To start the deployment, you need an existing VCN with an IP address CIDR of /24 or larger available for running the cluster . The CIDR size depends on the number of nodes that you plan to add in the cluster. Following is an overview of CIDR sizes and number of nodes the CIDR can support. 

- CIDR block size **/24**, segment size **/28**, number of nodes in cluster **3-12**.
- CIDR block size **/23**, segment size **/27**, number of nodes in cluster **3-28**.
- CIDR block size **/22**, segment size **/26**, number of nodes in cluster **3-60**.
- CIDR block size **/21**, segment size **/25**, number of nodes in cluster **3-64**.

For the lab deployment we will use the following subnet:

```
<copy>
172.16.2.0/24
</copy>
```

**Note** If you have created the VCN in Lab 1 with a different CIDR range or want to use an existing VCN, you can update the OCVS subnet accordingly.

## Task 2: Generate SSH Key

The SSH (Secure Shell) protocol is a method for secure remote login from one computer to another. SSH enables secure system administration and file transfers over insecure networks using encryption to secure the connections between endpoints. SSH keys are an important part of securely accessing Oracle Cloud Infrastructure compute instances in the cloud.

If you already have an SSH key pair, you may use that to connect to your environment.

### **On Mac**

1. On Mac, start up the terminal by using cmd + space and typing terminal or cmd + shift + U and click on terminal

  Once in the terminal type ssh-keygen or copy and paste the command into the terminal, press enter. You will prompted to enter file to save your key. pressing enter will select default in your .ssh folder. Press enter twice for no passphrase. Remember where it is saved as we will reference this later when creating instances.

    ![ssh-keygen](images/ssh-keygen.png)

    ```
    <copy>
    ssh-keygen
    </copy>
    ```

### **On Windows 10**

1. Open a Powershell command window on your Windows 10 system by clicking it’s icon/tile or by typing ‘powershell’ in the search field in the Start bar.

  ![ssh-keygen-windows](images/ssh-keygen-windows.png)

2. Once in the terminal type ssh-keygen or copy and paste the command into the terminal, press enter. You will prompted to enter file to save your key. pressing enter will select default in your .ssh folder. Press enter twice for no passphrase. Remember where it is saved as we will reference this later when creating instances.

    ```
    <copy>
    ssh-keygen
    </copy>
    ```

  ![verify-keygen-windows](images/verify-keygen-windows.png)

### **Verifying the Keys**

To verify that your keys exist, You can use the following commands.

```
	<copy>
	cd .ssh
	</copy>
```
```
	<copy>
	ls
	</copy>
```
```
	<copy>
	cat id_rsa.pub
	</copy>
```
![confirm-keygen-windows](images/confirm-keygen-windows.png)

## Task 3: Deploy Single Node OCVS Cluster

1. Open the **navigation** menu , select **Hybrid**, and then select **VMware Solution**.
2. Click **Create SDDC**.
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
   Provide the public key that we had created in the last section. 
5. Click **Next** to advance to the **Define Clusters** page.
6. Click **Define management cluster**, and provide following information for the cluster:
	- **Cluster name**
		```
		<copy>
		livelab-cluster
		</copy>
		```
	- **Availability domain**
		Select the Availability domain in which to create the SDDC.
	- **ESXi hosts**
		Provide configuration information:
	- **Host type**
		Single Host SDDC
	- **Prefix for ESXi hosts**
		```
		<copy>
		livelab
		</copy>
		```
	- **SDDC hardware type**
		DenseIO.E4.32
	- **Pricing interval commitment**
		Hourly
7. Click **Next** to advance to the cluster's **Networking** page.
8. Select the **VCN** you had created in Lab 1 for OCVS.
	- Click **Create new subnet and VLANs**.
	- Enter the subnet details as follows.
		```
		<copy>
		172.16.2.0/24
		</copy>
		```
		**Note**: If you had selected a different subnet in Task 1, enter that subnet detail.
9.  Enter the **cluster workload CIDR** to create an initial logical segment for the VMs.
		```
		<copy>
		192.168.1.0/24
		</copy>
		```
10. Click **Next** to advance to the **Datastores** page.
11. Click **Next** to review the **cluster configuration summary**.
12. Click **Complete cluster definition**.
13. Click **Review SDDC**.
14. Click **Create SDDC**.

The page shows the provisioning status of each resource.

**NOTE**: The deployment takes about 2.5 Hours to complete, you can monitor the status of the tasks in the work requests section.

## Task 4: Review OCVS SDDC

After OCVS deployment is complete, the SDDC overview page will show details related to the VMware components, Clusters, Hosts and Networking.

### 1. **SDDC Overveiw**

If you are not already on the OCVS SDDC Details page;

1. In the Upper left corner, click the hamburger menu icon.
2. Navigate to Hybrid
3. Select Software-Defined Data Centers under the VMware Solution section.
4. Select the **livelab-sddc** that we had cerated in last task. Make sure that the state of the SDDC is **Active**.
5. On the SDDC overview page, you can see following details about the SDDC;
      - **vCenter information** - The vCenter information sections list the vCenter URL, IP Address, initial username and initial password.
      - **NSX manager information** - the NSX information sections list the NSX manager URL, IP Address, initial username and initial password.
      - **HCX Manager information** - this section lists the details about the HCX Manager including the URL, IP Address, initial username, password, license type and on-prem connector activation keys.
      - **vSphere Clsuters** - This section lists all the clusters withing the SDDC, including the management and workload clusters. You can manage existing clusters by selecting the cluster name from this section or use the **Add a workload cluster** button to define and create a new workload cluster.
6. Click on the single management cluster **livelab-cluster** to view the cluster overview page.
7. The cluster overview page list the details of the individual cluster in following sections;
      - **Cluster Information** - This section has the basic details of the cluster deployment including the **OCID**, **VMware software version**, **Availability domain** where the cluster is deployed, **Workload CIDR** and **timestamps**.
      - **ESXi Hosts** - This section provides details of the individual hosts which are part of this cluster and include the **host Name**, **State**, **Availability Domain**, **Current** and **Next Pricing Interval**.
      - **Click** on the **Cluster Networks** option in the **Resources** section in the left hand pane.
      - In the **Cluster networks** section you can;
           - View the details of SDDC **VLANs** including but not limited to **vSphere**, **vMotion**, **Management** and **vSAN** VLAN.
           - View the details of the **provisioning subnet** under the subnet section.
8. **Click** on the **ESXi Hosts** option in the **Resources** section in the left hand and **Click** on the **ESXi host name** to view the details about the ESXi host.
9. On the **ESXi Host information** page, you can get detailed information about the ESXi Host instance, following information for the host is made available on the page;
      - Host OCID
      - Compartment
      - Availability Domain
      - Timestamps
      - Shape
      - OCPU Count
      - Capacity Reservation (if any)
      - Billing information

### 2. **Retrieve Credentials for VMware Softwares**

If you are not already on the OCVS SDDC Details page;

1. In the Upper left corner, click the **hamburger menu icon**.
2. Navigate to **Hybrid**
3. Select **Software-Defined Data Centers** under the **VMware Solution** section.
4. Select the **livelab-sddc** that we had cerated in last task. Make sure that the state of the SDDC is **Active**.
5. On the SDDC overview page, copy the following details and save these in a notepad. We will need these in the next section to access the SDDC components.
      - Copy the **vSphere client URL** by clicking on the associated **Copy** Link and paste it in a notepad file for easy retrieval.
      - Copy the **vcenter initial username** paste it in a notepad file for easy retrieval.
      - You can also retrieve the **vCenter initial password** by clicking the associated Show or Copy option.
6. **Repeat step 5** to get **access URL** and **credentials** for **NSX-T Manager** and **HCX Manager**.
7. Copy the **HCX on-premise connector activation keys** by clicking on the **View** button in the **HCX manager information** section.

## Task 5: Access SDDC Components

To build a secure and controlled environment and isolate the critical components from other workloads, we had deployed OCVS SDDC in a private subnet with limited access to the outside networks. We had also created a public subnet to allow access into the OCI environment from the public internet. Only SSH access is allowed in the public subnet to ensure complete control over network ingress.

To access the SDDC component, we will use the Linux Bastion host deployed in the public subnet and use port forwarding from the Bastion host to a Windows jump host in the private subnet. In the following sections we will create the SSH tunnel and RDP to the jump host.

### Setup SSH Tunnel from Bastion to Jump Host

1. **Login** to the **OCI Cloud** console by opening the https://cloud.oracle.com url in a web browser of your choice.
2. **Click** the **upper right corner** where you see your **home region** and ensure that you are in the correct region where you had deployed OCVS SDDC.
3. In the upper left corner, click the **hamburger menu icon**
4. Navigate to **Compute** ad click on **Instances**
5. Verify that Applied filters shows the **SDDC compartment**.
6. Locate the instance named - **<Bastion Host name will go here>**
7. Copy the **Public IP** address of the bastion instance.
8. Locate the instance named - <Jump Host name will go here>
9. Copy the **Private IP** address of the jump host.
10. Follow the instruction below to setup the SSH Tunnel based on your operating system.

**Mac Instructions**

1. Click on the **Launchpad** icon in the **dock**.
2. Search for **Termianl** app and open a new terminal window.
3. **Change directory** to the location where you have saved the private SSH key from [Lab-1-Task-6](./../configure_networking/configure_networking.md/#task-6---deploy-bastion-instance).

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

5. Create the ssh tunnel by running the following command in the terminal.
   **Note:** Make sure to replace the <public_ip> address with the actual **public IP** of the bastion host and <private_ip> with the **private IP** of the Windows Jump server.

	```
    <copy>
    ssh -i <bastion_private_key> opc@<public_ip> -L 5000:<private_ip>:3389
    </copy>
    ```

**Windows Instructions**

Windows operating system by default does not have an SSH client built in, So we will need to Download and install an SSH client such as Putty. If you already do not have the SSH Client installed, Follow the instruction at [www.putty.org](https://www.putty.org/) to download and install the client on your workstation.

Following instructions are only applicable if you are using PuTTY as the client. If you use a different SSH client, the instruction to setup SSH connection and remote port forwarding might be different. Refer to the documentation of your SSH Client to setup the connection and port forwarding.

1. **Click** on the **Windows** Icon on the workstation and search for **PuTTY**.
2. Open a new SSH connection window by clicking on the **PuTTY** icon.
3. In **Host Name** box, enter the **public IP** address of the Bastion Host in the following format
   
	```
	<copy>
	opc@<public_ip>
	</copy>
	```

4. Confirm that the **Connection type** option is set to **SSH**.
5. In the Category tree, expand SSH and then click **Auth**
6. Click the **Browse** button next to the **Private key file for authentication** box and select the <bastion_private_key.ppk> file. **How to convert to ppk add steps here?**
7. In the Category tree, click **Tunnels**.
      - In the **Source Port** box, enter **5000**.
      - In the **Destination box**, enter the following IP and port combination.
			```
			<copy>
			<jump_host_private_ip>:3389
			</copy>
			```
      - Confirm that the **Local** and **Auto** options are set.
      - Click **Add** to forward the port.
8. In the **Category** tree, click **Session**.
9.  In the **Saved Sessions** box, enter a name for this connection configuration. Then, click **Save**.
10. Click **Open** to open the connection.

**NOTE** If this is the first time you are connecting to the Bastion, the PuTTY Security Alert window is displayed, prompting you to confirm the public key.

11. Click **Yes** to continue connecting.

### **Access Jump Host via RDP**

Once you have the SSH tunnel setup, we can RDP to the jump host from the local workstation. Follow the instruction below to connect to the Windows Server jump host based on your workstations' operating system.

**Mac Instructions**

1. If you do not have the **Windows App** already installed on the Workstation, then Go to the App Store and Install "**Windows App**" from Microsoft.
2. Click on the **Launchpad** icon in the **dock**.
3. Search for **Windows App** and open the app by clicking on the app icon.
4. Click the **+** symbol and select the **add PC** option.
5. In **PC Name** field, enter the following **IP Address** and **Port**.

	```
	<copy>
    127.0.0.1:5000
    </copy>
	```

6. Click **Add**
7. When asked for the **credentials** enter following details;
   1. **Username**: opc
   2. **Password**: Enter the password for opc user that you had created in Lab-1, Task-7
8. Click **Add**
9. Launch the RDP Connection by **double clicking** on the RDP Instance icon.

**Windows Instructions**

1. Click on the **Windows** Icon on the workstation and search for **Remote Desktop Connection**.
2. Open the **Remote Desktop Connection** windows by clicking on the application icon.
3. Click on **Show Options** to view the authentication details.
4. In the **Computer** field, enter the following **IP Address** and **Port**

	```
	<copy>
    127.0.0.1:5000
    </copy>
	```

5. In the **User Name** field, enter the following username.

	```
	<copy>
    opc
    </copy>
	```

6. Click **Connect**
7. When asked for the opc password, enter the password for opc user that you had created in Lab-1, Task-7.
8. Press **Enter**

### **Access VMware Components**

Once you have the RDP connection to the Jump Host, the first thing we need to do is to install a Web Browser as the instance would only have Internet Explorer available by default and IE does not perform well for SDDC component web applications.

You can install any one of the following web browsers depending on your preference.

- Google Chrome
- Micorsoft Edge
- Mozilla Firefox
- Apple Safari

After you install the browser, open a new browser windows and follow the below steps to access the OCVS SDDC components.

**NOTE:** You will need the URLs and credentials for the SDDC components which we had captured in the [SDDC Overview Task](#access-vmware-components). If you have not captured the details. Please return to the [SDDC Overview Task](#access-vmware-components) and capture the mentioned details.

#### Access vCenter

1. In the web browser, open a new tab.
2. Paste the **vSphere Client URL** that you had captured in the [SDDC Overview Task](#access-vmware-components) in the **WebURL** field and press **Enter**.
3. If you receive a warning that the connection is not private, ignore the warning and proceed.
4. Click the **Launch vSphere Client** (HTML5) button.
5. On the authentication page, enter the following details for the **username** and **password**.
      - **Username** :
		```
		<copy>
    	administrator@vsphere.local
    	</copy>
		```
	  - **Password**: vCenter initial password captured in [SDDC Overview Task](#access-vmware-components)
6. Click **Login**
7. On the vCenter Home page, select **Hosts and Clusters**.
8. Expand the vCenter inventory in the left hand pane.
9. Review the details of the **cluster**, **host** and **management virtual machines**.

#### Access NSX-T

1. In the web browser, open a new tab.
2. Paste the **NSX Manager URL** that you had captured in the [SDDC Overview Task](#access-vmware-components) in the **WebURL** field and press **Enter**.
3. If you receive a warning that the connection is not private, ignore the warning and proceed.
4. On the **authentication page**, enter the following details for the **username** and **password**.
      - **Username** :
		```
		<copy>
    	admin
    	</copy>
		```
	  - **Password**: NSX Manager initial password captured in [SDDC Overview Task](#access-vmware-components)
5. Click **Login**
6. On the NSX-T Manager page, you can review the details of the **NSX Manager, Edges, Edge Cluster** and the **default segment**.

#### Access HCX

1. In the web browser, open a new tab.
2. Paste the **HCX Manager URL** that you had captured in the [SDDC Overview Task](#access-vmware-components) in the **WebURL field** and press **Enter**.
3. If you receive a warning that the connection is not private, ignore the warning and proceed.
4. On the **authentication** page, enter the following details for the **username** and **password**.
      - **Username** :
		```
		<copy>
    	administrator@vsphere.local
    	</copy>
		```
	  - **Password**: HCX Manager initial password captured in [SDDC Overview Task](#access-vmware-components)

5. Click **Login**
6. On the HCX Manager page, you can review the details of the **Site pairings, vCenter integrations, compute profiles, service meshes** etc.
7. At this stage, you will not see anything in the HCX Manager except the **vCenter integration** as we have not deployed the on-prem connector. We will deploy and configure the on-prem connector in the next lab.

## Learn More

- [Oracle Cloud VMware Solution (OCVS) Overview](https://www.oracle.com/in/cloud/compute/vmware/)
- [OCVS Networking - Getting Started](https://docs.oracle.com/en-us/iaas/Content/VMware/Tasks/ocvsmanagingl2net.htm)
- [OCVS Networking Reference Architecture](https://blogs.vmware.com/cloud/2021/04/28/oracle-cloud-vmware-solution-networking-reference-architecture/)
- [Getting Started with OCVS](https://docs.oracle.com/en-us/iaas/Content/VMware/Concepts/ocvsoverview.htm)
- [OCVS Solution Brief](https://www.oracle.com/a/ocom/docs/understanding-oracle-cloud-vmware-solution.pdf)

## Acknowledgements

- **Author** -
- **Contributors** -
- **Last Updated By/Date** -