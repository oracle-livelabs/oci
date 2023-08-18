# Verify MultiCloud connectivity

## Introduction

Estimated Lab Time: 10 minutes

### Objectives

In this lab, you will:

* Update the VCN Route Table
* Verify private connectivity between Oracle Cloud and your external cloud provider.

### Video Walkthrough

[Verify Connectivity Video](youtube:oTcQNfchMKc:large)

## Task 1 : Update VCN Route Table

1. From the Oracle Cloud homepage, open up the navigation menu in the top left hand corner. Navigate to **Compute -> Instances**.
    ![Select Deployed VM](images/route-table-1.png)
2. Select the name of the Virtual Machine that was deployed the previous lab.
    ![Click on the name](images/route-table-2.png)
3. Select the subnet that the Virtual Machine is deployed to.
    ![Click on the assigned subnet](images/route-table-3.png)
4. Select the route table this subnet is associated with.
    ![Click on the route table of the subnet](images/route-table-4.png)
5. Click **Add Route Rules**.
    ![Add a route rule](images/route-table-5.png)
6. On the Route Rule, add **Dynamic Routing Gateway** as the Target Type. **CIDR Block** as the Destination Type. **10.100.0.0/16** as the Destination CIDR Block, and an option description.
    ![Add the destination of the cloud provider](images/route-table-6.png)

## Task 2: Test Connectivity

1. Restore your Cloud Shell session that has an active SSH session to your Oracle Cloud virtual machine.
    ![Restore Cloud Shell](images/test-connectivity-1.png)
2. Run the command **ping ipaddress**, where **ipaddress** is the IP address of your external cloud provider's virtual machine private IP address.
    ![Ping the VM](images/test-connectivity-2.png)
3. Run the command **mtr ipaddress**, where **ipaddress** is the IP address of your external cloud provider's virtual machine private IP address. This command will show you all of the hops your traffic takes, confirms that you are going over the private connection and gives some basic packet statistic information.

    > **Note:** **Click on the image below to explode the view.**
    ![MTR to private IP](images/mtr-1.png)
4. Congratulations! You've completed the lab. You can now destroy the objects created in this lab, such as the Virtual Machines, FastConnect, DRG and VCN.

## Acknowledgements

* **Author** - Jake Bloom, Principal Solution Architect, OCI Networking
* **Last Updated By/Date** - Jake Bloom, August 2023
