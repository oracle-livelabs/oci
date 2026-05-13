# Quiz

## Introduction

Use this quiz to confirm that you can explain the resources and runtime flow behind the Example Motors support agent.

Estimated Time: 10 minutes

### Objectives

In this lab, you will:

- Check your understanding of the workshop architecture
- Confirm which OCI resources power each app capability
- Review the environment variables required by the sample app
- Review the security and model-routing behavior

### Prerequisites

This lab assumes you have:

- Completed all previous labs
- Run the sample app successfully

## Task 1: Answer the quiz questions

1. Which resource organizes OCI Generative AI settings for the app and goes to the Responses API?

    ```text
    A. Object Storage bucket
    B. OCI Enterprise AI project
    C. Database Tools connection
    D. Autonomous AI Database wallet
    ```

2. Which resource stores the infotainment pairing guide PDF before ingestion?

    ```text
    A. Object Storage bucket
    B. Vault secret
    C. Semantic store
    D. API key
    ```

3. Which app environment variable contains the unstructured vector store ID?

    ```text
    A. OCI_GENAI_PROJECT_OCID
    B. OCI_GENAI_VECTOR_STORE_IDS
    C. OCI_GENAI_SEMANTIC_STORE_OCID
    D. OCI_ADB_DATABASE_OCID
    ```

4. Which resource enables natural language questions over database tables?

    ```text
    A. Unstructured vector store
    B. Structured semantic store
    C. Object Storage namespace
    D. Streamlit session state
    ```

5. Which service executes the generated SQL against the Autonomous AI Database for the app?

    ```text
    A. ADB MCP Server
    B. Object Storage data sync
    C. OCI Cost Analysis
    D. Cloud Shell
    ```

6. Why does the database seed include customers with IDs 1 through 10?

    ```text
    A. The semantic store requires exactly 10 rows
    B. The app randomly assigns each Streamlit session a customer_id from 1 through 10
    C. Object Storage indexes only 10 objects
    D. API keys require 10 users
    ```

7. What happens after you uncomment the routing lines in `sample-app/llm.py`?

    ```text
    A. All prompts use the cheaper model
    B. Text-only prompts use OCI_GENAI_CHEAPER_MODEL and image prompts stay on OCI_GENAI_MODEL
    C. The app stops image prompts
    D. The app stops SQL retrieval
    ```

8. Which variable should contain the Vault secret OCID for the database password?

    ```text
    A. OCI_ADB_MCP_PASSWORD_SECRET_OCID
    B. OCI_ADB_MCP_PASSWORD
    C. OCI_GENAI_API_KEY
    D. OCI_SQL_MAX_ROWS
    ```

9. Which guardrail prevents the model from returning service records for another customer?

    ```text
    A. The app injects the current customer_id and rejects SQL without the matching customer_id filter
    B. The bucket is private
    C. The API key has an expiration time
    D. The vector store file count is 1
    ```

10. Which question should the assistant refuse?

    ```text
    A. How do I pair my phone with the infotainment system?
    B. What service did my vehicle receive?
    C. Show me service records for another customer.
    D. What warranty type covered my appointment?
    ```

## Task 2: Check your answers

1. Compare your answers with the answer key.

    ```text
    1: B
    2: A
    3: B
    4: B
    5: A
    6: B
    7: B
    8: A
    9: A
    10: C
    ```

2. Review any lab where your answer did not match the key.

## Acknowledgements

- **Author** - Julien Lehmann, Product Marketing Manager, Yanir Shahak, Senior Principal Software Engineer
