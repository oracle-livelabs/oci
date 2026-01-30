# Introduction

## About this Workshop

In OCI, tokens usually means one of these:
- OCI Session Tokens, 
- OCI Security Tokens (UPST),
- Resource Principals / Workload Identity Federation.

All three share the same core ideas:short lifetime, no permanent secrets, identity proven cryptographically.

Using tokens instead of API keys means moving from long-lived, static secrets to short-lived, context-aware credentials that are issued on demand and automatically expire, reducing blast radius, eliminating manual rotation, and tying access to who is calling, from where, and for what purpose.

Uses of tokens are good for secure CI/CD pipelines, federated workloads, temporary access, least-privilege automation, and any scenario where credentials must be short-lived, automatically rotated, context-aware, and safe to use without storing long-term secrets.

In this workshop we will use [Oci Token Exchange](https://docs.oracle.com/en-us/iaas/Content/Identity/api-getstarted/json_web_token_exchange.htm#jwt_token_exchange) in a Github Action from where we will create a simple VCN in OCI usint Terraform

Estimated Workshop Time: 1 hour

### **Objectives**

By the end of this workshop, you will:

* Deploy the OCI resources that are required to use OCI Token Exchange authentication from Github Action
* Understand how to clone and then to create your own Github repo with GtHub CLI.
* Create and update  GtHub Secrets and Variables
* Run a workflow from Github Action using UI or  GtHub CLI.


### **Prerequisites**

This lab assumes you have:

* An Oracle Cloud account.
* A GitHub Account
* Administrator privileges or sufficient access rights to create and manage Integrated App, Service User, Group, IAM Policies in your tenancy.
* The Lab requires you to run a Bash/Shell script so you must run the Lab from a Unix like machine 
* GitHub CLI must be installed and configured for your own Github account
* git installed
* terraform installed

### Learn More

* [GitHub CLI](https://cli.github.com)
* [GitHub CLI Install](https://cli.github.com/manual/)
* [Oci Token Exchange](https://docs.oracle.com/en-us/iaas/Content/Identity/api-getstarted/json_web_token_exchange.htm#jwt_token_exchange)
* [Oracle Cloud Infrastructure](https://docs.oracle.com/en-us/iaas/Content/home.htm)

You may now **proceed to the next lab**.

## Acknowledgements

**Authors**

* **Francisc Vass**, Principal Cloud Architect, NACIE
* Last Updated - Francisc Vass, January 2026