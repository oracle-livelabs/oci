# Configure the Application to Use the Object Storage Bucket

## Introduction

This lab provides instructions to configure the application to use the OCI Object Storage bucket you created.

Estimated Lab Time: 05 minutes

### Objectives

In this lab, you will:

* <if type="desktop">Use</if><if type="tenancy">Configure</if> OCI Instance Principal Authentication
* Set environment variables

## Task 1: <if type="desktop">Use</if><if type="tenancy">Configure</if> OCI Instance Principal Authentication

1. In VS Code, open `application-oraclecloud.properties`. The application is configured to use `OCI Instance Principal Authentication` when it is running on an OCI Compute Instance.

	_oci/src/main/resources/application-oraclecloud.properties_

	``` properties
	oci.config.instance-principal.enabled=true
	```

<if type="desktop">
2. The workshop environment includes a preconfigured `Instance Principal` using a `Dynamic Group` and a `Policy` in OCI to allow the application to manage (upload, list, download, and delete) objects in the OCI Object Storage bucket.
</if>

<if type="tenancy">
2. The following steps show you how to set up an `Instance Principal` using a `Dynamic Group`-less `Policy` in OCI to allow the application in a Compute Instance to manage (upload, list, download, and delete) objects in the OCI Object Storage bucket.

3. From the Oracle Cloud Console navigation menu, go to **Identity & Security >> Identity >> Policies**.

4. Go to your workshop compartment.

5. Click  **Create Policy**.

6. Enter a name and description.

7. Select your workshop compartment.

8. In the **Policy Builder** section, click **Show manual editor**.

9. Enter the following policy statement in the text area. Replace the placeholders `WORKSHOP_COMPARTMENT_NAME` with your workshop compartment name, and `WORKSHOP_COMPARTMENT_OCID` with your workshop compartment OCID.

	``` text
	<copy>
	Allow any-user to manage object-family in compartment WORKSHOP_COMPARTMENT_NAME where ALL {request.principal.type='instance', request.principal.compartment.id='WORKSHOP_COMPARTMENT_OCID'}
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

Congratulations! In this lab, you configured the application to use the OCI Object Storage bucket created earlier.

You may now **proceed to the next lab**.

## Learn More

* [Micronaut Oracle Cloud Authentication](https://micronaut-projects.github.io/micronaut-oracle-cloud/snapshot/guide/#authentication)

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
