# Configure the application to use OCI Monitoring

## Introduction

This lab provides instructions to configure the application to point to OCI Monitoring.

Estimated Lab Time: 05 minutes

### Objectives

In this lab, you will:

* Configure the application to use the OCI Monitoring
* Configure OCI Instance Principal Authentication

## Task 1: Configure the Application to use the OCI Monitoring

1. From the Oracle Cloud Console, open the navigation menu, navigate to  **Identity & Security >> Compartments** , find your workshop compartment in the list, open it, in the **Compartment Information** section click **Copy** to copy the value of the compartment OCID.

2. Open a new terminal in VS Code using the **Terminal > New Terminal** menu.

3. Set the environment variable `COMPARTMENT_OCID` using the compartment OCID you copied.

	```
	<copy>
	export COMPARTMENT_OCID=ocid1.compartment.oc1...
	</copy>
	```

4. Confirm the value set by running the following command:

	```
	<copy>
	echo $COMPARTMENT_OCID
	</copy>
	```

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
	Allow any-user to use metrics in compartment WORKSHOP_COMPARTMENT_NAME where ALL {request.principal.type='instance', request.principal.compartment.id='WORKSHOP_COMPARTMENT_OCID'}
	</copy>
	```

	To learn more about policies to control access to OCI Monitoring, see [Policy Reference - Details for Monitoring](https://docs.oracle.com/en-us/iaas/Content/Identity/Reference/monitoringpolicyreference.htm).

</if>

	To learn more about the supported authentication options, see [Micronaut Oracle Cloud Authentication](https://micronaut-projects.github.io/micronaut-oracle-cloud/snapshot/guide/#authentication).

Congratulations! In this lab, you configured the application to publish metrics to OCI Monitoring.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
