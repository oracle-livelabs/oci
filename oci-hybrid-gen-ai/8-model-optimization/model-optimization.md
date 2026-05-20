# Model Optimization

## Introduction

In this lab, you compare model choices for the Example Motors support agent. The app can use a stronger model for image prompts and a cheaper, faster model for text-only prompts. This lets the app optimize for capability, response speed, response depth, and cost per token.

Estimated Time: 15 minutes

### Objectives

In this lab, you will:

- Enable the model-routing hook in the app
- Compare model behavior for text-only and image prompts
- Record the tradeoff you would choose for production

### Prerequisites

This lab assumes you have:

- Completed the Sample Application lab

## Task 1: Enable model routing

1. Stop the application by pressing `CTRL + C` in the terminal/console.

1. Open `llm.py` in your text editor. Please make sure you are still in the `sample-app` folder. You. can choose your own text editor or:

    On Mac:

    ```bash
    <copy>
    nano llm.py
    </copy>
    ```

    On Windows PowerShell:

    ```powershell
    <copy>
    notepad llm.py
    </copy>
    ```

1. Find the `response_model` function.

    It contains these commented lines:

    ```python
    <copy>
    #if not messages_include_images(messages):
    #    model = cfg["cheaper_model"]
    </copy>
    ```

1. Uncomment the lines and keep the indentation inside the function. The function should look like this:

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

1. Save the file.

1. Restart Streamlit.

    ```bash
    <copy>
    streamlit run app.py
    </copy>
    ```

## Task 2: Test text-only routing

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
    Sending prompt to LLM (<cheaper-model-id>)...
    </copy>
    ```

4. Notice the following aspects:

    - Approximate response time
    - Answer quality

## Task 4: Test image routing

1. Download the [test image](./files/example-motors-service-receipt.png).

1. Attach the image to the request and add the following prompt:

    ```text
    <copy>
    What service does this receipt describe?
    </copy>
    ```

1. Confirm that the status shows the default stronger model:

    ```text
    <copy>
    Sending prompt to LLM (<stronger-model-id>)...
    </copy>
    ```

1. Notice the following aspects:

    - Approximate response time
    - Answer quality

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

In this lab we have explored a simple routing mechanism to select which LLM will process our request. We can optimize for performance, accuracy & cost. You could explore additional routing mechanism like intent based routing where the routing decision is made based on the use-case the user is interested in (for example: billing/finance, account related information, technical support etc.) where each use-case will trigger a different LLM.

You may now **proceed to the next lab**.

## Learn More

- [OCI Generative AI QuickStart for model selection](https://docs.oracle.com/en-us/iaas/Content/generative-ai/get-started-agents.htm)
- [OCI Generative AI models](https://docs.oracle.com/en-us/iaas/Content/generative-ai/pretrained-models.htm)
- [OCI cost analysis overview](https://docs.oracle.com/en-us/iaas/Content/Billing/Concepts/costanalysisoverview.htm)

## Acknowledgements

- **Author** - Julien Lehmann, Product Marketing Manager, Yanir Shahak, Senior Principal Software Engineer
