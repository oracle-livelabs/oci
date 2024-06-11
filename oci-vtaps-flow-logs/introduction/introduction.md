# Introduction

## About this Workshop

Estimated Time: 30 - 45 minutes

OCI Virtual Test Access Points (VTAPs) and Flow Logs allow customers full visibility into customer environments for understanding what your network in OCI is doing. Visit our [VTAP documentation](https://https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/vtap.htm) and [Logging documentation](https://docs.oracle.com/en-us/iaas/Content/Logging/home.htm) for more information on the VTAPs and Flow Logs. We will explore various, common use-cases and look into step-by-step guides on implementing each one of them.

To gain more familiarity with Oracle Cloud's networking concepts, I would recommend watching our introductory [Oracle Cloud Networking YouTube series](https://youtu.be/mIYSgeX5FkM) as well as the [Oracle Cloud Networking Overview Documentation](https://docs.cloud.oracle.com/iaas/Content/Network/Concepts/overview.htm).

### Objectives

In this workshop, you will learn how to:

* Deploy a Virtual Cloud Network (VCN), Subnets, and associated Security Lists.
* Deploy Compute Instances for client/server communication and traffic monitoring
* Deploy a VTAP along with an NLB and enable Flow Logs to investigate the client/server communication.

### Prerequisites

This lab assumes you have:

* Administrative Oracle Cloud Access to provision networking and compute resources (free tier account will suffice).
* Basic knowledge of OCI Networking components and networking.

### Workflow

This workshop contains multiple labs with associated tasks. Each lab depends on constructs deployed in previous. As such **do not skip** any lab or task as skipping labs or tasks may result in missing the overall objective of the exercise.

For deploying resources of any kind, OCI asks for an IAM Compartment. Every resource deployed in this workshop will be deployed in the same **LAB** Compartment. Make sure you are the admin of your environment or have sufficient privileges to deploy resources in the Compartment you plan to use.

## Acknowledgements

* **Author** - Gabriel Fontenot, Principal Architect, OCI Networking
* **Last Updated By/Date** - Gabriel Fontenot, June 2024