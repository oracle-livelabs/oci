# Access the Palo Alto and Perform Initial Setup

## Introduction

This lab moves from OCI resource deployment to PAN-OS configuration. You access the firewall, configure its trust and untrust interfaces, and security zones, then create the initial security policy that controls traffic through the firewall.

Estimated time: 20 minutes

### Objectives

In this lab, you will:
- Access the Palo Alto management interface.
- Set the `admin` password.
- Configure the management, trust, and untrust interfaces and their security zones.
- Create a security policy for the firewall.
- Commit the initial PAN-OS configuration.

### Prerequisites

Before you begin, ensure you have completed the preceding required labs in this workshop.

## Task 1: Access via SSH and Set Admin Password

Now that the Palo Alto Firewall is deployed you are ready to access it.

- For macOS:
1. Set up an SSH connection using your private SSH key and your public IP address with the following command: `ssh -i <your private key> admin@ <your public IP address>`.
2. Type `yes` to confirm that you want to connect.
3. Notice the `Welcome admin` message, that indicate that you are logged in.
4. Type in `configure` to enter the  configuration mode.
5. Type in `set mgt-config users admin password` to configure the password for the `admin` user.
6. Enter a secure `password`, and confirm the password.

    ![Set the administrator password from the PAN-OS CLI](images/set-admin-password-cli.png)

- Refer to the initial steps in the following [workshop](https://docs.oracle.com/en/learn/oci-openvpn-part1/index.html#task-52-access-openvpn-vm-from-putty-and-complete-the-initial-setup) to learn how to access from Windows using PuTTY.

## Task 2: Access via GUI and Configure the Interfaces

Use the web interface to configure the firewall data-plane interfaces and security zones.

1. Open a **web browser** and use your public IP address to connect to the management web interface of the Palo Alto Firewall. 
2. Depending on your browser (settings) you might need to allow the connection as the Palo Alto Firewall does not have a signed certificate deployed yet. Click on **Advanced**.

    ![Open Advanced options for the browser certificate warning](images/depending-your-browser-settings-you-might-need-allow-connect.png)

    - Click on **Proceed**.

    ![Proceed to the firewall despite the self-signed certificate warning](images/click-proceed.png)

<!-- -->

1. Type in your username: `admin`.
2. Type in your password (you just created).
3. Click in the **Log In** button.

    ![Sign in to the Palo Alto firewall as admin](images/click-log-button.png)

<!-- -->

1. You will be welcomed with the Welcome screen, Check the **Do not show again** check box.
2. Click on the **Close** button.

    ![Dismiss the PAN-OS welcome screen](images/dismiss-pan-os-welcome-screen.png)

    - A message about Telemetry Data Connection will show up, and you can modify these settings later. For now click on the **OK** button.

    ![Acknowledge the PAN-OS telemetry data collection prompt](images/acknowledge-telemetry-data-collection.png)

    - In Palo Alto Networks, **Address Objects** are reusable representations of IP hosts, subnets, IP ranges, or FQDNs. Creating them once and referencing them in policies and rules improves configuration clarity, consistency, and maintenance. They are optional, but are a recommended practice. This lab creates the initial objects; later examples may use direct values where that keeps the configuration focused.
    - Click on **Objects**.

    ![Select the Objects tab in PAN-OS](images/select-objects-tab.png)

    - Click on **Addresses**.

    ![Select Addresses under the Objects menu](images/select-addresses-object-menu.png)

    - Click on **Add**.

    ![Add a new address object](images/add-address-object.png)

<!-- -->

1. Provide a **name** for the address, we are going to begin with **Trust vNIC Private IP**.
2. Specify the type as **IP Netmask**.
3. Type Trust vNIC Private IP `172.16.0.40/28`.
4. Click on **OK**.

    ![Create the trust VNIC private IP address object](images/create-trust-vnic-address-object.png)

    - Repeat the same steps to add the rest of addresses.

    ![Review the created address objects](images/review-created-address-objects.png)

    - Whenever you need to add an address (for example, during interface configuration, virtual router setup, or security policy creation), you can select it from the address objects you have already created.

    ![Select an address object during interface or policy configuration](images/select-address-object-during-configuration.png)

    - This concludes the **optional** address objects part. We will now continue with the main configuration.
    - Navigate to the **Network** tab.

    ![Select the Network tab in PAN-OS](images/select-network-tab.png)

<!-- -->

1. Click on **Interfaces**. 
2. Click on interface **ethernet 1/1**.

    ![Select Interfaces and ethernet1/1](images/click-interface-ethernet-1-1.png)

<!-- -->

1. Set the **Interface Type** to Layer3.
2. Click on **Config**.

    ![Set ethernet1/1 to Layer3 and open its Config tab](images/set-untrust-interface-layer3-config.png)

<!-- -->

1. Set the **Virtual Router** to default.
2. Select the **Security Zone**.
3. In the pull down menu select **New Zone** (Untrusted).

    ![Create the untrust security zone for ethernet1/1](images/create-untrust-security-zone.png)

<!-- -->

1. Specify a **name** for the new (Untrusted) zone.
2. Click on the **OK** button.

    ![Name the new untrust security zone](images/name-untrust-security-zone.png)

    - Make sure the (new) **Untrusted Zone** is selected for interface ethernet 1/1.

    ![Confirm the untrust zone selection for ethernet1/1](images/confirm-untrust-zone-selection.png)

<!-- -->

1. Click on **IPv4** (make sure you **Static** is selected).
2. Click on the **Add** button to add an IP address.
3. Specify an **IP address** for the (Untrusted) interface ethernet 1/1. We have used `172.16.0.20/28` (Make sure this IP is in the same subnet as your Untrusted OCI subnet CIDR block).
4. Click on the **OK** button.

    ![Assign the static IP address to the untrust interface](images/assign-untrust-interface-ip-address.png)

    - Notice that the (Untrusted) interface ethernet 1/1 is now configured.

    ![Review the configured untrust interface](images/review-configured-untrust-interface.png)

    - Click on interface **ethernet 1/2**.

    ![Select ethernet1/2 for the trust interface](images/select-trust-interface-ethernet12.png)

<!-- -->

1. Set the **Interface Type** to Layer3.
2. Click on **Config**.

    ![Set ethernet1/2 to Layer3 and open its Config tab](images/set-trust-interface-layer3-config.png)

<!-- -->

1. Set the **Virtual Router** to default.
2. Select the **Security Zone**.
3. In the pull down menu select **New Zone** (Trusted).

    ![Create the trust security zone for ethernet1/2](images/create-trust-security-zone.png)

<!-- -->

1. Specify a **name** for the new (Trusted) zone.
2. Click on the **OK** button.

    ![Name the new trust security zone](images/name-trust-security-zone.png)

    - Make sure the (new) **Trusted Zone** is selected for interface ethernet 1/2.

    ![Confirm the trust zone selection for ethernet1/2](images/confirm-trust-zone-selection.png)

<!-- -->

1. Click on **IPv4** (make sure you **Static** is selected).
2. Click on the **Add** button to add an IP address.
3. Specify an **IP address** for the (Trusted) interface ethernet 1/2. We have used `172.16.0.40/28` (Make sure this IP is in the same subnet as your Trusted OCI subnet CIDR block).
4. Click on the **OK** button.

    ![Assign the static IP address to the trust interface](images/assign-trust-interface-ip-address.png)

    - Notice that the (Trusted) interface ethernet 1/2 is now configured.

    ![Review the configured trust interface](images/review-configured-trust-interface.png)

<!-- -->

1. Notice that the **Link state** is grey (and not green).
2. Click on the **Commit** button.

    > **Note:** You can **commit** after each configuration you make (safer, easier to troubleshoot), or you can wait and commit once after completing all steps (faster, fewer commits).

    ![Open the commit dialog for the interface configuration](images/open-commit-dialog.png)

<!-- -->

1. Notice the message that commit will overwrite the running configuration.
2. Click on the **Commit** button.

    ![Confirm the commit for the interface configuration](images/confirm-interface-configuration-commit.png)

    - Wait for the **Commit** to complete.

    ![Wait for the interface configuration commit to complete](images/wait-for-interface-configuration-commit.png)

<!-- -->

1. Notice that the **Commit** has completed.
2. Click on the **Close** button.

    ![Close the completed interface configuration commit dialog](images/close-completed-interface-commit.png)

- Notice that the **Link state** is now green out (and not grey anymore).

![Verify that the configured interface link states are green](images/notice-that-link-state-is-now-green-out-not-grey-anymore.png)

> **Note:** If the link state is still red, reboot the instance from the OCI Console and check again.

## Task 3: Create a Network Security Policy

The firewall interfaces are now in place. Create a security policy that controls which traffic may traverse the standalone firewall.

> **Note:** Palo Alto firewalls include two default read-only security policies: **intrazone-default**, which allows traffic within the same zone, and **interzone-default**, which blocks traffic between zones. Logging is disabled on both by default. For this workshop, create an `allow-all-temp` policy to simplify the later validation steps. In a production deployment, allow only the traffic that you require.

1. Navigate to the **Policies** tab.
2. Click on **Security**.
3. Notice the **default policy rules**.

    ![Review the default PAN-OS security policies](images/review-default-security-policies.png)

    - Click on the **Add** button.

    ![Add a new security policy rule](images/add-security-policy-rule.png)

<!-- -->

1. Navigate to the **General** tab.
2. Specify a **name** for the new policy rule.
3. Set the **rule type** to **Universal**.

    ![Set the general options for the new security policy](images/set-security-policy-general-options.png)

<!-- -->

1. Navigate to the **Source** tab.
2. In the **Source Zone** section, select **Any**.

    ![Allow any source zone in the temporary security policy](images/allow-any-source-zone.png)

<!-- -->

1. Navigate to the **Destination** tab.
2. In the **Destination Zone** section, select **Any**.

    ![Allow any destination zone in the temporary security policy](images/allow-any-destination-zone.png)

<!-- -->

1. Navigate to the **Application** tab.
2. In the **Applications** section, select **Any**.

    ![Allow any application in the temporary security policy](images/allow-any-application.png)

<!-- -->

1. Navigate to the **Service/URL Category** tab.
2. In the **Service** section, select **Any**.

    ![Allow any service in the temporary security policy](images/allow-any-service.png)

<!-- -->

1. Navigate to the **Actions** tab.
2. In the **Action Settings** section, select **Allow**.
3. In the **Log Settings** section, select **Log at Session End**.
4. Click **OK**.

    ![Set the security policy action and session-end logging](images/set-security-policy-action-and-logging.png)

<!-- -->

1. Confirm that the new security policy is listed.
2. Click **Commit**.

    ![Commit the new security policy](images/commit-new-security-policy.png)

<!-- -->

1. When warned that the commit overwrites the running configuration.
2. Click **Commit**.

    ![Confirm the security policy commit](images/confirm-security-policy-commit.png)

- Wait for the commit to complete.

    ![Wait for the security policy commit to complete](images/wait-for-security-policy-commit.png)

- Confirm that the commit completed successfully.

    ![Confirm that the security policy commit completed successfully](images/confirm-security-policy-commit-complete.png)

## Learn More

- [Configure Layer 3 Interfaces (PAN-OS)](https://docs.paloaltonetworks.com/ngfw/networking/configure-interfaces/layer-3-interfaces/configure-layer-3-interfaces)
- [Policy Objects](https://docs.paloaltonetworks.com/network-security/security-policy/administration/objects)

## Acknowledgements

- **Authors** - Anas Abdallah, Iwan Hoogendoorn (Cloud Networking Black Belts)
- **Contributor** - Antonio Gámir (Cloud Networking Black Belt)
- **Last Updated By/Date** - Anas Abdallah, August 2026

You may now **proceed to the next lab**.
