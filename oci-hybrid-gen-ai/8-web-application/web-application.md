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
- Python 3.11 or later
- OCI CLI session authentication or a Generative AI API key

## Task 1: Configure OCI authentication

1. Open a terminal in the workshop repository root.

2. If you are using OCI CLI session authentication, authenticate to OCI.

    Replace `<region>` with the Generative AI region you selected in the Setup lab:

    ```bash
    oci session authenticate --region <region>
    ```

3. Confirm that your OCI config profile has a security token file.

    ```bash
    oci session validate --profile DEFAULT
    ```

4. If you are using a Generative AI API key instead, keep the key value from the Setup lab available.

    The app can use `OCI_GENAI_AUTH=api_key` for the LLM request while still using OCI IAM session auth for NL2SQL, Vault, and ADB MCP.

## Task 2: Create the app environment file

1. Change into the app directory.

    ```bash
    cd sample-app
    ```

2. Copy the environment template.

    ```bash
    cp .env.example .env
    ```

3. Open `.env` in your editor.

4. Set the Generative AI project values.

    ```text
    OCI_GENAI_AUTH=session
    OCI_PROFILE=DEFAULT
    OCI_CONFIG_FILE=~/.oci/config
    OCI_GENAI_PROJECT_OCID=<car-manufacturer project OCID>
    OCI_GENAI_REGION=<generative-ai-region>
    OCI_GENAI_MODEL=<vision-capable model>
    OCI_GENAI_CHEAPER_MODEL=<fast text model>
    OCI_GENAI_MAX_OUTPUT_TOKENS=1000
    ```

5. If using API key auth for the LLM request, set:

    ```text
    OCI_GENAI_AUTH=api_key
    OCI_GENAI_API_KEY=<generative-ai-api-key>
    ```

6. Set the vector store and semantic store values.

    ```text
    OCI_GENAI_VECTOR_STORE_IDS=<car-operation vector store ID>
    OCI_GENAI_SEMANTIC_STORE_OCID=<car-manufacturer-service semantic store OCID>
    OCI_GENAI_NL2SQL_REGION=<generative-ai-region>
    OCI_GENAI_NL2SQL_API_VERSION=20260325
    ```

7. Set the ADB MCP values.

    ```text
    OCI_ADB_MCP_REGION=<adb-region>
    OCI_ADB_DATABASE_OCID=<car-service database OCID>
    OCI_ADB_MCP_USERNAME=ADB_MCP_USER
    OCI_ADB_MCP_PASSWORD_SECRET_OCID=<adb password secret OCID>
    OCI_ADB_MCP_PASSWORD_SECRET_REGION=<adb-region>
    OCI_ADB_MCP_EXECUTE_TOOL=EXECUTE_SQL
    OCI_ADB_MCP_SQL_ARGUMENT=query
    OCI_ADB_MCP_OFFSET_ARGUMENT=offset
    OCI_ADB_MCP_LIMIT_ARGUMENT=limit
    OCI_SQL_MAX_ROWS=50
    OCI_SQL_TIMEOUT_SECONDS=30
    OCI_SQL_AUTH=session
    ```

8. Save the file.

## Task 3: Install dependencies

1. Create a Python virtual environment.

    ```bash
    python -m venv .venv
    ```

2. Activate the environment.

    ```bash
    source .venv/bin/activate
    ```

3. Install the dependencies.

    ```bash
    pip install -r requirements.txt
    ```

## Task 4: Run the app

1. Start Streamlit.

    ```bash
    streamlit run app.py
    ```

2. Open the local URL shown by Streamlit.

3. Confirm that the page title is:

    ```text
    OCI LLM Chat
    ```

4. Note the displayed `Customer ID`.

    The app randomly assigns a customer ID from `1` through `10` for each Streamlit session. The app scopes database questions to this customer.

## Task 5: Test PDF retrieval

1. Ask this question:

    ```text
    How do I pair my phone with the Example Motors infotainment system?
    ```

2. Confirm that the app answers from the infotainment pairing guide.

3. If the app says it does not have enough information, verify:

    ```text
    OCI_GENAI_VECTOR_STORE_IDS
    Data sync job status
    Vector store file count
    ```

## Task 6: Test service-record retrieval

1. Ask this question:

    ```text
    What service appointments do you have for my vehicle, and how much did I pay?
    ```

2. Watch the assistant status messages.

    You should see the app call the SQL retrieval path:

    ```text
    Calling SQL retrieval tool...
    Calling NL2SQL function...
    Calling ADB MCP server...
    ```

3. Confirm that the answer includes only records for the displayed customer ID.

4. If SQL retrieval fails, verify:

    ```text
    OCI_GENAI_SEMANTIC_STORE_OCID
    OCI_ADB_DATABASE_OCID
    OCI_ADB_MCP_USERNAME
    OCI_ADB_MCP_PASSWORD_SECRET_OCID
    OCI_ADB_MCP_EXECUTE_TOOL
    ```

## Task 7: Test an image prompt

1. In the chat input, attach this image from the repository:

    ```text
    data/example-motors-service-receipt.png
    ```

2. Ask this question:

    ```text
    Summarize the service receipt in this image.
    ```

3. Confirm that the app responds using the image contents.

4. If the app reports that the model does not support images, set `OCI_GENAI_MODEL` to a vision-capable model in your region and restart Streamlit.

You may now **proceed to the next lab**.

## Learn More

- [OCI Generative AI QuickStart for Responses API](https://docs.oracle.com/en-us/iaas/Content/generative-ai/get-started-agents.htm)
- [OCI SDK configuration files](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/sdkconfig.htm)
- [Streamlit documentation](https://docs.streamlit.io/)

## Acknowledgements

- **Author** - Julien Lehmann, Product Marketing Manager, Yanir Shahak, Senior Principal Software Engineer
