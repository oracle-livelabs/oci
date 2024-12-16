# Installing the OKE Autoscaler Addon

In this lab you will install and verify the OKE Cluster Autoscaler Add-on.

## Introduction

The OKE Cluster Autoscaler Add-on is what is used to watch and manage specified node pools that should be autoscaled.  The node pool you will configure this add on for is the pool that will be running the Agones fleet in future labs of this workshop.

The add-on itself is installed into its own node pool to isolate it from its own scaling events.


Estimated Time: 20 minutes

Objectives
In this lab, you will:
 - Verify the installation of the Autoscaler
 - Create a config file for the Autoscaler Add-on
 - Install the Autoscaler Add-on

Prerequisites
 - Completed Lab 2 which walked through deploying the infrastructure

## **Task 1**: Verify if the Autoscaler is already installed

Depending on the OKE Terraform module used and your connectivity when creating the infrastructure the OKE Terraform may have installed the addon for you.  Its configured to do so, but does not always work in some scenarios.

You should verify the current state of addons to see if the autoscaler was installed by following the steps below.

1. SSH to your Operater using the output from `terraform output`, example below.

       ssh -J opc@<bastion public IP> opc@<operator private ip>

2. Get the OCID of your cluster by running this command and looking for the `id` (which is the OCID) of the cluster you just created.  This can also be obtained from the web console.

       oci ce cluster list -c <OCID of Compartment you used in terraform.tfvars>

3. Get the Addons installed on your cluster

       oci ce cluster list-addons --cluster-id <OCID of your OKE Cluster from previous step>

   If `Autoscaler` is listed as one of the addons you can go to the next lab in this workshop.  If not, proceed with the remaining tasks here to install it.

## **Task 2**: Install the Autoscaler Addon

Assuming the task before this indicated the addon was not installed you can now install the addon.  You can also optionally do the following steps manually in the web console for OKE.

1. SSH to your Operater using the output from `terraform output`, example below.

       ssh -J opc@<bastion public IP> opc@<operator private ip>

2. Get the OCID of the `node_pool_workers` node pool. This is the pool that will run the Agones fleet in subsequent labs of this workshop.

       kubectl get node -l oke.oraclecloud.com/pool.name=node_pool_workers -o json |grep node-pool-id

3. The file `files/addon.json` will be used as an example. Its format is `<min nodes>:<max nodes>:<node pool id>`. Its very important here to remember that as your node pools change (renaming, changing terraform etc) their respective OCID's will change and you will need to update this config.

   Create the config as `addon.json` and paste the contents from `files/addon.json`. Replace from the file `<NODE POOL OCID>` with the OCID from the previous step above.

       # using vim or nano
       vim addon.json

       # paste from files/addon.json into this new file and save, # Paste in the correct Node Pool OCID

4. Install the addon using the newly created config file.  This should run without error and a resulting work request ID will be displayed.

       oci ce cluster install-addon --addon-name ClusterAutoscaler --from-json file://addon.json --cluster-id <ocid of cluster>

5. Verify there are no errors with the newly installed addon. The result should say `ACTIVE`.

       oci ce cluster get-addon --addon-name ClusterAutoscaler --cluster-id <ocid of cluster> | grep lifecycle-state

## **Summary**

You have installed the OKE Cluster Autoscaler addon on and configured it to watch the node pool that will be running the Agones fleet in subsequent labs of this workshop.

## Learn More - *Useful Links*

- [Working with the OKE Cluster Autoscaler Add-on](https://docs.oracle.com/en-us/iaas/Content/ContEng/Tasks/contengusingclusterautoscaler_topic-Working_with_Cluster_Autoscaler_as_Cluster_Add-on.htm)
- ["oci ce cluster addon" documentation](https://docs.oracle.com/en-us/iaas/tools/oci-cli/3.50.3/oci_cli_docs/cmdref/ce/cluster.html)

## **Acknowledgements**

 - **Author** - Marcellus Miles, Master Cloud Architect
 - **Last Updated By/Date** - Marcellus Miles, Dec 2024