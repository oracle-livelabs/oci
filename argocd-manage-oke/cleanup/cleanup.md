# Cleanup

## Introduction

This lab will take you through the steps needed to destroy the infrastructure.

Estimated Lab Time: 10 minutes minutes

### Objectives

In this lab, you will:

- Delete the kubernetes service.
- Destroy the resources from Resource Manager.

## Task 1: Delete teh kubernetes service.

- SSH into the Bastion Instance.
- run `delete svc ingress-nginx-controller -n ingress-nginx`

## Task 2: Destroy the resources from Resource Manager.

- Go to the terraform stack.
- Click on Destroy button.

## Acknowledgements

**Author**

- **Gabriel Feodorov**, Principal Cloud Architect
