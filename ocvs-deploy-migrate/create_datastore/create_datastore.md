# Lab 3: Create New Datastore with OCI Block Volume

**Introduction**

In this lab you will create a new OCI Block Volume, attach the volume to ESXi hosts and create a new VMFS datastore on this Block Volume, this volume will then be used to host workload virtual machines.

**Estimated Time:** 15 Minutes

**Prerequisites**

It is assumed that you have access to or familiarity with following components:

- An Oracle account
- An existing OCVS environment.
- Necessary user permissions to create, attach and manage OCI Block Volumes.
- Familiarity with Oracle Cloud Infrastructure (OCI) and VMware SDDC stack.
- Familiarity with basic VMware Storage terminology will also be helpful.

**Objectives**

In this lab, you will;

- Create a new OCI Block Volume.
- Attach the volume to OCVS BareMetal instance.
- Configure ESXi Storage Adapter
- Create VMFS Datastore

## Task 1: Create OCI Block Volume

The Oracle Cloud Infrastructure Block Volume service lets you dynamically provision and manage block storage volumes. You can create, attach, connect and move volumes as needed to meet your storage and application requirements. Once attached and connected to an instance, you can use a volume like a regular hard drive. Volumes can also be disconnected and attached to another instance without the loss of data.

1. Click the Navigation Menu in the upper left. Navigate to Storage, and click Block Storage.
2. In Block Volume service, click Create Block Volume and provide the following details:

- **Name:** livelab-datastore01
- **Compartment:** Same as OCVS compartment
- **Availability Domain:** It must be the same as the AD you chose for your instance
- **Volume size and performance**: Custom
  - **Volume Size:** 250GB
  - **Volume Performance:** Balanced (10 VPU)
  - **IOPS:** 25,000 IOPS (60 IOPS/GB)
  - **Throughput:** 480 MB/s (480 KB/s/GB)


1. Leave the encryption and tags options as their default values
2. Click Create Block Volume. The volume will be ready to attach once its icon no longer lists it as **PROVISIONING** in the volume list.

## Task 2: Attach Volume to OCI Instance

Once the Block Volume is created, you can attach it to the ESXi Host instance. When attaching a Block Volume to Bare Metal instances iSCSI is the only supported attachment method.

1. Scroll down and on the left under Resources, select Attached Instances
2. Then click on the Attach to Instance button.
   1. On the right, select iSCSI
   2. Select Read/Write Shareable
   3. Accept the warning
   4. Scroll down
   5. Click on Select Instance
   6. Under Instance, select the ESXi host in the drop-down menu, e.g., ESXi-Lab001-1
   7. Select Attach (This action will take ~2 minutes)
3. Click Close.


## Task 3: Configure ESXi Storage Adapter

After you attach the block volume to the host instance, you need to get the iSCSI IP Address and Port, and configure this in the ESXi iSCSI adapter.

1. On the Block Volume overview page, select Attached instances.
2. Open the vertical 3 dot ellipsis menu to the far right of the ESXi host name.
3. Select **iSCSI Commands and Informaiton**.
4. Under the IP Address and Port field, copy the IP address. We don't need the port as the default port is already configured in the ESXi iSCSI adapter.
5. Select **Close**.
6. Access vCenter as Described in [Lab 2 - Task 5](./../deploy_ocvs/deploy_ocvs.md/)
7. Expand the vCenter inventory and select the ESXi host, e.g., sddc-lab001-1
8. Select Configure
9. Select Storage Adapters
10. Select the iSCSI Software Adapter
11. In the lower menu, select Dynamic Discovery
12. Click Add
13. Paste the IP address that you captured in the Text Editor during the creation of the block device.
    **Note**: You do not need the port ":3260" if you copied that as part of the IP.
14. Click OK.
15. Select iSCSI Software Adapter
16. Click **Rescan Adapter**

## Task 4: Create VMFS Datastore
Once you configure the iSCSI Adapter, the block volume will be visible as an external disk to the ESXi host. You can use this volume to create a new VMFS datastore.

1. **Right click** the ESXi host e.g., esxi-lab001-1
2. Select **Storage**
3. Click **New Datastore**
4. Verify **VMFS** is selected
5. Click **Next**
6. Enter a **name** for the Datastore - livelab-datastore01
7. Click **Next**
8. Ensure **VMFS 6** is selected
9. Click **Next**
10. Click **Next**
11. Click **Finish**.
12. Select the **Storage** icon
13. Verify the Block Volume Datastore has been created and added to your OCVS Cluster.

## Learn More

## Acknowledgements

- **Author** -
- **Contributors** -
- **Last Updated By/Date** -