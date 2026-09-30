# Lab 2: Semantic Store

## Introduction

In this lab, you create the structured semantic store for construction project, supplier, inspection, schedule, and compliance questions. The environment already includes the Autonomous AI Database, Construction Engineering schema, seed data, Vault secret, and Database Tools connections. The sample app sends natural-language questions to NL2SQL, validates the generated SQL, and retrieves governed Gold-view data through the ADB MCP Server.

Estimated Time: 10 minutes

### Objectives

In this lab, you will:

- Create a structured semantic store
- Connect the semantic store to the pre-created construction intelligence database
- Run the semantic enrichment
- Record the semantic store OCID for the sample app

### Prerequisites

This lab assumes you have:

- Completed the Unstructured RAG lab

## Task 1: Create the structured semantic store

1. In the Console navigation menu, go to **Analytics & AI**, then **Generative AI**.

1. Select **Vector stores**.

1. Select the reservation-specific child compartment from your sandbox resource list.

1. Click **Create vector store**.

1. Enter the following values:

    ```text
    Name: seer-construction-semantic
    Description: Governed construction project and supplier semantic store
    Compartment: <workshop-compartment>
    Data source type: Structured data
    Connection type: OCI Database tool
    ```

    ![Create the Construction Engineering semantic store](images/semantic-store-consteng.jpg)

    Use the connection OCIDs from your sandbox resource list:

    ```text
    Enrichment connection ID: <DB Tools Enrichment Connection OCID>
    Querying connection ID: <DB Tools Query Connection OCID>
    Schema: CONSTRUCTION_ENGINEERING
    Enrichment: On create
    ```

1. Click **Test enrichment connection** to make sure the semantic store can use the connection to connect to the database.

1. Click **Test query connection** to make sure the semantic store can use the connection to connect to the database.

    ![Configure the Construction Engineering database connections](images/create-structured-semantic-store-consteng.jpg)

1. Click **Create**.

1. Wait for `seer-construction-semantic` to reach **Active** and confirm that semantic enrichment completed successfully. Do not continue while enrichment is queued, running, or failed.

1. Copy the semantic store OCID and record it as the value for `Structured semantic store OCID`.

At this stage, the Semantic Store can generate SQL from natural language against the governed construction Gold views and execute it through the workshop database connection.

You may now **proceed to the next lab**.

## Learn More

- [OCI Generative AI QuickStart for semantic stores and NL2SQL](https://docs.oracle.com/en-us/iaas/Content/generative-ai/get-started-agents.htm)

## Acknowledgements

- **Author** - Julien Lehmann - Product Marketing Manager, Yanir Shahak - Senior Principal Software Engineer
