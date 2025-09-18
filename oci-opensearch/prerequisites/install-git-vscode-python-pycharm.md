# Install Git, VS CODE, Python and PyCharm

## Introduction

In this lab, your focus is to install some IDEs in your local machine so you can download sample code and execute to access your cluster and perform task such as data ingestion, data exploratory analysis, semantic search, visual search, conversational search, integration with LangChain, etc.

**Estimated Time: 10 minutes**

### Objectives

In this lab, you will:
1. Install *Python* on macOS and Windows
2. Install/verify *pip*
3. Install *PyCharm* and Jupyter Notebook
4. Install *Visual Studio Code* (VS Code)
5. Create & activate a virtual environment (*venv*)
6. Configure PyCharm to use your *venv*

<br/><br/>

## Task 1: Install python 3

There are several options for you to install python 3 on you local machine:

1. **On Mac:** using package installer:
   - For MacOS: navigate to the [python](https://www.python.org/downloads/macos/) and select what python 3 version you want to install. You choose the latest stable release
   - Click on the installer package for your version to download the package installer. e.g:  [install python 3.13.7](https://www.python.org/ftp/python/3.13.7/python-3.13.7-macos11.pkg)
   - Open your Download folder, locate the the **.pkg** installer file you just downloaded and double click on it to launch the installer. Follow the instructions to install python 3 on your machine.
   - Confirm install:

```powershell
<copy>
python3 --version
pip3 --version
</copy>
```

> Tip: On macOS, Python runs as `python3` and `pip3` by default.

<br/><br/>

2. **On Windows:**
   - Download the latest **Python 3** installer for Windows:
      - [Python Releases for Windows](https://www.python.org/getit/windows/)
   - **Important:** Check **“Add Python to PATH”** during setup.
   - Choose “Install Now” and finish.
   - Confirm install (Command Prompt / PowerShell):

```powershell
<copy>
py --version
py -m pip --version
</copy>
```


<br/><br/>

## Task 2: Install ```pip```

Most modern Python installers include ```pip```. If it’s missing, use one of the options below.
1. Quick check

```powershell
<copy>
# macOS/Linux
python3 -m pip --version

# Windows
py -m pip --version
</copy>
```

2. Ensure with built-in ```ensurepip```

```powershell
<copy>
# macOS/Linux
python3 -m ensurepip --upgrade

# Windows
py -m ensurepip --upgrade
</copy>
```

3. Fallback: ```get-pip.py```
   - Download ```get-pip.py```: https://bootstrap.pypa.io/get-pip.py
   - Run:

```powershell
<copy>
# macOS/Linux
python3 get-pip.py

# Windows
py get-pip.py
</copy>
```

<br/><br/>

## Task 3: Install PyCharm & Jupyter Notebook (Optional)

1. **PyCharm (IDE)**
   - **Download:**  [Community (free) or Professional](https://www.jetbrains.com/pycharm/download/)
   - **Install:** Run the installer and accept defaults.

   **Optional:** Install via JetBrains Toolbox (auto-updates & easy management).
   - Toolbox info: https://www.jetbrains.com/help/pycharm/installation-guide.html

2. **Jupyter Notebook:**
You can install Jupyter with `pip` (works great for this lab):

```powershell
<copy>
# macOS/Linux
python3 -m pip install --upgrade pip
python3 -m pip install notebook

# Windows
py -m pip install --upgrade pip
py -m pip install notebook
</copy>
```

Run it:
```bash
<copy>
jupyter notebook

# Or

jupyter-notebook
</copy>
```
It will open your browser at `http://localhost:8888`.


<br/><br/>

## Task 4: Install Visual Studio Code (VS Code)


1.  **Download and Install:** [Visual Studio](https://code.visualstudio.com/download). Be sure to select the installer that corresponds to your computer architecture e.g **Intel Chip** or **Apple Silicon**
2. **Install the Python extension (inside VS Code):**
  - Open VS Code → **Extensions** (⇧⌘X on macOS / Ctrl+Shift+X on Windows)
  - Search **“Python”** by Microsoft → **Install**
  - (Optional) Reload when prompted

Useful docs:
- Python in VS Code: https://code.visualstudio.com/docs/languages/python



<br/><br/>

## Task 5: Create & Activate a Virtual Environment (venv) - (Optional)

> A virtual environment keeps project dependencies isolated.

### macOS / Linux

```powershell
<copy>
# 1) Navigate to your project folder
cd ~/Users/<YOU>/<PATH-TO-PROJECT-FOLDER>>

# 2) Create a venv named .venv
python3 -m venv .venv

# 3) Activate it
source .venv/bin/activate

# 4) Verify
python --version
pip --version
</copy>
```

To **deactivate** later:

```bash
<copy>
deactivate
</copy>
```

### Windows (CMD or PowerShell)

```powershell
<copy>
# 1) Navigate to your project folder
cd C:\Users\<YOU>\projects\my-app

# 2) Create a venv named .venv
py -m venv .venv

# 3) Activate it
# PowerShell:
.venv\Scripts\Activate.ps1
# (If execution policy blocks it: Set-ExecutionPolicy -Scope CurrentUser RemoteSigned)

# CMD:
.venv\Scripts\activate.bat

# 4) Verify
python --version
pip --version
</copy>
```

> Tip: Use a `.venv` folder at the project root so common tools (PyCharm, VS Code) auto-detect it.






<br/><br/>

## Task 6: Configure PyCharm to Use Your Virtual Environment  (Optional)

You can either **create the venv from PyCharm** or **point PyCharm to an existing venv**.

1. **Create venv from PyCharm**
   - Open your project in PyCharm.
   - Go to **Settings/Preferences → Python | Interpreter**.
   - Click the gear icon → **Add…** → **Add Local Interpreter**.
   - Choose **Virtualenv Environment** → **New**.
   - Verify **Location** (ideally `<project>/.venv`) → **OK**.
   - PyCharm will index and use this interpreter.

2. **Use an existing venv (recommended if you created `.venv` via CLI)**
   - **Settings/Preferences → Python | Interpreter**.
   - Gear icon → **Add…** → **Add Local Interpreter**.
   - Select **Virtualenv Environment** → **Existing**.
   - Browse to your interpreter:
      - **macOS/Linux:** `<project>/.venv/bin/python`
      - **Windows:** `<project>\.venv\Scripts\python.exe`
   - **OK** to apply.



3. **Quick Smoke Test**

With your venv active (terminal or PyCharm), run:

```powershell
<copy>
python -c "import sys; print(sys.executable)"
python -m pip install requests
python -c "import requests; print('OK', requests.__version__)"
</copy>
```

Expected: prints the venv’s Python path and `OK <version>`.

---

<br/><br/>

## Handy Links (official)

- Python downloads: https://www.python.org/downloads/
- pip docs: https://pip.pypa.io/en/stable/installation/
- venv docs: https://docs.python.org/3/library/venv.html
- Jupyter install: https://jupyter.org/install
- PyCharm download: https://www.jetbrains.com/pycharm/download/
- Configure interpreter in PyCharm: https://www.jetbrains.com/help/pycharm/configuring-python-interpreter.html
- VS Code download: https://code.visualstudio.com/download
- Python in VS Code: https://code.visualstudio.com/docs/languages/python

---

<br/><br/>

### Appendix: Common Commands Cheat-Sheet

```powershell
<copy>
# Create venv
python3 -m venv .venv           # macOS/Linux
py -m venv .venv                # Windows

# Activate venv
source .venv/bin/activate       # macOS/Linux
.venv\Scripts\Activate.ps1    # Windows PowerShell
.venv\Scripts\activate.bat    # Windows CMD

# Upgrade pip
python -m pip install --upgrade pip

# Install Jupyter
python -m pip install notebook

# Run Jupyter
jupyter notebook
</copy>
```

## Acknowledgements

* **Author** - **Landry Kezebou**, Lead AI/ML Engineer, OCI Opensearch
* **Created** - September 2025
