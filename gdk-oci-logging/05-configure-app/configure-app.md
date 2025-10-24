# Configure the Application to Use the OCI Logging

## Introduction

This lab provides instructions to configure the application to point to OCI Logging.

Estimated Lab Time: 05 minutes

### Objectives

In this lab, you will:

* Configure the Application to Use the OCI Logging
* <if type="desktop">Use</if><if type="tenancy">Configure</if> OCI Instance Principal Authentication

## Task 1: Configure the Application to Use the OCI Logging

1. In VS Code, open _oci/src/main/resources/logback.xml_.

2. Go to the `<logId>` element and paste the Log OCID that you copied earlier.

	```xml
	<logId><!-- TODO set the value of the Oracle Cloud log OCID here --></logId>
	```

   Replace `ocid1.log.oc1.iad.ama...` with the actual value.

	```
	<logId>ocid1.log.oc1.iad.ama...</logId>
	```

3. Save the file.

## Task 2: <if type="desktop">Use</if><if type="tenancy">Configure</if> OCI Instance Principal Authentication

1. In VS Code, open `application-oraclecloud.properties`. The application is configured to use `OCI Instance Principal Authentication` when it is running on an OCI Compute Instance.

	_oci/src/main/resources/application-oraclecloud.properties_

	``` properties
	oci.config.instance-principal.enabled=true
	```

<if type="desktop">
2. The workshop environment includes a preconfigured `Instance Principal` using a `Dynamic Group` and a `Policy` in OCI to allow the application to send logs to OCI Logging.
</if>

<if type="tenancy">
2. The following steps show you how to set up an `Instance Principal` using a `Dynamic Group`-less `Policy` in OCI to allow the application to send logs to OCI Logging.

3. From the Oracle Cloud Console navigation menu, go to **Identity & Security >> Identity >> Policies**.

	![Policies Menu](https://oracle-livelabs.github.io//common/images/console/id-policies.png)

4. Go to your workshop compartment.

5. Click  **Create Policy**.

6. Enter a name and description.

7. Select your workshop compartment.

8. In the **Policy Builder** section, click **Show manual editor**.

9. Enter the following policy statement in the text area. Replace the placeholders `WORKSHOP_COMPARTMENT_NAME` with your workshop compartment name, and `WORKSHOP_COMPARTMENT_OCID` with your workshop compartment OCID.

	``` text
	<copy>
	Allow any-user to use log-content in compartment WORKSHOP_COMPARTMENT_NAME where ALL {request.principal.type='instance', request.principal.compartment.id='WORKSHOP_COMPARTMENT_OCID'}
	</copy>
	```

	To learn more about policies to control access to OCI Logging, see [Policy Reference - Details for Logging](https://docs.oracle.com/en-us/iaas/Content/Identity/Reference/loggingpolicyreference.htm).

</if>

	To learn more about the supported authentication options, see [Micronaut Oracle Cloud Authentication](https://micronaut-projects.github.io/micronaut-oracle-cloud/snapshot/guide/#authentication).

Congratulations! In this lab, you configured the application to use OCI Logging.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
