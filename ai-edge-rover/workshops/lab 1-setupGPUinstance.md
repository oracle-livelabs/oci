# Creating your GPU VM instance using the Oracle Roving Edge Device

## Introduction

The Oracle Roving Edge Device supports both Fixed VM as well as GPU shape which users can provision using the RED.2 console, OCI CLI or Terraform scripts. For the purpose of this demonstration, the underlying assumptions are:

- User has an OCI Account and access to a tenancy 
- User has already installed all the required OCI CLI and stored their public and private keys to connect to the tenancy
- User has subscribed to the Oracle Roving Edge device and has completed the setup with their OCI tenancy

In the following workshop, we will be using the Customer Enclave of the Roving Edge Device to provision a VM based off the VM.GPU.1.RED1.4 GPU shape and will be using the Ubuntu guest operating system to spin-up the VM. 

### Step 1: Login to RED using the UI Console

![Login to Console](/ai-edge-rover/images/1_redlogin.png)

### Step 2: Create a GPU instance using the UI Console

![Create GPU Instance](/ai-edge-rover/images/2_create_compute_instance.png)

### Step 3: Provisioning the Compute Instance
![Provisioning Instance](/ai-edge-rover/images/3_vm_provisioning.png)

![Instance Details](/ai-edge-rover/images/4_vm_running.png)

### Step 4: Login to the VM instance that you have created
![Logging into Instance](/ai-edge-rover/images/5_vm_login.png)

Once you have the VM provisioned and you can access the image using your local console, you can proceed to the next steps. 
