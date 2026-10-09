# Configure Hybrid Connectivity via IPSec VPN

## Introduction

In this lab, you configure routing for Site-to-Site IPSec connectivity between a Palo Alto firewall in OCI and a remote site. The firewall inspects traffic from OCI spoke VCNs before it enters the IPSec tunnels and enforces symmetric return routing.

This lab uses an OCI native DRG in Milan as the demonstration remote site. The same design applies when the IPSec peer is on-premises, in another cloud, or in another OCI environment.

Estimated Time: 30 minutes

### Objectives

In this lab, you will:

- Configure Frankfurt VCN and DRG route tables to steer traffic to the remote site through the Palo Alto firewall.
- Configure Palo Alto virtual-router static routes and ECMP for the redundant IPSec tunnels.
- Configure Milan VCN and DRG routes for return connectivity through the IPSec tunnels.
- Validate IPSec connectivity and confirm inspected traffic in Palo Alto logs.

### Prerequisites

Before following the routing steps below, complete the items that are out of scope for this workshop. They are not part of the routing configuration itself, but they have to exist before any of the routes you are about to create are useful.

![IPSec VPN topology](images/lab-9-hybrid-connectivity-ipsec-vpn-2.png)

<!-- -->

1. Complete [Deploy Palo Alto NGFW in OCI (Standalone)](https://livelabs.oracle.com/ords/dbpm/r/livelabs/view-workshop?wid=4487). This workshop deploys the baseline Palo Alto VM-Series firewall in OCI Frankfurt, including the Hub VCN, subnets, Internet Gateway, and base firewall configuration.

2. Complete [Setup IPSec Site-to-Site VPN on Palo Alto NGFW in OCI](https://livelabs.oracle.com/ords/dbpm/r/livelabs/view-workshop?wid=4500). This workshop configures the **Site-to-Site IPSec VPN** between the Palo Alto firewall in Frankfurt and an OCI native DRG in Milan. Ensure that Phase 1 and Phase 2 are up before configuring routing for this lab.

Palo Alto IPSec endpoint in OCI Frankfurt:

![Verify Frankfurt Palo Alto IPSec endpoint](images/verify-frankfurt-palo-alto-ipsec-endpoint.png)

OCI native Site-to-Site VPN endpoint in Milan:

![Verify Milan IPSec VPN endpoint](images/verify-milan-ipsec-vpn-endpoint.png)

3. Provision two Spoke VCNs with Oracle Linux 9 VMs (or use an existing workload or application in your environment):
    
    |VCN|VCN CIDR|Subnet|VM|
    |---|---|---|---|
    |Spoke-1|`10.0.1.0/24`|Frontend `10.0.1.0/28`|FE-VM-01 `10.0.1.10`|
    |||Backend `10.0.1.16/28`|BE-VM-01 `10.0.1.20`|
    |Spoke-2|`10.0.2.0/24`|Frontend `10.0.2.0/28`|FE-VM-02 `10.0.2.10`|
    |||Backend `10.0.2.16/28`|BE-VM-02 `10.0.2.20`|


![Confirm Spoke VM instances](images/confirm-spoke-vm-instances.png)

4. Attach the Hub, Spoke-1, and Spoke-2 VCNs to the DRG. Then, assign the DRG and VCN route tables according to the table below:

| Attachment             | DRG Route Table | VCN Route Table |
| ---------------------- | --------------- | --------------- |
| Hub VCN Attachment     | rt-hub          | rt-drg-ingress  |
| Spoke-1 VCN Attachment | rt-spoke        | -               |
| Spoke-2 VCN Attachment | rt-spoke        | -               |

![Confirm DRG VCN attachments](images/confirm-drg-vcn-attachments.png)

A **VCN Route Table** is assigned to a DRG attachment (also called an **Ingress** or **Transit Route Table**) when traffic entering the Hub VCN through the DRG needs to be steered to a destination other than what the VCN's local routing would pick. In this scenario, it steers traffic from the DRG to the Palo Alto Trust interface for inspection instead of allowing local VCN routing to bypass the firewall. The same principle applies to other gateways (IGW, SGW, NAT GW): you assign an Ingress Route Table to them when the default VCN routing is not what you want.

![Review Hub VCN attachment](images/lab-9-hybrid-connectivity-ipsec-vpn-5.png)

## Task 1: Review the Use Case

In this design, which builds on **Part 4 (Site-to-Site VPN)**, traffic from the Frankfurt spoke VCNs reaches a remote site through the Palo Alto firewall and Site-to-Site IPSec tunnels. The firewall inspects both the request and return traffic before it enters or leaves the tunnels.

This lab uses an OCI native DRG and VCN in Milan as the demonstration remote site. The same routing pattern applies to an on-premises network, another cloud, or another OCI environment.

### This is the right choice when:

- You need inspected Site-to-Site IPSec connectivity between OCI workloads and a remote site.
- You need security-policy enforcement and traffic logs for traffic crossing the IPSec tunnels.

### Traffic Flow:

1. A workload at the remote site initiates a connection to an OCI workload. In this lab, **VM-0** (`172.16.1.5`) in OCI Milan connects to **FE-VM-01** (`10.0.1.10`) in Frankfurt Spoke-1. The Milan Private Subnet route table sends `10.0.1.0/24` to the **DRG**.
2. The Milan DRG forwards the packet through the Site-to-Site IPSec tunnels to the **Palo Alto Untrust** interface. This lab uses `tunnel.1` and `tunnel.2` with ECMP for redundancy.
3. The Palo Alto inspects the packet and forwards it from Trust to the Hub VCN. The Hub **`rt-trust`** route table routes the Spoke-1 CIDR to the **DRG**.
4. The Frankfurt DRG forwards the packet through the **Spoke-1 VCN attachment** to the Frontend Subnet, where **FE-VM-01** receives it. Spoke-2 is not included in this flow and receives no route from the Milan site.
5. Return traffic follows the same path in reverse: **FE-VM-01** sends the Milan CIDR to the DRG, through the Hub and Palo Alto firewall, and back to **VM-0**. This keeps the flow symmetric.

![IPSec VPN traffic flow](images/lab-9-hybrid-connectivity-ipsec-vpn-3.png)

## Task 2: Configure Routing

The diagram below summarises the routing plan for Lab 9.

![IPSec VPN routing plan](images/lab-9-hybrid-connectivity-ipsec-vpn-4.png)

> **Note:** Routing has three parts: OCI VCN route tables control traffic leaving each subnet, OCI DRG route tables control traffic between attachments, and the Palo Alto virtual router controls forwarding through the firewall.

#### Step 1: Open the Hub VCN Routing view

1. Select the correct **region**.
2. Click on the **hamburger menu** in the top left corner.

    ![Select OCI region and open navigation menu](images/select-oci-region-and-open-navigation-menu.png)

<!-- -->

1. Click on **Networking**.
2. Click on **Virtual cloud networks**.

    ![Open Networking and Virtual Cloud Networks](images/open-networking-virtual-cloud-networks.png)

- Click on the **Hub VCN**.

    ![Open Hub VCN](images/open-hub-vcn.png)

- Click on the **Routing** tab.

    ![Open Hub VCN Routing](images/open-hub-vcn-routing.png)

#### Step 2: Configure `rt-drg-ingress` (Frankfurt Hub VCN - DRG attachment ingress route table)

Force traffic destined for Milan (`172.16.1.0/28`) into the Palo Alto Trust interface so the firewall inspects every inter-region flow.

- Click on the route table **rt-drg-ingress**.

    ![Confirm rt-drg-ingress](images/confirm-rt-drg-ingress.png)

<!-- -->

1. Click on the **Route Rules** tab.
2. Add the route rule `172.16.1.0/28 → 172.16.0.40` (target type **Private IP**, pointing at the Palo Alto Trust interface).
3. Click the back arrow to return to the Hub VCN route tables list.

    ![Configure rt-drg-ingress route rules](images/configure-rt-drg-ingress-route-rules.png)

#### Step 3: Configure `rt-untrust` (Frankfurt Hub VCN - Untrust subnet route table)

The Untrust subnet route table needs `0.0.0.0/0 → IGW` for the firewall's Internet egress and for terminating the IPSec tunnel.

- Click on the route table **rt-untrust**.

    ![Confirm rt-untrust](images/confirm-rt-untrust.png)

<!-- -->

1. Click on the **Route Rules** tab.
2. Add the route rule `0.0.0.0/0 → IGW`.
3. Click the back arrow to return to the Hub VCN route tables list.

    ![Configure rt-untrust route rules](images/configure-rt-untrust-route-rules.png)

#### Step 4: Configure `rt-trust` (Frankfurt Hub VCN - Trust subnet route table)

The Trust subnet route table sends both Frankfurt spoke CIDRs back to the DRG so the Palo Alto can deliver return packets to the correct spoke after inspection.

- Click on the route table **rt-trust**.

    ![Confirm rt-trust](images/confirm-rt-trust.png)

<!-- -->

1. Click on the **Route Rules** tab.
2. Add the two route rules `10.0.1.0/24 → DRG` and `10.0.2.0/24 → DRG`.
3. Click the back arrow to return to the Hub VCN route tables list.

    ![Configure rt-trust route rules](images/configure-rt-trust-route-rules.png)

<!-- -->

1. Notice that `rt-drg-ingress`, `rt-untrust`, and `rt-trust` each have one rule.
2. Click the back arrow to return to the **Virtual cloud networks** list.

    ![Confirm Hub VCN route tables](images/confirm-hub-vcn-route-tables.png)

#### Step 5: Configure Spoke subnet route tables (`rt-fe-01`, `rt-be-01`, `rt-fe-02`, `rt-be-02`)

Each spoke subnet sends traffic for the Milan subnet (`172.16.1.0/28`) to the DRG, so Milan-bound traffic is routed through the Hub.

- Click on **Spoke-1 VCN**.

    ![Open Spoke-1 VCN](images/open-spoke-1-vcn.png)

- Click on the **Routing** tab.

    ![Open Spoke-1 VCN Routing](images/open-spoke-1-vcn-routing.png)

- Click on the route table for the **Frontend Subnet** (`rt-fe-01`).

    ![Confirm rt-fe-01](images/confirm-rt-fe-01.png)

<!-- -->

1. Click on the **Route Rules** tab.
2. Add the route rule `172.16.1.0/28 → DRG`.
3. Then click the back arrow.

    ![Configure rt-fe-01 Milan route](images/configure-rt-fe-01-milan-route.png)

- Click on the route table for the **Backend Subnet** (`rt-be-01`).

    ![Confirm rt-be-01](images/confirm-rt-be-01.png)

<!-- -->

1. Click on the **Route Rules** tab.
2. Add the route rule `172.16.1.0/28 → DRG`.
3. Then click the back arrow.

    ![Configure rt-be-01 Milan route](images/configure-rt-be-01-milan-route.png)

<!-- -->

1. Notice that both `rt-fe-01` and `rt-be-01` now have one rule.
2. Click the back arrow to return to the **Virtual cloud networks** list.

    ![Confirm Spoke-1 route tables](images/confirm-spoke-1-route-tables.png)

- Click on **Spoke-2 VCN**.

    ![Open Spoke-2 VCN](images/open-spoke-2-vcn.png)

- Click on the **Routing** tab.

    ![Open Spoke-2 VCN Routing](images/open-spoke-2-vcn-routing.png)

- Click on the route table for the Spoke-2 **Frontend Subnet** (`rt-fe-02`).

    ![Confirm rt-fe-02](images/confirm-rt-fe-02.png)

<!-- -->

1. Click on the **Route Rules** tab.
2. Add the route rule `172.16.1.0/28 → DRG`.
3. Then click the back arrow.

    ![Configure rt-fe-02 Milan route](images/configure-rt-fe-02-milan-route.png)

- Click the back arrow, then click on the route table for the Spoke-2 **Backend Subnet** (`rt-be-02`).

    ![Confirm rt-be-02](images/confirm-rt-be-02.png)

<!-- -->

1. Click on the **Route Rules** tab.
2. Add the route rule `172.16.1.0/28 → DRG`.

    ![Configure rt-be-02 Milan route](images/configure-rt-be-02-milan-route.png)

- All four spoke subnet route tables now carry `172.16.1.0/28 → DRG`, so any spoke workload can reach Milan through the Hub.

#### Step 6: Configure DRG route tables (`ird-hub`, `rt-hub`, `rt-spoke`)

The DRG holds two route tables: **`rt-hub`** (used by the Hub VCN attachment) and **`rt-spoke`** (used by the Spoke VCN attachment). `rt-hub` is populated dynamically from an **Import Route Distribution** (`ird-hub`), so it always reflects the current set of spokes without manual updates. `rt-spoke` carries a static route back to the Hub VCN attachment for the Milan VCN-0 return path.

1. Click on the **hamburger menu**.
2. Click on **Networking**
3. Click on **Dynamic routing gateway**.

    ![Open Dynamic Routing Gateways](images/open-drg-navigation.png)

- Click on the **DRG**.

    ![Open DRG](images/open-drg.png)

- Click on the **Attachments** tab.

    ![Open DRG Attachments](images/open-drg-attachments.png)

<!-- -->

1. Make sure you are in the VCN attachments section.
2. Notice the **VCN attachments** table: the **Hub VCN Attachment** uses DRG route table `rt-hub`; the **Spoke-1 VCN Attachment** and **Spoke-2 VCN Attachment** use `rt-spoke`.

    ![Confirm two-spoke VCN attachments](images/confirm-two-spoke-vcn-attachments.png)

- Click on the **rt-hub** link in the **DRG route table** column for the **Hub VCN Attachment**.

    ![Open rt-hub from the Hub VCN attachment](images/open-rt-hub-two-spoke.png)

- On the **rt-hub** Details page, click on the **ird-hub** link in the **Import route distribution** field.

    ![Open ird-hub](images/open-ird-hub.png)

- Click on the **Statements** tab.

    ![Open ird-hub Statements](images/open-ird-hub-statements.png)

<!-- -->

1. Confirm two statements: priority `10` Spoke-1 VCN Attachment and priority `20` Spoke-2 VCN Attachment. You can instead use match type **Attachment type** and select **Virtual Cloud Network** to import future spokes automatically.
2. Click the back arrow.

    ![Confirm two-spoke ird-hub statements](images/confirm-two-spoke-ird-hub-statements.png)

- On the DRG, click on the **Routing** tab and notice both `rt-hub` and `rt-spoke` are present. Click on the route table **rt-hub**.

    ![Open rt-hub from DRG Routing](images/open-rt-hub-from-drg-routing-two-spoke.png)

- On the **rt-hub** details page, click the **Get all route rules** button to view the dynamic routes.

    ![Open rt-hub route rules](images/open-rt-hub-route-rules.png)

<!-- -->

1. Notice the **four DYNAMIC entries**: 
    - `10.0.1.0/28` and `10.0.1.16/28` (Spoke-1 FE/BE subnets) via **Spoke-1 VCN Attachment**, 
    - `10.0.2.0/28` and `10.0.2.16/28` (Spoke-2 FE/BE subnets) via **Spoke-2 VCN Attachment**. 
2. Click **Close**.

    ![Verify the DRG configuration rt](images/f460419775fc9e8dee0addc6eb9011da.png)

- Click the back arrow to return to the DRG route tables list.

    ![Return to DRG route tables](images/return-to-drg-route-tables.png)

- Click on the route table **rt-spoke**.

    ![Open rt-spoke](images/open-rt-spoke-two-spoke.png)

<!-- -->

1. Notice the **rt-spoke** Details page: **Import route distribution** is `-` (no dynamic routing).
2. Click on the **Static route rules** tab.

    ![Open rt-spoke static route rules](images/open-rt-spoke-static-route-rules-two-spoke.png)

- Notice the single static route `172.16.1.0/28 → Hub VCN Attachment` (next hop attachment type **Virtual Cloud Network**). 
- This is what carries Milan-bound spoke traffic back into the Hub for Palo Alto inspection.

    ![Confirm rt-spoke Milan route](images/confirm-rt-spoke-milan-route.png)

#### Step 7: Configure Palo Alto VR static routes

The OCI DRG and VCN route tables deliver traffic to the correct Palo Alto interface, but the firewall's default Virtual Router still needs static routes to forward each destination CIDR. The next-hop addresses used below are the OCI **default gateways** for the firewall subnets: `172.16.0.33` for the Trust subnet and `172.16.0.17` for the Untrust subnet. For Lab 9 the firewall needs:

- `172.16.1.0/28` — `tunnel.1`
- `172.16.1.0/28` — `tunnel.2`
- `10.0.1.0/24` — `ethernet1/2`, next hop `172.16.0.33`
- `10.0.2.0/24` — `ethernet1/2`, next hop `172.16.0.33`
- `0.0.0.0/0` — `ethernet1/1`, next hop `172.16.0.17`

The two Milan routes use ECMP across the IPSec tunnels for redundancy.

Open the Palo Alto Web GUI, then:

1. Sign in to the Palo Alto Web GUI, then click on the **Network** tab.
2. Click on **Virtual Routers**.
3. Click on the **default** virtual router.

    ![Open Palo Alto virtual router for IPSec](images/open-palo-alto-virtual-router-ipsec.png)

- In the **Virtual Router - default** dialog (Router Settings → General), verify that `ethernet1/1`, `ethernet1/2`, `tunnel.1`, and `tunnel.2` are listed.
- Click on the **ECMP** tab to enable load-sharing across the two IPSec tunnels.

    ![Verify Palo Alto IPSec interfaces](images/verify-palo-alto-ipsec-interfaces.png)

<!-- -->

1. Check **Enable** to turn ECMP on.
2. Set **Method** to `Weighted Round Robin` (and leave **Max Path** at `2` for the two tunnels).
3. Click on **Static Routes** in the left-hand menu to start adding routes.

    ![Enable Palo Alto ECMP](images/enable-palo-alto-ecmp.png)

<!-- -->

1. On the **IPv4** sub-tab, click **Add** and create the required routes for this scenario:

    - `route1-to-milan` (Destination `172.16.1.0/28`, Interface `tunnel.1`)
    - `route2-to-milan` (Destination `172.16.1.0/28`, Interface `tunnel.2`)
    - `route-to-spoke-1` (Destination `10.0.1.0/24`, Interface `ethernet1/2`, Next Hop `172.16.0.33`)
    - `route-to-spoke-2` (Destination `10.0.2.0/24`, Interface `ethernet1/2`, Next Hop `172.16.0.33`)
    - `route-to-internet` (Destination `0.0.0.0/0`, Interface `ethernet1/1`, Next Hop `172.16.0.17`)

2. Click on the **OK** button to save the Virtual Router configuration. In the **ECMP Configuration Change** dialog, click **Yes**. The virtual router restarts and re-converges in a few seconds.

    ![Configure IPSec static routes](images/configure-ipsec-static-routes.png)

<!-- -->

1. Confirm the five static routes in the IPv4 table.
2. Click on **OK**.

    ![Confirm IPSec static routes](images/confirm-ipsec-static-routes.png)

- Notice that the **default** Virtual Router now shows **Static Routes: 5** and **ECMP status: Enabled**. Click on the **Commit** button at the top right.

    ![Commit Palo Alto IPSec and ECMP configuration](images/commit-palo-alto-ipsec-ecmp.png)

<!-- -->

1. Select **Commit All Changes**.
2. In the **Commit** dialog, click the **Commit** button to confirm.

    ![Confirm IPSec commit](images/f94591e8144cd5f751059e9df9693332.png)

- The **Commit Status** dialog shows the operation as **Pending** while the configuration is applied.

    ![IPSec commit pending](images/2ee7bef5fed8b1002141138b301dab6a.png)

- Notice the **Commit Status** shows **Completed** and **Successful**.

    ![IPSec commit successful](images/7a36dbcce2f14179c4ffce2e72ad7b4d.png)

#### Step 8: Configure `rt-0` (Milan VCN-0 - Private subnet route table)

The Milan Private Subnet needs `10.0.1.0/24` and `10.0.2.0/24` routed to the **DRG**, so VM-0 can reach the Frankfurt spokes through the tunnel.

- Switch the region to **Italy Northwest (Milan)** and click on the **hamburger menu**.

    ![Select Milan region and open navigation menu](images/select-milan-region-and-open-navigation-menu.png)

<!-- -->

1. Click on **Networking**.
2. Click on **Virtual cloud networks**.

    ![Open Networking and Virtual Cloud Networks](images/open-networking-virtual-cloud-networks.png)

- Click on **VCN-0** (CIDR `172.16.1.0/24`).

    ![Open Milan VCN-0](images/open-milan-vcn-0.png)

- Click on the **Routing** tab.

    ![Open Milan VCN-0 Routing](images/open-milan-vcn-0-routing.png)

- Click on the route table attached to the Private Subnet (`rt-0`).

    ![Confirm Milan rt-0](images/confirm-milan-rt-0.png)

<!-- -->

1. Click on the **Route Rules** tab.
2. Add the two route rules `10.0.1.0/24 → DRG` and `10.0.2.0/24 → DRG`.

    ![Configure Milan rt-0 route rules](images/configure-milan-rt-0-route-rules.png)

#### Step 9: Configure Milan DRG route tables

This lab keeps OCI's two default DRG route tables and import distributions:

- The VCN attachment uses **Autogenerated Drg Route Table for VCN attachments**. It routes traffic entering the DRG from Milan VCN-0. Its **Autogenerated Import Route Distribution for ALL routes** imports routes learned from all attachment types, including the IPSec tunnels, so Milan traffic can reach the remote site.
- Both IPSec tunnels use **Autogenerated Drg Route Table for RPC, VC, and IPSec attachments**. It routes traffic entering the DRG from the remote site. Its **Autogenerated Import Route Distribution for VCN Routes** imports the Milan VCN route, so return traffic can reach Milan VCN-0.
- No custom DRG route tables or distributions are created. Use them in real designs to control route propagation explicitly.

1. Click on the **hamburger menu**.
2. Click on **Networking**
3. Click on **Dynamic routing gateway**.

    ![Open Milan DRG navigation](images/open-milan-drg-navigation.png)

- Click on the Milan **DRG**. Notice that **Oracle redundancy status** is **Redundant**, reflecting the two IPSec tunnels configured in Part 4 of this workshop series.

    ![Open Milan DRG](images/open-milan-drg.png)

- Click on the **Attachments** tab.

    ![Open Milan DRG Attachments](images/open-milan-drg-attachments.png)

<!-- -->

1. In the **VCN attachments** section.
2. Notice the single attachment **VCN-0 Attachment** uses the **Autogenerated Drg Route Table for VCN attachments**.

    ![Confirm Milan VCN attachment route table](images/confirm-milan-vcn-attachment-route-table.png)

- Click on the **Autogenerated Drg Route Table for VCN attachments** link.

    ![Open Milan autogenerated DRG route table](images/open-milan-autogenerated-drg-route-table.png)

<!-- -->

1. Confirm the route table has **ECMP Enabled** and **Import route distribution = Autogenerated Import Route Distribution for ALL routes**.
2. Click on the **Get all route rules** button.

    ![Milan VCN route table](images/3a0689fb5bf1ac3727e93dd5c5f8fea6.png)

<!-- -->

1. Confirm the dynamic routes in the popup: each Frankfurt spoke CIDR (`10.0.1.0/24` and `10.0.2.0/24`) has two equal-cost paths—one through **Tunnel 1** and one through **Tunnel 2**, so ECMP can use both IPSec tunnels. The Milan VCN-0 CIDR (`172.16.1.0/28`) has one path through the **VCN-0 Attachment**.
2. Click **Close**.

    ![Milan ECMP routes](images/ac6f59539af52dac78527205d5c0d041.png)

- Click the back arrow to return to the DRG.

    ![Return to Milan DRG](images/c0a1b0c97a95926d7fc1b7dcade429b9.png)

- On the DRG **Routing** tab, notice the two autogenerated tables (**Autogenerated Drg Route Table for RPC, VC, and IPSec attachments** and **Autogenerated Drg Route Table for VCN attachments**). Click on the **Attachments** tab to inspect the IPSec attachments next.

    ![Milan DRG route tables](images/5ec544abb632d6df70fc2d843cd03a6b.png)

<!-- -->

1. Scroll down on the Attachments page to the **IPSec tunnel attachments** section. 
2. Notice the two IPSec attachments (one per tunnel - **DRG Attachment for IPSec Tunnel: Tunnel 1** and **DRG Attachment for IPSec Tunnel: Tunnel 2**), both pointing to **CPE-PANW-FRA** (the Palo Alto in Frankfurt) and both using the **Autogenerated Drg Route Table for RPC, VC, and IPSec attachments**.

    ![Confirm Milan IPSec tunnel attachments](images/confirm-milan-ipsec-tunnel-attachments.png)

- Click on the **Autogenerated Drg Route Table for RPC, VC, and IPSec attachments** link.

    ![Open Milan IPSec autogenerated DRG route table](images/open-milan-ipsec-autogenerated-drg-route-table.png)

- On the route table details page, notice **Import route distribution = Autogenerated Import Route Distribution for VCN Routes** (so the tunnel side learns the Milan VCN-0 CIDR). Click on **Get all route rules**.

    ![Open Milan IPSec route table rules](images/open-milan-ipsec-route-table-rules.png)

- Confirm the single dynamic entry: `172.16.1.0/28 → VCN-0 Attachment` (next hop attachment type **Virtual Cloud Network**). This is what lets Frankfurt-originated packets arriving over either tunnel reach Milan VM-0.

    ![Milan VCN dynamic route](images/c11ead8043e5d9e48e3e7ff7829d2a59.png)

The Milan side is fully configured and all tunnel-learned routes are in place. Inter-region traffic between Frankfurt spokes and Milan VM-0 now flows over the IPSec tunnels with Palo Alto inspection on the Frankfurt side.

## Task 3: Test and Validate

- From **VM-0** in Milan (`172.16.1.5`), `ping` **FE-VM-01** in Frankfurt Spoke-1 (`10.0.1.10`). The session traverses the Site-to-Site IPSec tunnel(s) and is inspected by the Palo Alto firewall.

    ![Validate Milan-to-Frankfurt ping](images/validate-milan-to-frankfurt-ping.png)

<!-- -->

1. Open the Palo Alto **Monitor**.
2. Click on **Traffic** log.
3. Notice the matching session: source = `172.16.1.5`, destination = `10.0.1.10`, source zone = **s2s-vpn-zone**, destination zone = **trust-zone**, application = `ping`, action = **allow**. Confirms traffic from the remote site traversed the IPSec tunnel and was inspected by the firewall before reaching Frankfurt Spoke-1.

    ![Verify IPSec traffic in Palo Alto logs](images/verify-ipsec-palo-alto-traffic-log.png)

## Learn More

- [OCI VCN Route Tables](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/managingroutetables.htm)
- [OCI Dynamic Routing Gateway (DRG) and ECMP](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/managingDRGs.htm)
- [OCI Site-to-Site VPN Overview](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/overviewIPsec.htm)
- [Palo Alto Site-to-Site VPN with Static Routing](https://docs.paloaltonetworks.com/network-security/ipsec-vpn/administration/site-to-site-vpn-quick-configs/site-to-site-vpn-with-static-routing)
- [Palo Alto ECMP Settings](https://docs.paloaltonetworks.com/ngfw/help/12-1/network/network-virtual-routers/ecmp/ecmp-settings)
- [Palo Alto View and Manage Logs](https://docs.paloaltonetworks.com/ngfw/administration/monitoring/view-and-manage-logs)

## Acknowledgements

- **Authors** - Anas Abdallah, Iwan Hoogendoorn (Cloud Networking Black Belts)
- **Contributor** - Antonio Gámir (Cloud Networking Black Belt)
- **Last Updated By/Date** - Anas Abdallah, October 2026

You may now **proceed to the next lab**.
