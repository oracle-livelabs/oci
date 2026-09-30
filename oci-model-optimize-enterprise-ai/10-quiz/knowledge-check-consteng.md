# Lab 6: Knowledge Check

## Introduction

Use this scored knowledge check to review the Seer Construction Intelligence architecture. The questions apply to both the Build and Launch paths.

Estimated Time: 5 minutes

### Objectives

- Confirm which OCI resources support each application feature
- Review readiness, authentication, routing, and guardrail decisions
- Connect construction evidence to the governed retrieval architecture

### Prerequisites

- Completed Labs 1 through 5
- Successfully tested either application path

## Task 1: Complete the knowledge check

1. Select an answer for each question. A score of 80% passes.

    ```quiz-config
    passing: 80
    ```

    ```quiz score
    Q: Which resource stores the structural engineering specification before ingestion?
    * Object Storage bucket.
    - Vault secret.
    - Semantic store.
    - Container image.
    > Object Storage is the governed source location used by the data sync connector.

    Q: Which resource chunks, embeds, and stores the specification for file search?
    - Autonomous AI Database.
    * Unstructured vector store.
    - Database Tools connection.
    - OCI Vault.
    > The unstructured vector store prepares file content for semantic retrieval.

    Q: Which resource translates natural-language construction questions into SQL?
    - Unstructured vector store.
    * Structured semantic store.
    - Object Storage PAR.
    - Network security group.
    > The semantic store supplies the NL2SQL path over governed database data.

    Q: Which component executes the validated SQL against Autonomous AI Database?
    * ADB MCP Server.
    - Object Storage data sync.
    - OCIR.
    - Cloud Shell.
    > ADB MCP Server executes the approved SQL tool call.

    Q: Why does the application query governed Gold views?
    - Gold views store container images.
    - Gold views replace OCI IAM policy.
    * Gold views provide a stable, reconciled contract for decision-ready answers.
    - Gold views make vector ingestion unnecessary.
    > The Gold layer exposes reconciled project, supplier, document, and provenance data.

    Q: Why does the Launch path not require an OCI API private key in the container?
    - The public OCIR repository grants access to every OCI service.
    * OCI injects resource-principal credentials and IAM policies authorize the container.
    - The helper stores a Cloud Shell token in the image.
    - Container Instances bypasses OCI IAM.
    > The image is credential-free. OCI supplies short-lived resource-principal credentials at runtime.

    Q: Why can the workshop use a public OCIR repository safely?
    - The image contains the database password.
    * The image contains code only; tenant OCIDs and authorization are supplied at deployment time.
    - Public repositories are visible only inside the tenancy.
    - Public repositories disable image scanning.
    > Public pull removes registry credentials, so the image must never contain secrets or tenant-specific configuration.

    Q: What must be true before testing both retrieval paths?
    - The PAR must never expire.
    - Model routing must be enabled.
    * File ingestion must complete and semantic enrichment must be active.
    - The app must use three models.
    > Readiness gates distinguish service preparation from application failures.

    Q: What happens when model routing is enabled for a text-only prompt?
    * The app selects the configured lower-cost model and retains the stronger model for image input.
    - The semantic store chooses the model.
    - ApplyGuardrails is skipped.
    - Every model runs in parallel.
    > The routing rule optimizes narrow text workloads while preserving multimodal capability.

    Q: What does the app do when ApplyGuardrails flags prompt injection at or above the threshold?
    - Routes the prompt to the cheaper model.
    - Stores the prompt in Object Storage.
    * Blocks the prompt before calling the model.
    - Executes it through ADB MCP Server.
    > The guardrail is evaluated before the Responses API call and fails closed.
    ```

## Acknowledgements

- **Author** - Oracle LiveLabs
