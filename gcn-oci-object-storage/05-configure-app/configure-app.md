# Configure the Application to Use the Object Storage Bucket

## Introduction

This lab provides instructions to configure the application to use the OCI Object Storage bucket you created.

Estimated Lab Time: 05 minutes

### Objectives

In this lab, you will:

* Set environment variables
* Use OCI Instance Principal Authentication

## Task 1: Set Environment Variables

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

## Task 2: Use OCI Instance Principal Authentication

1. The application is configured to use `OCI Instance Principal Authentication` when it is running on an OCI Compute Instance. The lab environment includes a preconfigured `Instance Principal` using a `Dynamic Group` and a `Policy` in OCI to allow the application to manage (upload, list, download, and delete) objects in the OCI Object Storage bucket.

	_oci/src/main/resources/application-oraclecloud.properties_

	``` properties
	oci.config.instance-principal.enabled=true
	```

	To learn more about about the supported authentication options, see [Micronaut Oracle Cloud Authentication](https://micronaut-projects.github.io/micronaut-oracle-cloud/snapshot/guide/#authentication).

Congratulations! In this lab, you configured the application to use the OCI Object Storage bucket created earlier.

You may now **proceed to the next lab**.

## Learn More

* [Micronaut Oracle Cloud Authentication](https://micronaut-projects.github.io/micronaut-oracle-cloud/snapshot/guide/#authentication)

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
