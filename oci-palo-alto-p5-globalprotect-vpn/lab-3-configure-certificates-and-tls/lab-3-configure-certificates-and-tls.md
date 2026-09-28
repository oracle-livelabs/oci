# Configure Certificates and TLS

## Introduction

This lab creates and prepares the certificates and TLS profile that secure communication between GlobalProtect clients and the Portal and Gateway.

Estimated time: 25 minutes

### Objectives

In this lab, you will:
- Create the self-signed CA certificate.
- Create the Portal/Gateway server certificate.
- Trust the CA certificate on the client.
- Replicate the certificates for the Active/Active deployment.
- Create the SSL/TLS Service Profile.

### Prerequisites

Before you begin, ensure you have completed the preceding required labs in this workshop.

## Task 1: Create the Self-Signed CA Certificate

- Click on the **Device** tab.

![Open Device tab](images/open-device-tab.png)

1. Click on **Certificates** under **Certificate Management**.
2. Click on the **Generate** button.

    ![Open certificate management](images/open-certificate-management.png)

<!-- -->

1. Set the **Certificate Type** to **Local**.
2. Specify a **Certificate Name** (e.g. `GP-CA-Cert`).
3. Specify a **Common Name** (e.g. `GP-CA-Cert`).
4. Check the **Certificate Authority** box (this is what makes it a CA).
5. Leave the **Cryptographic Settings** at their default values.
6. Click on the **Generate** button.

    ![Configure self signed CA](images/configure-self-signed-ca-certificate.png)

    - Click on the **OK** button to acknowledge that the certificate and key pair have been generated successfully.

    ![Confirm CA certificate created](images/confirm-ca-certificate-created.png)

## Task 2: Create the Portal/Gateway Server Certificate

1. Notice that the CA certificate (`GP-CA-Cert`) is now listed.
2. Click on the **Generate** button to create the second certificate.

    ![Start server certificate creation](images/start-server-certificate-creation.png)

<!-- -->

1. Set the **Certificate Type** to **Local**.
2. Specify a **Certificate Name** (e.g. `GP-Portal-Gateway-Cert`).
3. Set the **Common Name** as follows:
    - **Single Instance:** Untrust primary public IP.
    - **Active/Passive:** Untrust secondary/floating public IP.
    - **Active/Active:** VPN NLB public IP.
4. Set **Signed By** to the CA we just created (`GP-CA-Cert`).
5. Leave **Certificate Authority** unchecked (this is a server certificate, not a CA).
6. Leave the **Cryptographic Settings** at their default values.
7. Click on the **Generate** button.

    ![Configure Portal Gateway certificate](images/configure-portal-gateway-certificate.png)

    - Click on the **OK** button to acknowledge that the certificate and key pair have been generated successfully.

    ![Confirm server certificate created](images/confirm-server-certificate-created.png)

## Task 3: Export the CA Certificate and Trust it on Your PC

The CA certificate is self-signed, so the client PC will not trust it by default. Export the CA from the firewall and install it in the local trust store. This step is optional for testing but recommended so the GlobalProtect agent does not throw certificate warnings. PC Client here is macOS.

1. Notice the **GP-Portal-Gateway-Cert** is created.
2. Select the **GP-CA-Cert** row.
3. Click on the **Export Certificate** button.

    ![Export CA certificate](images/export-ca-certificate.png)

<!-- -->

1. Set the **File Format** to **Base64 Encoded Certificate (PEM)**.
2. Click on the **OK** button.

    ![Select CA export format](images/select-ca-certificate-export-format.png)

<!-- -->

1. Open the browser's downloads list.
2. Verify that the CA certificate file **`cert_GP-CA-Cert.crt`** appears in the list and shows **Done**, confirming the export was successful. Click the file to open it.

    ![Verify CA certificate export](images/task-3-verify-that-ca-certificate-file-appears-list-shows-done-conf.png)

    - **Keychain Access** opens and prompts for authentication to modify the System keychain.

    ![Authenticate Keychain Access](images/authenticate-keychain-access.png)

    - The CA certificate is added to the System keychain.

    ![CA certificate added to System](images/task-3-ca-certificate-is-added-system-keychain.png)

<!-- -->

1. Notice the warning **This root certificate is not trusted**.
2. Expand the **Trust** section.

    ![Expand Trust section](images/task-3-expand-trust-section.png)

    - Open the **When using this certificate** dropdown.

    ![Open certificate trust dropdown](images/task-3-open-when-using-this-certificate-dropdown.png)

    - Select **Always Trust**.

    ![Select Always Trust](images/task-3-select-always-trust.png)

<!-- -->

1. All trust settings switch to **Always Trust**.
2. Close the certificate window to apply the changes.

    ![Close certificate window](images/task-3-close-certificate-window-apply-changes.png)

    - macOS prompts for authentication again to confirm the change to the System keychain.

    ![Confirm System keychain change](images/confirm-system-keychain-change.png)

    - Notice that the certificate is now marked as **trusted for all users**.

    ![Verify certificate trusted](images/task-3-notice-that-certificate-is-now-marked-as-trusted-all-users.png)

## Task 4: Replicate Certificates to PA-VM-02 (Active/Active only)

In an Active/Active setup, both firewalls must present the **same TLS identity** to clients connecting through the VPN NLB. Since certificates do not sync automatically between A/A peers, you need to export the CA and server certificates from PA-VM-01 and import them into PA-VM-02.

### On PA-VM-01: Export the Certificates

1. Select the **GP-CA-Cert** row.
2. Click on the **Export Certificate** button.

    ![Export CA certificate private key](images/export-ca-certificate-private-key.png)

<!-- -->

1. Set the **File Format** to **Base64 Encoded Certificate (PEM)**.
2. Check the **Export Private Key** box.
3. Specify a **Passphrase**.
4. Re-enter the same value in **Confirm Passphrase**.
5. Click on the **OK** button.

    ![Configure CA private key export](images/configure-ca-certificate-private-key-export.png)

<!-- -->

1. Open the browser's downloads list.
2. Verify that the CA certificate file **`cert_GP-CA-Cert.pem`** appears in the list and shows **Done**, confirming the export was successful.

    ![Verify CA certificate export](images/verify-ca-certificate-export.png)

<!-- -->

1. Select the **GP-Portal-Gateway-Cert** row.
2. Click on the **Export Certificate** button.

    ![Export server certificate private key](images/export-server-certificate-private-key.png)

<!-- -->

1. Set the **File Format** to **Base64 Encoded Certificate (PEM)**.
2. Check the **Export Private Key** box.
3. Specify a **Passphrase**.
4. Re-enter the same value in **Confirm Passphrase**.
5. Click on the **OK** button.

    ![Configure server private key export](images/configure-server-certificate-private-key-export.png)

<!-- -->

1. Open the browser's downloads list.
2. Verify that the CA certificate file **`cert_GP-Portal-Gateway-Cert.pem`** appears in the list and shows **Done**, confirming the export was successful.

    ![Verify server certificate export](images/verify-server-certificate-export.png)

    - Confirm that both `.pem` files are present in your Downloads folder.

    ![Confirm both PEM files](images/task-4-confirm-that-both-files-are-present-your-downloads-folder.png)

### On PA-VM-02: Import the Certificates

- Click on the **Import** button at the bottom of the Certificates page.

![Click Import button](images/task-4-click-import-button-at-bottom-certificates-page.png)

<!-- -->

1. Set the **Certificate Type** to **Local**.
2. Set the **Certificate Name** to `GP-CA-Cert` (must match the name used on PA-VM-01).
3. Set the **File Format** to **Base64 Encoded Certificate (PEM)**.
4. **Browse** and select `cert_GP-CA-Cert.pem`.
5. Check the **Import Private Key** box.
6. Enter the **Passphrase** used during export.
7. Re-enter the same value in **Confirm Passphrase**.
8. Click on the **OK** button.

    ![Import CA certificate private key](images/import-ca-certificate-private-key.png)

<!-- -->

1. Notice that **GP-CA-Cert** is now listed.
2. Click on the **Import** button.

    ![Start server certificate import](images/start-server-certificate-import.png)

<!-- -->

1. Set the **Certificate Type** to **Local**.
2. Set the **Certificate Name** to `GP-Portal-Gateway-Cert` (must match the name used on PA-VM-01).
3. Set the **File Format** to **Base64 Encoded Certificate (PEM)**.
4. **Browse** and select `cert_GP-Portal-Gateway-Cert.pem`.
5. Check the **Import Private Key** box.
6. Enter the **Passphrase** used during export.
7. Re-enter the same value in **Confirm Passphrase**.
8. Click on the **OK** button.

    ![Import server certificate private key](images/import-server-certificate-private-key.png)

    - Confirm that both **GP-CA-Cert** and **GP-Portal-Gateway-Cert** are now listed on PA-VM-02 with the same attributes as on PA-VM-01.

    ![Confirm imported certificates](images/task-4-confirm-that-both-gp-ca-cert-gp-portal-gateway-cert-are-now.png)

## Task 5: Create SSL/TLS Service Profile

In this task, you create an **SSL/TLS Service Profile** on the firewall and bind it to the server certificate created in Task 2. The GlobalProtect Portal and Gateway will use this profile to present a TLS endpoint to remote users when they connect.

1. Click on **SSL/TLS Service Profile** under **Certificate Management**.
2. Click on the **Add** button.

    ![Click Add button](images/task-5-click-add-button.png)

<!-- -->

1. Specify a **Name** for the profile (e.g. `GP-SSL/TLS-Profile`).
2. Select the **Certificate** created in Task 2 (`GP-Portal-Gateway-Cert`).
3. Click on the **OK** button.

    ![Configure SSL TLS profile](images/configure-ssl-tls-service-profile.png)

    - Notice that the SSL/TLS Service Profile is created and uses the certificate `GP-Portal-Gateway-Cert`.

    ![Verify SSL TLS profile](images/task-5-notice-that-ssl-tls-service-profile-is-created-uses-certific.png)

## Learn More

- [GlobalProtect Certificate Best Practices](https://docs.paloaltonetworks.com/globalprotect/administration/get-started/enable-ssl-between-globalprotect-components/globalprotect-certificate-best-practices)
- [Deploy Server Certificates to the GlobalProtect Components](https://docs.paloaltonetworks.com/globalprotect/administration/get-started/enable-ssl-between-globalprotect-components/deploy-server-certificates-to-the-globalprotect-components)
- [Export a Certificate and Private Key](https://docs.paloaltonetworks.com/pan-os/11-1/pan-os-admin/certificate-management/export-a-certificate-and-private-key)
- [Import a Certificate and Private Key](https://docs.paloaltonetworks.com/ngfw/administration/certificate-management/certificate-deployment/import-certificate-and-private-key)
- [Import a Trusted Root Certificate on Windows](https://learn.microsoft.com/en-us/system-center/scom/obtain-certificate-windows-server-and-operations-manager?view=sc-om-2025#import-the-trusted-root-certificate-from-the-ca-on-the-client)
- [Change Certificate Trust Settings on Mac](https://support.apple.com/en-gb/guide/keychain-access/kyca11871/mac)

## Acknowledgements

- **Authors** - Anas Abdallah, Iwan Hoogendoorn (Cloud Networking Black Belts)
- **Contributor** - Antonio Gámir (Cloud Networking Black Belt)
- **Last Updated By/Date** - Anas Abdallah, August 2026

You may now **proceed to the next lab**.
