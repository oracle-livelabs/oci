# Deploy Digital Twin Simulation Model
The digital twin model is a docker image including all necessary components. It runs on OCI OKE platform. So, the digital twin environmnet is scalable. We can run tens, hundreds of them to analyse root causes and simulate the a specific peformance.


## Introduction
In this session, we will deploy MapleSim Digital Twin simulation model on OCI OKE using Kubectl

*Estimated Time*: 20 minutes

### Objectives
Deploly the model to OKE

###Task 1 Configure OKE access in cloud shell
OCI cloud shell is a web browser-based terminal accessible from the Oracle Cloud Console. It provides access to a Linux shell, with a pre-authenticated Oracle Cloud Infrastructure CLI, kubenets ctl etc.
1. Click the "Cloud Shell" icon to open the cloud shell. 
![Cloud Shell](./images/cloud-shell.png " ")

2. Click "Access Cluster" to pop up the "Access Your cluster" window. Click "Cloud Shell Access" and click copy in the 

![Access Cluster](./images/access-cluster " ")

3. Run OCI command in cloud shell

![Kubernetes Config](./images/cloud-console-kube.png " ")

###Task 2 Deploy the service to OKE

1. Copy the deployment file from github.
The deployment file is under [file folder](https://github.com/tonyora/oci/blob/main/digital-twin/02-deploy-digitaltwin-simulation/file/digitaltwin.yaml)

open the file and copy the content
![Deployment Content](./images/deployment-file.png " ")

2. Create the deployment file. 
Use command "touch deployment.yaml" to create the deploymnet.yaml file
![Create Deployment](./images/create-deployment.png" ")


3. Use vi to save deployment file
Use command "vi deployment.yaml" open the newly created deploymnet file, copy the copied content
![Edit Deployment](./images/edit-deployment.png)

4. deploy the application to OKE. 
On the cloud shell console, run the following command to deploy the application.
kubectl apply -f deployment.yaml 
![!Kube Apply](./images/kube-apply.png " ")

5. Get the public IP address
The deploymnet may take a few minutes to finish. We can run the kubectl command to get the result.
kubectl get all
![View IP Address](./images/view-kubenetes.png " ")

The public IP address is 144.24.42.157 for reference. We will use it to access it in other labs.
