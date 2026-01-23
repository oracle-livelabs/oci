# Introduction

## About this Workshop

This workshop represents a reference implementation for deploying a Spring Boot application on Oracle Cloud Infrastructure (OCI) using GitHub Actions and a production-style CI/CD approach.
The repository shows a practical, end-to-end flow for container-based deployments on OCI, including build, deployment, traffic cutover, and cleanup.
It highlights some strengths of OCI for application workloads, such as tight integration between container services, load balancing, and networking, as well as straightforward automation via GitHub Actions.
The setup follows a blue/green-style replacement strategy, enabling safe deployments, health-based traffic cutover, and clean rollback paths — patterns commonly used in production environments.

The application is packaged as a Docker container and deployed to OCI Container Instances. Traffic is routed through an OCI Load Balancer, while persistent data is stored in a PostgreSQL database on OCI.

The entire build and deployment process is automated using GitHub Actions.

It is triggered on every push to main branch.

Concurrency is enabled to ensure only one deployment per branch runs at a time.


Estimated Workshop Time: 3 hours 30 minutes
<br>

### Objectives

In this workshop, you will learn how to:
* Setup project environment and understand project structure
* Create a Virtual Cloud Network, Container Registry, Load Balancer and PostgreSQL Database system in Oracle Cloud Infrastructure console
* Setup GitHub Repository Secrets and Variables
* Release the Spring Boot application to OCI Using GitHub Actions

### Prerequisites 

This lab assumes you have:

* An Oracle account
* A GitHub account
* An IDE such as VS Code or IntelliJ
* Familiarity with Java is desirable, but not required
* Familiarity with Oracle Cloud Infrastructure (OCI) is helpful

## High-level architecture

This workshop demonstrates a production-grade CI/CD pipeline that:

- Builds a Spring Boot application + PostgreSQL DB

- Packages it as a Docker image

- Pushes the image to OCI Container Registry (OCIR)

- Deploys it to OCI Container Instances

- Performs a blue/green deployment

- Updates an OCI Load Balancer

- Cleans up old container instances

## Trigger

The pipeline runs when:

Code is pushed to the main branch

Or it is manually triggered

## Acknowledgements
- Author - Maria Oprea, Account Cloud Engineer, ACE
<br>
- Last Updated By/Date - Maria Oprea, 01-2026
