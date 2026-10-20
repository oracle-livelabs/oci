# Introduction

## About this Workshop

This is the final part of the Palo Alto Networks in OCI series. The earlier parts focused on deploying and configuring the firewall itself, this part shifts the focus to routing and end-to-end connectivity around it.

This workshop uses a single Palo Alto VM-Series instance, suited to proof-of-concept, test, and learning environments; production workloads normally use Active/Passive or Active/Active HA. In a hub-and-spoke deployment, the firewall sits in the hub to inspect traffic between VCNs, subnets, and zones. This is mainly a routing exercise: correct routes steer traffic through the firewall; incorrect routes can bypass inspection, cause asymmetric flows, or disrupt connectivity.

This workshop walks through **nine common routing scenarios on a Single Instance Palo Alto NGFW** deployed in OCI Frankfurt:

- **Lab 1: Configure Public Application Access - ALB (WAF) First** - North-South access where a public Application Load Balancer and WAF sit in front of the Palo Alto firewall.
- **Lab 2: Configure Public Application Access - Palo Alto Firewall First** - North-South access where the firewall is in front of a private Application Load Balancer and performs destination NAT.
- **Lab 3: Configure Outbound Internet Access** - Centralized spoke Internet egress through the Palo Alto firewall with source NAT.
- **Lab 4: Configure Remote Access VPN via GlobalProtect** - Remote access through GlobalProtect with split-tunnel routing.
- **Lab 5: Configure OSN Access - Centralized SGW with Firewall Inspection** - Centralized Service Gateway access through the firewall for spoke-to-Oracle Services Network traffic.
- **Lab 6: Configure OSN Access - Distributed SGW with No Firewall Inspection** - Distributed Service Gateways in spokes for direct Oracle Services Network access.
- **Lab 7: Configure Intra-VCN Subnet-to-Subnet Communication** - East-west traffic between subnets in one spoke VCN routed through the firewall.
- **Lab 8: Configure Inter-VCN Spoke-to-Spoke Communication** - East-west traffic between spoke VCNs routed through the firewall.
- **Lab 9: Configure Hybrid Connectivity via IPSec VPN** - Hybrid IPSec connectivity between the Frankfurt Palo Alto firewall and an OCI native DRG in Milan.

Estimated Workshop Time: 4 hours

### Objectives

In this workshop, you will:

- Identify when traffic should flow through the Palo Alto firewall and how to force it there using OCI route tables.
- Configure DRG, VCN, and subnet route tables for North-South and East-West topologies.
- Configure matching static routes inside the Palo Alto's default Virtual Router.
- Apply NAT (source and destination) on the firewall where it is required by the topology.
- Validate end-to-end connectivity for each scenario and confirm traffic on the firewall.

### Prerequisites

Before you begin:

- Complete the LiveLabs workshop [Deploy Palo Alto NGFW in OCI (Standalone)](https://livelabs.oracle.com/ords/dbpm/r/livelabs/view-workshop?wid=4487), which deploys and licenses the standalone Palo Alto VM-Series firewall.
- Ensure you have permission to administer the required OCI networking resources and Palo Alto configuration.

## Hub-and-Spoke: Best Practices & Guidelines

In OCI, a Hub-and-Spoke topology places shared services—firewall, central egress, Gateways, and Bastions, in a single **Hub VCN**, and connects workload VCNs (the **Spokes**), IPSec VPN, and FastConnect through a **Dynamic Routing Gateway (DRG)**. All inter-VCN, hybrid, and Internet traffic that needs inspection or policy enforcement is then steered through the hub instead of being implemented separately in every spoke.

The pattern matters in three ways:

- **Operational simplicity**: one firewall, one set of policies, one place to enable a new service. Each new spoke is just a VCN attached to the DRG with a matching route entry. No per-VCN firewall, no per-VCN VPN, no per-VCN Gateway unless you explicitly want one.
- **Security posture**: every crossing through the hub means every inter-VCN, North-South, and (where designed) East-West flow is subject to the same inspection, logging, and policy. This is what makes a centralized security model possible in OCI.
- **Cost and scale**: shared NGFW capacity is cheaper than per-VCN firewalls, and the DRG scales horizontally without you having to redesign anything.

To get a clean and predictable Hub-and-Spoke design in OCI, a few guidelines apply throughout this workshop:

- **Use a dedicated Hub VCN** for the Palo Alto and any other shared services. Do not co-locate workloads in the Hub VCN - that breaks the boundary between "infrastructure" and "applications" and makes the routing tables harder to reason about.
- **Use separate subnets per Palo Alto interface** in the Hub VCN: Management, Untrust, and Trust. This keeps security lists and route tables aligned with each Palo Alto zone.
- **Attach each spoke to the DRG with its own VCN attachment** and apply a custom **DRG Route Table** (`rt-spoke`) that points back to the Hub VCN attachment for everything that must be inspected (typically `0.0.0.0/0` or selected CIDRs). Use a **DRG Import Route Distribution** (`ird-hub`) on the Hub's custom DRG Route Table (`rt-hub`) to dynamically learn all spoke CIDRs, so the hub does not need to be reconfigured each time a spoke is added.
- **Assign an Ingress Route Table** (`rt-drg-ingress`) on the Hub VCN's DRG attachment whenever return traffic needs to be steered back through the firewall instead of using the Hub VCN's local routing. This is the pattern that prevents asymmetric flows in some North-South scenarios.
- **Configure routes on the Palo Alto separately.** The DRG and the firewall maintain separate routing tables. Add the required static routes in the Palo Alto virtual router for networks reached through the Trust or Untrust interface; the firewall does not automatically learn routes from OCI or the DRG.
- **Avoid overlapping CIDR ranges.** Hub, spoke, on-premises, and multi-cloud networks need unique address ranges so the DRG and firewall can route traffic unambiguously.
- **Keep route tables small and named clearly** (`rt-drg-ingress`, `rt-hub`, `rt-spoke`, `rt-untrust`, `rt-trust`, `rt-lb`, `rt-app`, etc.). A consistent naming convention makes the routing diagrams in this workshop readable and, more importantly, makes incidents debuggable at 02:00.
- **Validate with logging.** Confirm the expected session, NAT rule, and traffic logs on the firewall after each routing change.

> **Important Notes:**
> 1) This workshop uses **specific routes** in spokes (for example, `172.16.0.48/28 → DRG`) instead of a default route (`0.0.0.0/0 → DRG`). Both are valid: specific routes keep traffic flows predictable and only steer what needs inspection through the firewall, while a default route to the hub is the **centralized egress** pattern commonly used in production to send all spoke traffic through the firewall for inspection and policy enforcement.
> 2) Throughout this workshop, you can commit Palo Alto changes after each task (safer, easier to troubleshoot) or wait and commit once at the end (faster, fewer commits). For clarity, explicit commit steps are not shown after every scenario.
> 3) Each lab, except the conclusion, includes a **Traffic Flow** section that explains the use case. The diagram illustrates the forward traffic path; **the final numbered step explains the return traffic**.

## Learn More

- [OCI VCN Route Tables](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/managingroutetables.htm)
- [OCI Dynamic Routing Gateway (DRG)](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/managingDRGs.htm)
- [Palo Alto Static Routes](https://docs.paloaltonetworks.com/ngfw/networking/static-routes)

## Acknowledgements

- **Authors** - Anas Abdallah, Iwan Hoogendoorn (Cloud Networking Black Belts)
- **Contributor** - Antonio Gámir (Cloud Networking Black Belt)
- **Last Updated By/Date** - Anas Abdallah, October 2026
