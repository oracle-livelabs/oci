# Clone the Sample Application Source Code

## Introduction

This lab describes the steps to download the sample application source code used in the workshop.

Estimated Lab Time: 5 minutes

### Objectives

In this lab, you will:

* Clone the sample application source code

## Task 1: Clone the Sample Application Source Code

1. From the **Activities** menu, start a new **Terminal** window.

2. Create and navigate to the _lab_ directory.

	```bash
	<copy>
	git init lab
	cd lab
	</copy>
	```

3.	Clone the sample application source code into the _lab_ directory.

	```bash
	<copy>
	git remote add origin https://github.com/sachin-pikle/gdk-oci-samples.git
	git config core.sparsecheckout true
	echo "gdk-oci-email-mvn/*">>.git/info/sparse-checkout
	git pull --depth=1 origin main
	</copy>
	```

4.	Open the sample application source code from the _lab_ directory in **Visual Studio Code**.

	```bash
	<copy>
	code lab
	</copy>
	```

5. VS Code may show a dialog box with the message "Do you trust the authors of the files in this folder?". Select **Trust the authors of all files in the parent folder 'oracle'** and click **Yes, I trust the authors**.

6. VS Code may ask you to choose a password for new keyring. Press **Cancel** twice to close the prompt.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
