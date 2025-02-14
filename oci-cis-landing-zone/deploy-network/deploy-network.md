# Deploy a Network on the Landing Zone

## Introduction

We have created the skeleton of the Landing Zone we need to deploy our workload. We have all the IAM requirements met including compartments, groups, and policies. Now, our workload will need the ability to communicate with clients and components. One or more Virtual Cloud Networks will give us the ability to do so.

### Objectives

- Learn how to modify Landing Zone by changing configuration variables
- Plan and Apply configuration in-place to create a 3-tier network
- Inspect network resources

## Task 1: Configure Network Variables

We will need to return to the configurations that we used to define the Landing Zone. By modifying the configuration variables, we can declare a network that will be added to the Landing Zone.

1. In the _Stacks_ menu for the _Resource Manager Stack_ we deployed in the previous lab, select __Variables__ under _Resources.
1. Click the __Edit Variables__ button. Please note that it may take a moment for the variables form to populate.

    ![Edit variables on the stack menu](./images/edit-variables-btn.png "Select the Edit Variables button")

1. Select the __Define Networking?__ checkbox in the _General_ section of the stack variables.

    ![Define Networking? is checked](./images/define-network.png "Make sure to check the Define Networking? button")

1. Four Networking sections will appear. Proceed to _Networking - Three Tier VCNs_ and check the __Add Three-Tier VCN (label: TT-VCN-1)?__ button. Note that the display name for the VCN is configurable by using the field _VCN Name (label: TT-VCN-1)_. The VCN name will default to _TT-VCN-1_ otherwise. The network CIDR Block(s) can be changed in the _List of CIDR Blocks_ field. Further customizations are available in _Customize VCN Subnets?_, but are outside the scope of this lab.

    ![Three tier network options](./images/network-config.png "Configure the network here")

1. Select the __Next__ button to move to the _Review_ page.
1. Ensure that _Run apply_ is __not checked__ and __Save changes__.

## Task 2: Plan and Apply Updated Configuration

With our new configurations in place, we will go through the plan and apply process to deploy a network.

1. You should be on the _Stack details_ page after saving the configuration. Click the __Plan__ button and then __Plan__.
1. Check the plan logs to ensure that resources are being added, ensuring that resources are being added and not changed or destroyed. This will mean the deployment will happen in-place, without any resources being terminated and re-created.

    ![Plan output showing resources to be added, changed, destroyed](./images/network-plan-output.png "X to add, 0 to change, 0 to destroy")

1. Navigate back to the _Stack details_ page and click the __Apply__ button.
1. Select the _Plan_ we just created from the __Apply job plan resolution__ drop down and then __Apply__ again.
1. Once the _Apply_ is complete, inspect the logs to make sure that the deployed resources match the desired state defined by the configuration.

    ![Apply output logs](./images/network-apply-output.png "Make sure the apply executed properly")

## Task 3: Inspect Changes

1. Navigate from the main menu in the top-left corner of the console to _Networking_ > _Virtual cloud networks_ to inspect the new 3-tier VCN. Make sure you are in the network compartment to see network resources.

    ![Virtual Cloud Network](./images/3-tier-vcn.png "3 tier VCN")

1. Click the Three Tier VCN and inspect the network details. Note that subnets, route tables, network security groups, and other objects have been created for the network. These resources determine how the VCN functions and how security is applied by default on the network.

    ![VCN Subnets and Details](./images/subnets.png "Subnets and other details about the VCN")

1. (_Optional_) From the main menu, go to _Networking_ > _Network Visualizer_ to see a visualization of the network. You should see three different gateways for resources on the network to communicate. An Internet Gateway (IGW) for the web tier, a NAT gateway for private internet access for the App and DB subnets, and finally a Service Gateway (SGW) for private communication with OCI internal services.

    ![Network Visualizer Image](./images/visualizer-output.png "Output from the Network Visualizer")

Your Landing Zone will look something like this now:

![3 Tier Network Architecture](./images/arch-three-tier.png "3 Tier Network Architecture")

In the next lab, we will increase the complexity (and scalability) of our Core Landing Zone network.

## Acknowledgements

- __Author__ - KC Flynn
- __Contributors__ - Andre Correa, Johannes Murmann, Josh Hammer, Olaf Heimburger
- __Last Updated By/Date__ - KC Flynn February 2025
