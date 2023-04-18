# Pre-requisites for Full Stack Disaster Recovery

## Introduction

In this lab, we will complete the pre-requisites setup work for Full Stack Disaster Recovery.

Estimated Time: 30 Minutes

### Objectives

- Prepare Object Storage Buckets for Operation Logs.
- Prepare Oracle Databases for Full Stack Disaster Recovery.

## Task 1: Preparing Object Storage Buckets for Operation Logs

Full Stack Disaster Recovery (FSDR) configurations use Object Storage to store Disaster Recovery (DR) operation logs.

Before you create any DR configurations, you must create Object Storage buckets in both Ashburn (primary) and Phoenix (standby) regions to include in the DR configuration process.

Oracle recommends that you follow these guidelines when creating the Object Storage bucket:

- Use a separate dedicated bucket for each DR protection group.
- Use Standard storage tier, not **Archive**.
- Do not set up replication for this object store bucket.
- Do not use this bucket to write other data, reserve it exclusively for use for logs for one DR protection group.
- Ensure that the object store bucket is writable by the user running DR plan executions.

1. Login into OCI Console. The primary region should be **Ashburn**.

    ![Ashburn OCI Console](./images/ashburn-region.png)

 2. Select **Storage** from the Hamburger menu, then **Buckets**. Verify the region is **Ashburn**.

    ![ashburn-object-storage](./images/ashburn-object-storage.png)

3. Click on Create Bucket and provide a name for the bucket and select the Default Storage Tier as **Standard**.

    ![ashburn-create-bucket](./images/ashburn-bucket.png)

4. Change the region to **Phoenix**. Select **Storage** from the Hamburger menu, then **Buckets**. Verify the region is **Phoenix**.

    ![phoenix-object-storage](./images/phoenix-object-storage.png)

5. Click on Create Bucket and provide a name for the bucket and select the Default Storage Tier as **Standard**.

    ![phoenix-create-bucket](./images/phoenix-bucket.png)

## Task 2: Preparing Oracle Databases for Full Stack Disaster Recovery

1. From the Ashburn region OCI console, select **Oracle Database** from the Hamburger menu then **Oracle Base Database (VM, BM)**.

    ![dbcs home](./images/ashburn-dbcs-home.png)

2. Click on the relevant DB System. Click on the Database.

    ![ashburn-dbcs-dg](./images/ashburn-dbcs-dg.png)

3. Under Resources section, click on Data Guard Assosciations.

    ![ashburn-dbcs-dg-enable](./images/ashburn-dbcs-dg-enable.png)

4. Click on Enable Data Guard.

    ![click-enable-data-guard](./images/ashburn-enable-dg.png)

5. Provide a peer DB display name, select the DR standby region in this case it will be Phoenix, select the Availability Domain (recommended to host in the same Availability Domain which is hosting the PeopleSoft Application Tier).

    ![dg-info](./images/ashburn-dg-info.png)

    Select the shape same as the primary DB.

    ![dg-shape](./images/ashburn-dg-shape.png)

    Choose the license type and select the correct VCN and subnet from the drop down.

    ![ashburn-dg-license-vcn](./images/ashburn-dg-license-vcn.png)

    Provide a hostname prefix.

    ![ashburn-dg-hostname](./images/ashburn-dg-hostname.png)

    Select the Data Guard Association type. Active Data Guard requires an Oracle Active Data Guard license.

    ![ashburn-dg-type](./images/ashburn-dg-type.png)

    Leave other fields as default and click Next.

    ![ashburn-dg-next](./images/ashburn-dg-next.png)

6. Enter the database administrator password of the primary database in the Database password field. Use this same database administrator password for the standby database. Click on Enable Data Guard.

    ![ashburn-dg-db-pwd](./images/ashburn-dg-db-pwd.png)

7. Create a vault in the Ashburn (primary) region. From the Ashburn region OCI console, select **Identity & Security** from the Hamburger menu then **Vault**.

    ![ashburn-vault-home](./images/ashburn-vault-page.png)

8. Click on Create Vault. Select the right compartment and provide a name for the Vault.

    ![ashburn-create-vault](./images/ashburn-create-vault.png)

9. Under Resources, click on Master Encryption Keys and click on Create Key.

    ![ashburn-click-key-vault](./images/ashburn-vault-key.png)

10. Select the right compartment, Protection Mode will be **HSM** and provide a name for the Key, Key Shape:Algorithm will be **AES (Symmetric key used for Encrypt and Decrypt)** and Key Shape:Lenght will be 256 bits. Click on Create Key.

    ![ashburn-create-key](./images/ashburn-create-key.png)

11. Under Resources, click on Secrets and click on Create Secrets.

    ![ashburn-create-secrets](./images/ashburn-create-secrets.png)

12. Select the right compartment, provide a name for the secret, a description for the secret, select the Master Encryption Key created in the previous task from the drop down, **Secret Type Template** will be Plain-Text, provide the DB SYS user password in plain text format in the **Secret Contents**.

    ![ashburn-create-secrets2](./images/ashburn-create-secrets2.png)

13. Change the region to Phoenix. 

    ![change-region](./images/change-region.png)

14. Create a vault in the Phoenix (standby) region. From the Phoenix region OCI console, select **Identity & Security** from the Hamburger menu then **Vault**.

    ![phoenix-vault-home](./images/phoenix-vault-page.png)

15. Click on Create Vault. Select the right compartment and provide a name for the Vault.

    ![phoenix-create-vault](./images/phoenix-create-vault.png)

16. Under Resources, click on Master Encryption Keys and click on Create Key.

    ![phoenix-click-key-vault](./images/phoenix-vault-key.png)

17. Select the right compartment, Protection Mode will be **HSM** and provide a name for the Key, Key Shape:Algorithm will be **AES (Symmetric key used for Encrypt and Decrypt)** and Key Shape:Lenght will be 256 bits. Click on Create Key.

    ![phoenix-create-key](./images/phoenix-create-key.png)

18. Under Resources, click on Secrets and click on Create Secrets.

    ![phoenix-create-secrets](./images/phoenix-create-secrets.png)

19. Select the right compartment, provide a name for the secret, a description for the secret, select the Master Encryption Key created in the previous task from the drop down, **Secret Type Template** will be Plain-Text, provide the DB SYS user password in plain text format in the **Secret Contents**.

    ![phoenix-create-secrets2](./images/phoenix-create-secrets2.png)

   You may now **proceed to the next lab**.

## Acknowledgements

- **Author** -  Vinay Shivanna, Principal Cloud Architect
- **Last Updated By/Date** -  Vinay Shivanna, Principal Cloud Architect, April 2023
