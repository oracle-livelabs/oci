# Conclusion

## Introduction

This lab concludes the Palo Alto Active/Active hub-and-spoke routing workshop by reviewing the configuration completed in the preceding seven scenarios. The resulting design uses private transparent Trust and Untrust NLBs for the flows that require route insertion, preserves session symmetry through those NLBs, and uses direct firewall termination for IPSec VPN.

Estimated Time: 5 minutes

### Objectives

In this lab, you will:
- Review the completed hub-and-spoke routing configuration across the seven scenarios.
- Confirm that OCI, DRG, and Palo Alto routing direct traffic through the intended inspection paths and maintain symmetric return paths where required.
- Confirm that NLB-inserted flows and directly terminated IPSec flows use their respective, correct paths.
- Confirm that end-to-end connectivity and Palo Alto traffic logs meet the workshop objectives.

### Prerequisites

Before you begin, ensure you have completed the preceding required labs in this workshop.

## Task 1: Verify the Hub-and-Spoke Routing Setup

Before moving on, verify the following:

- The Hub VCN and applicable spoke VCNs are attached to the DRG and use the intended DRG route tables and import route distributions.
- VCN subnet and gateway ingress route tables steer traffic through the Trust or Untrust NLB where NLB insertion is required.
- The forward and return paths are symmetric for every NLB-inserted inspected flow.
- The Palo Alto virtual router, security policies, and NAT policies contain the configuration required for the selected scenarios.
- Both firewalls have matching routing and policy configuration; the Trust and Untrust NLBs preserve packet headers and use symmetric hashing for NLB-inserted flows.
- The Site-to-Site IPSec connection terminates directly on its selected firewall. Its DRG ingress route targets that firewall's Trust private IP; neither the Trust nor Untrust NLB fronts or load-balances that IPSec connection.
- End-to-end connectivity succeeds for the scenarios you configured, and Palo Alto traffic logs show the validation traffic.

You have now configured seven Palo Alto hub-and-spoke routing scenarios in OCI: public application access, centralized outbound Internet access, centralized Oracle Services Network access with inspection, distributed Oracle Services Network access without inspection, intra-VCN subnet-to-subnet communication, inter-VCN spoke-to-spoke communication, and hybrid IPSec connectivity. You used OCI VCN and DRG routing, gateway ingress route tables, private NLBs, and Palo Alto virtual-router, security, and NAT policies to direct traffic through the Active/Active firewalls where required.

You should now understand how to:

- Use VCN route tables, DRG route tables, and gateway ingress route tables to steer traffic through transparent private NLBs and Active/Active firewalls.
- Design symmetric forward and return paths for NLB-inserted north-south, east-west, and OSN traffic, and direct per-firewall paths for hybrid IPSec traffic.
- Configure Palo Alto virtual-router routes, security policies, and NAT policies for the selected traffic flows.
- Validate NLB health, end-to-end connectivity, and Palo Alto traffic logs for each scenario.

## Learn More

- [OCI VCN Route Tables](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/managingroutetables.htm)
- [OCI Dynamic Routing Gateway (DRG)](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/managingDRGs.htm)
- [Palo Alto VM-Series Firewall on OCI](https://docs.paloaltonetworks.com/vm-series/deployment/public-cloud/set-up-the-vm-series-firewall-on-oracle-cloud-infrastructure/prepare-to-set-up-the-vm-series-firewall-on-oci)
- [Palo Alto View and Manage Logs](https://docs.paloaltonetworks.com/ngfw/administration/monitoring/view-and-manage-logs)

## Acknowledgements

- **Authors** - Anas Abdallah, Iwan Hoogendoorn (Cloud Networking Black Belts)
- **Contributor** - Antonio Gámir (Cloud Networking Black Belt)
- **Last Updated By/Date** - Anas Abdallah, October 2026
