# Run NVIDIA NIM Microservices on Oracle Kubernetes Engine (OKE)

## About this Workshop

*This lab walks you through a basic setup to deploy a Llama 3-based NIM on OKE. NVIDIA NIM microservices, when deployed on Oracle Kubernetes Engine (OKE), become a production-ready solution for Enterprise AI workloads, combining performance, portability, and flexibility in a fully containerized, GPU-accelerated architecture.*

Estimated Time: 90 minutes

## Run NVIDIA NIM Microservices on Oracle Kubernetes Engine (OKE)
**A Scalable Foundation for Enterprise-Grade LLM Inference**

As Large Language Models (LLMs) continue to evolve and drive a wave of
innovation, from copilots and chatbots to document summarization and
autonomous agents, one question keeps surfacing in engineering
conversations:

**“How do we run these models reliably, securely, and at scale?”**

One answer: **NVIDIA NIM microservices.** And when deployed on **Oracle
Kubernetes Engine (OKE)**, NIM microservices become a production-ready
solution for Enterprise AI workloads, combining performance,
portability, and flexibility in a fully containerized, GPU-accelerated
architecture.

This workshop explores:

- What are NVIDIA NIM microservices and why they matter

- Why OKE is an ideal platform for running them

- A step-by-step guide to deploying your first LLM inference endpoint
  with NIM on OKE

**What are NVIDIA NIM microservices?**

NIM are **prebuilt containers provided by NVIDIA** that simplify the
deployment of **AI foundation models** for real-time inference. Each NIM
exposes a standardized API and comes fully optimized for GPU
acceleration.

Each NIM microservice includes:

- A pre-configured, containerized runtime environment

- Optimized model weights and inference engine

- A REST API or gRPC interface for easy integration

- Support for various foundation models (Meta Llama, Mistral, etc.)

- Performance enhancements via NVIDIA TensorRT-LLM and other NVIDIA
  acceleration libraries

These are production-grade containers designed to minimize cold start
times, reduce overhead, and streamline enterprise AI deployments.

## Workshop Description

In this workshop, you will learn how to deploy and manage NVIDIA NIM containers on Oracle Container Engine for Kubernetes (OKE)  to run scalable, high-performance AI inference workloads with Llama3 today. This session is designed for developers and MLOps engineers who want to operationalize NVIDIA AI models using Kubernetes-native workflows on OCI.

This workshop is ideal for developers, data scientists, and DevOps practitioners interested in:

- Deploying NIM on Kubernetes: Learn how to orchestrate and scale NVIDIA NIM containers using OKE for efficient AI inference in production.
- Harnessing NVIDIA GPUs for optimal performance: Experience how OKE integrates with NVIDIA GPU nodes to accelerate inference with TensorRT-optimized NIMs.
- Streamlining MLOps: Automate deployment, scaling, and lifecycle management of AI models using Helm, kubectl, and OCI DevOps tools within a unified cloud environment.

What you will learn
By the end of this workshop, you will have hands-on experience with:

- Creating an NVIDIA API Key and pulling NIM containers
- Setting up an OKE cluster with GPU-enabled nodes
- Deploying NVIDIA NIM using Helm or kubectl
- Exposing NIM services securely for inference
- Sending inference requests and monitoring performance with OCI tools

## Resources to learn more

[Oracle Cloud Infrastructure
Documentation](https://docs.oracle.com/en-us/iaas/Content/home.htm)

[OKE Quickstart
Guide](https://docs.oracle.com/en-us/iaas/Content/ContEng/Tasks/contengcreatingclusterusingoke.htm)

Learn more about [NVIDIA NIM
Microservices](https://developer.nvidia.com/nim?sortBy=developer_learning_library%2Fsort%2Ffeatured_in.nim%3Adesc%2Ctitle%3Aasc&hitsPerPage=12)

[NVIDIA Developer
Program](https://developer.nvidia.com/developer-program)

[GitHub Sample: NIM on
OKE](https://github.com/NVIDIA/nim-deploy/tree/main/cloud-service-providers/oracle/oke)

[NVIDIA AI
Enterprise](https://cloudmarketplace.oracle.com/marketplace/en_US/listing/165234016)


## Acknowledgements

This lab is the result of a strategic and hands-on collaboration
between Oracle Cloud Infrastructure (OCI) and NVIDIA, two industry
leaders working together to accelerate enterprise AI innovation. By
combining OCI’s enterprise-grade infrastructure, the NVIDIA AI Platform,
and cutting-edge LLMs, we’re enabling customers to build, deploy, and
scale generative AI workloads with confidence and performance at the
core.

This workshop is part of a broader enablement initiative jointly developed
with our partners at NVIDIA.

A special thanks to the engineering teams at NVIDIA and OCI, whose deep
expertise and ongoing collaboration have been instrumental in supporting
our customers throughout their AI journey. Your contributions continue
to shape what’s possible.

- **Created By** -  Alejandro Casas OCI Product Marketing; Julien Lehmann, OCI Product Marketing
- **Contributors** - Dimitri Maltezakis Vathypetrou, NVIDIA Developer Relations; Anurag Kuppala, NVIDIA AI Solution Architect
- **Last Updated By/Date** - Dec 12th, Alejandro Casas, Julien Lehmann
