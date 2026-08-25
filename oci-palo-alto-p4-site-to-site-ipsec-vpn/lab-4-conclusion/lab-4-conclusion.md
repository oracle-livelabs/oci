# Conclusion

## Introduction

This lab closes the Site-to-Site IPSec VPN configuration by reviewing the OCI and firewall configuration completed in the preceding labs. The resulting design establishes encrypted connectivity between the Palo Alto firewall in Frankfurt and the OCI native Site-to-Site VPN service in Milan through two redundant tunnels.

Estimated time: 5 minutes

### Objectives

In this lab, you will:
- Review the completed OCI and Palo Alto IPSec configuration.
- Confirm that both IPSec tunnels are established.
- Confirm that the DRG routes and end-to-end connectivity meet the workshop objectives.

### Prerequisites

Before you begin, ensure you have completed the preceding required labs in this workshop.

## Task 1: Verify the Site-to-Site IPSec VPN Setup

Before moving on, verify the following:

- The Palo Alto firewall in Frankfurt has the required tunnel interfaces, IKE gateways, and IPSec tunnels configured.
- The IKE and IPSec crypto profiles match the parameters configured in OCI.
- The Palo Alto virtual router has static routes to the Milan VCN through both tunnel interfaces, with ECMP enabled.
- The Milan DRG route table shows the Frankfurt routes as active.
- The OCI native Site-to-Site VPN service in Milan reports both IPSec tunnels as up.
- End-to-end connectivity succeeds between Milan and the Palo Alto firewall in Frankfurt.
- Palo Alto traffic logs show the validation traffic.

You have now configured a Site-to-Site IPSec VPN between a Palo Alto Networks NGFW in Frankfurt and the OCI native Site-to-Site VPN service in Milan. You configured two redundant tunnels, the required OCI routing, and Palo Alto virtual-router, IKE, and IPSec settings to establish secure connectivity between the two environments.

You should now understand how to:

- Configure the DRG, CPE, and Site-to-Site VPN connection in OCI.
- Configure tunnel interfaces, crypto profiles, IKE gateways, and IPSec tunnels on a Palo Alto NGFW.
- Configure static routes and ECMP to use both IPSec tunnels.
- Validate tunnel status, DRG routing, connectivity, and Palo Alto traffic logs.

Next, you can explore designs such as:

- Palo Alto deployment models in OCI: Standalone, Active/Passive, and Active/Active.
- Secure remote-user access to OCI workloads through GlobalProtect.
- Hub-and-spoke inspection scenarios that bring the full architecture together and demonstrate different north-south and east-west traffic flows.

See **Learn More** below for related workshops.

## Acknowledgements

- **Authors** - Anas Abdallah, Iwan Hoogendoorn (Cloud Networking Black Belts)
- **Contributor** - Antonio Gámir (Cloud Networking Black Belt)
- **Last Updated By/Date** - Anas Abdallah, August 2026

You may now **proceed to the next lab**.
