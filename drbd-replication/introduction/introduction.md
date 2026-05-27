# Introduction

## About this Workshop

DRBD is a Linux-based storage replication technology. It mirrors block devices (like disks or partitions) between servers in real time over the network. It is commonly used for High Availability (HA) setups so that if one node fails, the other node has an identical copy of the data and can continue serving applications.

Corosync is the cluster communication layer. It manages node membership, quorum, and messaging between cluster nodes. In simple terms, it lets cluster servers know which nodes are alive and keeps them synchronized.

Pacemaker is the cluster resource manager. It controls and automates failover of services, virtual IPs, applications, filesystems, and DRBD resources. If a node fails, Pacemaker decides where and how services should restart on another node.

In Oracle Cloud Infrastructure these three components will be integrated in a setup which will let you replicate data between hosts in multiple regions and ADs providing a HA cluster for files replication. The deployment of these components will be on virtual machines, and because OCI provides nested virtualization we can have also guest VMs in this virtual machines replicated demonstrated with DRBD.

Estimated Workshop Time: 1.5 hour

### **Objectives**

By the end of this workshop, you will be able to:

* Deploy and configure DRBD, Corosync, and Pacemaker.
* Validate file replication between hosts with DRBD.
* Connect to a KVM virtual machine, create files, and observe data replication across nodes.


### **Prerequisites**

This lab assumes you have:

* An Oracle Cloud account
* Administrator privileges or access rights to the OCI tenancy
* Basic understanding of DBRD, Corosync and Pacemaker
* Basic understanding of KVM

### Learn More

* [DRBD Documentation](https://linbit.com/drbd-user-guide/drbd-guide-9_0-en/)
* [Corosync Documentation](https://docs.asterisk.org/Configuration/Interfaces/Distributed-Device-State/Corosync/#corosync)
* [Pacemaker Documentation](https://github.com/ClusterLabs/pacemaker/blob/main/doc/README.md)
* [Oracle Cloud Infrastructure](https://docs.oracle.com/en-us/iaas/Content/home.htm)

You may now proceed to the next lab.

**Authors**

* **Cristian Cozma**, Principal Cloud Architect, NACIE
* **Cristian Vlad**, Master Principal Cloud Architect, NACIE
* Last Updated By/Date - Cristian Vlad, May 2026