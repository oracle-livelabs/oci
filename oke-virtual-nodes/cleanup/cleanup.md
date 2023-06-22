# Cleanup

## Introduction

The following steps represents cleanup operations, which may vary depending on the actions performed for setup and deployment of MuShop.

Estimated Time: 10 minutes

### Objectives

* Log into OCI Tenancy.
* Undeploy the MuShop App using helm delete
* Terminate Oracle Cloud Infrastructure (OCI) components.

## Task 1: List any helm releases that may have been installed

1. To get a better look at all the installed Helm Charts by using the **helm list** command.

    ````shell
    <copy>
    helm list --all-namespaces
    </copy>
    ````

    Sample response:

    ````shell
    NAME    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
    mushop  default         1               2023-06-15 17:20:52.207651881 +0000 UTC deployed        mushop-0.2.1    2.0 
    ````

## Task 2: Clean Up MuShop App

1. Remove the application from Kubernetes where --name mushop was used during install.

    ````shell
    <copy>
    helm delete mushop
    </copy>
    ````

## Task 3: Terminate the OKE Cluster and Worker Nodes

1. Delete the OKE Cluster

    ![Delete Kubernetes Clusters](images/oke_delete_cluster.png)

1. Confirm

    ![Confirm delete Kubernetes Clusters](images/oke_delete_cluster_confirm.png)

This action will delete the Kubernetes Cluster and the Node Pool, terminating the worker nodes Compute Instances

## Acknowledgements

* **Author** - Adao Oliveira Junior, Solutions Architect
* **Contributors** -  Adao Oliveira Junior, Solutions Architect
* **Last Updated By/Date** - Adao Oliveira Junior, Jun 2023
