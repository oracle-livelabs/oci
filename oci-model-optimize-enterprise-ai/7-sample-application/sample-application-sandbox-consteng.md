# Lab 3A: Build the Sample Application

## Introduction

In this lab, you extract, configure, and run Seer Construction Intelligence on your own computer. The Gradio app uses OCI Enterprise AI Responses, the unstructured vector store for specification search, the semantic store for NL2SQL, and ADB MCP Server for governed project and supplier retrieval.

Estimated Time: 30 minutes

**File structure used throughout the lab.**

```text
<home-directory>/
├── .oci/
│   ├── config
│   └── oci_hybrid_hol_api_key.pem
└── Downloads/
    └── sample-app/
        └── .env
```

This is the file structure used throughout the lab.

### Objectives

In this lab, you will:

- Extract the sample app archive
- Configure OCI API key authentication
- Configure the sample app environment with the sandbox resource list
- Install Python dependencies
- Run the Gradio app
- Test the vector store, database retrieval, and image prompts
- Capture the values needed for model optimization

### Prerequisites

This lab assumes you have:

- Completed the Semantic Store lab
- Have Python installed on your computer or be able to install it
- Be comfortable with running terminal/command-line commands to copy, rename, edit text files, create folders etc.
- Be able to download the zip archive for the sample application, unzip it and run it as a Python script
- Be able to install Python dependencies with `python -m pip`

> **Note:** If your computer already has Python 3.10 and above installed and `python3 --version` on Mac or `py -3 --version` on Windows shows a valid Python version, move to Task 2.

## Task 1: Install Python

1. Download Python from [python.org/downloads](https://www.python.org/downloads/). Please make sure you choose version 3.10 or newer.

1. Run the installer.

    On Mac, open the downloaded `.pkg` file and complete the installer. It adds `python3` to PATH for new terminal windows.

    On Windows, select **Add python.exe to PATH**, click **Customize installation**, keep the defaults, click **Next**, select **Install Python for all users** and **Add Python to environment variables**, then click **Install**.

1. Open a new terminal or PowerShell window and verify Python.

    On Mac:

    ```bash
    <copy>
    python3 --version
    </copy>
    ```

    On Windows PowerShell:

    ```powershell
    <copy>
    py -3 --version
    </copy>
    ```

## Task 2: Download and extract the configured sample application

1. Copy the **Configured sample app PAR** from the Sandbox Resource List and open it in a new browser tab. Save the download as `sample-app.zip`.

    The archive already contains a generated `.env` file with the compartment, region, Autonomous AI Database, Construction Engineering Vault secret, and application defaults from your sandbox.

    > **Note for Windows:** Extract the app near a short path, such as `C:\labs\sample-app`, before you create the virtual environment or install dependencies. Deep folder paths can cause Windows path-length failures in generated OCI SDK files. If your organization allows it, enabling Windows long paths also avoids this issue.

1. Open a terminal window.

    On Mac:

    - Command + Spacebar
    - Type terminal
    - Press Return.

    > **Note:** The sample application contains a hidden file called `.env.example`. By default, this file cannot be seen in Finder. In order to see hidden files, use the following keyboard shortcut while in Finder: Shift + CMD + Period (the '.' character). This will also be helpful later when we interact with the `~/.oci` folder which is also hidden.

    On Windows:

    - Press the Windows Key
    - Type PowerShell
    - Press Enter.

1. In the terminal, go to the directory where you downloaded `sample-app.zip` (typically `Downloads`).

    On Mac:

    ```bash
    <copy>
    cd ~/Downloads
    </copy>
    ```

    ![Terminal at download folder](./images/terminal-downloads.png)

    On Windows:

    ```powershell
    <copy>
    cd $HOME\Downloads
    </copy>
    ```

    ![PowerShell at download folder](./images/windows-powershell-downloads.png)

1. Extract the sample application archive.

    On Mac:

    ```bash
    <copy>
    unzip sample-app.zip
    </copy>
    ```

    ![Terminal unzip sample app](./images/terminal-unzip-sample-app.png)

    On Windows PowerShell:

    ```powershell
    <copy>
    Expand-Archive -Path .\sample-app.zip -DestinationPath . -Force
    </copy>
    ```

    ![PowerShell unzip the sample app](./images/windows-powershell-unzip-sample-app.png)

1. Confirm that the extraction created the `sample-app` directory.

    On Mac:

    ```bash
    <copy>
    ls -la sample-app
    </copy>
    ```

    On Windows PowerShell:

    ```powershell
    <copy>
    Get-ChildItem .\sample-app
    </copy>
    ```

## Task 3: Configure OCI API key authentication

1. In the OCI Console, open the **Profile** menu (on the top right), then click your user name.

    ![Profile](./images/profile.png)

1. Select the **Tokens and keys** tab.

1. Under API keys, click **Add API key**.

    ![Add API key](./images/add-api-key.png)

1. Select **Generate API key pair**.

1. Click **Download private key** and save the private key file.

    ![Generate API key pair](./images/generate-api-key-pair.png)

    > **Note:** Treat the private key and OCI config as credentials. Do not commit them to source control, paste them into chat or email, or share them with other attendees.

1. Click **Add**.

1. Copy the generated configuration file preview. Save this information in your notes.

    ![Configuration file preview](./images/configuration-file-preview.png)

1. Back in the terminal screen, create the `.oci` directory in your home directory.

    > **Note:** If you already have an `.oci` folder and a `config` file in it, then you can re-use this file. Skip the creation steps and jump to the part where we update the file. Keep the updates at the end of the file so you do not overwrite the existing configuration.

    On Mac:

    ```bash
    <copy>
    mkdir -p ~/.oci
    </copy>
    ```

    On Windows PowerShell:

    ```powershell
    <copy>
    New-Item -ItemType Directory -Force $HOME\.oci
    </copy>
    ```

    ![Create new OCI folder in powershell](./images/window-powershell-create-oci-folder.png)

1. Move the downloaded private key into the `.oci` directory and name it `oci_hybrid_hol_api_key.pem`.

    On Mac, replace `<downloaded-private-key-file>` with the path to the downloaded key. It is typically similar to `~/Downloads/<username>-<date-and-time>.pem`.

    ```bash
    <copy>
    mv <downloaded-private-key-file> ~/.oci/oci_hybrid_hol_api_key.pem
    chmod 600 ~/.oci/oci_hybrid_hol_api_key.pem
    </copy>
    ```

    On Windows PowerShell, replace `<downloaded-private-key-file>` with the downloaded key file name. It is typically similar to `<user-name>-<date-time>.key`.

    ```powershell
    <copy>
    Move-Item $HOME\Downloads\<downloaded-private-key-file> $HOME\.oci\oci_hybrid_hol_api_key.pem
    </copy>
    ```

1. Find your home directory path before you open the OCI config file. Run the commands for your operating system, **then copy the absolute path displayed by `pwd`**. You will paste this value into the `key_file=` line in the configuration file.

    On Mac:

    ```text
    cd ~
    pwd
    ```

    On Windows:

    ```text
    cd $HOME
    pwd
    ```

1. Open the OCI config file. You can use your favorite text editor or `nano` for Mac and `Notepad` for Windows as described below.

    As mentioned above, if this file already exists, scroll down past all of the existing values and take care not to change or overwrite anything existing in the file.

    On Mac:

    ```bash
    <copy>
    nano ~/.oci/config
    </copy>
    ```

    ![Edit the OCI config file](./images/terminal-edit-config-file.png)

    Example of a pre-existing file:

    ![Example of an existing config file edited with nano](./images/terminal-config-file.png)

    On Windows PowerShell:

    ```powershell
    <copy>
    notepad $HOME\.oci\config.
    </copy>
    ```

    > **Note:** Please pay attention to the dot at the end of the file name! If we didn't add it at the end of the file name, Notepad would create a file called config.txt by default. Also, if Notepad is asking if you wish to create a new file, click **Yes**.

1. Paste the configuration file preview into the file. If you already have content in the file, paste the new configuration at the end of the file. In addition, if you already have a `[DEFAULT]` profile in this file, rename this new profile, for example to: `[MODELOPTHOL]`, and remember to change the profile name in the app `.env` file later in this lab.

    ![Edit the config file in the terminal](./images/terminal-edit-config-file2.png)

    ![Editing OCI config file with notepad](./images/notepad-edit-config-file.png)

1. Update the `key_file` line to point to the API private key we've downloaded and moved to the `.oci` folder. Paste the absolute home directory path you copied into the `key_file=` value, then append the private key path shown below. Do not use special expressions such as `~` on Mac or `$HOME`, `%USERPROFILE%` on Windows.

    The completed `key_file` line should use the following format:

    On Mac:

    ```text
    <copy>
    key_file=/Users/<user-name>/.oci/oci_hybrid_hol_api_key.pem
    </copy>
    ```

    On Windows:

    ```text
    <copy>
    key_file=c:\Users\<user-name>\.oci\oci_hybrid_hol_api_key.pem
    </copy>
    ```

    > **Note:** Please make sure to remove the `# TODO` comment from the `key_file` line.

1. Save the file.

    On Mac:

    - Ctrl + X
    - Answer the questions with: Y for Yes
    - Press Return

    On Windows:

    - Ctrl + S

1. Confirm that the config file exists.

    On Mac:

    ```bash
    <copy>
    ls -la ~/.oci/config ~/.oci/oci_hybrid_hol_api_key.pem
    </copy>
    ```

    ![Verify files in terminal](./images/terminal-verify-files.png)

    On Windows PowerShell:

    ```powershell
    <copy>
    Get-ChildItem $HOME\.oci\config, $HOME\.oci\oci_hybrid_hol_api_key.pem
    </copy>
    ```

    ![Windows verify files](./images/windows-verify-files.png)

## Task 4: Complete the app environment file

1. Change into the extracted `sample-app` directory and open the generated `.env` file.

2. Add only the three resources that you created in Labs 1 and 2.

    ```text
    OCI_GENAI_PROJECT_OCID=<Project OCID>
    OCI_GENAI_VECTOR_STORE_IDS=<Unstructured vector store ID starting with vs_>
    OCI_GENAI_SEMANTIC_STORE_OCID=<Semantic store OCID>
    ```

3. Confirm that `OCI_ADB_MCP_USERNAME=CONSTRUCTION_ENGINEERING` and `OCI_AUTH_MODE=config_file` are already present.

4. If you used an OCI profile name other than `DEFAULT`, update `OCI_CONFIG_PROFILE`. Keep both `OCI_GENAI_MODEL_ROUTING_ENABLED=false` and `OCI_GENAI_PROMPT_PROTECTION_ENABLED=false`. You will implement and enable those capabilities in Labs 4 and 5.

5. Save `.env`. Do not commit it because it contains tenancy-specific identifiers.

## Task 5: Install dependencies

1. Create a Python virtual environment. This will help shield your other Python applications from the dependencies we are going to install for the sample app and vice versa.

    > **Note:** Make sure that you are in the `sample-app` folder.

    On Mac:

    ```bash
    <copy>
    python3 -m venv .venv
    </copy>
    ```

    On Windows PowerShell:

    ```powershell
    <copy>
    py -3 -m venv .venv
    </copy>
    ```

2. Activate the environment.

    On Mac:

    ```bash
    <copy>
    source .venv/bin/activate
    </copy>
    ```

    The end result should look similar to this:

    ![Setup venv on mac](./images/terminal-setup-venv.png)

    On Windows PowerShell:

    ```powershell
    <copy>
    .\.venv\Scripts\Activate.ps1
    </copy>
    ```

    If PowerShell blocks script activation, run this command in the same PowerShell window and activate the environment again:

    ```powershell
    <copy>
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
    </copy>
    ```

    The end result should look similar to this:

    ![Setup venv on windows](./images/windows-setup-venv.png)

3. Install the dependencies.

    ```bash
    <copy>
    python -m pip install -r requirements.txt
    </copy>
    ```

## Task 6: Run the app

1. Start the Gradio application.

    ```bash
    <copy>
    python app.py
    </copy>
    ```

2. Leave the terminal running and open the local URL shown by Gradio, normally `http://127.0.0.1:8080`.

3. You should see the Seer Construction Intelligence application. The Build starter intentionally has no **Runtime configuration** menu; developers add the optimization and security decisions in later labs.

4. Note the displayed project code, `AUS-BANK-01`.

    The app scopes governed database questions to this project so generated SQL cannot widen the result set to unrelated projects.

## Task 7: Test the unstructured vector store

1. Ask this question:

    ```text
    <copy>
    Use file_search with the query 'structural engineering requirements Austin'. Search all indexed files, then summarize and cite the retrieved evidence.
    </copy>
    ```

    > **Note:** You can select **Specification requirements** under **Try a prompt** to insert this question, then press **Submit**.

2. Confirm that the answer cites facts from the structural engineering specification rather than inventing project requirements.


3. If the app says it does not have enough information, verify:

    - The `OCI_GENAI_VECTOR_STORE_IDS` variable value in `.env`
    - Data sync job status
    - Vector store file count

4. Notice the steps the application took to generate the response as described in the terminal. Also, notice the model used to process the request.


## Task 8: Test governed construction-data retrieval

Your exact answer can vary by model. Success means the answer is scoped to project `AUS-BANK-01`, cites governed evidence, and uses the database retrieval path.

1. Ask this question:

    ```text
    <copy>
    For project AUS-BANK-01, return the recommended suppliers with recommendation status, fit score, risk level, and explanation. Do not aggregate document names.
    </copy>
    ```

2. Watch the assistant status messages. Review the output in the terminal as it will outline the entire chain of tools the application is using to generate the response. Notice which model was used to process this request.


3. If SQL retrieval fails, verify the values of the following parameters in the `.env` file:

    ```text
    OCI_CONFIG_FILE
    OCI_CONFIG_PROFILE
    OCI_GENAI_SEMANTIC_STORE_OCID
    OCI_ADB_DATABASE_OCID
    OCI_ADB_MCP_USERNAME
    OCI_ADB_MCP_PASSWORD_SECRET_OCID
    ```

## Task 9: Test an image prompt

1. Attach a construction drawing, inspection image, or specification screenshot that does not contain confidential information.

1. In the chat input, attach the downloaded image and add the following prompt:

    ```text
    <copy>
    Summarize the visible construction or engineering details in five bullets. Separate observations from assumptions.
    </copy>
    ```


1. Confirm that the app responds using the image contents.

At this stage, Seer Construction Intelligence can retrieve specification evidence, query governed construction Gold views through the Semantic Store and ADB MCP, analyze an image prompt, and call models managed by OCI Enterprise AI.
We've also observed that the same LLM is being used to serve all requests. We are going to change that in the next lab.

You may now **proceed to the next lab**.

## Learn More

- [OCI Generative AI QuickStart for Responses API](https://docs.oracle.com/en-us/iaas/Content/generative-ai/get-started-agents.htm)
- [SDK and CLI Configuration File](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/sdkconfig.htm)

## Acknowledgements

- **Author** - Julien Lehmann - Product Marketing Manager, Yanir Shahak - Senior Principal Software Engineer
