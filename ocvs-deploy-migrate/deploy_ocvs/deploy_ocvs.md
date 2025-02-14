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

### 1. SDDC Overveiw

### 2. Retrieve Credentials for VMware Softwares

### 3. Retrieve HCX License Keys

### 4. Check Cluster and Host details


## Task 5: Access SDDC Components

### Setup SSH Tunnel from Bastion to Jump Host

### Access Jump Host via RDP

### Access VMware Components

#### Access vCenter

#### Access NSX-T

#### Access HCX

## Learn More

## Acknowledgements

- **Author** -
- **Contributors** -
- **Last Updated By/Date** -