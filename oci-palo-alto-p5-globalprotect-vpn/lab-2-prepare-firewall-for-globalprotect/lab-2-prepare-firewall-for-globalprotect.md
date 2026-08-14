# Prepare the Firewall for GlobalProtect

## Introduction

This lab prepares the Palo Alto firewall for GlobalProtect before you configure certificates, TLS, and the Portal/Gateway. You create the tunnel interface and Remote Access VPN security zone that terminate remote-user traffic, enable management access on the Untrust interface for the NLB health check, and configure the local user authentication components used by the portal and gateway. In an Active/Active deployment, apply the required firewall configuration on both peers so either node can serve remote users.

Estimated time: 15 minutes

### Objectives

In this lab, you will:
- Create the GlobalProtect tunnel interface and remote-VPN zone.
- Create and assign the Untrust interface management profile.
- Create the local user and authentication profile.

### Prerequisites

Before you begin, ensure you have completed the preceding required labs in this workshop.

## Task 1: Create tunnel interface

In this task, you create the required **tunnel interface** on the Palo Alto firewall. This logical interface will be used by the Remote Access VPN (GlobalProtect) to terminate VPN client connections and route traffic between remote users and resources in OCI. Correct tunnel interface configuration is essential, as it provides the Layer-3 interface used by the GlobalProtect gateway and allows the firewall to route traffic coming from connected VPN users.

- Go to the management web GUI of the Palo Alto firewall.

1. Click on the **Network** tab.
2. Click on **Interfaces**.
3. Click on the **Tunnel** tab.
4. Click on the **Add** button.

    ![Open tunnel interface configuration](images/open-tunnel-interface-configuration.png)

<!-- -->

1. Specify 3 to be the **number** of the tunnel.
2. Specify a **comment** / **description** of the tunnel.
3. Click on the **Config** tab.
4. Choose the default **Virtual Router**.
5. Click on the **Security Zone**.
6. Click on the **New Zone** button.

    ![Configure tunnel interface settings](images/configure-tunnel-interface-settings.png)

<!-- -->

1. Specify a **Name** for the new security zone.
2. Check **Enable User Identification** box. This maps traffic to usernames, so you can see which user is accessing OCI resources through GlobalProtect in your logs.
3. Click on the **OK** button.

    ![Create remote VPN security zone](images/create-remote-vpn-security-zone.png)

<!-- -->

1. Make sure the newly created **security zone** is selected.
2. Click on the **OK** button.

    ![Select remote VPN security zone](images/select-remote-vpn-security-zone.png)

    - Notice that the tunnel is created successfully.

    ![Verify tunnel interface created](images/verify-tunnel-interface-created.png)

## Task 2: Create and Assign Management Profile to Untrust Interface

In this task, you create and assign an Interface Management Profile to the untrust interface on the Palo Alto firewall. Interface Management Profiles control which administrative and diagnostic services -such as HTTPS, SSH, or ICMP- are permitted on a given interface.

By default, data interfaces do not allow any management traffic. Applying a management profile explicitly enables only the services you need while keeping everything else blocked, which supports a least-privilege security posture.

In this workshop, the profile enables two services on the untrust interface:

- **ICMP**: to validate basic connectivity and reachability with `ping` when testing the Remote Access VPN from your PC.
- **HTTP**: to allow `curl` testing from your PC, and **for Active/Active**: to pass the VPN NLB health check.

- Navigate to the **Network** tab.

![Open Network tab](images/open-network-tab.png)

1. Click on **Interface Mgmt**.
2. Click on the **Add** button.

    ![Open interface management profile](images/open-interface-management-profile.png)

<!-- -->

1. Specify a **Name** for the Interface Management Profile.
2. Check the **HTTP** Administrative Management Services box.
3. Check the **Ping** Network Services box.
4. Click on the **Add** button.
5. Specify the **CIDR block** or **IP address** that will be allowed to ping the firewall’s Untrust interface, which is `192.168.1.0/28` and represents the address pool assigned to VPN clients. This IP pool will be configured in Lab 4, Task 2, while setting up the GlobalProtect Gateway.
6. Click on the **OK** button.

    ![Configure interface management profile](images/configure-interface-management-profile.png)

<!-- -->

1. Notice that the Interface Management Profile is now created.
2. Click on **Interfaces**.

    ![Open Interfaces page](images/open-interfaces-page.png)

    - Click on interface **ethernet1/1**.

    ![Select Untrust interface](images/select-untrust-interface.png)

<!-- -->

1. Click on the **Advanced** tab.
2. Select the **Interface Management Profile** we just created.
3. Click on the **OK** button.

    ![Assign management profile to Untrust](images/assign-management-profile-to-untrust.png)

    - Click on **Yes**.

    ![Confirm interface management profile](images/confirm-interface-management-profile.png)

    - Notice that the **Interface Management Profile** is assigned to interface ethernet1/1.

    ![Verify management profile assignment](images/verify-management-profile-assignment.png)

    - **For Active/Active only:** add the LB Subnet CIDR `172.16.0.48/28` to the `http-untrust` interface management profile created in Part 3 of the workshop. Without this, the VPN NLB health checks (Lab 1) originating from the LB Subnet will be denied by the firewall, causing the backends to be marked unhealthy.

    ![Allow LB Subnet health checks](images/allow-lb-subnet-health-checks.png)

## Task 3: Configure User Authentication

In this task, you configure how the GlobalProtect Portal and Gateway authenticate remote users. To keep the lab self-contained, you will use the firewall's **Local User Database** rather than an external identity provider (LDAP, RADIUS, SAML, etc.). The flow is:

1. Create a **local user** with a password.
2. Create an **Authentication Profile** that points to the Local User Database and limits access to that user.

<!-- -->

1. Navigate to the **Device** tab.

    ![Open Device tab](images/open-device-tab.png)

<!-- -->

1. Click on **Users** under **Local User Database**.
2. Click on the **Add** button.

    ![Add local user](images/add-local-user.png)

<!-- -->

1. Specify a **Name** for the user (e.g. `Anas`).
2. Set the **Mode** to **Password**.
3. Specify a **Password**.
4. **Confirm Password**.
5. Make sure the **Enable** box is checked.
6. Click on the **OK** button.

    ![Configure local user](images/configure-local-user.png)

<!-- -->

1. Notice that the user has been created.
2. Click on **Authentication Profile**.

    ![Open authentication profile](images/open-authentication-profile.png)

    - Click on the **Add** button.

    ![Add authentication profile](images/add-authentication-profile.png)

<!-- -->

1. Specify a **Name** for the Authentication Profile (e.g. `GP-AuthN-Profile`).
2. Click on the **Authentication** tab.
3. Set the **Type** to **Local Database**.
4. Click on the **Advanced** tab.

    ![Configure authentication profile](images/configure-authentication-profile.png)

<!-- -->

1. Click on the **Add** button to add an entry to the Allow List.
2. Select the local user we just created (`Anas`).
3. The **Account Lockout** section can be configured to lock user accounts after a number of failed login attempts. We will leave it empty for this workshop.
4. Click on the **OK** button.

    ![Configure authentication allow list](images/configure-authentication-allow-list.png)

    - Notice that the Authentication Profile is created and references the Local Database with `Anas` in the allow list.

    ![Verify authentication profile created](images/verify-authentication-profile-created.png)

## Learn More

- [Create Interfaces and Zones for GlobalProtect](https://docs.paloaltonetworks.com/globalprotect/administration/get-started/create-interfaces-and-zones-for-globalprotect)
- [GlobalProtect User Authentication](https://docs.paloaltonetworks.com/globalprotect/administration/globalprotect-user-authentication)
- [Set Up External Authentication](https://docs.paloaltonetworks.com/globalprotect/administration/globalprotect-user-authentication/set-up-external-authentication)

## Acknowledgements

- **Authors** - Anas Abdallah, Iwan Hoogendoorn (Cloud Networking Black Belts)
- **Contributor** - Antonio Gámir (Cloud Networking Black Belt)
- **Last Updated By/Date** - Anas Abdallah, August 2026

You may now **proceed to the next lab**.
