# Introduction

## About This Workshop
In this workshop, you will learn how to build AI agents using LangChain and LangGraph.

Since LangChain and LangGraph are primarily Python libraries, you will progressively build agents using:
- Python
- LangChain or LangGraph
- an on-demand large language model (LLM)
- or a Dedicated AI Cluster (DAC) to import open-weight models from Hugging Face.
    - See https://docs.oracle.com/en-us/iaas/Content/generative-ai/imported-models.htm.
    - For example, models include Alibaba Qwen, DeepSeek, Google Gemma, Meta Llama, Microsoft Phi, MiniMax, Mistral, Moonshot AI Kimi, NVIDIA Nemotron, OpenAI Whisper, OpenAI GptOss, and Z.ai GLM.

The installation requirements for this lab are minimal. Everything is done in OCI Cloud Editor.

Estimated Workshop Time: 60 minutes

### What You Will Learn

In these labs, you will get an introduction to how to:
- Connect LangChain or LangGraph to OCI
- Build systems ranging from simple agents to multi-agent systems using LangChain

![Screenshot](images/lg-screenshot.png =50%x*)

### What is an Agent

Here is a **definition of an AI Agent**: 
- An AI agent interacts autonomously with its environment. It uses tools and data to perform self-determined tasks to meet predetermined goals. 

![Definition](images/oda-agent-definition.png =50%x*)

Unlike a traditional program, an AI agent determines which steps and actions to take to achieve a goal.

In practice, an AI agent has:
- **Tools**
- **Data**

that it can use. It decides which tool or data to use to achieve the **goal** and produce the desired **result**. At the core of an agent is a large language model. During the lab, we will use either an on-demand model or a Dedicated AI Cluster (DAC).

![LLM](images/oda-agent-llm.png =50%x*)

### Logical Architecture

This LiveLab covers several AI-agent architectures.
- First, **a single agent** with tools and data. 
- **A ReAct agent** that combines step-by-step reasoning with external tool use to solve complex tasks.

![Agent](images/lg-agent-react.png =50%x*)

We will then explore more complex architectures, including memory, multi-agent systems, and several multi-agent examples.
- **Reflection**
- **Human in the loop**
- **Supervisor**, ....

![MultiAgent](images/agent-architecture.png =50%x*)

### Physical Architecture

The physical architecture consists primarily of LangGraph, which calls Python functions or REST APIs to access tools.
In the lab, we keep the setup as simple as possible by using dummy tools to avoid dependencies.

![Physical Architecture](images/physical-architecture.png =50%x*)

### Objectives

- Import all the samples and test them

**Please proceed to the [next lab.](#next)**

## Acknowledgements 

- **Author**
    - Marc Gueury, AI Applied Engineer
