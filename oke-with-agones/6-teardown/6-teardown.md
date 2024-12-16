# Create the Agones System Pods with Helm

In this lab you will teardown all resources that were created during this workshop.

## Introduction

To make sure you dent leave infrastructure running that isn't being used you can use the steps in this guide to teardown some or all of what you deployed in this workshop.

Estimated Time: 10 minutes

Objectives
In this lab, you will:
 - Delete the Agones Fleet
 - Delete the Agones System
 - Delete the Terraformed infrastructure

Prerequisites
 - Completed all the previous labs

## **Task 1**: Delete The Fleet

Here we will delete the Agones Fleet

1. SSH to your Operater using the output from `terraform output`, example below.

    ```bash
    ssh -J opc@<bastion public IP> opc@<operator private ip>
    ```

2. Delete the fleet

    ```bash
    kubectl delete fleets --all --all-namespaces
    kubectl delete gameservers --all --all-namespaces
    ```

## **Task 2**: Delete The Agones System

Within your SSH session of Task 1, delete the Agones chart, using te same name when you created it, `my-release` in this workshop.

   ```bash
   helm uninstall my-release --namespace agones-system
   ```

## **Task 2**: Delete the Infrastructure

Now Terraform destroy the infrastructure from the directory you created it in. This could take some time to complete.

   ```bash
   cd infrastructure

   terraform destroy
   ```

## **Summary**

In this lab we tore down everything we created.  The Agones Fleet and any remaining `gameserver`'s, the Agones system pods and finally the terraformed infrastructure.

## Learn More - *Useful Links*

- [Agones](https://agones.dev/site/docs/)
- [Kubernetes](https://kubernetes.io/)

## **Acknowledgements**

 - **Author** - Marcellus Miles, Master Cloud Architect
 - **Last Updated By/Date** - Marcellus Miles, Dec 2024