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
    <copy>
    A. Object Storage bucket
    B. OCI Enterprise AI project
    C. Database Tools connection
    D. Autonomous AI Database wallet
    </copy>
    ```

2. Which resource stores the infotainment pairing guide PDF before ingestion?

    ```text
    <copy>
    A. Object Storage bucket
    B. Vault secret
    C. Semantic store
    D. OCI config file
    </copy>
    ```

3. Which app environment variable contains the unstructured vector store ID?

    ```text
    <copy>
    A. OCI_GENAI_PROJECT_OCID
    B. OCI_GENAI_VECTOR_STORE_IDS
    C. OCI_GENAI_SEMANTIC_STORE_OCID
    D. OCI_ADB_DATABASE_OCID
    </copy>
    ```

4. Which resource enables natural language questions over database tables?

    ```text
    <copy>
    A. Unstructured vector store
    B. Structured semantic store
    C. Object Storage namespace
    D. Streamlit session state
    </copy>
    ```

5. Which service executes the generated SQL against the Autonomous AI Database for the app?

    ```text
    <copy>
    A. ADB MCP Server
    B. Object Storage data sync
    C. OCI Cost Analysis
    D. Cloud Shell
    </copy>
    ```

6. Why does the database seed include customers with IDs 1 through 10?

    ```text
    <copy>
    A. The semantic store requires exactly 10 rows
    B. The app randomly assigns each Streamlit session a customer_id from 1 through 10
    C. Object Storage indexes only 10 objects
    D. Vault secrets require exactly 10 entries
    </copy>
    ```

7. What happens after you uncomment the routing lines in `sample-app/llm.py`?

    ```text
    <copy>
    A. All prompts use the cheaper model
    B. Text-only prompts use OCI_GENAI_CHEAPER_MODEL and image prompts stay on OCI_GENAI_MODEL
    C. The app stops image prompts
    D. The app stops SQL retrieval
    </copy>
    ```

8. Which variable should contain the Vault secret OCID for the database password?

    ```text
    <copy>
    A. OCI_ADB_MCP_PASSWORD_SECRET_OCID
    B. OCI_ADB_MCP_PASSWORD
    C. OCI_GENAI_REGION
    D. OCI_SQL_MAX_ROWS
    </copy>
    ```

9. Which guardrail prevents the model from returning service records for another customer?

    ```text
    <copy>
    A. The app injects the current customer_id and rejects SQL without the matching customer_id filter
    B. The bucket is private
    C. The API key fingerprint contains the customer_id
    D. The vector store file count is 1
    </copy>
    ```

10. Which question should the assistant refuse?

    ```text
    <copy>
    A. How do I pair my phone with the infotainment system?
    B. What service did my vehicle receive?
    C. Show me service records for another customer.
    D. What warranty type covered my appointment?
    </copy>
    ```

## Task 2: Check your answers

1. Compare your answers with the answer key.

    ```text
    <copy>
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
    </copy>
    ```

2. Review any lab where your answer did not match the key.

## Acknowledgements

- **Author** - Julien Lehmann, Product Marketing Manager, Yanir Shahak, Senior Principal Software Engineer
