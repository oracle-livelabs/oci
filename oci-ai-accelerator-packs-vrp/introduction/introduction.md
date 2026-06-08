# Introduction

## About this Workshop

NVIDIA cuOpt solves vehicle routing problems on a GPU.
A single Resource Manager stack provisions the whole bundle.
The bundle ships the solver, a React front-end, and a FastAPI backend.
It also bundles a JWT auth service, an OKE cluster, an ingress and TLS stack, Prometheus, and Grafana.

In this workshop you connect to a running pack and exercise each service.
You run a cuOpt solve from the UI and again from a Python client.
You modify the front-end, push the new image to OCI Container Registry, and patch the cluster.
You add a small Prometheus exporter for cuOpt and chart its output in Grafana.

Estimated Workshop Time: 3 hours 30 minutes.

### About the cuOpt Accelerator Pack

The pack builds these pieces on Oracle Cloud Infrastructure.

- A regional VCN with subnets for the API endpoint, worker nodes, load balancers, pods, and services.
- An OKE cluster with a control plane and a GPU node pool sized for cuOpt.
- The NVIDIA cuOpt NIM that runs on the GPU node pool.
- The cuOpt EV Routing front-end (React, Vite, Nginx) and the FastAPI backend.
- The auth service that mints HS256 JWTs and guards every `/api/*` route.
- Ingress-nginx, cert-manager for TLS certs, Prometheus, Grafana, and the NVIDIA DCGM exporter.
- The OCI AI Blueprints (Corrino) portal that manages the workloads.

### Workshop Tracks

This workshop ships in two tracks.

- **Live**, where the pack already runs and you skip the build-out steps.
- **At Home**, where you build the pack in your own tenancy from scratch.

The lab list is the same in both tracks.
Each lab notes whether it applies only to the At Home track.

### Objectives

In this workshop, you will:

- Connect to an OKE cluster from the OCI CLI and `kubectl`.
- Find pack services from the stack outputs and the OCI AI Blueprints portal.
- Run a cuOpt solve from the UI and from a Python client.
- Sign in to the auth service and call protected backend routes.
- Modify the front-end, build a fresh image, and push it to OCI Container Registry.
- Patch a Kubernetes Deployment to roll out the new image.
- Ship a sidecar exporter and chart its metrics in Grafana.

### Prerequisites

This workshop assumes:

- Comfort with Linux shells and basic Kubernetes objects (Pod, Deployment, Service, Ingress).
- For the At Home track, an OCI tenancy with GPU limits.
- An NVIDIA NGC API key and a laptop that runs Docker.
- For the Live track, a laptop that runs the OCI CLI, `kubectl`, Python 3.10 or newer, and `curl`.

You may now proceed to the next lab.

## Acknowledgements

* **Author** - Dennis Kennetz, OCI AI Accelerator Program.
* **Last Updated By/Date** - Dennis Kennetz, May 2026.
