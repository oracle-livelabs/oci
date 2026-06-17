# Check Your Understanding

## Introduction

*Test what you learned about deploying NVIDIA NIM on Oracle Kubernetes Engine (OKE).*

Estimated Lab Time: 10 minutes

```quiz-config
passing: 75
badge: images/badge.png
```

## Quiz

Answer the questions below. When you score 75% or higher, you complete the quiz and unlock the badge for this lab.

```quiz score
Q: Why is Oracle Kubernetes Engine (OKE) a strong platform for running NVIDIA NIM microservices?
* It combines managed Kubernetes with GPU-capable infrastructure that helps you deploy and scale inference workloads.
- It replaces the need for container images and Helm charts.
- It removes the need for Kubernetes namespaces and services.
- It is only useful for storing model files and not for running inference.
> OKE gives you managed Kubernetes plus OCI GPU infrastructure, networking, and scaling features, which is why it fits production inference workloads well.

Q: In Lab 1, why were the worker nodes created with GPU-enabled shapes?
* NIM inference workloads need NVIDIA GPU resources to run the model efficiently.
- GPU shapes are only required for using kubectl commands in Cloud Shell.
- GPU shapes are needed only to create Kubernetes namespaces.
- GPU shapes are optional because NIM always runs the same way on CPU-only nodes.
> The workshop explains that NIM is intended to run on NVIDIA GPUs, so the cluster needs GPU-backed worker nodes for the model service.

Q: Why did the lab ask you to check for and remove the nvidia.com/gpu:NoSchedule taint if it was present?
* Because that taint can stop GPU workloads from being scheduled onto the nodes unless the workload tolerates it.
- Because removing the taint automatically installs Helm.
- Because the taint blocks the Kubernetes API server from starting.
- Because taints are required only for LoadBalancer services.
> A NoSchedule taint tells Kubernetes to avoid placing pods on a node unless the pod explicitly tolerates that taint, so removing it can allow your NIM workloads to land on the GPU nodes.

Q: Why is the NVIDIA GPU Operator installed before deploying the NIM microservice?
* It prepares and manages GPU resources in the cluster so the later NIM deployment can use them.
- It creates the external IP address used by curl.
- It replaces the need for an NVIDIA API key.
- It converts the cluster into a serverless environment.
> The GPU Operator handles GPU-related setup and management in Kubernetes, which lays the groundwork for the NIM deployment that comes later.

Q: Why does the workshop create both a docker-registry secret and a generic secret?
* One is used for pulling images from NGC, and the other provides API key values needed by the NIM configuration.
- One secret is for the control plane and the other is only for kubectl autocomplete.
- Both secrets do exactly the same thing, but Kubernetes requires duplicates.
- They are only needed for creating the LoadBalancer service.
> The workshop separates image-pull access from API-key access because those credentials are used in different parts of the deployment flow.

Q: What tells you the NIM deployment is ready to accept inference requests?
* The pod is running and the service has an external IP address you can send requests to.
- The namespace exists, even if no pods are running.
- Helm finishes adding the NVIDIA repository.
- The boot volume size was increased to 500 GB.
> A running pod shows the workload started correctly, and the external IP gives you the endpoint used by the curl requests in the final lab.
```

## Wrap Up

You have reviewed the key ideas from this workshop, from preparing the OKE cluster to deploying GPU and NIM operators, configuring secrets, and testing live inference requests.

## Learn More

- Review the Introduction and Labs 1 through 3 again if you want to revisit any of the setup steps before moving on.
