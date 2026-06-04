# Workshop Details

## Short Summary

Deploy and extend an NVIDIA cuOpt route solver on Oracle Kubernetes Engine.

## Long Summary

NVIDIA cuOpt solves vehicle routing problems on a GPU.
Oracle Cloud Infrastructure ships a starter pack as a single stack.
The stack builds the cluster, the cuOpt NIM, the front-end, the FastAPI backend, the auth service, Prometheus, and Grafana.
You can apply the stack from the OCI Console in under an hour.

In this workshop you connect to a running pack and exercise each service.
You run a cuOpt solve from the browser and again from a Python client.
You modify the React front-end, build a new image, push it to OCI Container Registry, and patch the cluster.
You add a small Prometheus exporter for cuOpt and chart its output in Grafana.

The Live track skips the steps that need to run in your tenancy.
The At Home track walks through every step from a fresh tenancy.

## Note for self
Images need to be 1280 pixels x 1280 pixels
Replace "from your laptop, to cloudshell"

## Workshop Outline

1. [Introduction](introduction/introduction.md).
2. [Lab 1, Deploy the cuOpt Accelerator Pack](deploy-pack/deploy-pack.md) (tenancy).
3. [Lab 2, Explore Pack Services](explore-services/explore-services.md).
4. [Lab 3, Connect to Your OKE Cluster](connect-cluster/connect-cluster.md).
5. [Lab 4, Submit an Optimization Job from the UI](submit-ui-job/submit-ui-job.md).

## Optional
6. [Lab 5, Submit Jobs Directly to the cuOpt API](python-api/python-api.md).

## Workshop Prerequisites

- An OCI tenancy with GPU service limits for the cuOpt pack (At Home only).
- Access to cloud shell that can run Python 3.10 or newer, kubectl, and the OCI CLI.
- Comfort with Linux shells, REST, and basic Kubernetes objects.

## Notes

- Keep this file aligned with the final manifest and lab titles.
- The Live track maps to the `sandbox` variant.
- The At Home track maps to the `tenancy` variant.

Estimated Time: 3 hours 30 minutes.

## Acknowledgements

* **Author** - Dennis Kennetz, OCI AI Accelerator Program.
* **Last Updated By/Date** - Dennis Kennetz, May 2026.
