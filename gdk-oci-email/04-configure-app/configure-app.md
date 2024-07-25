# Configure the Application to Use the OCI Email Delivery

## Introduction

This lab provides instructions to configure the OCI Email Delivery service.

Estimated Lab Time: 05 minutes

### Objectives

In this lab, you will:

* <if type="desktop">Use</if><if type="tenancy">Configure</if> OCI Instance Principal Authentication
* Set environment variables
* Create SMTP Credentials
* Create an Approved Sender
* Change the "to" Email Address

## Task 1: <if type="desktop">Use</if><if type="tenancy">Configure</if> OCI Instance Principal Authentication

1. In VS Code, open `application-oraclecloud.properties`. The application is configured to use `OCI Instance Principal Authentication` when it is running on an OCI Compute Instance.

	_oci/src/main/resources/application-oraclecloud.properties_

	``` properties
	oci.config.instance-principal.enabled=true
	```

<if type="desktop">
2. The workshop environment includes a preconfigured `Instance Principal` using a `Dynamic Group` and a `Policy` in OCI to allow the application to manage (upload, list, download, and delete) emails in the OCI Email Delivery service
</if>

<if type="tenancy">
2. The following steps show you how to set up an `Instance Principal` using a `Dynamic Group`-less `Policy` in OCI to allow the application in a Compute Instance to manage (upload, list, download, and delete) emails in the OCI Email Delivery service
.

3. From the Oracle Cloud Console navigation menu, go to **Identity & Security >> Identity >> Policies**.

4. Go to your workshop compartment.

5. Click  **Create Policy**.

6. Enter a name and description.

7. Select your workshop compartment.

8. In the **Policy Builder** section, click **Show manual editor**.

9. Enter the following policy statement in the text area. Replace the placeholders `WORKSHOP_COMPARTMENT_NAME` with your workshop compartment name, and `WORKSHOP_COMPARTMENT_OCID` with your workshop compartment OCID.

	``` text
	<copy>
	Allow any-user to manage email-family in compartment WORKSHOP_COMPARTMENT_NAME where ALL {request.principal.type='instance', request.principal.compartment.id='WORKSHOP_COMPARTMENT_OCID'}
	</copy>
	```
</if>

	To learn more about about the supported authentication options, see [Micronaut Oracle Cloud Authentication](https://micronaut-projects.github.io/micronaut-oracle-cloud/snapshot/guide/#authentication).


## Task 2: Set Environment Variables

1. In VS Code, open `application-oraclecloud.properties`. The application configuration uses two environment variables `OBJECT_STORAGE_NAMESPACE` and `OBJECT_STORAGE_BUCKET`.

	_oci/src/main/resources/application-oraclecloud.properties_

	``` properties
	micronaut.object-storage.oracle-cloud.default.namespace=${OBJECT_STORAGE_NAMESPACE}
	micronaut.object-storage.oracle-cloud.default.bucket=${OBJECT_STORAGE_BUCKET}
	```

2. Open a new terminal in VS Code using the **Terminal > New Terminal** menu.

3. Run the following command to set the environment variable `OBJECT_STORAGE_NAMESPACE`:

	``` bash
	<copy>
	export OBJECT_STORAGE_NAMESPACE=$(oci os ns get --auth instance_principal --query "data" --raw-output)
	</copy>
	```

4. Confirm the value set by running the following command:

	``` bash
	<copy>
	echo $OBJECT_STORAGE_NAMESPACE
	</copy>
	```

5. Set the environment variable `OBJECT_STORAGE_BUCKET` using the bucket name from the previous lab.

	``` bash
	<copy>
	export OBJECT_STORAGE_BUCKET=<name-of-the-bucket-you-created>
	</copy>
	```

6. Confirm the value set by running the following command:

	``` bash
	<copy>
	echo $OBJECT_STORAGE_BUCKET
	</copy>
	```

## Task 3: Create SMTP Credentials

1. From the Oracle Cloud Console, click the **Profile** icon on the top right. Then click on **My profile**.
	![Profile icon](images/profile-icon.jpg#input)

<if type="desktop">
2. The workshop environment includes a preconfigured `Instance Principal` using a `Dynamic Group` and a `Policy` in OCI to allow the application to manage (upload, list, download, and delete) objects in the OCI Object Storage bucket.
</if>

<if type="tenancy">
2. The following steps show you how to set up an `Instance Principal` using a `Dynamic Group`-less `Policy` in OCI to allow the application in a Compute Instance to manage (upload, list, download, and delete) objects in the OCI Object Storage bucket.

3. From the **Profile details** screen, click **SMTP credentials** under **Resources**. Click **Generate credentials**.

    ![Generate SMTP Credentials Button](images/generate-smtp-creds.jpg#input)

4. From the **Generate credentials** panel, enter a description and click the **Generate credentials** button.

    ![Generate Credentials Panel](images/generate-creds.jpg#input)

5. The generated SMTP credentials information are displayed. Copy the generated `Username` and `Password` values.

    ![Generated SMTP User and Password](images/generated-smtp-creds.jpg#input)

6. Open a new terminal in VS Code using the **Terminal>New Terminal** menu.

7. Use the environment variable `SMTP_USER` to store the value of the generated `Username`.

   Replace `...me.com` with the actual value. Enclose the value in single quotes `' '` (instead of double quotes `" "`) as shown below to handle special characters.

   ``` 
   export SMTP_USER='...me.com'
   ```

   Confirm the value of the environment variable `SMTP_USER` by running the following command:

   ```
   echo $SMTP_USER
   ```

8. Use the environment variable `SMTP_PASSWORD` to store the value of the generated `Password`.

   Replace `nB..` with the actual value. Enclose the value in single quotes `' '` (instead of double quotes `" "`) as shown below to handle special characters.

   ``` 
   export SMTP_PASSWORD='nB..'
   ```

   Confirm the value of the environment variable `SMTP_PASSWORD` by running the following command:

   ```
   echo $SMTP_PASSWORD
   ```
**Note:** In this example, you've used environment variables to store the SMTP user and password values for simplicity. Note that storing secrets in a vault provides greater security than you might achieve by storing secrets elsewhere, such as in configuration files or environment variables.

## Task 4: Create an Approved Sender

1. In VS Code, open `application-oraclecloud.properties`. The application configuration uses two environment variables `OBJECT_STORAGE_NAMESPACE` and `OBJECT_STORAGE_BUCKET`.

	_oci/src/main/resources/application-oraclecloud.properties_

	``` properties
	micronaut.object-storage.oracle-cloud.default.namespace=${OBJECT_STORAGE_NAMESPACE}
	micronaut.object-storage.oracle-cloud.default.bucket=${OBJECT_STORAGE_BUCKET}
	```

2. Open a new terminal in VS Code using the **Terminal > New Terminal** menu.

3. Run the following command to set the environment variable `OBJECT_STORAGE_NAMESPACE`:

	``` bash
	<copy>
	export OBJECT_STORAGE_NAMESPACE=$(oci os ns get --auth instance_principal --query "data" --raw-output)
	</copy>
	```

4. Confirm the value set by running the following command:

	``` bash
	<copy>
	echo $OBJECT_STORAGE_NAMESPACE
	</copy>
	```

5. Set the environment variable `OBJECT_STORAGE_BUCKET` using the bucket name from the previous lab.

	``` bash
	<copy>
	export OBJECT_STORAGE_BUCKET=<name-of-the-bucket-you-created>
	</copy>
	```

6. Confirm the value set by running the following command:

	``` bash
	<copy>
	echo $OBJECT_STORAGE_BUCKET
	</copy>
	```

## Task 5: Change the "to" Email Address

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

Congratulations! In this lab, you configured the application to use the OCI Object Storage bucket created earlier.

You may now **proceed to the next lab**.

## Learn More

* [Micronaut Oracle Cloud Authentication](https://micronaut-projects.github.io/micronaut-oracle-cloud/snapshot/guide/#authentication)

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
