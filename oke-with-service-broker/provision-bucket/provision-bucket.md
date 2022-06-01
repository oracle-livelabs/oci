# Provision an OCI Object Storage Bucket for Loading Files with Kubernetes

## Introduction

You will use the Oracle Cloud Infrastructure (OCI) Service Broker to manage the lifecycle of an Object Storage bucket, using Kubernetes.

Note that the OCI Service Broker allows you to create a bucket and add files to the bucket via a pre-authorized request (PAR), which processes PUT requests only. In order to read, or delete files, you'll need to use the SDK with proper user credentials.

Estimated Time: 10 minutes.

### Objectives

- Configure an Object Storage Bucket instance and binding to deploy on Kubernetes.
- Use `kubectl` to deploy the instance and provision the bucket.
- See an example usage.
- Tear down the bucket instance.

## Task 1: Get the Template Manifests for Object Storage

1. Download the example templates:

    ```bash
    <copy>
    mkdir -p object_storage
    pushd object_storage
    curl -o create-bucket.yaml https://raw.githubusercontent.com/oracle/oci-service-broker/master/charts/oci-service-broker/samples/objectstore/create-bucket.yaml
    curl -o pre-auth.yaml https://raw.githubusercontent.com/oracle/oci-service-broker/master/charts/oci-service-broker/samples/objectstore/pre-auth.yaml
    popd
    </copy>
    ```

2. How it works:

    - `create-bucket.yaml` defines a bucket instance to be created.

    - `pre-auth.yaml` creates a binding to retrieve a pre-authorization request providing access to the bucket without credentials.

    - OCI Service Broker will then create a secret named `test-bucket-binding` containing the pre-authorized request endpoint to access the bucket in read and write mode.


## Task 2: Edit the Manifests

1. Edit `create-bucket.yaml` and replace `CHANGE_COMPARTMENT_OCID_HERE` with the **compartment OCID** of the compartment where you deployed the OKE cluster, and replace `CHANGE_NAMESPACE_HERE` with the name of the namespace of your OCI tenancy (not to be confused with the Kubernetes namespace).

     You can find this information with the CLI using the command:

    ```bash
    <copy>
    oci os ns get
    </copy>
    ```

    It returns:

    ```json
    {
    "data": "YOUR_TENANCY_NAMESPACE"
    }
    ```


    > **Note:** The bucket name needs to be unique across the OCI compartment, even if you deploy on different Kubernetes namespaces.

    If you're running this as part of a workshop with multiple users, make sure you modify the name of the bucket to make it unique by replacing the name `testbucket` with your unique name both in the `create-bucket.yaml` and `pre-auth.yaml` files.

## Task 3: Deploy

1. To deploy the mainfest, use:

    ```bash
    <copy>
    kubectl apply -f ./object_storage
    </copy>
    ```

    This will deploy all the manifests in the `object_storage` folder in the `default` Kubernetes namespace defined in the file.

## Task 4: Check the Deployment

1. Verify the database instance is being provisioned:

    ```bash
    <copy>
    kubectl get all -n default
    </copy>
    ```

    This should list the following:

    ```
    NAME                                               CLASS                                      PLAN       STATUS   AGE
    serviceinstance.servicecatalog.k8s.io/testbucket   ClusterServiceClass/object-store-service   standard   Ready    35m

    NAME                                                       SERVICE-INSTANCE   SECRET-NAME           STATUS   AGE
    servicebinding.servicecatalog.k8s.io/test-bucket-binding   testbucket         test-bucket-binding   Ready    35m
    ```


2. Verify that the `test-bucket-binding` secret was created in the namespace `default`:

    ```bash
    <copy>
    kubectl get secrets -n default
    </copy>
    ```

    This command should list `test-bucket-binding`.

    You can also check in the Oracle Cloud Console Console by selecting **Core**, and then selecting **Object Storage** in the compartment where you provisioned. You should see the bucket named `testbucket` (or the unique name you gave it).

## Task 5: Look at the Content of the Secret

1. You can look at the content of the secret by running:

    ```bash
    <copy>
    kubectl get secret test-bucket-binding -n default -o yaml
    </copy>
    ```

    It should return:

    ```yaml
    apiVersion: v1
    data:
    preAuthAccessUri: L3AvcXVoMGhTY205a0ltREhnRFZJZXZ4R3lnTzZOdWVjZ1lyZVQ5dDF5dTF5RjJrSFVzS1hzNkdvQzJaczJodS1OUy9uL3lvdV90ZW5hbmN5X25hbWVzcGFjZS9iL3Rlc3RidWNrZXQvby8K
    kind: Secret
    metadata:
    creationTimestamp: "2021-01-08T22:22:53Z"
    managedFields:
    - apiVersion: v1
        fieldsType: FieldsV1
        fieldsV1:
        f:data:
            .: {}
            f:preAuthAccessUri: {}
        f:metadata:
            f:ownerReferences:
            .: {}
            k:{"uid":"3fa4536d-fb83-4ad2-9d0b-d172a7875828"}:
                .: {}
                f:apiVersion: {}
                f:blockOwnerDeletion: {}
                f:controller: {}
                f:kind: {}
                f:name: {}
                f:uid: {}
        f:type: {}
        manager: service-catalog
        operation: Update
        time: "2021-01-08T22:22:53Z"
    name: test-bucket-binding
    namespace: default
    ownerReferences:
    - apiVersion: servicecatalog.k8s.io/v1beta1
        blockOwnerDeletion: true
        controller: true
        kind: ServiceBinding
        name: test-bucket-binding
        uid: 3fa4536d-fb83-4ad2-9d0b-d172a7875828
    resourceVersion: "47363"
    selfLink: /api/v1/namespaces/default/secrets/test-bucket-binding
    uid: 597286c2-0969-4f46-ace9-1f84d2460a30
    type: Opaque
    ```

2. The content of the secret is the `preAuthAccessUri` field, which is base64 encoded.

    When mounting the secret as a variable in a pod, this value will be decoded for you.

    To observe the decoded content of the field, you can use:

    ```bash
    echo <field content> | base64 -d
    ```

    For example:

    ```bash
    echo L3AvcXVoMGhTY205a0ltREhnRFZJZXZ4R3lnTzZOdWVjZ1lyZVQ5dDF5dTF5RjJrSFVzS1hzNkdvQzJaczJodS1OUy9uL3lvdV90ZW5hbmN5X25hbWVzcGFjZS9iL3Rlc3RidWNrZXQvby8K | base64 -d
    ```

    That returns:

    ```bash
    /p/quh0hScm9kImDHgDVIevxGygO6NuecgYreT9t1yu1yF2kHUsKXs6GoC2Zs2hu-NS/n/you_tenancy_namespace/b/testbucket/o/
    ```

    Note that this is the endpoint without the region namespace. You will need to prefix it with the regional endpoint to reach the bucket, for example:

    ```
    https://objectstorage.us-ashburn-1.oraclecloud.com/
    ```

## Task 6: Example Usage

1. To mount the secret into a pod, use an environment variable like:

    ```yaml
    env:
    - name: BUCKET_PAR
      valueFrom:
        secretKeyRef:
            name: test-bucket-binding
            key: preAuthAccessUri
    ```

2. A full example deployment with the nginx image as base would be like:

    ```yaml
    <copy>
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: object-storage-demo
      namespace: default
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: object-storage-demo
      template:
        metadata:
          labels:
            app: object-storage-demo
        spec:
          containers:
          # User application that uses the PAR to access the bucket.
          - name: app
            image: nginx
            env:
            - name: BUCKET_PAR
              valueFrom:
                secretKeyRef:
                  name: test-bucket-binding
                  key: preAuthAccessUri
            # build the full URI from the PAR
            - name: BUCKET_URI
              value: https://objectstorage.us-ashburn-1.oraclecloud.com$(BUCKET_PAR)
    </copy>
    ```

3. Create a new file, named `object-storage-demo-app.yaml`, and paste the content above into the file.

4. Deploy the manifest with:

    ```bash
    <copy>
    kubectl -apply -f object-storage-demo-app.yaml
    </copy>
    ```

5. Verify the URI was properly defined by getting a shell into the pod.

    ```bash
    <copy>
    kubectl get pods -n default
    </copy>
    ```

    Get the `object-storage-demo` pod name then:

      ```bash
      kubectl exec -it <pod_name> -n default -- /bin/bash
      ```

    At the shell prompt inside the container, check the environment variables with:

      ```bash
      <copy>
      env | grep BUCKET
      </copy>
      ```

    It should return something like:

    ```bash
    BUCKET_URI=https://objectstorage.us-ashburn-1.oraclecloud.com/p/quh0hScm9kImDHgDVIevxGygO6NuecgYreT9t1yu1yF2kHUsKXs6GoC2Zs2hu-NS/n/your_tenancy_namespace/b/testbucket/o/
    BUCKET_PAR=/p/quh0hScm9kImDHgDVIevxGygO6NuecgYreT9t1yu1yF2kHUsKXs6GoC2Zs2hu-NS/n/your_tenancy_namespace/b/testbucket/o/
    ```

6. Put something in the bucket:

    ```bash
    <copy>
    # Create a file with some content
    echo "Hello My Bucket" > hello.txt
    # put the object into the bucket with curl
    curl -X PUT --data-binary '@hello.txt' ${BUCKET_URI}hello.txt
    </copy>
    ```

7. In the Oracle Cloud Console, check that the object was created in the bucket.

## Task 7: Clean Up

1. Delete the content of the bucket.

    > **Note:** Buckets must be empty before attempting to delete them.

    If you fail to clean up the bucket, the attempt to deprovision the bucket will fail. Note, however, that the pre-authorized request, which gives you write access to the bucket, does not allow listing or deleting objects, so this needs to be done with the CLI or through the OCI console.

2. To undeploy, and delete the storage bucket instance, delete the Kubernetes instances.

    ```bash
    <copy>
    kubectl delete -f ./object_storage
    </copy>
    ```

## Acknowledgements

 - **Author** - Emmanuel Leroy, January 2021
 - **Last Updated By/Date** - Emmanuel Leroy, January 2021
