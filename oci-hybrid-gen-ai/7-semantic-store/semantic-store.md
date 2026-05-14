# Semantic Store

## Introduction

In this lab, you create the structured semantic store for service appointment questions. The semantic store connects OCI Generative AI to the Autonomous AI Database through Database Tools connections. The sample app sends customer-scoped natural language questions to the NL2SQL API for this semantic store, validates the generated SQL, and executes it through ADB MCP Server.

Estimated Time: 20 minutes

### Objectives

In this lab, you will:

- Create a structured semantic store
- Connect the semantic store to the service database
- Run or verify semantic enrichment
- Test a customer-scoped NL2SQL prompt
- Record the semantic store OCID for the sample app

### Prerequisites

This lab assumes you have:

- Completed the Database Tools and Vault lab
- The `car-service-enrichment` Database Tools connection OCID
- The `car-service-query` Database Tools connection OCID
- The `car-service` Autonomous AI Database OCID

## Task 1: Create the structured semantic store

1. In the Console navigation menu, go to **Analytics & AI**, then **Generative AI**.

2. Select **Vector stores**.

3. Click **Create vector store**.

4. Enter the following values:

    ```text
    <copy>
    Name: car-manufacturer-service
    Description: Example Motors service appointment semantic store
    Compartment: <workshop-compartment>
    Data source type: Structured data
    </copy>
    ```

    ![Create structured semantic store](images/create-structured-semantic-store.png)

5. Continue to the structured data source configuration.

## Task 2: Configure database connections

1. Select the Database Tools connection type.

2. For the enrichment connection, enter or select:

    ```text
    <copy>
    car-service-enrichment
    </copy>
    ```

3. For the query connection, enter or select:

    ```text
    <copy>
    car-service-query
    </copy>
    ```

4. Select the schema:

    ```text
    <copy>
    ADMIN
    </copy>
    ```

5. Include these tables in the semantic store:

    ```text
    <copy>
    CUSTOMERS
    VEHICLES
    SERVICE_APPOINTMENTS
    SERVICE_ITEMS
    </copy>
    ```

6. Select auto-run enrichment if the wizard offers it.

7. Click **Create**.

## Task 3: Verify enrichment

1. Open the `car-manufacturer-service` semantic store.

2. Wait until the store is active.

3. Open the enrichment or jobs section.

4. Confirm that the latest enrichment job succeeded.

5. If enrichment did not start automatically, run it from the sample app helper.

    ```bash
    <copy>
    cd sample-app
    python -m venv .venv
    source .venv/bin/activate
    pip install -r requirements.txt
    export OCI_GENAI_SEMANTIC_STORE_OCID="<semantic-store-ocid>"
    export OCI_GENAI_REGION="<workshop-region>"
    export OCI_GENAI_NL2SQL_REGION="${OCI_GENAI_REGION}"
    export OCI_SQL_AUTH="instance_principal"
    python scripts/start_enrichment_job.py --schema-name ADMIN --wait
    </copy>
    ```

6. Confirm that the command reports a terminal state of `SUCCEEDED`.

## Task 4: Test a customer-scoped prompt

1. In the semantic store console test panel, enter this prompt if the panel is available:

    ```text
    <copy>
    Show the service appointments for customer_id 7, including service summary, warranty type, total cost, and customer paid amount.
    </copy>
    ```

2. Confirm that the generated SQL references these tables as needed:

    ```text
    <copy>
    CUSTOMERS
    VEHICLES
    SERVICE_APPOINTMENTS
    SERVICE_ITEMS
    </copy>
    ```

3. Confirm that the generated SQL filters to:

    ```text
    <copy>
    customer_id = 7
    </copy>
    ```

4. If the console does not provide a test panel, skip this test.

    The Web Application lab validates the NL2SQL path through the running app.

## Task 5: Record the semantic store OCID

1. Open the semantic store details page.

2. Copy the semantic store OCID.

3. Record it as:

    ```text
    <copy>
    OCI_GENAI_SEMANTIC_STORE_OCID=<semantic-store-ocid>
    </copy>
    ```

4. Confirm that you still have these values for the Web Application lab:

    ```text
    <copy>
    OCI_GENAI_PROJECT_OCID
    OCI_GENAI_VECTOR_STORE_IDS
    OCI_GENAI_SEMANTIC_STORE_OCID
    OCI_ADB_DATABASE_OCID
    OCI_ADB_MCP_PASSWORD_SECRET_OCID
    </copy>
    ```

You may now **proceed to the next lab**.

## Learn More

- [OCI Generative AI QuickStart for semantic stores and NL2SQL](https://docs.oracle.com/en-us/iaas/Content/generative-ai/get-started-agents.htm)
- [Database Tools console tasks](https://docs.oracle.com/en-us/iaas/database-tools/doc/using-oracle-cloud-infrastructure-console.html)
- [Calling services from an instance](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/callingservicesfrominstances.htm)

## Acknowledgements

- **Author** - Julien Lehmann, Product Marketing Manager, Yanir Shahak, Senior Principal Software Engineer
