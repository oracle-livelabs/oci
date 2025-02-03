# Introduction

## About this Workshop

Generative AI inference using ARM-based CPUs has proven to be very effective, however we need more proof points to support this claim. Thus, we conducted extensive research to test popular open-source LLM models such as Llama 2, Mistral, and Orcas with Ampere Altra ARM-based CPUs on Oracle Cloud Infrastructure(OCI). 

Ampere A1 compute shapes provide flexible VM shapes and bare metal options across numerous regions with competitive pricing while providing flexibility in choosing CPU and memory. This allowed us to run various sized open-source LLM models and derive a conclusion from our hypothesis.

This guide will provide a thorough, step-by-step process for creating, provisioning, and deploying the necessary resources to access the lama.cpp, or an application of your choosing. 

Estimated Workshop Time: 90 minutes

### Objectives

In this workshop, you will learn how to:
* Configure the VCN, with required NSG rules that allow and open public traffic on port 8008 and 5005.
* Create a compute instance with Ampere A1 Flex Shape.
* Install docker runtime, configure minikube to use docker engine.
* Copy the container from Ampere GHCR repo to OCI Container Registry.
* Deploy a llama.cpp – serge container from Ampere – on minikube. 

### Prerequisites

This lab assumes you have:
* An Oracle account.
* Familiarity with Kubernetes and cloud native concepts of deployment and containerization is required.
* Some understanding of Linux shell commands.
* Familiarity with Oracle Cloud Infrastructure (OCI) components like OCI Compute, networking, OCIR.
* Basic familiarity with open-source tools like GIT and GitHub.

## Get Deployment Image from OCI Marketplace
- [OCI Marketplace Image](https://cloudmarketplace.oracle.com/marketplace/en_US/listing/169283589)

## Learn More

* [AI Datascience Blog](https://blogs.oracle.com/ai-and-datascience/post/democratizing-generative-ai-with-cpu-based-inference)


## Acknowledgements
* **Author** - Animesh Sahay and Francis Regalado, Enterprise Cloud Architect, OCI Cloud Venture
* **Contributors** - Andrew Lynch, Director Cloud Engineering, OCI Cloud Venture
* **Last Updated By/Date** - Animesh Sahay, August 2024
