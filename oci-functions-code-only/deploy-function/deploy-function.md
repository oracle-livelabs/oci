# Deploy and Trigger an Inventory-Processing Function

## Introduction

Create a Python function from a ZIP archive and connect it to an Object Storage upload event. Verify that an inventory CSV automatically produces restock and rejected-record reports.

Estimated Lab Time: 30-35 minutes.

### Objectives

- Review or generate the processing module and run the supplied checks in Cloud Shell.
- Deploy a code-only function in the prepared application.
- Connect an Object Storage event and verify the resulting reports.

### Prerequisites

- Complete **Get Started** using the sandbox or own-tenancy instructions.
- Have access to the prepared application, buckets, network, logging, and learner permissions.
- Use the assigned resource names if they differ from the examples.
- Optional: access to an AI coding assistant; the tested reference code is also provided.

## Task 1: Prepare and check the Python code

**Time:** 8 minutes. **Outcome:** Your inventory-processing code passes the supplied checks.

1. Download the [source and sample data bundle](files/inventory-lab-source.zip). It includes the reference code, four input CSVs, expected reports, a checker, and the reference function ZIP. Extract the bundle before deploying; the outer source bundle is not itself a function archive.

2. Open **Cloud Shell** from the Console's **Developer tools** menu and wait for the terminal prompt. Run every command in this task in **Cloud Shell**, not a terminal on your own computer. In the Cloud Shell panel, select **Menu > Upload**, select `inventory-lab-source.zip`, and select **Upload**. Wait for **Completed**, then close the transfer dialog. The file is uploaded to your Cloud Shell home directory.

![Cloud Shell upload dialog with the source bundle selected](images/02a-cloud-shell-upload.png "Upload the teaching bundle to Cloud Shell")

3. Confirm Python 3.12 is available, then extract the bundle into a new directory and open it:

```bash
python3.12 --version
mkdir inventory-lab && unzip inventory-lab-source.zip -d inventory-lab && cd inventory-lab
```

The first command should print `Python 3.12.x`. Use `python3.12` explicitly: the default `python3` can be a different version. If the command is unavailable, ask your facilitator to check the Cloud Shell environment. If `inventory-lab` already exists from an earlier attempt, use a new directory name throughout this task instead of overwriting it.

> **No dependency installation is needed:** The supplied checker, reference processing module, and repackaging script use only Python's standard library. Do not run `pip install` or install `requirements.txt` for this task. The function's OCI libraries are already inside the supplied deployment ZIP; Cloud Shell does not need to install or load them.

4. Read the [AI prompt](files/ai-prompt.txt). If using an AI assistant, submit the prompt and save its Python output as `function/inventory.py`, replacing the reference module. If you prefer the reference path, keep the supplied file and review its rules.

The function `process_inventory(csv_text, threshold=10)` returns two CSV strings. It trims values, uppercases product and warehouse codes, checks quantities, and selects valid rows with `quantity < threshold`.

> **Note:** Generate only the inventory-processing module. The supplied `func.py` handles OCI event parsing, Object Storage reads and writes, and logs. No AI service is called when the deployed function runs.

5. Run the checker from the `inventory-lab` directory:

```bash
python3.12 verify_inventory.py
```

6. Confirm that the output says **Ran 6 tests** and ends with **OK**. The tests cover all four sample files, normalization, threshold boundaries, and invalid input. If a generated implementation fails, read the failed assertion, correct the module, and run the checker again. Keep generated code limited to the standard library as the prompt requests; use the supplied reference version if you get stuck.

7. Open `inventory-run1.csv` and find the first five quantities: **2, 4, 5, 7, 9**. These are the five products expected in the initial restock report. A quantity of exactly **10** does not qualify.

8. If you changed `function/inventory.py`, repackage your code with the supplied dependencies:

```bash
python3.12 package_logic.py
```

This creates **inventory-reporter-custom.zip**, keeping the tested Linux dependencies from the reference archive. You can also run this command with the unchanged reference module to practice packaging.

![Cloud Shell running Python 3.12, passing all six checks, and creating the custom function ZIP](images/02b-cloud-shell-checks.png "Successful checks and repackaging in Cloud Shell")

9. To download your custom archive, select **Menu > Download** in the Cloud Shell panel. Enter the path below, relative to your **home directory**, and select **Download**. Do not add a leading `/` or `~/` in the dialog; it already supplies `~/`.

```text
inventory-lab/inventory-reporter-custom.zip
```

![Cloud Shell download dialog with the home-relative custom archive path](images/02c-cloud-shell-download.png "Download the function ZIP to your computer")

If using the unchanged reference implementation, you can instead use **inventory-reporter.zip** from the bundle extracted on your computer. Either way, you need the function ZIP on your computer for Task 2, not the outer `inventory-lab-source.zip`.

> **Checkpoint:** All checks pass. You can explain why the default rule selects five rows from the 20-row sample.

## Task 2: Create the function in your application

**Time:** 10 minutes. **Outcome:** The `inventory-reporter` function is active in `livelab-inventory-app`.

1. Open **Functions**, select **LiveLab**, and open **livelab-inventory-app**.

2. Select the **Functions** tab, open **Actions**, and select **Create from archive**.

![Application Functions tab with Create from archive in the Actions menu](images/03-create-from-archive-menu.png "Create from archive")

The reference image already contains a tested function. In a fresh lab, you create your own function here.

3. Enter **inventory-reporter** as the name. Under **File source**, select **Upload from your device**.

4. Select the reference **inventory-reporter.zip**, or the **inventory-reporter-custom.zip** you generated and checked in Task 1. Upload the function archive itself, not the outer source bundle.

5. Enter the settings below. The handler value means: load `func.py` from the archive's `function/` directory and call its `handler` function. The reference archive includes the OCI SDK and its Linux dependencies; the managed runtime supplies FDK. Do not rely on `requirements.txt` being installed during deployment.

The function will use these settings:

| Setting | Lab value |
| --- | --- |
| Compartment | `LiveLab` |
| Application | `livelab-inventory-app` |
| Function name | `inventory-reporter` |
| Runtime | `python312.ol9` |
| Handler | `func.handler` |
| Memory | 256 MB |
| Synchronous invocation timeout | 60 seconds |
| Runtime version management | Function update |
| Input bucket | `livelab-inventory-incoming` |
| Output bucket | `livelab-inventory-output` |
| Low-stock threshold | `10` |

The application supplies `INPUT_BUCKET`, `OUTPUT_BUCKET`, `OBJECT_STORAGE_NAMESPACE`, and `LOW_STOCK_THRESHOLD` as configuration. The function uses its OCI resource identity to access the buckets; there are no personal credentials in the code.

6. Leave provisioned concurrency disabled and the destination settings at their defaults. Select **Create** and wait until the function is **Active**.

![Active inventory-reporter function with Python runtime, handler, memory, and timeout](images/04-function-active.png "Successful function deployment")

**Function update** means that OCI adopts a newer managed runtime version when the function is modified. The Python source and dependencies are in your archive; OCI manages the execution runtime.

> **Checkpoint:** Do not continue until the deployed function is **Active** and the application configuration matches the lab environment.

## Task 3: Connect the upload event

**Time:** 7 minutes. **Outcome:** An Events rule targets your function when a new object is created in the incoming bucket.

1. Search for **Events** in the Console and open the Events rules page. Select the **LiveLab** compartment.

2. Select **Create rule**, name the rule **livelab-inventory-upload**, and use a description such as `Process new supplier inventory CSV files`.

3. Configure the event condition:

| Field | Value |
| --- | --- |
| Condition | Event Type |
| Service | Object Storage |
| Event type | Object - Create |

4. Add an attribute condition for **bucketName**, with the value **livelab-inventory-incoming**. This restricts the rule to the lab's input bucket.

5. Add a **Functions** action and select the **LiveLab** compartment, **livelab-inventory-app** application, and **inventory-reporter** function.

![Rule fields showing Object Create, incoming bucket, application, and function](images/05-event-function-target.png "Event condition and function action")

This reference image reviews an existing rule in **Edit rule**. When creating your rule for the first time, complete these fields in **Create rule**.

6. Create the rule and confirm that it is enabled. Inspect the condition and target once more before uploading a file.

![Active rule with Object Create and the incoming bucketName attribute](images/05-event-condition.png "Verify the event condition")

> **Note:** The function must exist before it can be selected as a rule action. Use a new object name for each exercise; replacing an existing object is an update, while this lab listens for object creation.

> **Checkpoint:** The enabled rule matches **Object - Create** for the incoming bucket and names your function as its action.

## Task 4: Upload inventory and inspect the reports

**Time:** 7-10 minutes. **Outcome:** You see five restock rows and an empty rejected-records report.

1. Download [inventory-run1.csv](files/inventory-run1.csv) to your computer. If your browser displays the CSV, save it as a file with that name.

2. In Object Storage, open **livelab-inventory-incoming** and select **Upload objects**.

![Object Storage upload dialog with file selection and Next](images/02-upload-dialog.png "Select the inventory CSV")

3. Leave **Object name prefix** blank and choose `inventory-run1.csv`. Keep **Standard** storage tier, select **Next**, review the file, and complete the upload.

4. Open **livelab-inventory-output**, then its **Objects** tab. Refresh the list until you see the `inventory-run1/` prefix. Event delivery and execution are asynchronous; the reports may not appear immediately.

5. Open that prefix and download **restock-report.csv** and **rejected-records.csv**.

![Output bucket containing restock-report.csv and rejected-records.csv](images/06-generated-reports.png "Both reports were created automatically")

Your first upload uses `inventory-run1.csv` and produces `inventory-run1/`. A different new filename changes only the output prefix.

6. Compare the reports with the expected result:

| Report | Expected data rows | What to look for |
| --- | --- | --- |
| `restock-report.csv` | 5 | INV-001 through INV-005; normalized SKU and warehouse codes |
| `rejected-records.csv` | 0 | Only the `record_id,reason` header |

7. Check that the product with a quantity of **10** is absent from the restock report. The condition is **less than 10**, not less than or equal to 10.

> **Checkpoint:** Uploading a CSV produced two reports without a manual function invocation. You created an event-driven workflow: upload, match event, run code, write results.

If reports have not appeared after a few minutes, verify the region, input bucket, new filename, enabled rule, and function target. Then inspect the application's invocation logs. A `reports_written` message includes the source filename and report counts. Ask the facilitator for help if there is no invocation or a permissions error.


## Task 5: Recap and choose your next step

You created an event-driven workflow: upload an inventory CSV, match an event, run Python code, and write two reports.

1. Explain what caused the function to run, where it read data, and where it wrote its results.

2. To explore configuration changes and rejected-row diagnosis, proceed to **Lab 2: Configure and Troubleshoot Your Function (Optional)** using the workshop navigation. Keep your resources for that lab.

3. If you are finishing here, follow your facilitator's cleanup guidance. In your own tenancy, coordinate cleanup with the resource owner. Do not delete shared or unrelated resources.
