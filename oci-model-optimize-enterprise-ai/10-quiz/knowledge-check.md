# Lab 6: Knowledge Check

## Introduction

Use this scored knowledge check to review the Example Motors architecture. The questions apply to both the Build and Launch paths.

Estimated Time: 5 minutes

### Objectives

In this lab, you will:

- Check your understanding of the workshop architecture.
- Confirm which OCI resources power each app feature.
- Review the OCI resources used by the sample app.
- Review ApplyGuardrails checks and model routing.

### Prerequisites

This lab assumes you have:

- Completed all previous labs.
- Run the sample app successfully.

## Task 1: Complete the knowledge check

1. Select an answer for each question, then check your answer. A score of 80% passes the knowledge check.

    ```quiz-config
    passing: 80
    ```

    ```quiz score
    Q: Which resource organizes app settings for the Responses API?
    - Object Storage bucket.
    * OCI Enterprise AI project.
    - Database Tools connection.
    - Autonomous AI Database wallet.
    > The app keeps its Generative AI settings in an OCI Enterprise AI project.

    Q: Which resource stores the Bluetooth pairing guide PDF before processing it in the vector store?
    * Object Storage bucket.
    - Vault secret.
    - Semantic store.
    - OCI config file.
    > Object Storage holds the PDF before it is processed for retrieval.

    Q: Which OCI resource chunks, embeds, and stores content for semantic file search?
    - Object Storage bucket.
    * Unstructured vector store.
    - Structured semantic store.
    - Database Tools connection.
    > The unstructured vector store processes files for semantic file search.

    Q: Which resource supports natural language questions over database tables?
    - Unstructured vector store.
    * Structured semantic store.
    - Object Storage namespace.
    - Streamlit session state.
    > The structured semantic store helps the app query database tables from natural language.

    Q: Which service executes generated SQL against the Autonomous AI Database?
    * ADB MCP Server.
    - Object Storage data sync.
    - OCI Cost Analysis.
    - Cloud Shell.
    > The app uses the ADB MCP Server to execute generated SQL.

    Q: Which OCI resource stores customer, vehicle, appointment, and service item records?
    - Object Storage bucket.
    - OCI Vault.
    * Autonomous AI Database.
    - Unstructured vector store.
    > Autonomous AI Database stores the structured dealership service data.

    Q: Which OCI API generates chat responses and can use file search over the vector store?
    * OCI Enterprise AI Responses API.
    - OCI Object Storage API.
    - OCI ApplyGuardrails API.
    - OCI Cost Analysis API.
    > The app uses the OCI Enterprise AI Responses API for chat responses and file search.

    Q: Which OCI resource stores database credentials outside the app code?
    - Structured semantic store.
    * OCI Vault secret.
    - Object Storage data sync connector.
    - OCI Enterprise AI project.
    > OCI Vault secrets keep database credentials out of the application code.

    Q: Which OCI API screens user prompts for prompt-injection risk?
    - OCI Enterprise AI Responses API.
    - OCI NL2SQL API.
    * OCI ApplyGuardrails API.
    - OCI Object Storage API.
    > OCI ApplyGuardrails checks prompts before the app calls the chat model.

    Q: What does the app do when ApplyGuardrails flags prompt injection at or above the threshold?
    - Sends the prompt to the cheaper model.
    - Stores the prompt in Object Storage.
    * Blocks the prompt before calling the chat model.
    - Retries the prompt through ADB MCP Server.
    > The app blocks prompt-injection attempts before it calls the chat model.

    Q: Why does the Launch path not require an OCI API private key in the container?
    - The public OCIR repository grants access to every OCI service.
    * OCI injects resource-principal credentials and IAM policies authorize the container.
    - The helper stores a Cloud Shell auth token in the image.
    - Container Instances bypasses OCI IAM.
    > The image contains no user credentials. OCI supplies short-lived resource-principal credentials and IAM controls their permissions.

    Q: What must be true before testing file search and semantic retrieval?
    - The Container Instance must use two OCPUs.
    - The PAR must be made permanent.
    * File ingestion must complete and semantic enrichment must be active.
    - Model routing must be enabled.
    > Readiness checks prevent an application configuration problem from being confused with an ingestion or enrichment job that is still running.

    Q: What happens when model routing is enabled for a text-only prompt?
    * The app selects the configured lower-cost model while retaining the stronger model for image input.
    - The app skips ApplyGuardrails.
    - The semantic store chooses a model.
    - The prompt is sent to every model simultaneously.
    > The routing rule optimizes text-only requests while preserving multimodal capability for image prompts.
    ```

## Acknowledgements

- **Author** - Julien Lehmann - Product Marketing Manager, Yanir Shahak - Senior Principal Software Engineer
