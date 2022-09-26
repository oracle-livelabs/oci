# Deploy Digital Twin Simulation Model
The digital twin model is a `docker` image including all necessary components. It runs on the OKE (Oracle Kubernetes Engine) platform. By leveraging OKE, the digital twin environment can be easily scaled to meet workload demands cost-effectively, with high availability that comes with a load balancing implementation that we will use. We can run tens, hundreds of them to analyse root causes and simulate the a specific peformance.


## Introduction
In this session, we will deploy MapleSim Digital Twin simulation model on OKE using `kubectl`.

*Estimated Time*: 20 minutes

### Objectives
Deploly the model to OKE.

## Task 1 Configure OKE access in Cloud Shell
OCI Cloud Shell is a web browser-based terminal accessible from the Oracle Cloud Console. It provides access to a Linux shell, with a pre-authenticated Oracle Cloud Infrastructure CLI (OCI-CLI), `kubectl`, docker, and other useful command-line tools.
1. Click the `Cloud Shell` icon to open the Cloud Shell.

![Cloud Shell](./images/cloud-shell.png " ")

2. Click `Access Cluster` to pop up the `Access Your cluster` window. Click `Cloud Shell Access` and click copy in the menu bar.

![Access Cluster](./images/access-cluster.png)

3. Run the following OCI-CLI command in Cloud Shell:

![Kubernetes Config](./images/cloud-console-kube.png)

## Task 2 Deploy the service to OKE

1. Copy the deployment file for your Kubernetes cluster configuration, which can be accessed [here](https://github.com/tonyora/oci/blob/main/digital-twin/02-deploy-digitaltwin-simulation/file/digitaltwin.yaml).

Open the file and copy the content:

![Deployment Content](./images/deployment-file.png)

2. Open a deployment file with `vi deployment.yaml`, then enter insert-mode by pressing `i`, and paste the content from your clipboard into the `vi` editor. Then press `ESC` to escape from insert-mode, followed by `:wq` to write, i.e. save, and quit from the `vi` editor.

![Edit Deployment](./images/edit-deployment.png)

3. Deploy the application to OKE. 
On the Cloud Shell console, run the following command to deploy the application.

`kubectl apply -f deployment.yaml`

![!Kube Apply](./images/kube-apply.png)

4. Get the public IP address
The deployment may take a few minutes to finish. We can run the following `kubectl` command to monitor the progress of the deployment of your Kubernetes cluster configuration:

`kubectl get all`

![View IP Address](./images/view-kubenetes.png)

Make a note of the public IP address that corresponds to the Kubernetes service of type `LoadBalancer`, under `EXTERNAL-IP`. In this case, the public IP address is `144.24.42.157` for reference. You will use the public IP address of the Load Balancer to access your application later on in this workshop.

## Task 3 Generate the training data
1. Create the fleet
2. Validate the fleet created 
3. Generate and upload the training set to object storage
4. Validate the generated training set