# Lab 3B: Launch the Sample Application

## Introduction

In this path, you launch the pre-built Example Motors application on OCI Container Instances. You configure the OCI resources that you created in Labs 1 and 2, while OCI supplies short-lived resource-principal credentials to the running container. No API key, private key, or auth token is stored in the image.

Choose either Lab 3A or Lab 3B. Both paths use the same OCI Enterprise AI services and continue to Labs 4 through 6.

Estimated Time: 15 minutes

### Objectives

In this lab, you will:

- Review the managed application deployment options
- Launch a pre-built image with a generated Cloud Shell helper
- Connect the application to both vector stores
- Confirm resource-principal authentication and application health

### Prerequisites

- The OCI Enterprise AI project OCID from Lab 1
- The completed unstructured vector store ID from Lab 1 (starts with `vs_`)
- The active semantic store OCID from Lab 2
- The **Launch helper PAR** from the Sandbox Resource List

## Task 1: Review the deployment choice

OCI Generative AI hosted applications provide a managed production path for packaging and operating agentic applications close to the service. Hosted applications are reserved for customer deployments in this workshop because the shared training tenancies cannot allocate one hosted application to every attendee at event scale.

Container Instances demonstrates the same OCI-native deployment principles without requiring a server or Kubernetes cluster. The workshop image contains application code only. Its runtime configuration is injected as environment variables, the public OCIR repository removes image-pull credentials, and the container resource principal receives OCI permissions through a pre-created dynamic group and IAM policy.

## Task 2: Confirm readiness

1. Confirm that the Lab 1 data sync job is **Succeeded**, the unstructured vector store is **Completed**, and its processed file count is greater than zero.

2. Confirm that the Lab 2 semantic store is **Active** and semantic enrichment completed successfully.

3. Keep the project OCID, unstructured vector store ID, and semantic store OCID available. These are the only resource identifiers that the helper asks you to enter.

## Task 3: Download the generated launch helper

1. Open Cloud Shell in the workshop region.

2. Copy the **Launch helper PAR** from the Sandbox Resource List and run the following command. Replace `<launch-helper-par>` with the complete URL.

    ```bash
    <copy>
    curl -fL '<launch-helper-par>' -o launch-container-instance.sh
    chmod 700 launch-container-instance.sh
    </copy>
    ```

3. Inspect the beginning of the script. The compartment, public subnet, network security group, database, Vault secret, region, image URL, and resource sizing are already populated from Terraform output.

    ```bash
    <copy>
    sed -n '1,45p' launch-container-instance.sh
    </copy>
    ```

## Task 4: Launch the application

1. Run the helper.

    ```bash
    <copy>
    ./launch-container-instance.sh
    </copy>
    ```

2. At the prompts, paste the project OCID, unstructured vector store ID, and semantic store OCID from Labs 1 and 2.

3. Wait for the lifecycle state to reach **ACTIVE**. The helper prints the Container Instance OCID and application URL.

    The instance uses 1 OCPU and 4 GB of memory. The container sets `OCI_AUTH_MODE=resource_principal`; OCI injects and rotates the resource-principal session token automatically.

## Task 5: Validate application health

1. Open the printed application URL.

2. If the page is not ready immediately, wait 30 seconds and refresh. The image includes a health check against Streamlit's `/_stcore/health` endpoint.

3. Ask:

    ```text
    How do I pair my phone with the Example Motors infotainment system?
    ```

4. Confirm that the answer uses the ingested guide. Then ask:

    ```text
    What service appointments do you have for my vehicle, and how much did I pay?
    ```

5. Confirm that the application calls the semantic store and ADB MCP path. If either test fails, recheck the three entered resource identifiers and the readiness states from Task 2 before recreating the instance.

You may now proceed to Lab 4. Keep the Container Instance OCID; Lab 4 creates a routed replacement and leaves the current instance available for comparison.

## Learn More

- [Overview of OCI Container Instances](https://docs.oracle.com/en-us/iaas/Content/container-instances/overview-of-container-instances.htm)
- [OCI Generative AI IAM-based authentication](https://docs.oracle.com/en-us/iaas/Content/generative-ai/oci-genai-auth.htm)
- [OCI Generative AI application deployment permissions](https://docs.oracle.com/en-us/iaas/Content/generative-ai/deploy-permissions.htm)

## Acknowledgements

- **Author** - Oracle LiveLabs
