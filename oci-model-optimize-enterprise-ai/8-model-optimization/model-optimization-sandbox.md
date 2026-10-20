# Lab 4: Model Optimization

## Introduction

In this lab, you enable model routing without changing application code. Text-only prompts use the lower-cost model, while image prompts remain on the stronger multimodal model.

Estimated Time: 15 minutes

### Objectives

- Establish a baseline with one model
- Enable routing through application configuration
- Compare text and image routing behavior
- Optionally evaluate a third model

### Prerequisites

- A running application from Lab 3A or Lab 3B
- Access to both configured models in the workshop region

## Task 1: Record the baseline

1. Open the application and note the model shown under the title.

2. Submit a text-only question and an image question. Record the model label and the rough response time for each.

## Task 2: Enable model routing

### Build path

1. In `sample-app/.env`, set:

    ```text
    OCI_GENAI_MODEL_ROUTING_ENABLED=true
    ```

2. Save the file, stop Streamlit with Ctrl+C, and restart it.

    ```bash
    <copy>
    streamlit run app.py
    </copy>
    ```

### Launch path

1. Return to the Cloud Shell directory that contains `launch-container-instance.sh`.

2. Create a routed replacement. Enter the same three resource identifiers when prompted.

    ```bash
    <copy>
    MODEL_ROUTING_ENABLED=true APP_VERSION=v2 ./launch-container-instance.sh
    </copy>
    ```

3. Keep the original instance until the replacement passes the tests. Container runtime configuration is versioned by creating a replacement instance rather than editing credentials or code inside a running container.

## Task 3: Test the routing policy

1. Submit a text-only support question. Confirm that the application reports the cheaper model.

2. Attach the sample image and submit an image question. Confirm that the stronger model remains selected.

3. Compare the answers with your baseline. Consider capability, latency, response depth, and token cost rather than treating model size as the only quality signal.

## Task 4: Optional third-model experiment

1. Select another text-capable model that is available in the workshop region and note its model identifier.

2. In the Build path, set `OCI_GENAI_CHEAPER_MODEL` to that identifier and restart the app. In the Launch path, update the generated helper's `CHEAPER_MODEL` value and launch `APP_VERSION=v3`.

3. Run the same text-only prompt for all three candidates and record latency, answer quality, and relative cost. Keep the stronger multimodal model assigned to image input unless the third model supports images.

You may now proceed to Lab 5.

## Learn More

- [OCI Generative AI models](https://docs.oracle.com/en-us/iaas/Content/generative-ai/pretrained-models.htm)

## Acknowledgements

- **Author** - Oracle LiveLabs
