# Review VCN Routing & Security (Prerequisites)

## Introduction

This lab reviews the OCI networking prerequisites for the standalone Palo Alto firewall deployment, including the VCN, subnets, route tables, security lists, and Internet Gateway.

Estimated time: 10 minutes

### Objectives

In this lab, you will:
- Verify that the required VCN networking components are in place.
- Review the routing and security configuration for the management, untrust, and trust subnets.

![Palo alto vm series prerequisite](images/palo-alto-vm-series-prerequisite-vcn-subnet-setup.png)

### Prerequisites

No prerequisite lab is required. Complete Lab 0 if you want to deploy the required VCN networking components using Terraform; otherwise, create them manually before starting this lab.

## Task 1: Review VCN Routing

Review the VCN route tables to confirm that the management and untrust subnets can reach the internet through the Internet Gateway.

1. Select the **OCI Region** you want to deploy the Firewall in.
2. Click on the **hamburger menu** in the top left corner.

    ![Click hamburger menu top left](images/click-hamburger-menu-top-left-corner.png)

<!-- -->

1. Click on **Networking**.
2. Click on **Virtual cloud networks**.

    ![Open networking select virtual cloud](images/open-networking-and-select-virtual-cloud-networks.png)

    - Make sure the VCN is created as part of your prerequisites. Click on the **Hub VCN**.

    ![Select hub vcn](images/select-hub-vcn.png)

<!-- -->

1. Click on **Subnets**.
2. Make sure the Subnets are created and that each one has its own custom Route Table and Security List assigned as part of your prerequisites.

    ![Verify subnets created](images/make-sure-subnets-are-created-that-each-one-has-its-own-cust.png)

<!-- -->

1. Click on **Gateways**.
2. Make sure the Internet Gateway is created as part of your prerequisites.

    ![Verify internet gateway created](images/make-sure-internet-gateway-is-created-as-part-your-prerequis.png)

<!-- -->

1. Click on **Routing**.
2. The default VCN Routing Table will be available (we will not be using this).
3. Make sure the custom Routing Tables are created as part of your prerequisites.

    ![Verify custom routing tables](images/make-sure-custom-routing-tables-are-created-as-part-your-pre.png)

    - Click on the **rt-management** **Routing Table**.

    ![Click rt management routing table](images/click-rt-management-routing-table.png)

<!-- -->

1. Click on the **Route Rules**.
2. Make sure you have the following route rule configured:

    | Destination | Target Type      | Target | Route Type |
    | ----------- | ---------------- | ------ | ---------- |
    | 0.0.0.0/0   | Internet Gateway | IGW    | Static     |

3. Go Back to the Hub VCN overview.

    ![Return to hub vcn overview](images/go-back-hub-vcn-overview.png)

    - Click on the **rt-untrust** **Routing Table**.

    ![Click rt untrust routing table](images/click-rt-untrust-routing-table.png)

<!-- -->

1. Click on the **Route Rules**.
2. Make sure you have the following route rule configured:

    | Destination | Target Type      | Target | Route Type |
    | ----------- | ---------------- | ------ | ---------- |
    | 0.0.0.0/0   | Internet Gateway | IGW    | Static     |

3. Go Back to the Hub VCN overview.

    ![Return to hub vcn overview](images/go-back-hub-vcn-overview-2.png)

## Task 2: Review VCN Security

Review the security lists to confirm that PAN-OS management access and the required trust and untrust traffic are allowed.

1. Click on **Security**.
2. Notice the **default VCN Security List** will be available (we will not be using this).
3. Make sure the **custom Security Lists** are created as part of your prerequisites.

    ![Verify custom security lists](images/make-sure-custom-security-lists-are-created-as-part-your-pre.png)

    - Click on the **sl-management Security List** (for the Management Subnet).

    ![Click sl management security list](images/click-sl-management-security-list-management-subnet.png)

    - Click on **Security rules**.

    ![Click security rules](images/click-security-rules.png)

<!-- -->

1. Make sure to add in an **Ingress rule** to allow traffic from all sources (`0.0.0.0/0`) to port `TCP/22` (SSH).
2. Make sure to add in an **Ingress rule** to allow traffic from all sources (`0.0.0.0/0`) to port `TCP/443` (HTTPS).

> **Note:** Opening SSH/HTTPS to `0.0.0.0/0` is not a best practice. For better security, restrict access to your own public IP or another trusted range.

![Restrict SSH and HTTPS](../../lab-1-review-vcn-routing-and-security/images/opening-ssh-https-is-not-best-practice-better-security-restr.png)

- Scroll down for the **Egress rules**.
- Make sure you add in an **Egress rule** to allow traffic to all destinations (`0.0.0.0/0`) for `All Protocols`.

![Verify egress rule](images/make-sure-you-add-egress-rule-allow-traffic-all-destinations.png)

- Go back to the **Security List Overview**.

![Return to security list overview](images/go-back-security-list-overview.png)

- Click on the **sl-trust Security List** (for the Trusted Subnet).

![Click sl trust security list](images/click-sl-trust-security-list-trusted-subnet.png)

- Click on **Security Rules**.

![Click security rules](images/click-security-rules-2.png)

- Make sure you add in an **Ingress rule** to allow traffic from all sources (`0.0.0.0/0`) for `All Protocols`.

> **Note:** Allowing **All Protocols (Ingress)** from `0.0.0.0/0` is not a best practice. We are only doing it here only for simplicity and to avoid extra troubleshooting as we move into the later workshops in this series. In real deployments, allow only what you actually need.

![Ingress all-protocol rule](images/allowing-all-protocols-ingress-is-not-best-practice-we-are-o.png)

- Scroll down for the **Egress rules**.
- Make sure you add in an **Egress rule** to allow traffic to all destinations (`0.0.0.0/0`) for `All Protocols`.

![Verify egress rule](images/make-sure-you-add-egress-rule-allow-traffic-all-destinations.png)

- Go back to the **Security List Overview**.

![Return to security list overview](images/go-back-security-list-overview-2.png)

- Click on the **sl-untrust Security List** (for the Untrusted Subnet).

![Select untrust security list](images/select-untrust-security-list.png)

- Click on **Security Rules**.

![Click security rules](images/click-security-rules-3.png)

- Make sure you add in an **Ingress rule** to allow traffic from all sources (`0.0.0.0/0`) for `All Protocols`.

> **Note:** Allowing **All Protocols (Ingress)** from `0.0.0.0/0` is not a best practice. We are only doing it here only for simplicity and to avoid extra troubleshooting as we move into the later workshops in this series. In real deployments, allow only what you actually need.


![Ingress all-protocol rule](images/allowing-all-protocols-ingress-is-not-best-practice-we-are-o-2.png)

- Scroll down for the **Egress rules**.
- Make sure you add in an **Egress rule** to allow traffic to all destinations (`0.0.0.0/0`) for `All Protocols`.

![Verify egress rule](images/make-sure-you-add-egress-rule-allow-traffic-all-destinations.png)

## Learn More

- [VCN and Subnet Management](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/managingVCNs.htm)
- [VCN Route Tables](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/managingroutetables.htm)
- [Security Lists](https://docs.oracle.com/en-us/iaas/Content/Network/Concepts/securitylists.htm)

## Acknowledgements

- **Authors** - Anas Abdallah, Iwan Hoogendoorn (Cloud Networking Black Belts)
- **Contributor** - Antonio Gámir (Cloud Networking Black Belt)
- **Last Updated By/Date** - Anas Abdallah, August 2026

You may now **proceed to the next lab**.
