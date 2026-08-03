# Access the Palo Alto and Perform Initial Setup

## Introduction

This lab moves from OCI resource deployment to PAN-OS configuration for the Active/Active firewall pair. You access both firewalls, configure their trust and untrust interfaces, and security zones, then create and commit the initial security policy on each firewall.

Estimated time: 25 minutes

### Objectives

In this lab, you will:
- Access the management interface of both Palo Alto firewalls.
- Set the `admin` password on both firewalls.
- Configure the management, trust, and untrust interfaces and their security zones.
- Create interface management profiles that allow NLB health checks to reach the trust and untrust interfaces.
- Create a security policy for the firewall.
- Commit the initial PAN-OS configuration.

### Prerequisites

Before you begin, ensure you have completed the preceding required labs in this workshop.

## Task 1: Access via SSH and Set the Admin Password on Both Firewalls

Now that the Palo Alto firewalls are deployed, you are ready to access them. Complete these steps on **PA-VM-01**, then repeat them on **PA-VM-02** using its management public IP address. Each firewall needs its own `admin` password before you access its web interface.

- For macOS:
1. Set up an SSH connection using your private SSH key and your public IP address with the following command: `ssh -i <your private key> admin@ <your public IP address>`.
2. Type `yes` to confirm that you want to connect.
3. Notice the `Welcome admin` message, that indicate that you are logged in.
4. Type in `configure` to enter the  configuration mode.
5. Type in `set mgt-config users admin password` to configure the password for the `admin` user.
6. Enter a secure `password`, and confirm the password.

    ![Set admin password](images/set-admin-password-ssh.png)

- Refer to the initial steps in the following [workshop](https://docs.oracle.com/en/learn/oci-openvpn-part1/index.html#task-52-access-openvpn-vm-from-putty-and-complete-the-initial-setup) to learn how to access from Windows using PuTTY.

## Task 2: Access via GUI and Configure the Interfaces for PA-VM-01

Use the web interface to configure the PA-VM-01 data-plane interfaces and security zones. You will repeat the applicable configuration on PA-VM-02 later in this task.

1. Open a **web browser** and use your public IP address to connect to the management web interface of the Palo Alto Firewall (PA-VM-01).
2. Depending on your browser (settings) you might need to allow the connection as the Palo Alto Firewall does not have a signed certificate deployed yet. Click on **Advanced**.

    ![Depending your browser settings you](images/depending-your-browser-settings-you-might-need-allow-connect.png)

    - Click on **Proceed**.

    ![Click proceed](images/click-proceed.png)

<!-- -->

1. Type in your username: `admin`.
2. Type in your password (you just created).
3. Click in the **Log In** button.

    ![Click log button](images/click-log-button.png)

<!-- -->

1. You will we welcomed with the Welcome screen, Enable the **Do not show again** check box.
2. Click on the **Close** button.

    ![Click close button](images/click-close-button.png)

    - A message about Telemetry Data Connection will show up, and you can modify these settings later. For now click on the **OK** button.

    ![Message about telemetry data connection](images/message-about-telemetry-data-connection-will-show-up-you-can.png)

    - In Palo Alto Networks, **Address Objects** are used to define reusable representations of IP hosts, subnets, IP ranges, or FQDNs. Rather than typing IP addresses directly into the configuration, these objects are created once and referenced across multiple policies and rules, this improves configuration clarity, consistency, and ease of maintenance. **Using address objects is optional**, but it is considered a best practice. However, for the sake of simplicity, we will not rely on address objects through this workshop series.
    - Click on **Objects**.

    ![Click objects](images/click-objects.png)

<!-- -->

    - Click on **Addresses**.

    ![Click add](images/click-add.png)

    - Click on **Add**.

    ![Click ok](images/click-ok.png)

<!-- -->

1. Provide a **name** for the address, we are going to begin with **Trust vNIC Primary Private IP**.
2. Specify the type as **IP Netmask**.
3. Type Trust vNIC Private IP `172.168.0.40/28`.
4. Click on **OK**.

    ![Repeat same steps add rest](images/repeat-same-steps-add-rest-addresses.png)

    - Repeat the same steps to add the rest of addresses.

    ![Review created address objects](images/review-created-address-objects.png)

    - Whenever you need to add an address (for example, during interface configuration, virtual router setup, or security policy creation), you can select it from the address objects you have already created.

    ![Select address object during configuration](images/select-address-object-during-configuration.png)

    - This concludes the **optional** address objects part. We will now continue with the main configuration.
    - An **Interface Management Profile** in Palo Alto Networks defines which administrative services -such as HTTPS, SSH, or ICMP (ping)- are allowed on a specific firewall interface. By default, data interfaces block all management traffic. Applying a management profile explicitly enables the required services and allows access to be restricted to a whitelist of permitted IP addresses, reducing the attack surface while maintaining necessary administrative access. In this workshop, we use an interface management profile to allow HTTP on both the untrust and trust interfaces, allowing the Network Load Balancers to perform interface health checks in the next lab.
    - Navigate to the **Network** tab.

    ![Navigate network tab](images/navigate-network-tab.png)

<!-- -->

1. Click on **Interface Mgmt**.
2. Click on the **Add** button.

    ![Create management profile](images/create-interface-management-profile.png)

<!-- -->

1. Specify a **Name** for the Interface Management Profile.
2. Check the **HTTP** Administrative Management Services box.
3. Click on the **Add** button.
4. Specify the **CIDR block** that will be allowed to access the firewall’s Trust interface over HTTP. Use the Trust subnet CIDR where the Trust NLB will be created.
5. Click on the **OK** button.

    ![Configure trust management profile](images/configure-trust-management-profile.png)

<!-- -->

1. Notice that the Interface Management Profile is now created.
2. Click on the **Add** button.

    ![Click add button](images/click-add-button-2.png)

<!-- -->

1. Specify a **Name** for the Interface Management Profile.
2. Check the **HTTP** Administrative Management Services box.
3. Click on the **Add** button.
4. Specify the **CIDR block** that will be allowed to access the firewall’s Untrust interface over HTTP. Use the Untrust subnet CIDR where the Untrust NLB will be created.
5. Click on the **OK** button.

    ![Configure untrust management profile](images/configure-untrust-management-profile.png)

<!-- -->

1. Notice that the Interface Management Profile is now created.
2. Click on **Interfaces**. 

    ![Click interfaces](images/click-interfaces.png)

    - Click on interface **ethernet 1/1**.

    ![Select untrust interface](images/select-untrust-interface.png)

<!-- -->

1. Set the **Interface Type** to Layer3.
2. You will land on the **Advanced** tab.
3. Select the **Management Profile** you created for the **Untrust** interface.
4. Click on **Config**.

    ![Configure untrust interface](images/configure-untrust-interface.png)

<!-- -->

1. Set the **Virtual Router** to default.
2. Select the **Security Zone**.
3. In the pull down menu select **New Zone** (Untrusted).

    ![Set untrust zone](images/set-untrust-virtual-router-zone.png)

<!-- -->

1. Specify a **name** for the new (Untrusted) zone.
2. Click on the **OK** button.

    ![Name untrust zone](images/name-untrust-zone.png)

    - Make sure the (new) **Untrusted Zone** is selected for interface ethernet 1/1.

    ![Verify untrust zone](images/make-sure-new-untrusted-zone-is-selected-interface-ethernet.png)

<!-- -->

1. Click on **IPv4** (make sure you **Static** is selected).
2. Click on the **Add** button to add an IP address.
3. Specify an **IP address** for the (Untrusted) interface ethernet 1/1. We have used `172.16.0.20/28` (Make sure this IP is in the same subnet as your Untrusted OCI subnet CIDR block).
4. Click on the **OK** button.

    ![Set untrust IP address](images/set-untrust-interface-ip-address.png)

    - Notice that the (Untrusted) interface ethernet 1/1 is now configured.

    ![Verify untrust interface](images/verify-untrust-interface.png)

    - Click on interface **ethernet 1/2**.

    ![Select trust interface](images/select-trust-interface.png)

<!-- -->

1. Set the **Interface Type** to Layer3.
2. You will land on the **Advanced** tab.
3. Select the **Management Profile** you created for the **Trust** interface.
4. Click on **Config**.

    ![Configure trust interface](images/configure-trust-interface.png)

<!-- -->

1. Set the **Virtual Router** to default.
2. Select the **Security Zone**.
3. In the pull down menu select **New Zone** (Trusted).

    ![Set trust zone](images/set-trust-virtual-router-zone.png)

<!-- -->

1. Specify a **name** for the new (Trusted) zone.
2. Click on the **OK** button.

    ![Name trust zone](images/name-trust-zone.png)

    - Make sure the (new) **Trusted Zone** is selected for interface ethernet 1/2.

    ![Verify trust zone](images/verify-trust-zone.png)

<!-- -->

1. Click on **IPv4** (make sure you **Static** is selected).
2. Click on the **Add** button to add an IP address.
3. Specify an **IP address** for the (Trusted) interface ethernet 1/2. We have used `172.16.0.40/28` (Make sure this IP is in the same subnet as your Trusted OCI subnet CIDR block).
4. Click on the **OK** button.

    ![Set trust IP address](images/set-trust-interface-ip-address.png)

    - Notice that the (Trusted) interface ethernet 1/2 is now configured.

    ![Verify trust interface](images/verify-trust-interface.png)

<!-- -->

1. Notice that the **Link state** is grey (and not green).
2. Click on the **Commit** button.

    > **Note:** You can **commit** after each configuration you make (safer, easier to troubleshoot), or you can wait and commit once after completing all steps (faster, fewer commits).

    ![Commit interface configuration](images/commit-interface-configuration.png)

<!-- -->

1. Notice the message that commit will overwrite the running configuration.
2. Click on the **Commit** button.

    ![Click commit button](images/click-commit-button.png)

    - Wait for the **Commit** to complete.

    ![Verify interface commit](images/wait-commit-complete.png)

<!-- -->

1. Notice that the **Commit** has completed.
2. Click on the **Close** button.

    ![Close completed commit](images/close-completed-interface-commit.png)

    - Notice that the **Link state** is now green out (and not grey anymore).

    ![Verify green link state](images/notice-that-link-state-is-now-green-out-not-grey-anymore.png)

> **Note:** If the link state is still red, reboot the instance from the OCI Console and check again.

## Task 3: Access via GUI and Configure the Interfaces for PA-VM-02

Repeat the steps in Task 2 for the second Palo Alto VM, **PA-VM-02**, using the following parameters:

- Repeat the exact steps above on the second Palo Alto VM (PA-VM-02) instance.
- Use the following parameters:
    - Public IP for management interface of PA-VM-02 for SSH and HTTPS (GUI) access.
    - Untrusted IPv4 Address:
        - ethernet1/1: `172.16.0.21/28`
    - Trusted IPv4 Address: 
        - ethernet1/2: `172.16.0.41/28`

The screenshot below shows the final ethernet interface configuration of the second Palo Alto VM (PA-VM-02) instance.

![Below shows final ethernet interface](images/screenshot-below-shows-final-ethernet-interface-configuratio.png)

> **Note:** If the link state is still red, reboot the instance from the OCI Console and check again.

## Task 4: Create a Network Security Policy

The firewall interfaces are now in place. Create a security policy that controls which traffic may traverse the standalone firewall.

> **Note:** Palo Alto firewalls include two default read-only security policies: **intrazone-default**, which allows traffic within the same zone, and **interzone-default**, which blocks traffic between zones. Logging is disabled on both by default. For this workshop, create an `allow-all-temp` policy to simplify the later validation steps. In a production deployment, allow only the traffic that you require.

- Apply the following steps only on both, PA-VM-01 and PA-VM-02.

1. Navigate to the **Policies** tab.
2. Click on **Security**.
3. Notice the **default policy rules**.
    ![Review default security policies](images/review-default-security-policies.png)

    - Click on the **Add** button.

    ![Add security policy rule](images/add-security-policy-rule.png)

<!-- -->

1. Navigate to the **General** tab.
2. Specify a **name** for the new policy rule.
3. Set the **rule type** to **Universal**.

    ![Set security policy general options](images/set-security-policy-general-options.png)

<!-- -->

1. Navigate to the **Source** tab.
2. In the **Source Zone** section, select **Any**.

    ![Allow any source zone](images/allow-any-source-zone.png)

<!-- -->

1. Navigate to the **Destination** tab.
2. In the **Destination Zone** section, select **Any**.

    ![Allow any destination zone](images/allow-any-destination-zone.png)

<!-- -->

1. Navigate to the **Application** tab.
2. In the **Applications** section, select **Any**.

    ![Allow any application](images/allow-any-application.png)

<!-- -->

1. Navigate to the **Service/URL Category** tab.
2. In the **Service** section, select **Any**.

    ![Allow any service](images/allow-any-service.png)

<!-- -->

1. Navigate to the **Actions** tab.
2. In the **Action Settings** section, select **Allow**.
3. In the **Log Settings** section, select **Log at Session End**.
4. Click **OK**.

    ![Set security policy action logging](images/set-security-policy-action-and-logging.png)

<!-- -->

1. Confirm that the new security policy is listed.
2. Click **Commit**.

    ![Commit new security policy](images/commit-new-security-policy.png)

<!-- -->

1. When warned that the commit overwrites the running configuration.
2. Click **Commit**.

    ![Confirm security policy commit](images/confirm-security-policy-commit.png)

- Wait for the commit to complete.

    ![Verify security policy commit](images/wait-for-security-policy-commit.png)

- Confirm that the commit completed successfully.

    ![Confirm security policy commit complete](images/confirm-security-policy-commit-complete.png)

## Learn More

- [Configure Layer 3 Interfaces (PAN-OS)](https://docs.paloaltonetworks.com/ngfw/networking/configure-interfaces/layer-3-interfaces/configure-layer-3-interfaces)
- [Create a Security Policy Rule (PAN-OS)](https://docs.paloaltonetworks.com/pan-os/11-1/pan-os-admin/policy/security-policy/create-a-security-policy-rule)
- [Use Interface Management Profiles to Restrict Access](https://docs.paloaltonetworks.com/ngfw/networking/configure-interfaces/use-interface-management-profiles-to-restrict-access)
- [Policy Objects in Palo Alto](https://docs.paloaltonetworks.com/network-security/security-policy/administration/objects)

## Acknowledgements

- **Authors** - Anas Abdallah, Iwan Hoogendoorn (Cloud Networking Black Belts)
- **Contributor** - Antonio Gámir (Cloud Networking Black Belt)
- **Last Updated By/Date** - Anas Abdallah, August 2026

You may now **proceed to the next lab**.
