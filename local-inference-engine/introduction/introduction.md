# Introduction

## About this Workshop
Welcome to the NovaSystems Team! 🚀🚀 


NovaSystems is a leader in deep space exploration. With dozens of satellites already launched to support their research initiatives, the team is now preparing for its most ambitious mission yet: the first crewed deep-space voyage to Mars. As the spacecraft ventures farther from Earth, real-time communication with mission control will become increasingly limited. To overcome this challenge, NovaSystems has developed a locally running large language model (LLM) — a virtual mission expert designed to assist the crew by answering critical questions that would normally require input from ground control.

As NovaSystems' leading AI engineer, your task is to build and test a locally running large language model (LLM) capable of supporting the crew during deep-space operations. After evaluating various options, you’ve selected llama.cpp, paired with the latest Mistral 7B model, as the optimal solution due to its efficiency, local inference capability, and support for quantized (i.e. "compressed") models (which means lower-cost GPUs with less VRAM are a suitable option). 

Before deploying to physical flight hardware, you need to test this solution in a controlled environment. Since NovaSystems operates its infrastructure in Oracle Cloud Infrastructure (OCI) today, your testing will take place there.

Estimated Workshop Time: 60 minutes

### Objectives

In this workshop, you will learn how to:
* Provision an Ubuntu 24 compute instance with NVIDIA GPU acceleration in Oracle Cloud Infrastructure (OCI).
* Configure the instance in a public subnet and establish SSH access using OCI networking.
* Install and verify NVIDIA GPU drivers and CUDA Toolkit on the OCI instance.
* Build and configure llama.cpp with CUDA support for GPU inference on OCI.
* Download and run a quantized Mistral 7B LLM model on the OCI GPU instance.
* Perform basic and interactive AI inference tasks using the deployed model on OCI infrastructure.
* Monitor and interpret GPU utilization in real time using nvidia-smi.
* Identify the effects of GPU acceleration versus CPU offloading during inference on OCI GPU shapes.

### Prerequisites

This lab assumes you have:
* Oracle Cloud Infrastructure (OCI) account with sufficient quota to launch VM or BM GPU shapes.
* Basic understanding of OCI networking, including Virtual Cloud Networks (VCNs) and public subnets.
* Familiarity with basic Linux commands and SSH usage.
* Internet access from the instance to download software packages and the model (should be automatic).

> **Note:** GPU shapes in OCI incur costs while running. Be sure to terminate your instance when the lab is complete to avoid unexpected charges. 💵 💵 
## Task

### Learn More

* [AI Datascience Blog](https://blogs.oracle.com/ai-and-datascience/post/democratizing-generative-ai-with-cpu-based-inference)


## Acknowledgements
* **Author** - Jeff Allen, Distinguished Cloud Architect, AI Accounts
* **Contributors** -  Animesh Sahay, Enterprise Cloud Engineering
* **Last Updated:** - May 2025
