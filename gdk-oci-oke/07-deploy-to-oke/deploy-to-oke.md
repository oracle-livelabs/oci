# Deploy the application to OKE

## Introduction

This lab provides instructions to deploy the application to OKE.

Estimated Lab Time: 05 minutes

### Objectives

In this lab, you will:

* Configure access to your OKE cluster
* Deploy the application to the OKE cluster

## Task 1: Configure access to your OKE cluster

1. In the same terminal in VS Code, run the command:

	```bash
	<copy>
	mkdir -p $HOME/.kube
	</copy>
	```

2. Generate the Kubernetes configuration for authentication to OKE:

	```bash
	<copy>
	   oci ce cluster create-kubeconfig \
      --cluster-id $OCI_CLUSTER_ID \
      --file $HOME/.kube/config \
      --region $OCI_REGION \
      --token-version 2.0.0 \
      --kube-endpoint PUBLIC_ENDPOINT
	</copy>
	```

3. Set the environment variable `KUBECONFIG` to the created config file, as shown below. This variable is used by `kubectl`.

	```bash
	<copy>
	export KUBECONFIG=$HOME/.kube/config
	</copy>
	```

4. Run the following command to check access to your OKE cluster.

	```bash
	<copy>
	kubectl cluster-info
	</copy>
	```

   The output should look like the following:

      ```txt
      Kubernetes control plane is running at https://<ip-address>:6443
      CoreDNS is running at https://<ip-address>:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

      To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
      ```

## Task 2:  Deploy the application to the OKE cluster

1. In the same terminal in VS Code, run the following command to create Kubernetes resources defined in _auth.yml_. The placeholders in the yml file will be substituted using environment variables.

	```bash
	<copy>
	envsubst < auth.yml | kubectl apply -f -
	</copy>
	```

2. Create a Kubernetes secret `ocirsecret` with your OCIR credentials using the following command. OKE uses this secret to authenticate to OCIR and pull the container image.

	```bash
	<copy>
	kubectl create secret docker-registry ocirsecret \
      --namespace=$K8S_NAMESPACE \
      --docker-server=$OCI_REGION.ocir.io \
      --docker-username=$OCIR_USERNAME \
      --docker-password=$AUTH_TOKEN
	</copy>
	```

3. Deploy the application on OKE using the following command. The placeholders in the yml file will be substituted using environment variables.

	```bash
	<copy>
	envsubst < k8s-oci.yml | kubectl apply -f -
	</copy>
	```

4. Run the following command to check the status of the Kubernetes pod and make sure that it has the status `Running`:

	```bash
	<copy>
	kubectl get pods -n=$K8S_NAMESPACE
	</copy>
	```

   The output should look like the following:

      ```txt
      NAME                   READY   STATUS    RESTARTS   AGE
      oci-7696b44fd5-xsdcj   1/1     Running   0          48s
      ```

5.  Run the following command to check the status of the Kubernetes service (maps to an OCI Load Balancer for this workshop):

	```bash
	<copy>
	kubectl get services -n=$K8S_NAMESPACE
	</copy>
	```

   The output should look like the following:

      ```txt
      NAME   TYPE           CLUSTER-IP    EXTERNAL-IP      PORT(S)             AGE
      oci    LoadBalancer   10.96.9.53    129.146.149.81   8080:31666/TCP      2m9s
      ```

   If the `EXTERNAL-IP` property of the service has a "pending" status, wait a few seconds and then run the command again. If the "pending" status persists for more than one minute, try the following:

      1. Verify that a Load Balancer was created:

         a. In the Oracle Cloud Console, open the navigation menu.

         b. Click **Networking**, and then click **Load balancers**.

         c. Click **Load balancer**.

         d. Ensure a Load Balancer has been created for your service in your workshop compartment.

      2. Check Load Balancer quota (if a Load Balancer was not created, you may have reached the quota limit):

         a. In the Oracle Cloud Console, open the navigation menu.

         b. Click **Governance & Administration**. Under **Tenancy Management**, click **Limits, Quotas and Usage**.

         c. Select the Load Balancer quota. If the quota limit has been reached, request a quota increase or delete unused Load Balancers.

Congratulations! In this section, you successfully deployed the application to OKE.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
