# Conclusion

## Introduction

This lab closes the standalone deployment by reviewing the OCI and PAN-OS configuration completed in the preceding labs. The resulting design is the foundation for the high-availability and VPN workshops that follow.

Estimated time: 5 minutes

### Objectives

In this lab, you will review and validate the completed standalone Palo Alto deployment in OCI.

### Prerequisites

Before you begin, ensure you have completed the preceding required labs in this workshop.

## Task 1: Verify the Standalone Firewall Setup

Before moving on, verify the following:

- You can access the firewall through the management interface.
- The trust and untrust interfaces are configured and show an available link state.
- The interfaces are assigned to the correct security zones and virtual router.
- The security policy is committed and active.

You have now deployed a Palo Alto Networks VM-Series Next-Generation Firewall (NGFW) in Oracle Cloud Infrastructure (OCI), integrated it into a functional network topology, and positioned it between trusted and untrusted zones.

You should now understand how to:

- Deploy the Palo Alto NGFW Marketplace image in a VCN.
- Attach and configure VNICs for management and data traffic.
- Access and manage the NGFW for initial configuration and testing.

Next, you can explore designs such as:

- Alternative firewall deployment architectures, where you can introduce high availability through Active/Passive and Active/Active designs.
- Secure connectivity between OCI and remote networks through Site-to-Site IPSec VPN.
- Secure remote-user access to OCI workloads through GlobalProtect.
- Hub-and-spoke inspection scenarios that bring the full architecture together and demonstrate different north-south and east-west traffic flows.

See **Learn More** below for related workshops.

## Acknowledgements

- **Authors** - Anas Abdallah, Iwan Hoogendoorn (Cloud Networking Black Belts)
- **Contributor** - Antonio Gámir (Cloud Networking Black Belt)
- **Last Updated By/Date** - Anas Abdallah, August 2026
