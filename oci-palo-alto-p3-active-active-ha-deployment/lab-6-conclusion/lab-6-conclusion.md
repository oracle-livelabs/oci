# Conclusion

## Introduction

This lab closes the Active/Active deployment by reviewing the OCI and firewall configuration completed in the preceding labs. The resulting design distributes inspected traffic across both firewalls while preserving the session symmetry required for stateful inspection.

Estimated time: 5 minutes

### Objectives

In this lab, you will:
- Review the completed Active/Active firewall and NLB configuration.
- Confirm that both firewalls and both Network Load Balancers are ready for the configured traffic flows.

### Prerequisites

Before you begin, ensure you have completed the preceding required labs in this workshop.

## Task 1: Verify the Active/Active Setup

Before moving on, verify the following:

- You can access both firewalls through their management interfaces.
- The trust and untrust interfaces are configured on both firewalls and assigned to the correct security zones and virtual router.
- The interface management profiles allow the Trust and Untrust NLB health checks to reach both firewalls.
- The security policy is committed on both firewalls.
- The private Trust and Untrust NLBs include both firewalls as equal-weight backends and report healthy backend status.
- Source/destination preservation and symmetric hashing are enabled on both NLBs.

You have now deployed a Palo Alto Networks VM-Series Active/Active pair in Oracle Cloud Infrastructure (OCI), configured the OCI Network Load Balancers, and prepared both firewalls to inspect traffic through the intended symmetric paths.

You should now understand how to:

- Deploy and prepare two VM-Series firewalls for an Active/Active design.
- Configure the trust and untrust interfaces and management profiles on both firewalls for the health-check.
- Configure private Trust and Untrust NLBs with source/destination preservation and symmetric hashing.
- Validate that both firewalls are healthy and ready to inspect traffic through symmetric paths.

Next, you can explore designs such as:

- Alternative firewall deployment architectures, including standalone and Active/Passive designs.
- Secure connectivity between OCI and remote networks through Site-to-Site IPSec VPN.
- Secure remote-user access to OCI workloads through GlobalProtect.
- Hub-and-spoke inspection scenarios that bring the full architecture together and demonstrate different north-south and east-west traffic flows.

See **Learn More** below for related workshops.

## Learn More

- [Introduction to Network Load Balancer](https://docs.oracle.com/en-us/iaas/Content/NetworkLoadBalancer/introduction.htm)
- [Enabling Network Load Balancer Source/Destination Preservation](https://docs.oracle.com/en-us/iaas/Content/NetworkLoadBalancer/NetworkLoadBalancers/preserve-source-id.htm)
- [VM-Series Firewall Deployments on OCI](https://docs.paloaltonetworks.com/vm-series/10-1/vm-series-performance-capacity/vm-series-performance-capacity/vm-series-on-oracle-performance-and-capacity)

## Acknowledgements

- **Authors** - Anas Abdallah, Iwan Hoogendoorn (Cloud Networking Black Belts)
- **Contributor** - Antonio Gámir (Cloud Networking Black Belt)
- **Last Updated By/Date** - Anas Abdallah, August 2026
