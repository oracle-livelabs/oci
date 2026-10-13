# Conclusion

## Introduction

This lab concludes the Palo Alto hub-and-spoke routing workshop by reviewing the configuration completed in the preceding nine scenarios. The resulting standalone Palo Alto setup steers traffic through the hub firewall where inspection is required and maintains symmetric return paths.

Estimated Time: 5 minutes

### Objectives

In this lab, you will:
- Review the completed hub-and-spoke routing configuration across the nine scenarios.
- Confirm that OCI, DRG, and Palo Alto routing direct traffic through the intended inspection paths and maintain symmetric return paths where required.
- Confirm that end-to-end connectivity and Palo Alto traffic logs meet the workshop objectives.

### Prerequisites

Before you begin, ensure you have completed the preceding required labs in this workshop.

## Task 1: Verify the Hub-and-Spoke Routing Setup

Before moving on, verify the following:

- The Hub VCN and applicable spoke VCNs are attached to the DRG and use the intended DRG route tables and import route distributions.
- VCN subnet and gateway ingress route tables steer traffic through the Palo Alto firewall where inspection is required.
- The forward and return paths are symmetric for every inspected flow.
- The Palo Alto virtual router, security policies, and NAT policies contain the configuration required for the selected scenarios.
- End-to-end connectivity succeeds for the scenarios you configured, and Palo Alto traffic logs show the validation traffic.

You have now configured nine Palo Alto hub-and-spoke routing scenarios in OCI: public application access, centralized outbound Internet access, GlobalProtect remote access, Oracle Services Network access, intra- and inter-VCN routing, and hybrid IPSec connectivity. You used OCI VCN and DRG routing, gateway ingress route tables, and Palo Alto virtual-router, security, and NAT policies to direct traffic through the standalone firewall where required.

You should now understand how to:

- Use VCN route tables, DRG route tables, and gateway ingress route tables to steer traffic through a hub firewall.
- Design symmetric forward and return paths for inspected north-south, east-west, remote-access, OSN, and hybrid traffic.
- Configure Palo Alto virtual-router routes, security policies, and NAT policies for the selected traffic flows.
- Validate end-to-end connectivity and Palo Alto traffic logs for each scenario.

## Learn More

- [OCI VCN Route Tables](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/managingroutetables.htm)
- [OCI Dynamic Routing Gateway (DRG)](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/managingDRGs.htm)
- [Palo Alto VM-Series Firewall on OCI](https://docs.paloaltonetworks.com/vm-series/deployment/public-cloud/set-up-the-vm-series-firewall-on-oracle-cloud-infrastructure/prepare-to-set-up-the-vm-series-firewall-on-oci)
- [Palo Alto View and Manage Logs](https://docs.paloaltonetworks.com/ngfw/administration/monitoring/view-and-manage-logs)

## Acknowledgements

- **Authors** - Anas Abdallah, Iwan Hoogendoorn (Cloud Networking Black Belts)
- **Contributor** - Antonio Gámir (Cloud Networking Black Belt)
- **Last Updated By/Date** - Anas Abdallah, October 2026
