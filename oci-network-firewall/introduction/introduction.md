# Introduction

### About this Workshop

Estimated Time: 3 - 5 hours

OCI Network Firewall is a next-generation managed network firewall and intrusion detection and prevention service for your Oracle Cloud Infrastructure virtual cloud network (VCN), powered by Palo Alto Networks®. [Visit our documentation](https://docs.oracle.com/en-us/iaas/Content/network-firewall/home.htm) for more information on the Network Firewall service. We will explore various, common, use-cases and look into step-by-step guides on implementing each one of them.

To gain more familiarity with Oracle Cloud's networking concepts, I would recommend watching our introductory [Oracle Cloud Networking YouTube series](https://youtu.be/mIYSgeX5FkM) as well as the [Oracle Cloud Networking Overview Documentation](https://docs.cloud.oracle.com/iaas/Content/Network/Concepts/overview.htm).

### Objectives

In this workshop, you will learn how to:

* Deploy a Virtual Cloud Network (VCN), Subnets, Route tables, Security Lists.
* Deploy OCI Network Firewalls and use different configuration items in the Firewall Security Policy.
* Adjust routing inside the OCI VCN so we introduce a Network Firewall on the path.

### Prerequisites

This lab assumes you have:

* Administrative Oracle Cloud Access to provision networking and compute resources.
* Basic knowledge of OCI Networking components and networking.

### Workflow

This workshop contains six labs, each with their own dedicated tasks. Each lab depends on constructs deployed in previous ones so **do not skip** any lab or task or else you will not get the intended result. 
For deploying resources of any kind, OCI asks for an IAM Compartment. Every resource deployed in this workshop will be deployed in the same **LAB** Compartment. Make sure you are the admin of your environment or have sufficient privileges to deploy resources in the Compartment you plan to use.  

## Acknowledgements

* **Author** - Radu Nistor, Principal Cloud Architect, OCI Networking
* **Last Updated By/Date** - Radu Nistor, November 2023