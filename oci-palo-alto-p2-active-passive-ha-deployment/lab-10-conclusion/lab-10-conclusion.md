# Conclusion

## Introduction

This lab closes the Active/Passive deployment by reviewing the OCI and firewall configuration completed in the preceding labs. The resulting design provides redundant traffic inspection and establishes the foundation for the advanced connectivity workshops that follow.

Estimated time: 5 minutes

### Objectives

In this lab, you will:
- Review the completed Active/Passive HA configuration.
- Confirm that HA synchronization and failover behave as expected.

### Prerequisites

Before you begin, ensure you have completed the preceding required labs in this workshop.

## Task 1: Verify the Active/Passive HA Setup

Before moving on, verify the following:

- You can access both firewalls through their management interfaces.
- The trust, untrust, and HA interfaces are configured on both peers.
- HA1 control communication and HA2 session synchronization are operational.
- The security policy is committed on the active firewall and synchronized to the passive peer.
- The floating trust and untrust addresses support traffic redirection to the active firewall.
- The failover test promotes the passive firewall to active, and the expected failback behavior is confirmed.

You have now deployed a Palo Alto Networks VM-Series Active/Passive HA pair in Oracle Cloud Infrastructure (OCI), configured the OCI networking and IAM permissions that support failover, and validated peer synchronization and role transition.

You should now understand how to:

- Deploy and prepare two VM-Series firewalls for an Active/Passive design.
- Attach and configure VNICs for management and data traffic.
- Access and manage the NGFW for initial configuration and testing.
- Configure floating addresses, IAM permissions, and the HA1 and HA2 links.
- Validate configuration synchronization, session state synchronization, failover, and failback behavior.

Next, you can explore designs such as:

- Alternative firewall deployment architectures, including standalone and Active/Active designs.
- Secure connectivity between OCI and remote networks through Site-to-Site IPSec VPN.
- Secure remote-user access to OCI workloads through GlobalProtect.
- Hub-and-spoke inspection scenarios that bring the full architecture together and demonstrate different north-south and east-west traffic flows.

See **Learn More** below for related workshops.

## Acknowledgements

- **Authors** - Anas Abdallah, Iwan Hoogendoorn (Cloud Networking Black Belts)
- **Contributor** - Antonio Gámir (Cloud Networking Black Belt)
- **Last Updated By/Date** - Anas Abdallah, August 2026
