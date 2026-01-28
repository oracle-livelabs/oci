# Configure Storage Classes

## Introduction

In this lab, you will configure Ceph storage classes to provide different types of storage to your applications. Rook-Ceph supports three storage types: Block Storage (RBD), Shared File System (CephFS), and Object Storage (S3/Swift compatible).

Estimated Time: 20 minutes

### Objectives

In this lab, you will:

- Create a CephBlockPool and Block Storage Class
- Create a CephFilesystem and File System Storage Class
- Create a CephObjectStore for S3-compatible object storage
- Verify storage class availability

### Prerequisites

This lab assumes you have:

- Completed the previous lab (Deploy Rook-Ceph)
- A healthy Ceph cluster (`HEALTH_OK`)
- kubectl access to the OKE cluster

## Task 1: Create Block Storage (RBD)

Block storage provides persistent volumes that can be mounted by a single pod (ReadWriteOnce). This is ideal for databases and stateful applications.

1. Review the CephBlockPool configuration:

   Download the file [ceph-block-pool.yaml](./files/ceph-block-pool.yaml). The file `ceph-block-pool.yaml` contains the block pool and storage class definition. Key settings include:
   - `replicated.size: 3`: Data is replicated across 3 OSDs
   - `failureDomain: host`: Each replica on a different host
   - `allowVolumeExpansion: true`: Volumes can be resized

2. Create the block pool and storage class:

    ```bash
    <copy>
    kubectl apply -f ceph-block-pool.yaml
    </copy>
    ```

3. Verify the block pool was created:

    ```bash
    <copy>
    kubectl get cephblockpool -n rook-ceph
    </copy>
    ```

   Expected output:

    ```text
    NAME          PHASE
    replicapool   Ready
    ```

4. Verify the storage class:

    ```bash
    <copy>
    kubectl get storageclass rook-ceph-block
    </copy>
    ```

   Expected output:

    ```text
    NAME              PROVISIONER                  RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION
    rook-ceph-block   rook-ceph.rbd.csi.ceph.com   Delete          Immediate           true
    ```

5. Check the pool status in Ceph:

    ```bash
    <copy>
    kubectl exec -it deploy/rook-ceph-tools -n rook-ceph -- ceph osd pool ls detail
    </copy>
    ```

## Task 2: Create Shared File System (CephFS)

CephFS provides shared file system storage that can be mounted by multiple pods simultaneously (ReadWriteMany). This is ideal for shared data, web content, and applications requiring shared storage.

1. Download the [ceph-filesystem.yaml](./files/ceph-filesystem.yaml) and review the CephFilesystem configuration 

2. Create the CephFS filesystem and storage class:

    ```bash
    <copy>
    kubectl apply -f ceph-filesystem.yaml
    </copy>
    ```

3. Wait for the MDS (Metadata Server) pods to be ready:

    ```bash
    <copy>
    kubectl get pods -n rook-ceph -l app=rook-ceph-mds -w
    </copy>
    ```

   Wait until you see active MDS pods:

    ```text
    NAME                                    READY   STATUS    RESTARTS   AGE
    rook-ceph-mds-myfs-a-xxxxxxxxx-xxxxx    2/2     Running   0          2m
    rook-ceph-mds-myfs-b-xxxxxxxxx-xxxxx    2/2     Running   0          2m
    ```

4. Verify the filesystem:

    ```bash
    <copy>
    kubectl get cephfilesystem -n rook-ceph
    </copy>
    ```

   Expected output:

    ```text
    NAME   ACTIVEMDS   AGE   PHASE
    myfs   1           2m    Ready
    ```

5. Verify the CephFS storage class:

    ```bash
    <copy>
    kubectl get storageclass rook-cephfs
    </copy>
    ```

6. Check filesystem status in Ceph:

    ```bash
    <copy>
    kubectl exec -it deploy/rook-ceph-tools -n rook-ceph -- ceph fs status
    </copy>
    ```

   Expected output:

    ```text
    myfs - 0 clients
    ====
    RANK  STATE           MDS             ACTIVITY     DNS    INOS   DIRS   CAPS
     0    active  myfs-a  Reqs:    0 /s     10      13     12      0
         POOL           TYPE     USED  AVAIL
    myfs-metadata  metadata  96.0k   141G
    myfs-replicated  data       0    141G
    STANDBY MDS
    myfs-b
    ```

## Task 3: Create Object Storage (S3-Compatible)

Object storage provides S3-compatible access for storing and retrieving data using standard S3 APIs.

1. Download and review the CephObjectStore configuration in [ceph-object-store.yaml](./files/ceph-object-store.yaml)

2. Create the object store:

    ```bash
    <copy>
    kubectl apply -f ceph-object-store.yaml
    </copy>
    ```

3. Wait for the RGW (RADOS Gateway) pod to be ready:

    ```bash
    <copy>
    kubectl get pods -n rook-ceph -l app=rook-ceph-rgw -w
    </copy>
    ```

   Expected output:

    ```text
    NAME                                        READY   STATUS    RESTARTS   AGE
    rook-ceph-rgw-my-store-a-xxxxxxxxx-xxxxx    2/2     Running   0          2m
    ```

4. Verify the object store:

    ```bash
    <copy>
    kubectl get cephobjectstore -n rook-ceph
    </copy>
    ```

   Expected output:

    ```text
    NAME       PHASE
    my-store   Ready
    ```

5. Get the object store endpoint:

    ```bash
    <copy>
    kubectl get svc -n rook-ceph rook-ceph-rgw-my-store
    </copy>
    ```

   Note the ClusterIP and port for internal access.

6. Create an Object Store User for S3 access:

    ```bash
    <copy>
    cat <<EOF | kubectl apply -f -
    apiVersion: ceph.rook.io/v1
    kind: CephObjectStoreUser
    metadata:
      name: my-user
      namespace: rook-ceph
    spec:
      store: my-store
      displayName: "My S3 User"
    EOF
    </copy>
    ```

7. Retrieve the S3 credentials:

    ```bash
    <copy>
    echo "Access Key: $(kubectl get secret rook-ceph-object-user-my-store-my-user -n rook-ceph -o jsonpath='{.data.AccessKey}' | base64 --decode)"
    echo "Secret Key: $(kubectl get secret rook-ceph-object-user-my-store-my-user -n rook-ceph -o jsonpath='{.data.SecretKey}' | base64 --decode)"
    </copy>
    ```

   Save these credentials for later use.

## Task 4: Verify All Storage Classes

1. List all available storage classes:

    ```bash
    <copy>
    kubectl get storageclass
    </copy>
    ```

   Expected output:

    ```text
    NAME                PROVISIONER                     RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION
    oci-bv              blockvolume.csi.oraclecloud.com Delete          WaitForFirstConsumer   true
    rook-ceph-block     rook-ceph.rbd.csi.ceph.com      Delete          Immediate              true
    rook-cephfs         rook-ceph.cephfs.csi.ceph.com   Delete          Immediate              true
    rook-ceph-bucket    rook-ceph.ceph.rook.io/bucket   Delete          Immediate              false
    ```

2. View the complete Ceph cluster status:

    ```bash
    <copy>
    kubectl exec -it deploy/rook-ceph-tools -n rook-ceph -- ceph status
    </copy>
    ```

   Expected output showing all services:

    ```text
    cluster:
      id:     a1b2c3d4-e5f6-7890-abcd-ef1234567890
      health: HEALTH_OK

    services:
      mon: 3 daemons, quorum a,b,c (age 30m)
      mgr: a(active, since 29m)
      mds: 1/1 daemons up, 1 standby
      osd: 3 osds: 3 up (since 28m), 3 in (since 28m)
      rgw: 1 daemon active (1 hosts, 1 zones)

    data:
      volumes: 1/1 healthy
      pools:   9 pools, 97 pgs
      objects: 200 objects, 5.5 KiB
      usage:   3.1 GiB used, 147 GiB / 150 GiB avail
      pgs:     97 active+clean
    ```

You may now **proceed to the next lab**.

## Learn More

- [Ceph Block Storage](https://rook.io/docs/rook/latest/Storage-Configuration/Block-Storage-RBD/block-storage/)
- [Ceph Filesystem](https://rook.io/docs/rook/latest/Storage-Configuration/Shared-Filesystem-CephFS/filesystem-storage/)
- [Ceph Object Storage](https://rook.io/docs/rook/latest/Storage-Configuration/Object-Storage-RGW/object-storage/)
- [Kubernetes Storage Classes](https://kubernetes.io/docs/concepts/storage/storage-classes/)

## Acknowledgements

* **Author** - Dragos Nicu, Cloud Infrastructure Engineer
* **Last Updated By/Date** - Dragos Nicu, January 2026
