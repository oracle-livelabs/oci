# Model Optimization

## Introduction

In this lab, you compare model choices for the Example Motors support agent. The app can use a stronger multimodal model for image prompts and a cheaper, faster text model for text-only prompts. This lets the app optimize for capability, response speed, response depth, and cost per token.

Estimated Time: 15 minutes

### Objectives

In this lab, you will:

- Configure a default multimodal model
- Configure a cheaper text model
- Enable the model-routing hook in the app
- Compare model behavior for text-only and image prompts
- Record the tradeoff you would choose for production

### Prerequisites

This lab assumes you have:

- Completed the Web Application lab
- A working `.env` file in `sample-app`
- At least one vision-capable model available in your workshop region
- At least one lower-cost or faster text model available in your workshop region

## Task 1: Choose model roles

1. Open `sample-app/.env`.

2. Set the default model to a vision-capable model.

    This model handles image prompts and any prompt that needs multimodal capability:

    ```text
    <copy>
    OCI_GENAI_MODEL=<vision-capable-model-id>
    </copy>
    ```

3. Set the cheaper model to a fast text model.

    This model handles text-only prompts after you enable routing:

    ```text
    <copy>
    OCI_GENAI_CHEAPER_MODEL=<fast-text-model-id>
    </copy>
    ```

4. Keep the max output token limit modest while testing.

    ```text
    <copy>
    OCI_GENAI_MAX_OUTPUT_TOKENS=1000
    </copy>
    ```

5. Save `.env`.

## Task 2: Enable model routing

1. Open `sample-app/llm.py`.

2. Find the `response_model` function.

    It contains these commented lines:

    ```python
    <copy>
    #if not messages_include_images(messages):
    #    model = cfg["cheaper_model"]
    </copy>
    ```

3. Uncomment the lines and keep the indentation inside the function.

    The function should look like this:

    ```python
    <copy>
    def response_model(model, cfg, messages=None):
        # Uncomment to route image prompts to a stronger vision model and text-only
        # prompts to a cheaper text model.
        if not messages_include_images(messages):
            model = cfg["cheaper_model"]

        return model
    </copy>
    ```

4. Save the file.

5. Restart Streamlit.

    ```bash
    <copy>
    streamlit run app.py
    </copy>
    ```

## Task 3: Test text-only routing

1. Ask a text-only question:

    ```text
    <copy>
    What service appointments do you have for my vehicle, and how much did I pay?
    </copy>
    ```

2. Watch the app status text.

3. Confirm that the status shows the cheaper text model:

    ```text
    <copy>
    Sending prompt to LLM (<fast-text-model-id>)...
    </copy>
    ```

4. Record:

    ```text
    <copy>
    Text-only model:
    Approximate response time:
    Answer quality:
    Any missing detail:
    </copy>
    ```

## Task 4: Test multimodal routing

1. Attach the image:

    ```text
    <copy>
    data/example-motors-service-receipt.png
    </copy>
    ```

2. Ask:

    ```text
    <copy>
    What service does this receipt describe?
    </copy>
    ```

3. Confirm that the status shows the default vision-capable model:

    ```text
    <copy>
    Sending prompt to LLM (<vision-capable-model-id>)...
    </copy>
    ```

4. Record:

    ```text
    <copy>
    Image model:
    Approximate response time:
    Answer quality:
    Image details captured:
    </copy>
    ```

## Task 5: Compare model tradeoffs

1. Compare the two runs.

2. Use this decision checklist:

    ```text
    <copy>
    Use a faster text model when:
    - The request is text-only
    - Tools can ground the answer
    - Short response time matters
    - Lower token cost matters

    Use a stronger multimodal or deeper model when:
    - The request includes an image
    - The user asks for deeper reasoning
    - The task needs better instruction following
    - Accuracy is more important than latency
    </copy>
    ```

3. Keep the routing hook enabled for the remaining labs.

You may now **proceed to the next lab**.

## Learn More

- [OCI Generative AI QuickStart for model selection](https://docs.oracle.com/en-us/iaas/Content/generative-ai/get-started-agents.htm)
- [OCI Generative AI models](https://docs.oracle.com/en-us/iaas/Content/generative-ai/pretrained-models.htm)
- [OCI cost analysis overview](https://docs.oracle.com/en-us/iaas/Content/Billing/Concepts/costanalysisoverview.htm)

## Acknowledgements

- **Author** - Julien Lehmann, Product Marketing Manager, Yanir Shahak, Senior Principal Software Engineer
