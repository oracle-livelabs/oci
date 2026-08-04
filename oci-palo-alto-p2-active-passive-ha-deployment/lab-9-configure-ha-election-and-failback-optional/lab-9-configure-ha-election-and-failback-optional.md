# Configure HA Election and Failback (Optional)

## Introduction

By default, when a failed firewall recovers, it remains passive and the peer that assumed the active role continues to handle traffic. Lab 8 demonstrated this non-preemptive behavior. In this optional lab, you configure device priority and enable preemption so that, after recovery, PA-VM-01 can automatically reclaim the active role.

Estimated time: 20 minutes

### Objectives

In this lab, you will:
- Configure HA device priority and election settings.
- Optionally enable preemption and verify the expected failback behavior.

### Prerequisites

Before you begin, ensure you have completed the preceding required labs in this workshop.

## Task 1: Configure HA Election

> **Note:** A lower device-priority value is preferred during an HA election. Therefore, we will make PA-VM-01 use priority `1`, which is preferred over PA-VM-02's priority of `100`.

### PA-VM-01

- Navigate to the **PA-VM-01** WEB GUI.
1. Click on **Device**.
2. Click on **High Availability**.
3. Click on the **General** tab.
4. In the **Election Settings** section, click on the **settings wheel**.

    ![Open HA election settings](images/open-ha-election-settings.png)

<!-- -->

1. Set the **device priority** for PA-VM-01 to 1 so it will be the active firewall when available.
2. Check the **Preemptive** box.
3. Click on the **OK** button.

    ![Configure HA election settings](images/configure-ha-election-settings.png)

    - Click on **Commit**.

    > **Note:** You can **commit** after each configuration you make (safer, easier to troubleshoot), or you can wait and commit once after completing all steps (faster, fewer commits).

    ![Commit HA election settings](images/commit-ha-election-settings.png)

<!-- -->

1. Notice the message that commit will overwrite the running configuration.
2. Click on the **Commit** button.

    ![Confirm HA election commit](images/confirm-ha-election-commit.png)

    - Wait for the **Commit** to complete.

    ![Wait HA election commit](images/wait-ha-election-commit.png)

<!-- -->

1. Notice that the **Commit** has completed.
2. Click on the **Close** button.

    ![HA election commit complete](images/ha-election-commit-complete.png)

### PA-VM-02

- Navigate to the **PA-VM-02** WEB GUI and repeat the same steps above.
- Keep the **device priority** at the default value of 100 so PA-VM-02 remains passive when available.

![Verify PA-VM-02 election settings](images/verify-pa-vm-02-election-settings.png)

## Task 2: Test Failover

To perform an additional test, reboot PA-VM-01.

1. At this point, PA-VM-01 is active and PA-VM-02 is passive, so reboot PA-VM-01.
2. Wait for some time.
3. Unlike the previous test, PA-VM-01 will reclaim the active role after recovery.

### PA-VM-01

- Navigate to the **PA-VM-01** WEB GUI.
- Notice that the **local** high availability status of PA-VM-01 is now in **active** state.

![Verify PA-VM-01 active](images/verify-pa-vm-01-active.png)

### PA-VM-02

- Navigate to the **PA-VM-02** WEB GUI.
- Notice that the **local** high availability status of PA-VM-02 is now in **passive** state.

![Verify PA-VM-02 passive](images/verify-pa-vm-02-passive.png)

## Task 3: Understand which Is better: Enable or Disable Preemptive Mode?

**Recommended: _Disable Preemptive Mode_**

For most deployments, leave preemption disabled unless you require a specific firewall to automatically reclaim the active role after recovery.

Here’s why:
- **More stable failover behavior**
    - When preemptive mode is disabled, the firewall that becomes _active_ during a failover remains active until **another failure occurs**.
    - This avoids unnecessary role flipping.
- **Prevents “flapping” in cloud environments**
    - Cloud networks can experience brief latency or API delays.
    - Preemptive mode may interpret these as a failure and try to reclaim Active role, causing disruptive failovers.
- **Better for OCI where both nodes have equal operational capability**
    - In OCI, both firewalls are deployed identically (same shape, same configuration, same routing).
    - There is no strong requirement for a specific firewall (Primary) to always be Active.

**When to enable preemptive mode (rare cases):**
- You have a strict operational requirement that the **Primary firewall must always be Active** when healthy.
- Your environment has **LOCAL stable, low-latency, on-prem-like conditions**.
- You accept the risk of additional failover events.

## Learn More

- [How to Configure Palo Alto Active/Passive HA on OCI](https://docs.paloaltonetworks.com/vm-series/11-0/vm-series-deployment/set-up-the-vm-series-firewall-on-oracle-cloud-infrastructure/configure-activepassive-ha-on-oci)

## Acknowledgements

- **Authors** - Anas Abdallah, Iwan Hoogendoorn (Cloud Networking Black Belts)
- **Contributor** - Antonio Gámir (Cloud Networking Black Belt)
- **Last Updated By/Date** - Anas Abdallah, August 2026

You may now **proceed to the next lab**.
