# Lab 1 - Generate and Store the PAN-OS API Key in OCI Vault
## Introduction

In this lab, you generate a long-lived PAN-OS API key from the firewall and store it securely in OCI Vault. This key lets the function authenticate to the firewall later, without embedding credentials in code or configuration. You generate it once with a single `keygen` call from Cloud Shell, then place it in an encrypted Vault secret. By the end, the key lives entirely inside OCI's managed, encrypted-at-rest storage, and you have the secret OCID ready to wire into the function.

## Task 1: Generate the PAN-OS API Key

1. Click the **Developer tools** icon in the top-right navigation bar.
2. Select **Cloud Shell** from the dropdown.

![](010.%20Oracle/3.%20Public%20Assets/LiveLabs/Automate%20OSN%20Public%20IP%20Range%20Sync%20to%20a%20Palo%20Alto%20Firewall%20in%20OCI/Resource%20Scheduler%20Method/automate-osn-sync-palo-alto/lab-1-generate-api-key/images/bd14066c595202717c1d1c260401b30a.png)

- Wait for Cloud Shell to start up.

![](010.%20Oracle/3.%20Public%20Assets/LiveLabs/Automate%20OSN%20Public%20IP%20Range%20Sync%20to%20a%20Palo%20Alto%20Firewall%20in%20OCI/Resource%20Scheduler%20Method/automate-osn-sync-palo-alto/lab-1-generate-api-key/images/162a4be5b0439bc18ec866b2a0ff66dd.png)

1. From OCI Cloud Shell, run the following command, replacing the placeholders with your firewall's values:

```bash
curl -sk -G 'https://<firewall-mgmt-ip>/api/' \
  --data-urlencode 'type=keygen' \
  --data-urlencode 'user=<admin-username>' \
  --data-urlencode 'password=<admin-password>'; echo
```

Where:

- `<firewall-mgmt-ip>`: Public IP of the firewall's management interface, provisioned by the Live Labs workshop in the Management Subnet.
- `<admin-username>`: The PAN-OS superuser account (typically `admin`), set during the Live Labs workshop.
- `<admin-password>`: The password for the admin account, set during the Live Labs workshop.
The trailing `echo` just adds a newline so the XML response is easier to read in the terminal.

2. The response is XML:

```xml
<response status = 'success'><result><key>LUF...GtVcQ==</key></result></response>
```

Copy the value between `<key>` and `</key>`, that string is your API key. By default it never expires. It becomes invalid only if you set an API Key Lifetime, expire or revoke all keys, change the admin password, or regenerate the key.

![](010.%20Oracle/3.%20Public%20Assets/LiveLabs/Automate%20OSN%20Public%20IP%20Range%20Sync%20to%20a%20Palo%20Alto%20Firewall%20in%20OCI/Resource%20Scheduler%20Method/automate-osn-sync-palo-alto/lab-1-generate-api-key/images/69e6d6dd07dd2baf79c008ab13ee2681.png)

## Task 2: Create a Vault and Master Key

1. In the OCI Console, navigate to **Identity & Security** → **Vault**.
2. Choose your working compartment.
3. Click **Create Vault**.
    - Name: `panos-vault`
    - Leave **Make it a virtual private vault** unchecked (paid feature, not needed).
    - Click **Create Vault** and wait for the state to be **Active**.

![](010.%20Oracle/3.%20Public%20Assets/LiveLabs/Automate%20OSN%20Public%20IP%20Range%20Sync%20to%20a%20Palo%20Alto%20Firewall%20in%20OCI/Resource%20Scheduler%20Method/automate-osn-sync-palo-alto/lab-1-generate-api-key/images/9f0a1331b674afa45b3d78f389ba2a82.png)

Inside the vault, create the master encryption key. Click **Master Encryption Keys** → **Create Key**.

- Protection Mode: Software
- Name: `panos-master-key`
- Algorithm: AES, Length: 256
- Click **Create Key**

![](010.%20Oracle/3.%20Public%20Assets/LiveLabs/Automate%20OSN%20Public%20IP%20Range%20Sync%20to%20a%20Palo%20Alto%20Firewall%20in%20OCI/Resource%20Scheduler%20Method/automate-osn-sync-palo-alto/lab-1-generate-api-key/images/5327bf088d9f858a6c16fc8707239807.png)

## Task 3: Create the Secret

1. In the OCI Console, navigate to **Identity & Security** → **Secret Management**.
2. Choose your working compartment `Tutorial`.
3. Click **Create secret**.
4. Fill in:
    - Name: `panos-api-key`
    - Vault: `panos-vault`
    - Encryption key: `panos-master-key`
    - Choose **Manual secret generation**. You are storing a known value, not generating one.
    - Secret type template: **Plain-Text**
    - Secret Contents: paste the API key from Task 1 `LUF...GtVcQ==`
    - Leave **Show Base64 conversion** unchecked
5. Click **Create secret**.
6. Copy the **OCID** and save it. You will reference it later when configuring the function.

![](010.%20Oracle/3.%20Public%20Assets/LiveLabs/Automate%20OSN%20Public%20IP%20Range%20Sync%20to%20a%20Palo%20Alto%20Firewall%20in%20OCI/Resource%20Scheduler%20Method/automate-osn-sync-palo-alto/lab-1-generate-api-key/images/7c33be7660fb4aaa6f62b0a66025f042.png)

## Learn More

- [Overview of Vaults and Key Management](https://docs.oracle.com/en-us/iaas/Content/KeyManagement/Concepts/keyoverview.htm)
- [Managing Secrets](https://docs.oracle.com/en-us/iaas/Content/secret-management/Concepts/manage-secrets.htm)

## Acknowledgements

- **Author** - Anas Abdallah (OCI Network Black Belt)
- **Last Updated By/Date** - Anas Abdallah, June 2026

