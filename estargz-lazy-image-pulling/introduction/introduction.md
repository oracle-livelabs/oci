# Introduction

## About this Workshop

eStargz is a lazy container image format that lets a container start before the full image is downloaded by fetching filesystem data on demand. This workshop uses an Oracle Linux VM on OCI to compare regular image startup against eStargz startup using containerd, nerdctl, and stargz-snapshotter.

The goal is to make the benchmark simple, defensible, and focused on the real benefit of eStargz: faster time to first container start.

Estimated Workshop Time: 1 hour 45 minutes

### Objectives

By the end of this workshop, you will:

* Understand what eStargz changes in container startup behavior.
* Use automation to provision a benchmark VM and configure containerd for stargz.
* Create an eStargz image from a regular image and push both images to OCIR for benchmarking.
* Run startup benchmarks for both regular and eStargz images.
* Interpret results and explain why `nerdctl run` is the right measurement for eStargz.

### **Prerequisites**

This lab assumes you have:

* An Oracle Cloud account
* Access to an OCI tenancy and compartment
* A local SSH key for OCI VM access
* Basic familiarity with Linux shell commands
* Access to a public container image source (for pulling a regular image) and OCIR permissions so you can convert the image locally, create eStargz, and push both images for the benchmark

### Learn More

* [Oracle Cloud Infrastructure](https://docs.oracle.com/en-us/iaas/Content/home.htm)
* [OCI Container Registry Documentation](https://docs.oracle.com/en-us/iaas/Content/Registry/home.htm)
* [containerd Documentation](https://containerd.io/docs/)
* [stargz-snapshotter Project](https://github.com/containerd/stargz-snapshotter)

You may now proceed to the next lab.


## Acknowledgements

* **Author** - **Adina Nicolescu**, Senior Cloud Engineer, NACIE
* **Last Updated By/Date** - Adina Nicolescu, June 2026
