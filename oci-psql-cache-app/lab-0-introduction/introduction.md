# Introduction

## About This Workshop

Welcome to Accelerating IoT applications with OCI Cache and OCI PostgreSQL Workshop!

This workshop walks you step by step through creating a full stack  functional application including OCI Compute, OCI Cache, OCI PostgreSQL and the necessary core OCI components.

**Estimated Time:** 5 minutes

### Objectives

The core focus is on the deployment and integration of cache and database working together to deliver high performance. The application requires minimal setup, allowing you to spend more time exploring key integration concepts and observing the real-world impact of caching through a dynamic, visual interface.

By the end of this workshop, you will understand how to architect modern applications that blend the speed of caching with the robustness of relational storage — all using managed services on OCI.

### What are we solving?

General transport IoT applications require instant access to combined real-time data and historical database records, but frequent PostgreSQL queries under high user demand cause latency spikes and introduce bottlenecks into the system.

This workshop demonstrates accelerating these apps by integrating OCI Cache (Valkey) with OCI PostgreSQL - caching full API responses to reduce database calls while blending live transit updates with stored route data for responsive, map-based UIs and dashboards.

This approach can also enhance existing solutions: migrate current PostgreSQL workloads to OCI PostgreSQL with minimal effort, then layer in OCI Cache to offload read-heavy queries. Existing apps can gain instant performance boosts by routing API requests through the cache, achieving faster responses and better scalability without major code changes.

### Prerequisites

To complete this lab you need:

* An Oracle Cloud Account(Tenancy)
* Basic familiarity with Core OCI Services
* Must have an Administrator Account or Permissions to manage several OCI Services: OCI Database with PostgreSQL, OCI Cache, Compute, Network, Dynamic Groups, Policies, Vault

### Architecture

The key components are:
* OCI Database with PostgreSQL
* OCI Cache
* OCI Compute (Hosting the application)

Additionally OCI Vault is used for storing the database credentials.

![Solution Architecture](images/architecture.png)

Typical request flow:
* User opens the web frontend. (map)
* Frontend sends an API request (e.g., /route).
* Request reaches the Go backend service which
    - fetches cached data from Valkey or
    - queries PostgreSQL.
* Backend returns the response to the frontend.
* Frontend updates the UI.

## Acknowledgements

- **Created By/Date** - Piotr Kurzynoga, Andriy Dorokhin, April 2026
- **Last Updated By** - Piotr Kurzynoga, April 2026