# Deploy the NVIDIA Deep Research AI Agent Blueprint on Oracle Kubernetes Engine (OKE)

## About this Workshop

This workshop guides you through deploying a complete AI research platform on Oracle Kubernetes Engine (OKE). You'll deploy both the NVIDIA RAG Blueprint  and the AI-Q Research Assistant  to create a powerful system for document Q&A and automated research report generation.

The platform combines document understanding (RAG) with intelligent research capabilities (AI-Q) to enable:

* **Document Q&A**: Chat with your documents using state-of-the-art RAG technology
* **Research Reports**: Generate comprehensive reports from multiple sources with AI-Q
* **Web Search Integration**: Combine your private documents with real-time web research
* **Human-in-the-Loop**: Edit and refine AI-generated content collaboratively

This workshop is ideal for researchers, analysts, and developers interested in:

* Building production-grade AI applications with NVIDIA NIM on NVIDIA GPU
* Deploying RAG pipelines with advanced reasoning capabilities
* Creating AI-powered research tools with multi-source intelligence
* Leveraging Kubernetes for scalable AI deployments
### Objectives

By the end of this workshop, you will have hands-on experience with:

1. Deploying the RAG Blueprint: Set up a complete document Q&A system with Nemotron 49B, embedding, reranking, and vector search.
2. Deploying AI-Q: Add advanced research capabilities that reuse Nemotron 49B for multi-source synthesis and report generation.
3. Integrating Multiple AI Services: Connect 4 different NIM and microservices in a cohesive architecture with shared LLM resources.
4. Enabling Web Search: Configure Tavily API for real-time web research capabilities.
5. Loading Research Datasets: Initialize the system with curated biomedical and financial document collections.
6. Generating Research Reports: Use AI to create comprehensive, multi-source research documents.
7. Phoenix Tracing: Monitor and debug your AI workflows with distributed tracing.

### Learn the Components
**NVIDIA RAG Blueprint**: 
A production-ready Retrieval Augmented Generation pipeline that enables Q&A over your documents. Includes document ingestion, embedding, vector search, reranking, and LLM-powered response generation with citations.

**NVIDIA AI-Q Research Assistant**: 
An intelligent research platform that generates comprehensive reports by querying multiple sources, synthesizing findings, and presenting them in editable, human-friendly formats.

**NIM (NVIDIA Inference Microservices)**:
Optimized containers for deploying AI models with TensorRT acceleration. This workshop uses:

* **Nemotron Super 49B**: Advanced reasoning, chain-of-thought, Q&A, and report synthesis (shared by both RAG and AI-Q)
* **NeMo Retriever Embedding 1B**: High-quality text embeddings
* **NeMo Retriever Reranking 1B**: Result reranking for improved accuracy
* **Page Elements NIM**: PDF text extraction

**Tavily API**: 
A research-grade web search API optimized for AI consumption, enabling real-time web research beyond your document collections.

**Phoenix Tracing**: 
An open-source observability platform providing distributed tracing and performance monitoring for AI workflows.

### Prerequisites

NVIDIA API Key ([Get it here](https://nvdam.widen.net/s/kfshg7fpsr/create-build-account-and-api-key-4) )

Tavily API Key ([Sign up here](https://tavily.com/) - Free tier available)

GPU Allocation Breakdown (Complete System):

| Component               | Blueprint   | GPU Count | GPU Memory | Purpose                                             |
|-------------------------|-------------|-----------|------------|-----------------------------------------------------|
| Nemotron Super 49B LLM  | RAG + AI-Q  | 4         | 40GB each  | Advanced reasoning, thinking, instructing & report generation |
| Embedding Model         | RAG         | 1         | 40GB       | Text embeddings                                     |
| Reranking Model         | RAG         | 1         | 40GB       | Result reranking                                   |
| Page Elements NIM       | RAG         | 1         | 40GB       | PDF text extraction                                |
| Milvus Vector DB        | RAG         | 0         | CPU        | Vector storage                                     |
| **Total Used**          | **7**       |           | **40GB each** | **Full system**                                  |
| **Available**           | **1**       |           | **40GB**   | Spare for other workloads                          |


## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [NVIDIA AI Q BluePrint](hhttps://build.nvidia.com/nvidia/aiq)
* [NVIDIA Technical Blog](https://developer.nvidia.com/blog/chat-with-your-enterprise-data-through-open-source-ai-q-nvidia-blueprint/)
* [NVIDIA NIM](https://www.nvidia.com/en-us/ai-data-science/products/nim-microservices/)
* [Llama Nemotron Model](https://build.nvidia.com/nvidia/llama-3_3-nemotron-super-49b-v1)


## Acknowledgements
* **Author** - Alejandro Casas - Oracle and Anurag Kuppala - NVIDIA
* **Contributors** -  Julien Lehmann
* **Last Updated By/Date** - Julien Lehmann / Jan26
