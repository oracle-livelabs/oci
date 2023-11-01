
## Deploy Oracle Autonomous Database from Kubernetes

## Introduction

In this lab, we will use the deployed Oracle Service Operator for Kubernetes (OSOK) on your Kubernetes cluster from Lab 1 and Lab 2, to deploy the Oracle Autonomous Database Service.  

[Oracle Autonomous Database Service](https://docs.oracle.com/en-us/iaas/Content/Database/Concepts/adboverview.htm) is a fully managed, preconfigured database environment. It delivers automated patching, upgrades, and tuning, including performing all routine database maintenance tasks while the system is running, without human intervention. Autonomous Database service is also offered via the OCI Service Operator for Kubernetes (OSOK), making it easy for applications to provision and integrate seamlessly.

## Task 1: Create  Autonomous Database Dynamic Group Policies

**For Instance Principle**
The OCI Service Operator dynamic group you created in the previous lab, will need the following [policies](https://docs.oracle.com/en-us/iaas/Content/Database/Concepts/adboverview.htm) .

1. Open the navigation menu and click ***Identity & Security***. Under ***Identity***, click ***Policies***.

2. Click ***Create Policy***.

**Sample Policy:**

```plain
Allow dynamic-group {OSOK_DYNAMIC_GROUP} to manage autonomous-database in tenancy
```

## Task 2:  Provisioning an Autonomous Database

Provisioning of an Autonomous Database requires you to input the admin password as a Kubernetes secret. OSOK acquires the admin password from the Kubernetes secret provided in the `spec`. 
The Kubernetes secret should contain the admin password in `password` field. 
```sh
kubectl create secret generic {ADMIN-PASSWORD-SECRET-NAME}--from-literal=password={ADMIN-PASSWORD}
```

The Autonomous Database can be accessed using the details in the wallet which will be downloaded as part of the provision/bind operation of the CR. OSOK acquires the wallet password from the Kubernetes secret whose name is provided in the `spec`. Also, we can configure the name of the wallet in the `spec`.

```sh
kubectl create secret generic {WALLET-PASSWORD-SECRET-NAME}--from-literal=walletpassword={WALLET-PASSWORD}
```

The OSOK AutonomousDatabases controller automatically provisions an Autonomous Database when you provides mandatory fields to the `spec`. the following is a sample YAML for Autonomous Database.

```yaml
apiVersion: oci.oracle.com/v1beta1
kind: AutonomousDatabases
metadata:
  name: {CR_OBJECT_NAME}
spec:
  compartmentId: {COMPARTMENT_OCID}
  displayName: {DISPLAY_NAME}
  dbName: {DB_NAME}
  dbWorkload: {OLTP/DW}
  isDedicated: {false/true}
  dbVersion: {ORABLE_DB_VERSION}
  dataStorageSizeInTBs: {SIZE_IN_TBs}
  cpuCoreCount: {COUNT}
  adminPassword:
    secret:
      secretName: {ADMIN_PASSWORD_SECRET_NAME}
  isAutoScalingEnabled: {true/false}
  isFreeTier: {false/true}
  licenseModel: {BRING_YOUR_OWN_LICENSE/LICENSE_INCLUDE}
  wallet:
    walletName: {WALLET_SECRET_NAME}
    walletPassword:
      secret:
        secretName: {WALLET_PASSWORD_SECRET_NAME}
  freeformTags:
    <KEY1>: {VALUE1}
  definedTags:
    <TAGNAMESPACE1>:
      <KEY1>: {VALUE1}
```

Example Yaml:

```yaml
#
# Copyright (c) 2021, Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.
#

apiVersion: oci.oracle.com/v1beta1
kind: AutonomousDatabases
metadata:
  name: autonomousdatabases-sample
spec:
#  Id: ocid1.autonomousdatabase.oc1.<region-code>.aaaaXXXXXXXXXXXXXXXXXXXX
  compartmentId: ocid1.compartment.oc1..aaaaaaaaXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  displayName: SampleADB
  dbName: sampleadb
  dbWorkload: OLTP
  isDedicated: false
  dbVersion: 19c
  dataStorageSizeInTBs: 2
  cpuCoreCount: 1
  adminPassword:
    secret:
      secretName: admin-password
  isAutoScalingEnabled: true
  isFreeTier: false
  licenseModel: BRING_YOUR_OWN_LICENSE
  wallet:
    walletName: sampleadb-wallet
    walletPassword:
      secret:
        secretName: wallet-password

 ```



Run the following command to create a CR in the cluster:
```sh
kubectl apply -f {CREATE_ADB}.yaml
```

Once the CR is created, OSOK will reconcile and create an Autonomous Database. OSOK will ensure the Autonomous Database instance is available.

The AutonomousDatabases CR can list the Autonomous Databases in the cluster as below: 
```sh
$ kubectl get autonomousdatabases
NAME                         DBWORKLOAD   STATUS         AGE
autonomousdatabases-sample   OLTP         Active         4d
```

The AutonomousDatabases CR can list the Autonomous Databases in the cluster with detailed information as below: 
```sh
$ kubectl get autonomousdatabases -o wide
NAME                         DISPLAYNAME   DBWORKLOAD   STATUS         OCID                                   AGE
autonomousdatabases-sample   ADBTest       OLTP         Active         ocid1.autonomousdatabase.oc1........   4d
```

The AutonomousDatabases CR can be describe as below:
```sh
$ kubectl describe autonomousdatabases <NAME_OF_CR_OBJECT>
```
