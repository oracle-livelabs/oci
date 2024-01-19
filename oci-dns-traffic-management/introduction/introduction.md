# Introduction

### About this Workshop

Estimated Time: 3 - 5 hours

Traffic Management helps you guide traffic to endpoints based on various conditions, including endpoint health and the geographic origins of DNS requests. Use Traffic Management steering policies to serve intelligent responses to DNS queries, meaning different answers (endpoints) might be served for the query depending on the logic defined in the policy. [Visit our documentation](https://docs.oracle.com/en-us/iaas/Content/DNS/home.htm) for more information on the Public DNS service. 

To gain more familiarity with Oracle Cloud's networking concepts, I would recommend watching our introductory [Oracle Cloud Networking YouTube series](https://youtu.be/mIYSgeX5FkM) as well as the [Oracle Cloud Networking Overview Documentation](https://docs.cloud.oracle.com/iaas/Content/Network/Concepts/overview.htm).

In this workshop we will do a step-by-step implementation for each type of DNS Traffic Management steering policy. 

### Objectives

In this workshop, you will learn how to:

* Deploy a Virtual Cloud Network (VCN), Subnets, Route tables, Security Lists.
* Delegate Public DNS Zones to OCI.
* Configure each type of DNS Traffic Management steering policy.

### Prerequisites

This lab requires that you have:

* Administrative Oracle Cloud Access to provision networking and compute resources.
* Basic knowledge of OCI Networking components, DNS and networking.
* A DNS Domain/Zone that you own or manage. This workshop will use the domain **oci-lab.cloud** however you will need to use your own domain to complete the workshop's labs.
* SSL/TLS Certificates and private keys for the domain that you will use.  

### Workflow

This workshop contains six labs, each with their own dedicated tasks. Each lab depends on constructs deployed in previous ones so **do not skip** any lab or task or else you will not get the intended result. 
For deploying resources of any kind, OCI asks for an IAM Compartment. Every resource deployed in this workshop will be deployed in the same **LAB** Compartment. Make sure you are the admin of your environment or have sufficient privileges to deploy resources in the Compartment you plan to use.  

## Acknowledgements

* **Author** - Radu Nistor, Principal Cloud Architect, OCI Networking
* **Last Updated By/Date** - Radu Nistor, February 2024