# Use Cases and Applications

## Introduction

In this lab, you will deploy sample applications that demonstrate the three main use cases for Rook-Ceph storage: block storage for databases, shared file systems for web content, and object storage for S3-compatible workloads.

Estimated Time: 20 minutes

### Objectives

In this lab, you will:

- Deploy a WordPress application using Block Storage
- Deploy a shared web application using CephFS
- Test S3-compatible Object Storage
- Monitor storage usage

### Prerequisites

This lab assumes you have:

- Completed the previous labs
- All storage classes created and ready
- A healthy Ceph cluster

## Task 1: Deploy WordPress with Block Storage

WordPress with MySQL demonstrates block storage usage for database workloads.

1. Create a namespace for the application:

    ```bash
    <copy>
    kubectl create namespace wordpress
    </copy>
    ```

2. Deploy MySQL using Ceph block storage:

    ```bash
    <copy>
    cat <<EOF | kubectl apply -f -
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: mysql-pvc
      namespace: wordpress
      labels:
        app: wordpress
    spec:
      storageClassName: rook-ceph-block
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: 10Gi
    ---
    apiVersion: v1
    kind: Secret
    metadata:
      name: mysql-secret
      namespace: wordpress
    type: Opaque
    stringData:
      password: "wordpress123"
    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: mysql
      namespace: wordpress
      labels:
        app: wordpress
    spec:
      selector:
        matchLabels:
          app: wordpress
          tier: mysql
      strategy:
        type: Recreate
      template:
        metadata:
          labels:
            app: wordpress
            tier: mysql
        spec:
          containers:
          - name: mysql
            image: mysql:8.0
            env:
            - name: MYSQL_ROOT_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: mysql-secret
                  key: password
            - name: MYSQL_DATABASE
              value: wordpress
            ports:
            - containerPort: 3306
              name: mysql
            volumeMounts:
            - name: mysql-persistent-storage
              mountPath: /var/lib/mysql
          volumes:
          - name: mysql-persistent-storage
            persistentVolumeClaim:
              claimName: mysql-pvc
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: mysql
      namespace: wordpress
      labels:
        app: wordpress
    spec:
      ports:
        - port: 3306
      selector:
        app: wordpress
        tier: mysql
    EOF
    </copy>
    ```

3. Deploy WordPress using Ceph block storage:

    ```bash
    <copy>
    cat <<EOF | kubectl apply -f -
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: wp-pvc
      namespace: wordpress
      labels:
        app: wordpress
    spec:
      storageClassName: rook-ceph-block
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: 5Gi
    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: wordpress
      namespace: wordpress
      labels:
        app: wordpress
    spec:
      selector:
        matchLabels:
          app: wordpress
          tier: frontend
      strategy:
        type: Recreate
      template:
        metadata:
          labels:
            app: wordpress
            tier: frontend
        spec:
          containers:
          - name: wordpress
            image: wordpress:6.4-apache
            env:
            - name: WORDPRESS_DB_HOST
              value: mysql
            - name: WORDPRESS_DB_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: mysql-secret
                  key: password
            - name: WORDPRESS_DB_NAME
              value: wordpress
            ports:
            - containerPort: 80
              name: wordpress
            volumeMounts:
            - name: wordpress-persistent-storage
              mountPath: /var/www/html
          volumes:
          - name: wordpress-persistent-storage
            persistentVolumeClaim:
              claimName: wp-pvc
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: wordpress
      namespace: wordpress
      labels:
        app: wordpress
    spec:
      type: LoadBalancer
      ports:
        - port: 80
      selector:
        app: wordpress
        tier: frontend
    EOF
    </copy>
    ```

4. Wait for the pods to be ready:

    ```bash
    <copy>
    kubectl get pods -n wordpress -w
    </copy>
    ```

5. Get the WordPress external URL:

    ```bash
    <copy>
    kubectl get svc wordpress -n wordpress
    </copy>
    ```

   Note the `EXTERNAL-IP`. Once available, access WordPress at `http://<EXTERNAL-IP>`

6. Verify the PVCs are bound:

    ```bash
    <copy>
    kubectl get pvc -n wordpress
    </copy>
    ```

   Expected output:

    ```text
    NAME        STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS      AGE
    mysql-pvc   Bound    pvc-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx   10Gi       RWO            rook-ceph-block   5m
    wp-pvc      Bound    pvc-yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy   5Gi        RWO            rook-ceph-block   5m
    ```

## Task 2: Deploy Shared Web Application with CephFS

Demonstrate shared file system storage with multiple pods accessing the same data.

1. Create a namespace:

    ```bash
    <copy>
    kubectl create namespace shared-web
    </copy>
    ```

2. Create a shared PVC using CephFS:

    ```bash
    <copy>
    cat <<EOF | kubectl apply -f -
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: shared-content
      namespace: shared-web
    spec:
      storageClassName: rook-cephfs
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 5Gi
    EOF
    </copy>
    ```

3. Deploy an init job to populate shared content:

    ```bash
    <copy>
    cat <<EOF | kubectl apply -f -
    apiVersion: batch/v1
    kind: Job
    metadata:
      name: content-init
      namespace: shared-web
    spec:
      template:
        spec:
          containers:
          - name: init
            image: busybox
            command:
              - /bin/sh
              - -c
              - |
                cat > /data/index.html << 'HTMLEOF'
                <!DOCTYPE html>
                <html>
                <head>
                    <title>Rook-Ceph CephFS Demo</title>
                    <style>
                        body { font-family: Arial, sans-serif; margin: 40px; background: #f5f5f5; }
                        .container { background: white; padding: 30px; border-radius: 10px; }
                        h1 { color: #333; }
                        .info { background: #e7f3ff; padding: 15px; border-radius: 5px; }
                    </style>
                </head>
                <body>
                    <div class="container">
                        <h1>Rook-Ceph CephFS Shared Storage</h1>
                        <div class="info">
                            <p><strong>Storage:</strong> CephFS (ReadWriteMany)</p>
                            <p><strong>This content is shared across all replicas!</strong></p>
                        </div>
                    </div>
                </body>
                </html>
                HTMLEOF
                echo "Content initialized!"
            volumeMounts:
            - name: shared-storage
              mountPath: /data
          restartPolicy: Never
          volumes:
          - name: shared-storage
            persistentVolumeClaim:
              claimName: shared-content
      backoffLimit: 4
    EOF
    </copy>
    ```

4. Wait for initialization:

    ```bash
    <copy>
    kubectl wait --for=condition=complete job/content-init -n shared-web --timeout=120s
    </copy>
    ```

5. Deploy multiple nginx replicas sharing the same storage:

    ```bash
    <copy>
    cat <<EOF | kubectl apply -f -
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: shared-nginx
      namespace: shared-web
    spec:
      replicas: 3
      selector:
        matchLabels:
          app: shared-nginx
      template:
        metadata:
          labels:
            app: shared-nginx
        spec:
          containers:
          - name: nginx
            image: nginx:alpine
            ports:
            - containerPort: 80
            volumeMounts:
            - name: shared-storage
              mountPath: /usr/share/nginx/html
          volumes:
          - name: shared-storage
            persistentVolumeClaim:
              claimName: shared-content
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: shared-nginx
      namespace: shared-web
    spec:
      type: LoadBalancer
      ports:
        - port: 80
      selector:
        app: shared-nginx
    EOF
    </copy>
    ```

6. Verify all replicas are running:

    ```bash
    <copy>
    kubectl get pods -n shared-web -o wide
    </copy>
    ```

   All three nginx pods should be running on different nodes but accessing the same PVC.

7. Get the service URL:

    ```bash
    <copy>
    kubectl get svc shared-nginx -n shared-web
    </copy>
    ```

   Access `http://<EXTERNAL-IP>` to see the shared content.

8. Verify shared access by updating content from any pod:

    ```bash
    <copy>
    # Update content from one pod
    kubectl exec -n shared-web deploy/shared-nginx -- sh -c 'echo "<p>Updated at $(date)</p>" >> /usr/share/nginx/html/index.html'
    
    # Verify all pods see the update
    for pod in $(kubectl get pods -n shared-web -l app=shared-nginx -o jsonpath='{.items[*].metadata.name}'); do
      echo "=== $pod ==="
      kubectl exec -n shared-web $pod -- tail -1 /usr/share/nginx/html/index.html
    done
    </copy>
    ```

## Task 3: Test S3-Compatible Object Storage

Test the S3-compatible object storage using the toolbox.

1. Enter the Rook toolbox:

    ```bash
    <copy>
    kubectl exec -it deploy/rook-ceph-tools -n rook-ceph -- bash
    </copy>
    ```

2. Set up S3 environment variables (inside toolbox):

    ```bash
    <copy>
    export AWS_HOST=$(kubectl get svc rook-ceph-rgw-my-store -n rook-ceph -o jsonpath='{.spec.clusterIP}')
    export AWS_ENDPOINT=http://${AWS_HOST}:80
    export AWS_ACCESS_KEY_ID=$(kubectl get secret rook-ceph-object-user-my-store-my-user -n rook-ceph -o jsonpath='{.data.AccessKey}' | base64 -d)
    export AWS_SECRET_ACCESS_KEY=$(kubectl get secret rook-ceph-object-user-my-store-my-user -n rook-ceph -o jsonpath='{.data.SecretKey}' | base64 -d)
    </copy>
    ```

3. Create a bucket:

    ```bash
    <copy>
    aws --endpoint-url ${AWS_ENDPOINT} s3 mb s3://my-first-bucket
    </copy>
    ```

4. Upload a test file:

    ```bash
    <copy>
    echo "Hello from Rook-Ceph Object Storage!" > /tmp/test.txt
    aws --endpoint-url ${AWS_ENDPOINT} s3 cp /tmp/test.txt s3://my-first-bucket/
    </copy>
    ```

5. List bucket contents:

    ```bash
    <copy>
    aws --endpoint-url ${AWS_ENDPOINT} s3 ls s3://my-first-bucket/
    </copy>
    ```

6. Download and verify:

    ```bash
    <copy>
    aws --endpoint-url ${AWS_ENDPOINT} s3 cp s3://my-first-bucket/test.txt /tmp/downloaded.txt
    cat /tmp/downloaded.txt
    </copy>
    ```

7. Exit the toolbox:

    ```bash
    <copy>
    exit
    </copy>
    ```

## Task 4: Monitor Storage Usage

1. Check overall Ceph usage:

    ```bash
    <copy>
    kubectl exec -it deploy/rook-ceph-tools -n rook-ceph -- ceph df
    </copy>
    ```

2. Check PV usage per namespace:

    ```bash
    <copy>
    kubectl get pv -o custom-columns='NAME:.metadata.name,CAPACITY:.spec.capacity.storage,CLAIM:.spec.claimRef.namespace/.spec.claimRef.name,STORAGECLASS:.spec.storageClassName'
    </copy>
    ```

3. View RBD images (block volumes):

    ```bash
    <copy>
    kubectl exec -it deploy/rook-ceph-tools -n rook-ceph -- rbd ls -p replicapool
    </copy>
    ```

4. Check CephFS usage:

    ```bash
    <copy>
    kubectl exec -it deploy/rook-ceph-tools -n rook-ceph -- ceph fs status myfs
    </copy>
    ```

5. View object storage buckets:

    ```bash
    <copy>
    kubectl exec -it deploy/rook-ceph-tools -n rook-ceph -- radosgw-admin bucket list
    </copy>
    ```

## Task 5: Access the Ceph Dashboard (Optional)

Rook can expose the Ceph Dashboard for visual monitoring.

1. Create a port-forward to access locally:

    ```bash
    <copy>
    kubectl port-forward svc/rook-ceph-mgr-dashboard -n rook-ceph 8443:8443 &
    </copy>
    ```

2. Get the admin password:

    ```bash
    <copy>
    kubectl get secret rook-ceph-dashboard-password -n rook-ceph -o jsonpath='{.data.password}' | base64 --decode && echo
    </copy>
    ```

3. Access `https://localhost:8443` with username `admin` and the retrieved password.

You may now **proceed to the next lab**.

## Learn More

- [WordPress on Kubernetes](https://kubernetes.io/docs/tutorials/stateful-application/mysql-wordpress-persistent-volume/)
- [CephFS Shared Filesystem](https://rook.io/docs/rook/latest/Storage-Configuration/Shared-Filesystem-CephFS/filesystem-storage/)
- [Ceph Object Gateway (RGW)](https://docs.ceph.com/en/latest/radosgw/)
- [Ceph Dashboard](https://rook.io/docs/rook/latest/Storage-Configuration/Monitoring/ceph-dashboard/)

## Acknowledgements

* **Author** - Dragos Nicu, Cloud Infrastructure Engineer
* **Last Updated By/Date** - Dragos Nicu, January 2026
