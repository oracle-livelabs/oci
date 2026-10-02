# The Economics of AI: Model Routing for Construction Engineering

## Introduction

Construction decisions combine specifications, schedules, inspections, supplier performance, certifications, purchase orders, and nonconformance evidence. Seer Construction Intelligence demonstrates how OCI Enterprise AI can ground those decisions in both documents and governed database data while routing each request to an appropriately capable model.

You will use a hybrid inference pattern:

- Ingest a structural engineering specification into an unstructured vector store.
- Connect a semantic store to reconciled Construction Engineering Gold views.
- Retrieve project and supplier evidence through NL2SQL and ADB MCP Server.
- Route text-only questions to a lower-cost model while retaining a stronger model for image input.
- Screen every prompt with OCI ApplyGuardrails before model inference.

After creating both retrieval sources, choose one application path. **Build** runs the Python app locally for code-level exploration. **Launch** deploys a pre-built image to OCI Container Instances with resource-principal authentication. Both paths continue to the same optimization, guardrails, and Knowledge Check labs.

Estimated Time: 1 hour 30 minutes

### Objectives

- Build document-grounded retrieval over construction specifications
- Query governed project and supplier data with natural language
- Compare model capability, latency, and cost
- Use OCI-native identity instead of long-lived container credentials
- Validate security and readiness controls around the application

### Prerequisites

- General familiarity with the OCI Console
- For the Build path, Python 3.10 or later and basic terminal skills
- For the Launch path, basic OCI Cloud Shell skills

## Solution Architecture

The application combines two retrieval paths behind the OCI Enterprise AI Responses API. `file_search` retrieves specification evidence from the unstructured vector store. A function tool sends governed questions to the semantic store, validates generated SQL, and executes it through ADB MCP Server against Autonomous AI Database. OCI Vault protects the database credential, and ApplyGuardrails screens the prompt before inference.

The Launch path packages only application code in OCIR. Tenant-specific OCIDs are supplied as Container Instances environment variables, and the container resource principal receives access through IAM policy. The Build path receives a Terraform-generated `.env` with foundation values already populated and asks the learner to add only the three resources created during the labs.

## Learn More

- [OCI Enterprise AI](https://www.oracle.com/artificial-intelligence/enterprise-ai/)
- [OCI Generative AI](https://docs.oracle.com/en-us/iaas/Content/generative-ai/home.htm)
- [OCI Container Instances](https://docs.oracle.com/en-us/iaas/Content/container-instances/overview-of-container-instances.htm)

## Acknowledgements

- **Author** - Oracle LiveLabs
