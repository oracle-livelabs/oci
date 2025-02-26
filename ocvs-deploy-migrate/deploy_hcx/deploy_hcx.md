# Lab 4: Deploy and Configure HCX

**Introduction**

Migrating workloads to a public cloud is challenging because of the incompatibilities between on-premises and cloud infrastructure environments. Some of the bigger challenges for cloud adoption are:

- Incompatible, non-interoperable stacks in application dependency mapping
- Cross-site networking and security issues
- Application dependency mapping delay
- Business disruptions that require maintaining a secure, off-premises “active” infrastructure

Oracle Cloud VMware Solution overcomes these challenges by building an abstraction layer on top of existing site-specific implementations of Oracle Cloud Infrastructure using VMware HCX. In this lab we will discover how HCX can help you migrate onprem workloads to the cloud without impacting the application running in the virtual machine.

HCX supports following methods of migration;

- **Migration with vMotion:** HCX vMotion uses the standard VMware vMotion to migration virtual machines between sites without service interruptions. vMotion can be performed for both running as well as powered-off virtual machines.
- **Bulk Migrations:** Bulk migrations uses the VMware vSphere Replication protocols to move virtual machines to a destination site. This method is designed to move VMs in parallel and can be scheduled. With bulk migration the service interruption is equivalent to a virtual machine reboot.

In this lab we will deploy HCX Connector appliance, configure HCX and perform a Virtual Machine live migration.

**Estimated Time:** 30 Minutes

**Prerequisites**

It is assumed that you have access to or familiarity with following components:

- An Oracle account
- An existing OCVS environment.
- An existing VMware SDDC running in source site.
- You will need to setup forward and reverse DNS lookup entries for VMware components, ensure that lookup works from both locations onprem as well as OCVS.
- Familiarity with Oracle Cloud Infrastructure (OCI) and VMware SDDC stack.
- Familiarity with basic VMware Storage terminology will also be helpful.

**Objectives**

In this lab, you will;
    - Download the HCX Connector appliance
    - Deploy and license the connector in source vCenter
    - Configure Compute profile
    - Configure Service Mesh and Interconnect
    - (Optional) Configure Network Extension

**HCX Topology**

The following image demonstrate a high level topology of HCX deployment between On-premises datacenter and OCVS.

![HCX Topology](./images/mig_hcx_ocvs_topology.png)

**Soure Site Considerations**

Before you can start with HCX Connector deployment, you need to ensure that you have following information about the source site (On-Premises SDDC)

|    **Resources**    |    **Requirement**    |
|---------------------|-----------------------|
|vSphere version|5.0 and later|
|vSphere/ESXi Cluster Networks|<ul><li>Identify the ESXi Management, vMotion, and Replication port groups (if they exist) required for network profile. Create missing network port groups, if needed.</li><li>Identify virtual standard switch (VSS) port groups or distributed port groups (DPG) names, VLANs, and subnets. If these networks vary from cluster to cluster, additional configuration is needed.</li><li>Identify available IP addresses. (HCX participates in these networks.)</li></ul>|
|NSX version and configurations|<ul><li>NSX is not required at the source site. However, verify the details of the NSX requirements for HCX appliance deployments in the VMware HCX product documentation.</li><li>NSX is required only when HCX is used to extend NSX networks.</li><li>NSX Manager URL and admin credentials.</li></ui>|
|DNS and NTP|<ul><li>Verify that DNS is configured according to the requirement listed in the Configure DNS for Oracle Cloud VMware Solution section.</li><li>Ensure that NTP is configured with all the components deployed.</li></ul>|
|vCenter and SSO|<ul><li>vCenter IP address or FQDN</li><li>SSO IP address or FQDN</li></ul>|
|Site-to-Site Connectivity|The on-premises SDDC is connected to the Oracle Cloud VMware Solution environment through a FastConnect dedicated link of 1 Gbps or 10 Gbps for best performance.|
|HCX network port requirements|	For detailed firewall port opening requirements, see HCX port requirements in the VMware documentation.|


**HCX Connector Network Requirements**

Before moving to the next section ensure that you have gathered following information about the onprem hcx connector appliance.

VM Name
IP Address
DNS
Domain Search List
Gateway
Subnet
HCX Network Portgroup
CLI Password
NTP


**Target Site Considerations**

Oracle Cloud VMware Solution (OCVS) is a one-click fully automated deployment. As part of the deployment, HCX Cloud appliance is deployed, licensed, registered with OCVS vCenter and compute profile is configured.

As part of the lab, we will not make any changes to the default HCX configurations. To ensure that both sites can communicate with each other using FQDN, ensure that both the primary and destination DNS servers have all the forward and reverse lookup entries for both sites' VMware components such as vCenter, NSX, Platform Service Controller (PSC).

## Task 1: Install On-prem connector

Follow below steps to download the HCX connector and deploy it in the on-prem vCenter server.

1. If you already do not have the RDP connection to the Jump server, then initiate an RDP connection to the jump server using the steps mentioned in [Lab-2 Task-5 - Access Jump Host via RDP](./../deploy_ocvs/deploy_ocvs.md)
2. Once logged into the jump server, login to the HCX Manager with administrative credentials as mentioned in [Lab-2 Task-5 - Access HCX](./../deploy_ocvs/deploy_ocvs.md)
3. In the **Administration** section, click **System Updates**.
4. Click **Check for Updates** under Local HCX.
5. Once the check completes, click **Request Download Link**.
6. Download the HCX Connector OVA by clicking on **VMware HCX**.

**NOTE:** Before moving to the next step, you will need to transfer the OVA file to a location which has access to the onprem vCenter server. This might be your local workstation or a different jump server. The lab does not cover the procedure to transfer the file to appropriate location as that might differ from one environment to another.

7. Login to the on-prem vCenter Server with a user who has permissions to deploy appliances/virtual machines.
8. Go to the Hosts and Cluster view, right click on the cluster/host/datacenter where you want to deploy the appliance and select **Deploy OVF Template**.
9. On the **Select an OVF template** page, browse to the connector OVA that we had downloaded in Step 6.
10. On the Select a name and folder page, provide a name and folder location for the appliance and click **Next**.
11. On the Select a compute resource page, select a cluster/host for deployment and click **Next**.
12. on the Review details page, verify the OVA template details and click **Next**.
13. On the License agreements page, read and accept the VMware End User License Agreement, and click Next.
<<<<<<< Updated upstream
14. On the Select storage page, select the virtual disk format, storage policy, storage name, and then click Next.
15. On the Select networks page, select the destination network, and click Next.
16. On the Customize Template page, set the appropriate deployment properties:
    1.  Passwords - Configure the CLI admin password and the root user password.
    2.  Network Properties - Enter the network properties for the default gateway.
    3.  Static Routes - Add a static route for a destination subnet or host.
    4.  DNS
    5.  DNS Server List - Enter the list of DNS servers for this virtual machine.
    6.  Domain Search List - Domains that you enter are searched in the order you list them, and the search stops when a valid name is found.
    7.  NTP Server List - Enter the list of NTP servers and ensure that the NTP server can be reached from the virtual machine. If the NTP time is out of sync, services fail to start.
    8.  Deployment (Connector OVA installation only)
    9.  Click Next.
17. Review the deployment settings and click Finish.

It will take ~10 Minutes for the OVA deployment to complete and the HCX Connector VM services to start. Once the services have started successfully, you can continue with Task 2.

## Task 2: Activate and Configure HCX Connector

Before you begin with task 2, you need to obtain the HCX license keys from the OCI console. If you haven't already retrieved the HCX activation key, follow 


## Task 3: Create Compute Profile in HCX Connector




## Task 4: Configure Site Pairing

## Task 5: Configure Service Mesh and Interconnect

## Task 6: (Optional) Configure Network Extension

## Learn More

- VMware HCX User Guide
- HCX Port Information
- Activating and Configuring HCX
- Creating a Compute Profile
- Deploying the Installer OVA in the vSphere Client
- [Oracle Cloud VMware Solution (OCVS) Overview](https://www.oracle.com/in/cloud/compute/vmware/)
- [OCVS Networking - Getting Started](https://docs.oracle.com/en-us/iaas/Content/VMware/Tasks/ocvsmanagingl2net.htm)
- [OCVS Networking Reference Architecture](https://blogs.vmware.com/cloud/2021/04/28/oracle-cloud-vmware-solution-networking-reference-architecture/)
- [Getting Started with OCVS](https://docs.oracle.com/en-us/iaas/Content/VMware/Concepts/ocvsoverview.htm)
- [OCVS Solution Brief](https://www.oracle.com/a/ocom/docs/understanding-oracle-cloud-vmware-solution.pdf)

## Acknowledgements