# Configure the Application to Use the OCI Email Delivery

## Introduction

This lab provides instructions to configure the OCI Email Delivery service.

Estimated Lab Time: 05 minutes

### Objectives

In this lab, you will:

* Create SMTP Credentials
* Set the SMTP server as the public endpoint
* Create an Approved Sender
* Change the "to" Email Address

## Task 1: Create SMTP Credentials

1. From the Oracle Cloud Console, click the **Profile** icon on the top right. Then click on **My profile**.

	![Profile icon](images/profile-icon.jpg#input)

2. From the **Profile details** screen, navigate to **Saved passwords** under **SMTP credentials**. Click **Generate credentials**.

	![Generate SMTP Credentials Button](images/generate-smtp-creds.jpg#input)

3. From the **Generate credentials** panel, enter a description and click the **Generate credentials** button.

	![Generate Credentials Panel](images/generate-creds.jpg#input)

4. The generated SMTP credentials information are displayed. Copy the generated `Username` and `Password` values.

	![Generated SMTP User and Password](images/generated-smtp-creds.jpg#input)

5. Open a new terminal in VS Code using the **Terminal > New Terminal** menu.

6. Use the environment variable `SMTP_USER` to store the value of the generated `Username`.

	Replace `...me.com` with the actual value. Enclose the value in single quotes `' '` (instead of double quotes `" "`) as shown below to handle special characters.

	``` bash
	<copy>
	export SMTP_USER='...me.com'
	</copy>
	```

	Confirm the value of the environment variable `SMTP_USER` by running the following command:

	``` bash
	<copy>
	echo $SMTP_USER
	</copy>
	```

7. Use the environment variable `SMTP_PASSWORD` to store the value of the generated `Password`.

	Replace `nB..` with the actual value. Enclose the value in single quotes `' '` (instead of double quotes `" "`) as shown below to handle special characters.

	``` bash
	<copy>
	export SMTP_PASSWORD='nB..'
	</copy>
	```

	Confirm the value of the environment variable `SMTP_PASSWORD` by running the following command:

	``` bash
	<copy>
	echo $SMTP_PASSWORD
	</copy>
	```

**Note:** In this example, you've used environment variables to store the SMTP user and password values for simplicity. Note that storing secrets in a vault provides greater security than you might achieve by storing secrets elsewhere, such as in configuration files or environment variables.

## Task 2: Set the SMTP server as the public endpoint

Each region in Oracle Cloud Infrastructure has an SMTP endpoint to use as the SMTP server address. Follow the steps to configure the SMTP connection for your region and save the public endpoint, for example, `smtp.email.us-ashburn-1.oci.oraclecloud.com`.

1. From the Oracle Cloud Console navigation menu, go to **Developer Services**. Under **Application Integration**, click **Email Delivery**.

   ![Email Delivery Menu](https://oracle-livelabs.github.io/common/images/console/developer-application-emaildelivery.png)

2. Under **Email Delivery**, click **Configuration**. In **SMTP Sending Information** panel copy **Public Endpoint**.

   ![SMTP Sending information Panel](images/smtp-sending-informatiom.png#input)

3. Set the `SMTP_HOST` variable:

	Replace `your-public-endpoint` with the actual value.

	``` bash
	<copy>
	export SMTP_HOST=<your-public-endpoint>
	</copy>
	```

	Confirm the value of the environment variable `SMTP_HOST` by running the following command:

	``` bash
	<copy>
	echo $SMTP_HOST
	</copy>
	```

## Task 3: Create an Approved Sender

In this step, you will create an approved sender who can send emails using the OCI Email Delivery service.

1. From the Oracle Cloud Console navigation menu, go to the **Developer Services >> Application Integration >> Email Delivery**.

   ![Email Delivery Menu](https://oracle-livelabs.github.io/common/images/console/developer-application-emaildelivery.png)

2. Under **Email Delivery**, click **Approved Senders**. Ensure that you are in the correct compartment. Your user must be in a group with permissions to manage approved-senders in this compartment.

   ![Approved Sender Button](images/approved-senders-button.jpg#input)

3. Click **Create Approved Sender** within the **Approved Senders** view.

   ![Create Approved Sender Panel](images/create-approved-senders.jpg#input)

4. Enter the **gdk@gdk.example** as an approved sender in the **Add Sender** dialog box. Click **Create Approved Sender**.

   ![Add Approved Sender Panel](images/add-approved-sender.jpg#input)

   The email address is added to your approved senders list.

   **Note:** Approved senders are unique to tenancies. If you try to create a duplicate approved sender within a tenancy, a 409 Conflict error is displayed.

   ![Duplicate Approved Sender](images/duplicate-approved-sender.jpg#input)

5. Set `FROM_EMAIL` and `FROM_NAME` values:

	``` bash
	<copy>
	export FROM_EMAIL=<email-from-the-previous-step>
	export FROM_NAME=gdk
	</copy>
	```

   A dialog box will ask **Are you sure you want to paste 2 lines of text into the terminal?**. Select **Do not ask me again** and click **Paste** to proceed.

   ![VS Code Paste Icon](images/vs-code-paste-icon.jpg#input)

   Confirm the values of the environment variables `FROM_EMAIL` and `FROM_NAME` by running the following command:

	``` bash
	<copy>
	echo $FROM_EMAIL
	echo $FROM_NAME
	</copy>
	```

## Task 4: Change the "to" Email Address

In this step, you'll change the "to" email address to your personal email address so that you can verify the emails sent by the application in subsequent steps.

1. Go to `EmailController.java` and replace `recipient@gdk.example` with your personal email address. Specify a valid personal email address so you can see the emails sent by this application in the next section.

   _oci/src/main/java/com/example/EmailController.java_

	``` java
	class EmailController {

		private final String toEmail = "recipient@gdk.example";
	```

2. Save (`CTRL+S`) the file.

3. Go to `EmailControllerTest.java` and replace `recipient@gdk.example` with your personal email address. Use the same email address you entered in `EmailController.java` above.

	_oci/src/test/java/com/example/EmailControllerTest.java_

	``` java
	class EmailControllerTest {

		...

		private final String toEmail = "recipient@gdk.example";
		List<Email> emails = new ArrayList<>();

		...
	```

4. Save (`CTRL+S`) the file.

Congratulations! In this lab, you configured the application to use OCI Email Delivery.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
