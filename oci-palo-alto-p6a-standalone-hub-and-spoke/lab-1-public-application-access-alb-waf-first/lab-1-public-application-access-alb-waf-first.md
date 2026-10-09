# Configure Public Application Access - ALB (WAF) First

## Introduction

In this lab, you configure a public Application Load Balancer with Web Application Firewall protection in front of the Palo Alto firewall. The firewall then inspects traffic before it reaches an application workload in a spoke VCN.

Estimated Time: 25 minutes

### Objectives

In this lab, you will:

- Review the ALB/WAF-first ingress design and its traffic flow through the Palo Alto firewall.
- Configure the OCI VCN, DRG, and ingress route tables that steer the request and return paths symmetrically through the firewall.
- Configure Palo Alto virtual-router static routes.
- Validate application access and confirm the inspected session in Palo Alto Traffic logs.

### Prerequisites

Before following the routing steps below, complete the items that are out of scope for this workshop. They are not part of the routing configuration itself, but they have to exist before any of the routes you are about to create are useful.

![ALB WAF first topology](images/lab-1-public-application-access-alb-waf-first.png)

<!-- -->

1. Complete [Deploy Palo Alto NGFW in OCI (Standalone)](https://livelabs.oracle.com/ords/dbpm/r/livelabs/view-workshop?wid=4487). This workshop deploys the baseline Palo Alto VM-Series firewall in OCI Frankfurt, including the Hub VCN, subnets, Internet Gateway, and base firewall configuration.

2. Provision the APP-VM in the Spoke VCN (or use an existing workload or application in your environment):
    - Create a **Spoke VCN** `10.0.0.0/24` with an **App Subnet** `10.0.0.0/28`.
    - Deploy an **APP-VM** in the App Subnet with private IP `10.0.0.10`, running **Oracle Linux 9**.
    - Install and configure NGINX on the APP-VM using the script below.

![APP-VM networking details](images/lab-1-public-application-access-alb-waf-first-3.png)

```bash
<copy>
# Install Nginx
sudo dnf install -y nginx

# Enable and start Nginx
sudo systemctl enable --now nginx

# Open firewall ports (firewalld is enabled by default on OL9)
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --reload

# Create the APP-VM page
sudo tee /usr/share/nginx/html/index.html &gt; /dev/null &lt;&lt;'EOF'
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
    &lt;title&gt;APP-VM&lt;/title&gt;
    &lt;style&gt;
        body { font-family: Arial, sans-serif; text-align: center; padding: 50px; background: #1e3a5f; color: white; }
        h1 { font-size: 48px; }
        .info { background: rgba(255,255,255,0.1); padding: 20px; border-radius: 10px; display: inline-block; margin-top: 20px; }
        .label { color: #88c0d0; font-weight: bold; }
    &lt;/style&gt;
&lt;/head&gt;
&lt;body&gt;
    &lt;h1&gt;This is the APP VM&lt;/h1&gt;
    &lt;div class="info"&gt;
        &lt;p&gt;&lt;span class="label"&gt;Source IP of request:&lt;/span&gt; &lt;!--# echo var="remote_addr" --&gt;&lt;/p&gt;
    &lt;/div&gt;
&lt;/body&gt;
&lt;/html&gt;
EOF

# Configure Nginx with SSI enabled
sudo tee /etc/nginx/conf.d/default.conf &gt; /dev/null &lt;&lt;'EOF'
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name _;
    root /usr/share/nginx/html;

    location / {
        ssi on;
        index index.html;
    }
}
EOF

# Restart Nginx
sudo systemctl restart nginx
</copy>
```

The script installs and enables NGINX, opens TCP/80 on the OL9 firewalld, drops in a simple HTML page that displays the source IP of the incoming request using NGINX's Server-Side Includes (SSI), and reloads NGINX so the new config takes effect. The page is used in **Task 3: Test & Validate** to confirm which IP the application actually sees as the source.

![Configure NGINX SSI](images/configure-nginx-ssi.png)

3. Provision a **Public Application Load Balancer** in the Hub VCN with the following settings:

    - Subnet: LB Subnet (Public).
    - Public IP is generated: x.x.x.x
    - Load balancing policy: Weighted round robin.
    - Listener: listener-http (HTTP/80)
    - Backend set: be-set-app (APP-VM as backend listening on port 80).
    - Health check policy: HTTP/80
    - WAF: Assign a policy if ready.

    ![Verify public ALB health](images/lab-1-public-application-access-alb-waf-first-4.png)

4. Attach the Hub VCN and Spoke VCN to the DRG. Then, assign the DRG and VCN route tables according to the table below:

| Attachment           | DRG Route Table | VCN Route Table |
| -------------------- | --------------- | --------------- |
| Hub VCN Attachment   | rt-hub          | rt-drg-ingress  |
| Spoke VCN Attachment | rt-spoke        | -               |

![Review DRG VCN attachments](images/lab-1-public-application-access-alb-waf-first-6.png)


A **VCN Route Table** is assigned to a DRG attachment (also called an **Ingress** or **Transit Route Table**) when traffic entering the Hub VCN through the DRG needs to be steered to a destination other than what the VCN's local routing would pick. In this scenario, it steers traffic from the DRG to the Palo Alto Trust interface for inspection instead of allowing local VCN routing to bypass the firewall. The same principle applies to other gateways (IGW, SGW, NAT GW): you assign an Ingress Route Table to them when the default VCN routing is not what you want.

![Review Hub VCN attachment](images/lab-1-public-application-access-alb-waf-first-7.png)

## Task 1: Review the Use Case

In this design, OCI's **Public Application Load Balancer (ALB)** terminates the inbound HTTP/HTTPS connection at the edge, applies any **Web Application Firewall (WAF)** policy attached to it, and then forwards the request to the Palo Alto for L4-L7 inspection before it reaches the application VM in the spoke.

### This is the right choice when:

- You want WAF protection for the application (SQLi, XSS, OWASP Top-10) - the ALB/WAF performs these checks closer to the edge and at lower cost than the NGFW.
- You want TLS termination at the OCI edge for HTTP-based services.
- The application's logs can show the ALB's private IP as the source instead of the original client IP (which is normal for path-based-routed or session-affinity apps).

### Traffic Flow:

1. The end user opens the application's public URL, which resolves to the ALB Public IP. Traffic enters the Hub VCN through the Internet Gateway (IGW).
2. The IGW forwards the traffic to the Public ALB in the Hub LB Subnet, which applies the WAF policy and selects a backend.
3. The ALB forwards the request to the backend (the APP-VM at `10.0.0.10` in the Spoke VCN). The LB Subnet route table (`rt-lb`) sends the `10.0.0.0/24` destination to the Palo Alto Untrust interface (`172.16.0.20`) as a Private IP target, instead of the DRG. This forces the request through the firewall before it leaves the Hub VCN.
4. The Palo Alto inspects the request and forwards it out of its Trust interface (`172.16.0.40`) towards the DRG (hub attachment).
5. The DRG sends the request to APP-VM in the Spoke VCN.
6. The APP-VM replies. The reply is destined to the ALB's private IP in the LB Subnet (because the ALB SNATs to its own IP when forwarding to the backend), so the destination is in `172.16.0.48/28`. The return traffic must come back through the firewall to keep the flow symmetric, which is why the Hub DRG attachment is assigned an Ingress Route Table (`rt-drg-ingress`) with `172.16.0.48/28 → 172.16.0.40` (the Palo Alto Trust interface). Without this, OCI's local routing in the Hub VCN would short-circuit the return packet straight back to the ALB and the connection would break (asymmetric flow).

![Lab 1 topology](images/lab-1-public-application-access-alb-waf-first-1.png)

## Task 2: Configure Routing

The diagram below summarises the routing plan for Lab 1.

![Lab 1 traffic flow](images/lab-1-public-application-access-alb-waf-first-2.png)

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

#### Step 2: Configure `rt-lb` (Hub VCN - LB Subnet route table)

This route table is attached to the **LB Subnet** in the Hub VCN. It forwards Internet-bound traffic to the IGW and sends application traffic (`10.0.0.0/24`) towards the **Palo Alto Untrust interface** instead of the DRG, so the firewall inspects every packet from the ALB on its way to the spoke.

- Click on the route table **rt-lb**.

    ![Confirm rt-lb](images/confirm-rt-lb.png)

<!-- -->

1. Click on the **Route Rules** tab.
2. Add the two route rules: `0.0.0.0/0 → IGW` (for Internet egress) and `10.0.0.0/24 → 172.16.0.20` (the Palo Alto Untrust private IP as a **Private IP** target).
3. Click the back arrow to return to the Hub VCN route tables list.

    ![Configure rt-lb route rules](images/configure-rt-lb-route-rules.png)

> **Note:** The **target type** for the `10.0.0.0/24` route is **Private IP** pointing at the Palo Alto Untrust private IP (`172.16.0.20`), not the DRG. This is what forces the ALB-to-APP flow into the firewall instead of letting OCI deliver it directly through the DRG.

#### Step 3: Configure `rt-drg-ingress` (Hub VCN - DRG attachment ingress route table)

This is the **Ingress Route Table** assigned to the Hub VCN's DRG attachment. It routes return traffic destined for the LB Subnet (`172.16.0.48/28`) to the **Palo Alto Trust interface** (`172.16.0.40`) instead of delivering it locally to the LB Subnet. Without this entry, the return path is asymmetric and TCP sessions drop.

- Click on the route table **rt-drg-ingress**.

    ![Confirm rt-drg-ingress](images/confirm-rt-drg-ingress.png)

<!-- -->

1. Click on the **Route Rules** tab.
2. Add the route rule `172.16.0.48/28 → 172.16.0.40` (target type **Private IP**, pointing at the Palo Alto Trust interface).
3. Click the back arrow to return to the Hub VCN route tables list.

    ![Configure rt-drg-ingress route rules](images/configure-rt-drg-ingress-route-rules.png)

#### Step 4: Configure `rt-trust` (Hub VCN - Trust subnet route table)

The Trust subnet route table sends spoke-destined traffic (`10.0.0.0/24`) to the DRG so that packets leaving the Palo Alto Trust interface can reach the spoke through the DRG.

- Click on the route table **rt-trust**.

    ![Confirm rt-trust](images/confirm-rt-trust.png)

<!-- -->

1. Click on the **Route Rules** tab.
2. Add the route rule `10.0.0.0/24 → DRG`.
3. Click the back arrow to return to the Hub VCN route tables list.

    ![Configure rt-trust route rules](images/configure-rt-trust-route-rules.png)

<!-- -->

1. Notice the four Hub VCN route tables (`rt-lb`, `rt-drg-ingress`, `rt-untrust`, `rt-trust`) are listed with the rule counts you just verified.
2. Click the back arrow to return to the **Virtual cloud networks** list.

    ![Confirm Hub VCN route tables](images/confirm-hub-vcn-route-tables.png)

#### Step 5: Configure `rt-app` (Spoke VCN - App Subnet route table)

This route table is attached to the **App Subnet** in the Spoke VCN. It sends return traffic destined for the LB Subnet (`172.16.0.48/28`) to the DRG, where `rt-spoke` then takes over.

- Click on the **Spoke VCN**.

    ![Open Spoke VCN](images/open-spoke-vcn.png)

- Click on the **Routing** tab.

    ![Open Spoke VCN Routing](images/open-spoke-vcn-routing.png)

- Click on the route table **rt-app**.

    ![Confirm rt-app](images/confirm-rt-app.png)

<!-- -->

1. Click on the **Route Rules** tab.
2. Add the route rule `172.16.0.48/28 → DRG`.

    ![Configure rt-app route rules](images/configure-rt-app-route-rules.png)

#### Step 6: Configure DRG route tables (`ird-hub`, `rt-hub`, `rt-spoke`)

The DRG holds two custom route tables: **`rt-hub`** (used by the Hub VCN attachment) and **`rt-spoke`** (used by the Spoke VCN attachment). `rt-hub` is populated dynamically from an **Import Route Distribution** (`ird-hub`), so it always reflects the current set of spokes without manual updates. `rt-spoke` carries a static route back to the Hub VCN attachment for the LB Subnet return path.

1. Click on the **hamburger menu**.
2. Click on **Networking**.
3. Click on **Dynamic routing gateway**.

    ![Open Dynamic Routing Gateways](images/open-drg-navigation.png)

- Click on the **DRG** that is already deployed.

    ![Open DRG](images/open-drg.png)

- Click on the **Attachments** tab.

    ![Open DRG Attachments](images/open-drg-attachments.png)

<!-- -->

1. Make sure you are in the VCN attachments section.
2. Notice the **VCN attachments** table: the **Hub VCN Attachment** uses DRG route table `rt-hub` and the **Spoke VCN Attachment** uses `rt-spoke`.

    ![Confirm one-spoke VCN attachments](images/confirm-vcn-attachments-one-spoke.png)

- Click on the **rt-hub** link in the **DRG route table** column for the **Hub VCN Attachment**.

    ![Open rt-hub from the Hub VCN attachment](images/open-rt-hub-one-spoke.png)

- On the **rt-hub** Details page, click on the **ird-hub** link in the **Import route distribution** field.

    ![Open ird-hub](images/open-ird-hub.png)

- Click on the **Statements** tab.

    ![Open ird-hub Statements](images/open-ird-hub-statements.png)

<!-- -->

1. Notice the single statement in `ird-hub`: priority `10`, match type **Attachment**, match criteria **Spoke VCN Attachment**. This is what makes the DRG dynamically import the Spoke VCN's CIDRs into `rt-hub`. You can instead use match type **Attachment type** and select **Virtual Cloud Network** to import future spokes automatically.
2. Click the back arrow to return to the DRG.

    ![Confirm one-spoke ird-hub statement](images/confirm-ird-hub-one-spoke.png)

- Click on the route table **rt-hub**.

    ![Open rt-hub from DRG Routing](images/open-rt-hub-one-spoke-routing.png)

- On the **rt-hub** Details page, click on the **Get all route rules** button to view the dynamic routes learned via `ird-hub`. 

    ![Open rt-hub route rules](images/open-rt-hub-route-rules.png)

<!-- -->

1. Notice the **DYNAMIC** entry: destination `10.0.0.0/28` (the Spoke's App Subnet CIDR), next hop **Virtual Cloud Network → Spoke VCN Attachment**, learned via the `ird-hub` import distribution. 
2. Click on the **Close** button.

    ![Confirm one-spoke rt-hub dynamic route](images/confirm-rt-hub-dynamic-routes-one-spoke.png)

- Click the back arrow to return to the DRG route tables list.

    ![Return to DRG route tables](images/return-to-drg-route-tables.png)

- Click on the route table **rt-spoke**.

    ![Open rt-spoke](images/open-rt-spoke-one-spoke.png)

<!-- -->

1. Notice the **rt-spoke** Details page: **Import route distribution** is `-` (no dynamic routing).
2. Click on the **Static route rules** tab.

    ![Open rt-spoke static route rules](images/open-rt-spoke-static-route-rules-one-spoke.png)

- Notice the single static route in `rt-spoke`: `172.16.0.48/28 → Hub VCN Attachment`. This is what carries the spoke's LB-Subnet-bound return traffic back to the Hub for firewall inspection.

    ![Confirm rt-spoke static route](images/confirm-rt-spoke-static-route.png)

#### Step 7: Configure Palo Alto VR static routes

The OCI DRG and VCN route tables deliver traffic to the correct Palo Alto interface, but the firewall's default Virtual Router still needs static routes to forward each destination CIDR. The next-hop addresses used below are the OCI **default gateways** for the firewall subnets: `172.16.0.33` for the Trust subnet and `172.16.0.17` for the Untrust subnet. For Lab 1 the firewall needs:

- `172.16.0.48/28` — `ethernet1/1`, next hop `172.16.0.17`
- `10.0.0.0/24` — `ethernet1/2`, next hop `172.16.0.33`

Open the Palo Alto management Web GUI, then:

1. Sign in to the Palo Alto Web GUI, then click on the **Network** tab.
2. Click on **Virtual Routers**.
3. Click on the **default** virtual router.

    ![Open Palo Alto Virtual Router](images/open-palo-alto-virtual-router.png)

- In the **Virtual Router - default** dialog, click on **Static Routes** in the left-hand menu.

    ![Open Palo Alto Static Routes](images/open-palo-alto-static-routes.png)

Make sure this is done:
- On the **IPv4** sub-tab, click **Add** and create the first route `route-to-lb` (Destination `172.16.0.48/28`, Interface `ethernet1/1`, Next Hop **IP Address** `172.16.0.17`).
- Click **Add** again and create the second route `route-to-spoke` (Destination `10.0.0.0/24`, Interface `ethernet1/2`, Next Hop **IP Address** `172.16.0.33`).

1. Notice both routes are listed in the IPv4 table.
2. Click on the **OK** button to save the Virtual Router configuration.

    ![Confirm Lab 1 Palo Alto static routes](images/confirm-lab1-palo-alto-static-routes.png)

#### Step 8: Commit the Palo Alto configuration

- Notice that the **default** Virtual Router now shows **Static Routes: 2**. Click on the **Commit** button at the top right.

    ![Configure Palo Alto VR static](images/configure-palo-alto-vr-static.png)

<!-- -->

1. Select **Commit All Changes**.
2. In the **Commit** dialog, click the **Commit** button to confirm.

    ![Commit the Palo Alto configuration](images/commit-the-palo-alto-configuration.png)

- The **Commit Status** dialog shows the operation as **Pending** while the configuration is applied.

    ![Commit the Palo Alto configuration](images/commit-the-palo-alto-configuration-2.png)

- Notice the **Commit Status** shows **Completed** and **Successful**.

    ![Commit the Palo Alto configuration](images/commit-the-palo-alto-configuration-3.png)

## Task 3: Test and Validate

- In the OCI Console, open the **Public-ALB** load balancer details. 

1. Notice the **Overall health** is **OK**.
2. And the **IP address** shows the assigned public IP. 

This confirms the ALB is up and the backend (APP-VM) is healthy.

![Public ALB health](images/public-alb-health.png)

<!-- -->

1. From a browser on your local machine, enter the **public IP address assigned to Public-ALB** in the address bar.
2. Verify that the APP-VM web page loads and that **Source IP of request** shows the ALB private IP (`172.16.0.50` in this lab). This is expected: the APP-VM sees the ALB as the source, not the original Internet client. The `172.16.0.50` address is from the LB Subnet CIDR (`172.16.0.48/28`) and is the source IP the public ALB uses when connecting to the APP-VM.

    ![Validate Public-ALB browser access](images/validate-public-alb-browser-access.png)

<!-- -->

1. On the Palo Alto, open **Monitor**.
2. Click on **Traffic**.
3. Verify the matching sessions:
   - **Source:** `172.16.0.50` (ALB private IP)
   - **Destination:** `10.0.0.10` (APP-VM)
   - **Port:** `80`
   - **Application:** `web-browsing`
   - **Rule:** `allow-all-temp`
   - **Action:** `allow`
   - **Zones:** `untrust-zone` to `trust-zone`

![Verify Palo Alto traffic log](images/verify-palo-alto-traffic-log.png)

## Learn More

- [OCI Load Balancer Overview](https://docs.oracle.com/en-us/iaas/Content/Balance/)
- [OCI Web Application Firewall](https://docs.oracle.com/en-us/iaas/Content/WAF/)
- [OCI VCN Route Tables](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/managingroutetables.htm)
- [OCI Dynamic Routing Gateway (DRG)](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/managingDRGs.htm)
- [Palo Alto Static Routes](https://docs.paloaltonetworks.com/ngfw/networking/static-routes)
- [Palo Alto View and Manage Logs](https://docs.paloaltonetworks.com/ngfw/administration/monitoring/view-and-manage-logs)

## Acknowledgements

- **Authors** - Anas Abdallah, Iwan Hoogendoorn (Cloud Networking Black Belts)
- **Contributor** - Antonio Gámir (Cloud Networking Black Belt)
- **Last Updated By/Date** - Anas Abdallah, October 2026

You may now **proceed to the next lab**.
