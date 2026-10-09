# Configure Public Application Access - Palo Alto Firewall First

## Introduction

In this lab, you publish an application through the Palo Alto firewall before it reaches a private Application Load Balancer. You configure the routing and destination NAT needed to keep inbound application traffic inspected and symmetric.

Estimated Time: 30 minutes

### Objectives

In this lab, you will:

- Review the firewall-first application publishing design, in which a Palo Alto Untrust public IP fronts a Private ALB.
- Verify the OCI VCN and DRG routes, and configure the required Palo Alto virtual-router static routes.
- Configure a combined SNAT and DNAT rule to publish the Private ALB through the Palo Alto firewall.
- Validate application access, NAT translation, and symmetric sessions in Palo Alto Traffic logs.

### Prerequisites

Before following the routing steps below, complete the items that are out of scope for this workshop. They are not part of the routing configuration itself, but they have to exist before any of the routes you are about to create are useful.

![Lab 2 topology](images/lab-2-public-application-access-ngfw-first-4.png)

<!-- -->

1. Complete [Deploy Palo Alto NGFW in OCI (Standalone)](https://livelabs.oracle.com/ords/dbpm/r/livelabs/view-workshop?wid=4487). This workshop deploys the baseline Palo Alto VM-Series firewall in OCI Frankfurt, including the Hub VCN, subnets, Internet Gateway, and base firewall configuration.

2. Provision the APP-VM in the Spoke VCN (or use an existing workload or application in your environment):
    - Create a **Spoke VCN** `10.0.0.0/24` with an **App Subnet** `10.0.0.0/28`.
    - Deploy an **APP-VM** in the App Subnet with private IP `10.0.0.10`, running **Oracle Linux 9**.
    - Install and configure NGINX on the APP-VM using the script below.

![APP-VM networking details](images/app-vm-networking-details.png)

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

3. Provision a **Private Application Load Balancer** in the Spoke VCN with the following settings:

    - Subnet: LB Subnet (Private).
    - Private IP is 10.0.0.22
    - Load balancing policy: Weighted round robin.
    - Listener: listener-http (HTTP/80)
    - Backend set: be-set-app (APP-VM as backend listening on port 80).
    - Health check policy: HTTP/80
    - WAF: Assign a policy if ready.

    ![Restart Nginx configuration screenshot](images/restart-nginx-configuration-screenshot.png)

4. Attach the Hub VCN and Spoke VCN to the DRG. Then, assign the DRG and VCN route tables according to the table below:

| Attachment           | DRG Route Table | VCN Route Table |
| -------------------- | --------------- | --------------- |
| Hub VCN Attachment   | rt-hub          | -               |
| Spoke VCN Attachment | rt-spoke        | -               |

![Review DRG VCN attachments](images/lab-2-public-application-access-ngfw-first-8.png)

In this lab, **no Ingress Route Table is needed on the Hub VCN attachment**, because the firewall SNATs the source to its Trust interface IP. The return traffic from the Private ALB naturally comes back to the Palo Alto without any DRG-level rewriting (transit RT).

## Task 1: Review the Use Case

In this design, the **Palo Alto sits at the edge** with one of its **Untrust public IPs** as the front-door, and forwards the inbound connection (after L4-L7 inspection) to a **Private Application Load Balancer (ALB)** in the spoke VCN. The Palo Alto performs both **Destination NAT** (rewriting the destination from the Untrust public IP to the Private ALB IP) and **Source NAT** (rewriting the source from the original client to its own Trust interface IP), so the reply comes back to the firewall instead of being asymmetric.

### This is the right choice when:

- You want the NGFW to inspect traffic before any load balancing decision is made.
- You want multiple applications behind a single firewall public IP, distinguished by destination port and DNAT-rewritten to different private ALBs in different spokes.
- You want a single public attack surface (the firewall) instead of one public IP per ALB.
- You do not need the OCI-native WAF at the edge (the NGFW provides threat prevention, URL filtering, etc.) and the WAF needs to be applied behind the firewall on the Private ALB.

### Traffic Flow:

1. The end user sends a request to one of the Palo Alto Untrust public IPs (`public ip 1`, `public ip 2`, `public ip 3`, ...).
2. Traffic enters the Hub VCN through the IGW and arrives at the Palo Alto Untrust interface.
3. The Palo Alto inspects the request and applies a NAT rule: DNAT rewrites the destination from the Untrust public IP to the Private ALB IP (`10.0.0.22`), and SNAT rewrites the source from the end user's public IP to the Palo Alto Trust interface IP (`172.16.0.40`). The Palo Alto then sends the request out of the Trust interface towards the DRG (hub attachment).
4. The DRG sends the request to Private-ALB in the Spoke VCN.
5. The Private ALB applies its policy (and any WAF if configured), selects a backend, and forwards the request to the APP-VM (`10.0.0.10`).
6. The APP-VM replies. Because the source was SNAT'd to the Palo Alto's Trust IP, the reply naturally returns to the firewall (no `rt-drg-ingress` needed). The firewall reverses the NAT and sends the reply back to the original end user through the IGW.

![Lab 2 traffic flow](images/lab-2-public-application-access-ngfw-first-5.png)

## Task 2: Configure Routing

The diagram below summarises the routing plan for Lab 2.

![Lab 2 routing plan](images/lab-2-public-application-access-ngfw-first-6.png)

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

#### Step 2: Configure `rt-untrust` (Hub VCN - Untrust subnet route table)

Configure `0.0.0.0/0 → IGW` in the Untrust subnet route table so the Palo Alto's Untrust interface can reach the Internet for inbound and outbound flows.

- Click on the route table **rt-untrust**.

    ![Confirm rt-untrust](images/confirm-rt-untrust.png)

<!-- -->

1. Click on the **Route Rules** tab.
2. Add the route rule `0.0.0.0/0 → IGW`.
3. Click the back arrow to return to the Hub VCN route tables list.

    ![Configure rt-untrust route rules](images/configure-rt-untrust-route-rules.png)

#### Step 3: Configure `rt-trust` (Hub VCN - Trust subnet route table)

The Trust subnet route table sends Spoke VCN traffic (`10.0.0.0/24`) to the DRG so packets leaving the Palo Alto Trust interface can reach the Private ALB.

- Click on the route table **rt-trust**.

    ![Confirm rt-trust](images/confirm-rt-trust.png)

<!-- -->

1. Click on the **Route Rules** tab.
2. Add the route rule `10.0.0.0/24 → DRG`.
3. Click the back arrow to return to the Hub VCN route tables list.

    ![Configure rt-trust route rules](images/configure-rt-trust-route-rules.png)

<!-- -->

1. Notice that `rt-untrust` and `rt-trust` each have one rule, while `rt-management` has none.
2. Click the back arrow to return to the **Virtual cloud networks** list.

    ![Confirm Hub VCN route tables](images/confirm-hub-vcn-route-tables.png)

#### Step 4: Configure `rt-lb` (Spoke VCN - LB Subnet route table)

The Private ALB sits in the Spoke LB Subnet. Its route table sends return traffic destined for the **Palo Alto Trust interface** (`172.16.0.40/32`) to the DRG, so the firewall receives the reply on its Trust zone.

- Click on the **Spoke VCN**.

    ![Open Spoke VCN](images/open-spoke-vcn.png)

- Click on the **Routing** tab.

    ![Open Spoke VCN Routing](images/open-spoke-vcn-routing.png)

- Click on the route table **rt-lb**.

    ![Confirm rt-lb](images/confirm-rt-lb.png)

<!-- -->

1. Click the **Route Rules** tab.
2. Add the route rule `172.16.0.40/32 → DRG`.

    ![Configure rt-lb route rules](images/configure-rt-lb-route-rules.png)

#### Step 5: Configure DRG route tables (`ird-hub`, `rt-hub`, `rt-spoke`)

The DRG holds two route tables: **`rt-hub`** (used by the Hub VCN attachment) and **`rt-spoke`** (used by the Spoke VCN attachment). `rt-hub` is populated dynamically from an **Import Route Distribution** (`ird-hub`), so it always reflects the current set of spokes without manual updates. `rt-spoke` carries a static route back to the Hub VCN attachment for the Palo Alto Trust interface return path.

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

1. Notice the single statement in `ird-hub`: priority `10`, match type **Attachment**, match criteria **Spoke VCN Attachment**. You can instead use match type **Attachment type** and select **Virtual Cloud Network** to import future spokes automatically.
2. Click the back arrow to return to the DRG.

    ![Confirm one-spoke ird-hub statement](images/confirm-ird-hub-one-spoke.png)

    - Click on the route table **rt-hub**.

    ![Open rt-hub from DRG Routing](images/open-rt-hub-one-spoke-routing.png)

    - On the **rt-hub** Details page, click on the **Get all route rules** button to view the dynamic routes learned via `ird-hub`. 

    ![Open rt-hub route rules](images/open-rt-hub-route-rules.png)

<!-- -->

1. Notice the **DYNAMIC** entries, both learned via the `ird-hub` import distribution:
    - Destination `10.0.0.0/28` (the Spoke's App Subnet CIDR), next hop **Virtual Cloud Network → Spoke VCN Attachment**.
    - Destination `10.0.0.16/28` (the Spoke's LB Subnet CIDR), next hop **Virtual Cloud Network → Spoke VCN Attachment**.
2. Click on the **Close** button.

    ![rt-hub dynamic routes](images/lab-2-public-application-access-ngfw-first.png)

    - Click the back arrow to return to the DRG route tables list.

    ![Return to DRG route tables](images/return-to-drg-route-tables.png)

    - Click on the route table **rt-spoke**.

    ![Open rt-spoke](images/open-rt-spoke-one-spoke.png)

<!-- -->

1. Notice the **rt-spoke** Details page: **Import route distribution** is `-` (no dynamic routing).
2. Click on the **Static route rules** tab.

    ![Open rt-spoke static route rules](images/open-rt-spoke-static-route-rules-one-spoke.png)

    - Notice the single static route in `rt-spoke`: `172.16.0.40/32 → Hub VCN Attachment`. This carries return traffic destined for the Palo Alto Trust interface back to the Hub VCN for firewall inspection.

    ![Confirm rt-spoke static route](images/confirm-rt-spoke-static-route.png)

#### Step 6: Configure Palo Alto VR static routes

The OCI DRG and VCN route tables deliver traffic to the correct Palo Alto interface, but the firewall's default Virtual Router still needs static routes to forward each destination CIDR. The next-hop addresses used below are the OCI **default gateways** for the firewall subnets: `172.16.0.33` for the Trust subnet and `172.16.0.17` for the Untrust subnet. For Lab 2 the firewall needs:

- `10.0.0.0/24` — `ethernet1/2`, next hop `172.16.0.33`
- `0.0.0.0/0` — `ethernet1/1`, next hop `172.16.0.17`

Open the Palo Alto management Web GUI, then:

1. Sign in to the Palo Alto Web GUI, then click on the **Network** tab.
2. Click on **Virtual Routers**.
3. Click on the **default** virtual router.

    ![Open Palo Alto Virtual Router](images/open-palo-alto-virtual-router.png)

    - In the **Virtual Router - default** dialog, click on **Static Routes** in the left-hand menu.

    ![Open Palo Alto Static Routes](images/open-palo-alto-static-routes.png)

    Make sure this is configured:
    - On the **IPv4** sub-tab, click **Add** and create the first route `route-to-spoke` (Destination `10.0.0.0/24`, Interface `ethernet1/2`, Next Hop **IP Address** `172.16.0.33`).
    - Click **Add** again and create the second route `route-to-internet` (Destination `0.0.0.0/0`, Interface `ethernet1/1`, Next Hop **IP Address** `172.16.0.17`).

<!-- -->

1. Notice both routes are listed in the IPv4 table.
2. Click on the **OK** button to save the Virtual Router configuration.

    ![Confirm Palo Alto static routes](images/confirm-palo-alto-static-routes.png)

#### Step 7: Commit the Palo Alto configuration

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

## Task 3: Configure NAT

NAT is what makes this scenario work end-to-end:

- **Destination NAT (DNAT)** rewrites the destination from the firewall's Untrust public IP to the **Private ALB IP** (`10.0.0.22`), so users on the Internet can reach a private resource through one of the firewall's public IPs.
- **Source NAT (SNAT)** rewrites the source from the original client public IP to the **Palo Alto Trust interface IP** (`172.16.0.40`), so the return traffic from the Private ALB comes back to the firewall (which holds the session state) instead of going out somewhere else and creating an asymmetric flow.

    ![NAT traffic flow](images/lab-2-public-application-access-ngfw-first-7.png)

Both happen in a single NAT rule. Without SNAT specifically, the Private ALB would receive a packet with the original Internet source IP and try to reply directly out of the Spoke VCN through the DRG, which is exactly the asymmetric path you want to avoid. Open the Palo Alto GUI:

1. Click on the **Policies** tab.
2. Click on **NAT** in the left-hand menu.

    ![Open Palo Alto NAT policy](images/open-palo-alto-nat-policy.png)

    - Click on the **Add** button at the bottom to create a new NAT rule.

    ![Add NAT rule](images/add-nat-rule.png)

    In the **NAT Policy Rule** dialog, configure the **General** tab:

<!-- -->

1. Click on the **General** tab.
2. Specify a **Name** for the NAT rule (e.g. `NAT-Inbound-to-ALB`).
3. Add a **Description**.
4. Select **NAT Type** to be ipv4.
5. Click on the **Original Packet** tab.

    ![Configure NAT rule General tab](images/configure-nat-rule-general.png)

    On the **Original Packet** tab (this is the **Pre-NAT** view - the packet fields as the firewall first receives the packet):

<!-- -->

1. Set the **Source Zone** to **untrust**.
2. Set the **Destination Zone** to **untrust**.
3. Set the **Destination Interface** to `ethernet1/1`.
4. Set the **Service** to service-http.
5. Click on "Any" for **Source Address**.
6. Add the Untrust private IP `172.16.0.20` to **Destination Address**.
7. Click on the **Translated Packet** tab.

    ![Configure NAT rule Original Packet tab](images/configure-nat-rule-original-packet.png)

    On the **Translated Packet** tab, configure the **SNAT** (Source Address Translation) and **DNAT** (Destination Address Translation)

<!-- -->

1. Under **Source Address Translation**, set the **Translation Type** to **Dynamic IP And Port**.
2. Set **Address Type** to **Interface Address**.
3. Selecting `ethernet1/2` (Trust) .
4. So the source is SNAT'd to `172.16.0.40/28`.
5. Under **Destination Address Translation**, set the **Translation Type** to **Static IP**.
6. Set the **Translated Address** to `10.0.0.22` (the Private ALB IP).
7. Set the **Translated Port** to `80`.

    ![Configure NAT rule Translated Packet tab](images/configure-nat-rule-translated-packet.png)

    - Click on the **OK** button.

    ![Save NAT rule](images/save-nat-rule.png)

<!-- -->

1. Confirm that the new NAT rule appears in the list.
2. Click on **Commit**.

    ![Confirm NAT rule](images/confirm-nat-rule.png)

<!-- -->

1. Select **Commit All Changes**.
2. Click on the **Commit** button.

    ![NAT commit dialog](images/nat-commit-dialog.png)

- Notice that the change is pushed.

    ![NAT commit pending](images/nat-commit-pending.png)

- Wait for the **Commit** to complete successfully.

    ![NAT commit success](images/nat-commit-success.png)

## Task 4: Test and Validate

- In the OCI Console, open the **Private-ALB** load balancer details. 

1. Notice the **Overall health** is **OK** and the 
2. **IP address** shows `10.0.0.22 (private)`. This is the IP that the Palo Alto's NAT rule rewrites the destination to.

    ![Private ALB health](images/private-alb-health.png)

<!-- -->

1. From a browser on your local machine, enter one of the **Palo Alto Untrust public IP addresses** in the address bar.
2. Verify that the APP-VM web page loads. The OCI Console shows `10.0.0.22` as the Private ALB frontend IP, while **Source IP of request** on the APP-VM shows `10.0.0.21` in this lab. This is expected: the ALB uses a another private service IP when connecting to the backend, so the APP-VM sees the ALB rather than the original Internet client.

    ![Validate Private ALB browser access](images/validate-private-alb-browser-access.png)

<!-- -->

1. On the Palo Alto, open **Monitor**.
2. Click on **Traffic**.
3. Verify the matching sessions:
   - **Source:** the original client public IP (for example, `176.29.230.40`).
   - **Destination:** `172.16.0.20` (Palo Alto Untrust private IP).
   - **NAT Applied:** `yes`.
   - **NAT Source IP:** `172.16.0.40` (Trust interface; SNAT).
   - **NAT Destination IP:** `10.0.0.22` (Private ALB; DNAT).

![Verify Palo Alto NAT traffic log](images/verify-palo-alto-nat-traffic-log.png)

## Learn More

- [OCI Load Balancer Overview](https://docs.oracle.com/en-us/iaas/Content/Balance/)
- [OCI Web Application Firewall](https://docs.oracle.com/en-us/iaas/Content/WAF/)
- [OCI VCN Route Tables](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/managingroutetables.htm)
- [OCI Dynamic Routing Gateway (DRG)](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/managingDRGs.htm)
- [Palo Alto Static Routes](https://docs.paloaltonetworks.com/ngfw/networking/static-routes)
- [Palo Alto Source and Destination NAT Example](https://docs.paloaltonetworks.com/ngfw/networking/nat/source-and-destination-nat-example)
- [Palo Alto View and Manage Logs](https://docs.paloaltonetworks.com/ngfw/administration/monitoring/view-and-manage-logs)

## Acknowledgements

- **Authors** - Anas Abdallah, Iwan Hoogendoorn (Cloud Networking Black Belts)
- **Contributor** - Antonio Gámir (Cloud Networking Black Belt)
- **Last Updated By/Date** - Anas Abdallah, October 2026

You may now **proceed to the next lab**.
