# Configure the Application to use the OCI MySQL HeatWave Database Instance

## Introduction

This lab provides instructions to configure the application to connect to the OCI MySQL HeatWave Database instance using credentials stored as secrets in the OCI Vault.

The [Micronaut Oracle Cloud](https://micronaut-projects.github.io/micronaut-oracle-cloud/latest/guide/index.html) project provides integration between Micronaut applications and Oracle Cloud, including using Vault as a distributed configuration source.

Estimated Lab Time: 05 minutes

### Objectives

In this lab, you will:

* Uncomment the Application dependencies
* Configure the Application to read secrets stored in OCI Vault
* Configure OCI Instance Principal Authentication

## Task 1: Uncomment the Application dependencies

1. In VS Code, open _oci/pom.xml_.

2. Uncomment the following snippet in the _pom.xml_ file to add a dependency for `micronaut-oraclecloud-vault` and related OCI SDK dependencies to enable OCI Vault support.

	The `micronaut-oracle-cloud` subproject provides integration between Micronaut applications and Oracle Cloud, including using Vault as a distributed configuration source.

    _oci/pom.xml_

    ``` xml
    <dependency>
        <groupId>io.micronaut.oraclecloud</groupId>
        <artifactId>micronaut-oraclecloud-httpclient-netty</artifactId>
        <scope>compile</scope>
    </dependency>
    <dependency>
        <groupId>io.micronaut.oraclecloud</groupId>
        <artifactId>micronaut-oraclecloud-vault</artifactId>
        <scope>compile</scope>
    </dependency>
    ```

## Task 2: Configure the Application to read secrets stored in OCI Vault

1. Confirm the distributed configuration feature is enabled using the `micronaut.config-client.enabled` flag in the _bootstrap-oraclecloud.properties_ file.

    _oci/src/main/resources/bootstrap-oraclecloud.properties_

    ```properties
    micronaut.config-client.enabled=true
    ```

2. Uncomment the following snippet in the _bootstrap-oraclecloud.properties_ file. This snippet configures the application to read secrets stored in OCI Vault when the application is running on an OCI Compute Instance. You'll set the value of the externalized configuration variables `VAULT_ID` and `COMPARTMENT_ID` in subsequent steps.

    _oci/src/main/resources/bootstrap-oraclecloud.properties_

    ```properties
	oci.vault.config.enabled=true
	# <b>
    oci.vault.vaults[0].ocid=${VAULT_ID}
    # <c>
    oci.vault.vaults[0].compartment-ocid=${COMPARTMENT_ID}
    ```

3. Navigate to the **Identity & Security >> Compartments** section in the Oracle Cloud Console, find your workshop compartment in the list, open it, in the **Compartment Information** section click **Copy** to copy the value of the Compartment OCID. This is the compartment when you created the secrets.

4. In the same terminal in VS Code, set the environment variable `COMPARTMENT_ID` using the secrets' compartment OCID you copied.

	```
	<copy>
	export COMPARTMENT_ID=ocid1.compartment.oc1...
	</copy>
	```

5. Confirm the value set by running the following command:

	```
	<copy>
	echo $COMPARTMENT_ID
	</copy>
	```

6. Navigate to the **Identity & Security >> Vault** section in the Oracle Cloud Console, find your recently created Vault, open it, in the **Vault Information** section click **Copy** to copy the value of the Vault OCID.

7. In the same terminal in VS Code, set the environment variable `VAULT_ID` using the Vault OCID you copied.

	```
	<copy>
	export VAULT_ID=ocid1.vault.oc1...
	</copy>
	```

8. Confirm the value set by running the following command:

	```
	<copy>
	echo $VAULT_ID
	</copy>
	```

9. The application uses externalized configuration (`DATASOURCES_DEFAULT_URL`, `JDBC_USER`, and `JDBC_PASSWORD`) to establish a database connection. Here, the application will automatically connect to OCI Vault and retrieve the values of the secrets `JDBC_USER` and `JDBC_PASSWORD` from OCI Vault. The application will use the `DATASOURCES_DEFAULT_URL` set as an environment variable.

	_oci/src/main/resources/application-oraclecloud.properties_

	``` properties
	datasources.default.url=${DATASOURCES_DEFAULT_URL:`jdbc:mysql://localhost:3306/db`}
	datasources.default.username=${JDBC_USER:sherlock}
	datasources.default.password=${JDBC_PASSWORD:elementary}
	```

10. Set the environment variable `DATASOURCES_DEFAULT_URL` using the MySQL database name you created.

	```bash
	<copy>
	export DATASOURCES_DEFAULT_URL='jdbc:mysql://'$MYSQL_IP':3306/gdkDB'
	</copy>
	```

11. Confirm the value set by running the following command:

	```
	<copy>
	echo $DATASOURCES_DEFAULT_URL
	</copy>
	```

## Task 3: <if type="desktop">Use</if><if type="tenancy">Configure</if> OCI Instance Principal Authentication

1. In VS Code, open `bootstrap-oraclecloud.properties`. Uncomment the property `oci.config.instance-principal.enabled=true`. The application is configured to use `OCI Instance Principal Authentication` when it is running on an OCI Compute Instance. 

	_oci/src/main/resources/bootstrap-oraclecloud.properties_

	```properties
	oci.config.instance-principal.enabled=true
	```

<if type="desktop">
2. The workshop environment includes a preconfigured `Instance Principal` using a `Dynamic Group` and a `Policy` in OCI to allow the application to read secrets stored in OCI Vault.
</if>

<if type="tenancy">
2. The following steps show you how to set up an `Instance Principal` using a `Dynamic Group`-less `Policy` in OCI to allow the application to to read secrets stored in OCI Vault.

3. From the Oracle Cloud Console navigation menu, go to **Identity & Security >> Identity >> Policies**.

	![Policies Menu](https://oracle-livelabs.github.io/common/images/console-2025/id-policies.png)

4. Go to your workshop compartment.

5. Click  **Create Policy**.

6. Enter a name and description.

7. Select your workshop compartment.

8. In the **Policy Builder** section, click **Show manual editor**.

9. Enter the following policy statements in the text area. Replace the placeholders `WORKSHOP_COMPARTMENT_NAME` with your workshop compartment name, and `WORKSHOP_COMPARTMENT_OCID` with your workshop compartment OCID.

	```text
	<copy>
	Allow any-user to read secret-family in compartment WORKSHOP_COMPARTMENT_NAME where ALL {request.principal.type='instance', request.principal.compartment.id='WORKSHOP_COMPARTMENT_OCID'}
	</copy>
	```

	To learn more about access control policies for the Vault, see [Policy Reference - Details for Vault](https://docs.oracle.com/en-us/iaas/Content/Identity/Reference/keypolicyreference.htm).

</if>

	To learn more about the supported authentication options, see [Micronaut Oracle Cloud Authentication](https://micronaut-projects.github.io/micronaut-oracle-cloud/snapshot/guide/#authentication).

Congratulations! In this lab, you configured the application to connect to the OCI MySQL HeatWave Database instance using credentials stored as secrets in the OCI Vault.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)
