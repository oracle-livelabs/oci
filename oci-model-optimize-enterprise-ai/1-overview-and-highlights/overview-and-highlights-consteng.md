# Optimize AI Workloads with Intelligent Model Selection

## Introduction

Construction decisions combine specifications, schedules, inspections, supplier performance, certifications, purchase orders, and nonconformance evidence. Seer Construction Intelligence demonstrates how OCI Enterprise AI can ground those decisions in both documents and governed database data while routing each request to an appropriately capable model.

You will use a hybrid inference pattern:

- Ingest a structural engineering specification into an unstructured vector store.
- Connect a semantic store to reconciled Construction Engineering Gold views.
- Retrieve project and supplier evidence through NL2SQL and ADB MCP Server.
- Route text-only questions to a lower-cost model while retaining a stronger model for image input.
- Enable OCI ApplyGuardrails in Lab 5 to screen subsequent text prompts before model inference.

After creating both retrieval sources, choose one application path. **Build** runs the Python app locally for code-level exploration. **Launch** deploys a pre-built image to OCI Container Instances with resource-principal authentication. Both paths continue to the same optimization, guardrails, and Knowledge Check labs.

Estimated Time: 1 hour 15 minutes for Launch, or 1 hour 30 minutes for Build. Provisioning and ingestion waits, local software installation, and the optional additional-model experiment can add time.

### Objectives

- Build document-grounded retrieval over construction specifications
- Query governed project and supplier data with natural language
- Compare model selection, answer quality, app response time, and reported token usage; optionally estimate model-call cost
- Use resource-principal authentication for Launch, or an OCI API signing key for local Build
- Validate security and readiness controls around the application

### Prerequisites

- General familiarity with the OCI Console
- A ready LiveLabs reservation; use its assigned region and reservation-specific child compartment throughout
- For the Build path, Python 3.10 or later and basic terminal skills
- For the Launch path, basic OCI Cloud Shell skills

## Solution Architecture

The application combines two retrieval paths behind the OCI Enterprise AI Responses API. `file_search` retrieves specification evidence from the unstructured vector store. A function tool sends governed questions to the semantic store for NL2SQL, validates generated SQL, and executes it through ADB MCP Server against Autonomous AI Database. OCI Vault protects the database credential. Routing and prompt-injection protection start disabled for the baseline; you enable routing in Lab 4 and ApplyGuardrails in Lab 5. When enabled, the guardrail screens each submitted text prompt before the Responses API call; it is not an image-content safety assessment.

The Launch path packages only application code in OCIR. Tenant-specific OCIDs are supplied as Container Instances environment variables, and the container resource principal receives access through IAM policy. The Build path receives a Terraform-generated `.env` with foundation values already populated and asks the learner to add only the three resources created during the labs.

Follow **Lab 1: Unstructured RAG**, then **Lab 2: Semantic Store**. Choose **Lab 3A: Build** or **Lab 3B: Launch**, not both. Continue with **Lab 4: Model Optimization**, **Lab 5: Security Guardrails**, and **Lab 6: Knowledge Check**. The optional model experiment in Lab 4 is not required for the Knowledge Check.

## Learn More

- [OCI Enterprise AI](https://www.oracle.com/artificial-intelligence/enterprise-ai/)
- [OCI Generative AI](https://docs.oracle.com/en-us/iaas/Content/generative-ai/home.htm)
- [OCI Container Instances](https://docs.oracle.com/en-us/iaas/Content/container-instances/overview-of-container-instances.htm)

## Acknowledgements

- **Author** — Julien Lehmann - Product Marketing Manager, Yanir Shahak - Senior Principal Software Engineer
- **Contributors** — Oracle LiveLabs Platform Team
- **Last Updated By/Date** — Eli Schilling, November 2026
