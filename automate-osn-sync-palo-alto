# Introduction

Oracle Cloud Infrastructure (OCI) publishes a [JSON document](https://docs.oracle.com/en-us/iaas/tools/public_ip_ranges.json) listing the public IP address ranges used by its cloud services. The file groups CIDR blocks by region and tags each block with the service it belongs to, such as `OBJECT_STORAGE` for Object Storage endpoints, `OSN` for the Oracle Services Network, and `OCI` for VCN public IP ranges (used by resources like compute instances, NAT Gateways, and public Load Balancers).

Network and security teams that operate firewalls in front of OCI workloads rely on these ranges to control traffic to OCI services. The ranges change over time, and any drift between the published file and the firewall's address objects can break legitimate traffic or leave stale objects in policies. To keep firewall policies aligned, OCI recommends polling the file at least weekly to pick up new ranges. Tracking these changes manually is repetitive, error-prone, and easy to neglect.

This workshop shows how to automate the process end-to-end on OCI. An OCI Function downloads the JSON file, filters to the regions and services you care about, and synchronizes the resulting CIDRs to a Palo Alto firewall: it creates and updates address objects to match the CIDRs in the file, removes any of its own auto-managed objects that are no longer in the file, groups them into an address group, and commits the change via the PAN-OS XML API. The function is stateless and stores no secrets on disk; the firewall API key lives in OCI Vault and is fetched at runtime via resource principal authentication. Scheduling is handled by a daily cron job on a small Always-Free Compute VM that calls the function. The function is where the work happens; cron is just the heartbeat.

## Why this is needed

As an example, the diagram below shows a typical OCI hub-and-spoke deployment, where workloads in spoke VCNs reach Oracle services through a Palo Alto firewall in the hub. The firewall is the single egress inspection point for all spoke traffic destined to OCI services, which means it must permit Oracle's current set of public IP ranges. If those ranges drift out of sync with what Oracle publishes, applications in the spokes lose access to services they were previously reaching.

![](13a10b0cba3dea5e775a3c3e374daeaa.png)

In a setup like this, every spoke depends on the hub firewall's address objects being accurate and current. Three reasons to automate this rather than maintain it by hand:

- **Keeping up with changes.** OCI updates the published ranges in the [JSON document](https://docs.oracle.com/en-us/iaas/tools/public_ip_ranges.json) over time, and a firewall that lags behind will either block legitimate traffic or trust ranges that no longer belong to Oracle. Reviewing the file and editing address objects by hand every week is slow, repetitive, and easy to forget.
- **Avoiding configuration drift.** When updates happen manually, different engineers handle them differently. Names change, CIDRs get missed, old objects stay behind. A single automated process produces the same result every run, with predictable naming and no leftovers.
- **Operating without static credentials.** Any manual workflow ends up with someone holding a PAN-OS API key on a laptop or jump host. Running the work inside OCI lets the firewall API key live in Vault and be fetched at runtime by the function's own identity, with no keys stored on disk and every invocation visible in OCI Monitoring.

## Objectives

In this workshop, you will:

- Store a PAN-OS API key securely in **OCI Vault**.
- Configure **IAM dynamic groups and policies** so the function can authenticate to Vault using its own identity (resource principal). No static credentials.
- Build and deploy an **OCI Function** (Python) that fetches Oracle's public IP ranges, filters by region/service, and synchronizes them to your Palo Alto firewall.
- Trigger the function on a daily schedule from an **Always-Free Compute VM**, using cron and instance principal authentication.

## Architecture Summary

The diagram below shows the components involved in the sync and how they interact. One full cycle runs through four steps:

1. The cron VM invokes the OCI Function on schedule (instance principal auth, no keys on the VM).
2. The function fetches the public JSON from Oracle via the Hub VCN's Internet Gateway.
3. The function reads the PAN-OS API key from OCI Vault using its own identity (resource principal auth).
4. The function reconciles address objects on the PA-VM by calling the PAN-OS XML API over the management interface.

![](3bb48394a7b19e7010e8846030fc5673.png)

What each component does:

| Component                         | Purpose                                                                                                                                                                                                          |
| --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| OCI Function (Python)             | Stateless function attached to a Hub VCN subnet. Fetches Oracle's JSON, reconciles address objects on the PA-VM via the PAN-OS XML API (creates, updates, deletes auto-managed objects), and commits the change. |
| OCI Vault                         | Encrypted storage for the PAN-OS API key.                                                                                                                                                                        |
| Dynamic Group + Policy (function) | Lets the function read the secret using its own identity (resource principal), with no static credentials on disk.                                                                                               |
| Always-Free Compute VM            | 24/7 cron host in the Hub VCN that triggers the function via OCI CLI. Uses instance principal auth.                                                                                                              |
| Dynamic Group + Policy (VM)       | Lets the VM invoke the function as itself, with no API keys stored on the VM.                                                                                                                                    |
| PA-VM (Palo Alto VM-Series)       | Target firewall. Receives address-object updates on its management interface (vNIC0) at 172.16.0.10.                                                                                                             |

## Prerequisites

Before starting, make sure you have:

1. An OCI tenancy with a compartment you can deploy resources into. Here we used the `Tutorial` compartment.
2. A Palo Alto VM-Series firewall deployed in an OCI VCN. Complete the following Live Labs workshop first: `<Live Labs URL>`. It provisions the baseline environment used in this workshop: the firewall along with the Hub VCN, subnets, Internet Gateway, and base configuration. After completing it, note the firewall's management IP and admin credentials.
3. Access to Cloud Shell from the OCI Console.
4. The following OCIDs ready. Replace the placeholders below with values from your own tenancy:
    - Compartment OCID: `ocid1.compartment.oc1..aaaaaaaaxxxxyyyyyyqqq`.
    - Subnet OCID (function/management subnet): `ocid1.subnet.oc1.eu-frankfurt-1.aaaaaaaaxxxxxyyyyqqq`.
    - Tenancy namespace: `fr8xxyz44x`.

![](e1e12120bd8def13cffcd3f12c1d1442.png)

## Learn More

1. [Familiarity with OCI console](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm)
2. [Overview of Networking](https://docs.us-phoenix-1.oraclecloud.com/Content/Network/Concepts/overview.htm)
3. **This will be updated when the full palo alto workshop series is published.**

## Acknowledgements

- **Author** - Anas Abdallah (OCI Network Black Belt)
- **Last Updated By/Date** - Anas Abdallah, June 2026
