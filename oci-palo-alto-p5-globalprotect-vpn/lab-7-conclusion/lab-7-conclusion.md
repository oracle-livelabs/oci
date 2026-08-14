# Conclusion

## Introduction

This lab closes the GlobalProtect configuration by reviewing the certificates, authentication, Portal and Gateway settings, and client validation completed in the preceding labs. The resulting design provides remote users with secure VPN access to OCI resources through the Palo Alto firewall.

Estimated time: 5 minutes

### Objectives

In this lab, you will:
- Review the completed GlobalProtect remote-access VPN configuration.
- Confirm that the client connection and OCI access tests meet the workshop objectives.

### Prerequisites

Before you begin, ensure you have completed the preceding required labs in this workshop.

## Task 1: Verify the GlobalProtect Setup

Before moving on, verify the following:

- The GlobalProtect Portal and Gateway are configured on the firewall.
- The Portal and Gateway use the intended SSL/TLS Service Profile and Authentication Profile.
- The Gateway uses the GlobalProtect tunnel interface and assigns addresses from the configured client IP pool.
- The GlobalProtect agent connects successfully to the Portal and Gateway.
- The remote client receives an IP address from the GlobalProtect client pool.
- The remote client can access the intended OCI resources through the VPN tunnel.
- Palo Alto traffic logs show the GlobalProtect connection and validation traffic.

You have now configured GlobalProtect remote-access VPN on a Palo Alto Networks NGFW in OCI. You configured certificates, authentication, the Portal, the Gateway, client settings, and the GlobalProtect agent to provide secure remote-user access to OCI resources.

You should now understand how to:

- Create certificates and an SSL/TLS Service Profile for GlobalProtect.
- Configure local-user authentication for the Portal and Gateway.
- Configure the GlobalProtect Portal, external gateway, and trusted root CA settings.
- Configure the GlobalProtect Gateway, tunnel interface, IPSec, and client IP pool.
- Download and activate the GlobalProtect client software on the firewall, then install the GlobalProtect agent and validate client connectivity and firewall logs.

Next, you can explore designs such as:

- Palo Alto deployment models in OCI: Standalone, Active/Passive, and Active/Active.
- Site-to-Site IPSec VPN connectivity between OCI and remote networks.
- Hub-and-spoke inspection scenarios that bring the full architecture together and demonstrate different north-south and east-west traffic flows.

See **Learn More** below for related workshops.

## Acknowledgements

- **Authors** - Anas Abdallah, Iwan Hoogendoorn (Cloud Networking Black Belts)
- **Contributor** - Antonio Gámir (Cloud Networking Black Belt)
- **Last Updated By/Date** - Anas Abdallah, August 2026

You may now **proceed to the next lab**.
