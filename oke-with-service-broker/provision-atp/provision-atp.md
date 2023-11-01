# Provision an Oracle Autonomous Transaction Processing database with Kubernetes

## Introduction

You will use the Oracle Cloud Infrastructure (OCI) Service Broker to manage the lifecycle of an Oracle Autonomous Transaction Processing database, using Kubernetes.

Estimated Time: 10 minutes.

### Objectives

- Configure an Autonomous Transaction Processing instance and binding to deploy on kubernetes.
- Use kubectl to deploy the instance and provision the database.
- Learn how to tear down the Autonomous Transaction Processing database instance when you are done.

Note: OCI Service Broker provisions an Autonomous Transaction Processing database with a public endpoint. It is currently not possible to provision the database in a private subnet via OCI Service Broker.

## Task 1: Get the Template Manifests for Autonomous Transaction Processing

1. Download the example templates:

    ```bash
    <copy>
    mkdir -p atp
    pushd atp
    curl -o atp-binding.yaml https://raw.githubusercontent.com/oracle/oci-service-broker/master/charts/oci-service-broker/samples/atp/atp-binding.yaml
    curl -o atp-instance.yaml https://raw.githubusercontent.com/oracle/oci-service-broker/master/charts/oci-service-broker/samples/atp/atp-instance.yaml
    curl -o atp-secret.yaml https://raw.githubusercontent.com/oracle/oci-service-broker/master/charts/oci-service-broker/samples/atp/atp-secret.yaml
    curl -o atp-demo-secret.yaml https://raw.githubusercontent.com/oracle/oci-service-broker/master/charts/oci-service-broker/samples/atp/atp-demo-secret.yaml
    curl -o atp-demo.yaml https://raw.githubusercontent.com/oracle/oci-service-broker/master/charts/oci-service-broker/samples/atp/atp-demo.yaml
    popd
    </copy>
    ```

2. How it works:

    - `atp-demo-secret.yaml` file defines a secret with the admin password and wallet password as-is. Secrets are base64 encoded.

    - `atp-secret.yaml` defines a secret with the same information as `atp-demo-secret.yml`, but the variables are defined as JSON objects. The admin password is used to provision the instance, while the wallet password is used for the binding.

    - `atp-instance.yaml` define an instance of the Autonomous Transaction Processing service to deploy. It defines the specifications for this instance, including OCPUs, autoscaling mode and storage parameters.

    - `atp-binding.yaml` creates a binding and will generate the wallet secret to use by the app.

    - `atp-demo.yaml` contains the deployment of a demo app, showing how to load the wallet in the app using the init container.

        Note that the init container is currently needed to decode the credentials that are base64 encoded twice (see the GitHub repo for OCI Service Broker for more details about this topic).

    - A secret called `atp-demo-binding` is created by the OCI Service Broker when deploying, which provides the wallet credentials for the Autonomous Transaction Processing database.

        This secret contains the content of the wallet to access the Autonomous Transaction Processing database.

## Task 2: Edit the Manifests

1. Edit `atp-instance.yaml` and replace `CHANGE_COMPARTMENT_OCID_HERE` with the **compartment OCID** of the compartment where you deployed the OKE cluster.

2. Edit `atp-demo.yaml` and replace `<USER_APPLICATION_IMAGE>` with `nginx` and replace the `apiVersion` to be `apps/v1`.


## Task 3: Deploy

1. To deploy the mainfest use:

    ```bash
    <copy>
    kubectl apply -f ./atp
    </copy>
    ```

    This will deploy all the manifests in the `atp` folder.

## Task 4: Check the Deployment

1. Verify the database instance is being provisioned:

    ```bash
    <copy>
    kubectl get all
    </copy>
    ```

    This should list the following manifests:

    ```
    NAME                            READY   STATUS     RESTARTS   AGE
    pod/atp-demo-56d678995f-fbcvj   0/1     Init:0/1   0          12s

    NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/atp-demo   0/1     1            0           12s

    NAME                                  DESIRED   CURRENT   READY   AGE
    replicaset.apps/atp-demo-56d678995f   1         1         0       12s   

    NAME                                                    SERVICE-INSTANCE   SECRET-NAME        STATUS   AGE
    servicebinding.servicecatalog.k8s.io/atp-demo-binding   osb-atp-demo-1     atp-demo-binding   Ready    9m44s
    NAME                                                   CLASS                             PLAN       STATUS   AGE
    serviceinstance.servicecatalog.k8s.io/osb-atp-demo-1   ClusterServiceClass/atp-service   standard   Ready    9m43s
    ```

3. Check to be sure the Autonomous Transaction Processing database is being provisioned.

    In the Oracle Cloud Console, select **Oracle Databases**, and then select **Autonomous Transaction Processing** in the compartment where you provisioned the database. You should see the Autonomous Transaction Processing database named `osbdemo`.

    Wait until it is provisioned and **Available**, which is when the OCI Service Broker is able to create the `atp-demo-binding` secret containing the access wallet.

3. Verify that the `atp-demo-binding` secret was created:

    ```bash
    <copy>
    kubectl get secrets
    </copy>
    ```

    Should show `atp-demo-binding`.

    If it does not show, then it is likely that the database is not fully provisioned yet. Check in the console and be patient.


## Task 5: Check the Wallet Content in the Demo App

The demo application doesn't do anything: it uses a generic nginx container that has not interaction with the database. It is solely to demonstrate how to get the wallet credentials inside the container.

You can verify the wallet is now accessible inside the demo app container by looking up the pod ID, and getting a shell into it:

1. Get the demo app pod ID with:

    ```bash
    <copy>
    kubectl get pods
    </copy>
    ```

    You should find a pod called `atp-demo-XXXXXXXXXX`.

    Make sure the status is `READY 1/1` or wait until it becomes ready; since the secret was not available for some time (until the database was available) the demo app would be unable to load the secret to decode the wallet. Once the secret is available, the pod will initialize.

    Once the pod is ready, copy the name of the pod and execute:

    ```bash
    <copy>
    kubectl exec -it <pod_name> -- /bin/sh
    </copy>
    ```

    You'll be prompted with a shell prompt inside the container.

    You can check the wallet files are available in the folder `/db-demo/creds` with:

    ```bash
    <copy>
    cd /db-demo/creds
    ls -lah
    </copy>
    ```

    Now you know how to get the credentials for a dynamically provisioned Autonomous Transaction Processing database, and you can build your own app connecting to the database.

## Task 5: Clean Up

1. To undeploy, and terminate the Autonomous Transaction Processing instance, delete the Kubernetes instances with:

    ```bash
    <copy>
    kubectl delete -f ./atp
    </copy>
    ```

    Clean up is done asynchronously, and the Autonomous Transaction Processing database will be de-provisioned after a few minutes.

## Acknowledgements

 - **Author** - Emmanuel Leroy, January 2021
 - **Last Updated By/Date** - Emmanuel Leroy, January 2021
