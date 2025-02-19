# Clone the Sample Application Source Code

## Introduction

This lab describes the steps to download the sample application source code used in the workshop.

Estimated Lab Time: 5 minutes

### Objectives

In this lab, you will:

* Clone the sample application source code

## Task 1: Clone the Sample Application Source Code

1. From the **Activities** menu, start a new **Terminal** window.

2. Clone the sample application source code.

	``` bash
	<copy>
	git init lab
	cd lab
	git remote add origin https://github.com/oracle-samples/gdk-micronaut-samples.git
	git config core.sparsecheckout true
	echo "gdk-oci-oke-mvn/*">>.git/info/sparse-checkout
	git pull --depth=1 origin main
	</copy>
	```

3. Open the sample application source code from the _gdk-oci-oke-mvn_ directory in **Visual Studio Code**.

	``` bash
	<copy>
	code gdk-oci-oke-mvn
	</copy>
	```

4. VS Code may show a dialog box with the message "Do you trust the authors of the files in this folder?". Select **Trust the authors of all files in the parent folder 'oracle'** and click **Yes, I trust the authors**.

5. VS Code may ask you to choose a password for new keyring. Press **Cancel** twice to close the prompt.

6. VS Code may show a dialog box with the message "A git repository was found in the parent folders of the workspace or the open file(s). Would you like to open the repository?". Click **Never**.

	![VS Code Question Icon](images/vs-code-question-icon.jpg#input)

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
