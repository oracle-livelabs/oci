# Cleanup

## Introduction

From the Oracle Cloud Console, clean up the resources provisioned for this workshop.

Estimated Workshop Time: 05 minutes

### Objectives

In this lab, you will:

* Delete the Kubernetes namespace
* Delete the image from the private OCIR repo
* Delete the private OCIR repo
* Delete the OKE cluster (and VCN)
* Delete the Object Storage bucket
* Delete the OKE Workload Identity policy
* Delete the Auth Token
* (Optional) Purge local docker resources
* Destroy Stack
* Delete the Stack


## Task 1: Cleanup

From the Oracle Cloud Console, clean up the resources provisioned for this workshop:

1. From the same terminal in VS Code, run the following command to delete the Kubernetes namespace and related resources (service account, role, role binding, deployment, pod, service), including the OCI Load Balancer.

    ```bash
    <copy>
    kubectl delete ns $K8S_NAMESPACE
    </copy>
    ```

2. From **Developer Services** >> **Container Registry** >> search for your repo >> **images**, use **Delete Image** to delete image in OCIR repository.

3. From **Developer Services** >> **Container Registry** >> search for your repo >> use **Delete repository** to delete the OCIR repository.

4. From **Developer Services** >> **Kubernetes Clusters (OKE)** >> navigate to your cluster details section >> use **Delete** to delete it. 

5. If the VCN provisioned by the OKE cluster isn't automatically deleted, you can delete it manually from **Networking** >> **Virtual cloud networks**.

6. From **Storage >> Object Storage & Archive Storage >> Buckets**, delete the **Bucket**.

7. From **Identity & Security >> Identity >> Policies**, delete the Workload Identity policy.

8. From **Profile** icon on the top right >> go to **Profile details** >> **Resources** >> **Auth tokens**. Use **Delete** to delete the auth token.

9. (Optional) From the same terminal in VS Code, run the command to purge all local docker resources (images, containers, volumes, etc.)

    ```bash
    <copy>
    docker system prune -a
    </copy>
    ```

    Check the result using:

    ```bash
    <copy>
    docker system df
    </copy>
    ```

10. From **Resource Manager >> Stacks >> Stack Details** screen, run **Destroy** to delete the VCN and the Compute instance.

11. From **Resource Manager >> Stacks >> Stack Details** screen, **Delete** the stack.

Congratulations! You've successfully completed this lab.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)