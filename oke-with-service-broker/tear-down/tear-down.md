# Tear Down the Infrastructure

## Introduction

You will be cleaning up our deployment and tearing down the infrastructure.

Estimated Time: 10 minutes.

### Objectives

You will tear down the infrastructure you deployed.

## Task 1: Tear Down the OKE Cluster

1. Before tearing down infrastructure, it is recommended that you undeploy the Kubernetes objects. The Terraform code will attempt to destroy all Kubernetes objects but some artifacts may be left behind if it is not able to deprovision some resources (like buckets that are not empty).

2. To tear down the Kubernetes cluster, use:

    ```bash
    <copy>
    terraform destroy
    </copy>
    ```

3. Type `yes` at the prompt.

    This command will take several minutes.

4. Sometimes the destroy phase will fail because the nodes in the node pool are not completely cleaned up before the Terraform code attempts to destroy the VCN.

    Run the destroy command again to finish clean up if it fails at first.

## Acknowledgements

 - **Author** - Emmanuel Leroy, January 2021
 - **Last Updated By/Date** - Emmanuel Leroy, January 2021
