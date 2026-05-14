# Web Application

## Introduction

In this lab, you configure and run the Example Motors support app. The app is a Streamlit chat interface that uses OCI Generative AI Responses API, the unstructured vector store for PDF-based file search, the structured semantic store for NL2SQL, and ADB MCP Server for service-record retrieval.

Estimated Time: 20 minutes

### Objectives

In this lab, you will:

- Configure the sample app environment
- Install Python dependencies
- Run the Streamlit app
- Test PDF retrieval, database retrieval, and image prompts
- Capture the values needed for model optimization

### Prerequisites

This lab assumes you have:

- Completed the Semantic Store lab
- The `sample-app` folder from this workshop repository
- Access to the compute instance that belongs to the `examplemotorscompute` dynamic group
- Python 3.11 or later
- Instance principal authentication for OCI service calls

## Task 1: Confirm compute instance authentication

1. Connect to the compute instance that will run the sample app.

2. Open a terminal in the workshop repository root on the compute instance.

3. Confirm that the instance can read its OCI metadata.

    ```bash
    <copy>
    curl -H "Authorization: Bearer Oracle" http://169.254.169.254/opc/v2/instance/
    </copy>
    ```

4. If the metadata request fails, confirm that you are running the command on an OCI compute instance and that the instance is in the compartment matched by the `examplemotorscompute` dynamic group.

## Task 2: Create the app environment file

1. Change into the app directory.

    ```bash
    <copy>
    cd sample-app
    </copy>
    ```

2. Copy the environment template.

    ```bash
    <copy>
    cp .env.example .env
    </copy>
    ```

3. Open `.env` in your editor.

4. Set the Generative AI project values.

    ```text
    <copy>
    OCI_GENAI_AUTH=instance_principal
    OCI_GENAI_PROJECT_OCID=<car-manufacturer project OCID>
    OCI_GENAI_REGION=<workshop-region>
    OCI_GENAI_MODEL=<vision-capable model>
    OCI_GENAI_CHEAPER_MODEL=<fast text model>
    OCI_GENAI_MAX_OUTPUT_TOKENS=1000
    </copy>
    ```

5. Set the vector store and semantic store values.

    ```text
    <copy>
    OCI_GENAI_VECTOR_STORE_IDS=<car-operation vector store ID>
    OCI_GENAI_SEMANTIC_STORE_OCID=<car-manufacturer-service semantic store OCID>
    OCI_GENAI_NL2SQL_REGION=<workshop-region>
    OCI_GENAI_NL2SQL_API_VERSION=20260325
    </copy>
    ```

6. Set the ADB MCP values.

    ```text
    <copy>
    OCI_ADB_MCP_REGION=<workshop-region>
    OCI_ADB_DATABASE_OCID=<car-service database OCID>
    OCI_ADB_MCP_USERNAME=ADMIN
    OCI_ADB_MCP_PASSWORD_SECRET_OCID=<adb password secret OCID>
    OCI_ADB_MCP_PASSWORD_SECRET_REGION=<workshop-region>
    OCI_ADB_MCP_EXECUTE_TOOL=EXECUTE_SQL
    OCI_ADB_MCP_SQL_ARGUMENT=query
    OCI_ADB_MCP_OFFSET_ARGUMENT=offset
    OCI_ADB_MCP_LIMIT_ARGUMENT=limit
    OCI_SQL_MAX_ROWS=50
    OCI_SQL_TIMEOUT_SECONDS=30
    OCI_SQL_AUTH=instance_principal
    </copy>
    ```

7. Save the file.

## Task 3: Install dependencies

1. Create a Python virtual environment.

    ```bash
    <copy>
    python -m venv .venv
    </copy>
    ```

2. Activate the environment.

    ```bash
    <copy>
    source .venv/bin/activate
    </copy>
    ```

3. Install the dependencies.

    ```bash
    <copy>
    pip install -r requirements.txt
    </copy>
    ```

## Task 4: Run the app

1. Start Streamlit.

    ```bash
    <copy>
    streamlit run app.py
    </copy>
    ```

2. Open the local URL shown by Streamlit.

3. Confirm that the page title is:

    ```text
    <copy>
    OCI LLM Chat
    </copy>
    ```

4. Note the displayed `Customer ID`.

    The app randomly assigns a customer ID from `1` through `10` for each Streamlit session. The app scopes database questions to this customer.

## Task 5: Test PDF retrieval

1. Ask this question:

    ```text
    <copy>
    How do I pair my phone with the Example Motors infotainment system?
    </copy>
    ```

2. Confirm that the app answers from the infotainment pairing guide.

3. If the app says it does not have enough information, verify:

    ```text
    <copy>
    OCI_GENAI_VECTOR_STORE_IDS
    Data sync job status
    Vector store file count
    </copy>
    ```

## Task 6: Test service-record retrieval

1. Ask this question:

    ```text
    <copy>
    What service appointments do you have for my vehicle, and how much did I pay?
    </copy>
    ```

2. Watch the assistant status messages.

    You should see the app call the SQL retrieval path:

    ```text
    <copy>
    Calling SQL retrieval tool...
    Calling NL2SQL function...
    Calling ADB MCP server...
    </copy>
    ```

3. Confirm that the answer includes only records for the displayed customer ID.

4. If SQL retrieval fails, verify:

    ```text
    <copy>
    OCI_GENAI_SEMANTIC_STORE_OCID
    OCI_ADB_DATABASE_OCID
    OCI_ADB_MCP_USERNAME
    OCI_ADB_MCP_PASSWORD_SECRET_OCID
    OCI_ADB_MCP_EXECUTE_TOOL
    </copy>
    ```

## Task 7: Test an image prompt

1. In the chat input, attach this image from the repository:

    ```text
    <copy>
    data/example-motors-service-receipt.png
    </copy>
    ```

2. Ask this question:

    ```text
    <copy>
    Summarize the service receipt in this image.
    </copy>
    ```

3. Confirm that the app responds using the image contents.

4. If the app reports that the model does not support images, set `OCI_GENAI_MODEL` to a vision-capable model in your region and restart Streamlit.

You may now **proceed to the next lab**.

## Learn More

- [OCI Generative AI QuickStart for Responses API](https://docs.oracle.com/en-us/iaas/Content/generative-ai/get-started-agents.htm)
- [Calling services from an instance](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/callingservicesfrominstances.htm)
- [Streamlit documentation](https://docs.streamlit.io/)

## Acknowledgements

- **Author** - Julien Lehmann, Product Marketing Manager, Yanir Shahak, Senior Principal Software Engineer
