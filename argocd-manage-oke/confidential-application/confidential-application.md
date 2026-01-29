# Create Confidential Application

## Introduction

In this Lab we will create a Confidential Application.
This is used to authenticate in ArgoCD UI using your OCI user.
This is an optional Lab, in case you don't want this functionality, you can skip it and Log in to ArgoCD using the default admin user and password.

Estimated Lab Time: 10 minutes

### Objectives

- Create Confidential Application

### Prerequisites

This lab assumes you have:

- An Oracle Cloud account
- Permission to create a confidential application.

## Task 1: Create Confidential Application.

- Nativagate to [Oracle Identity Domains](https://cloud.oracle.com/identity/domains) in the OCI Console and click on your current domain.
- Select **Integrated Applications** and click **Add application**.
- Select **Confidential Application** and click **Launch workflow**.
- Add a name and description and click on **Submit**.
- Click on **OAuth configuration**
  - Click on **Edit OAuth configuration**.
  - **Client configuration** select **Configure this application as a client now**.
  - Check the boxes for **Client credentials** and **Authorization code**.
  - **Redirect URL** - add the following 2 redirects:
    - `https://argocd.<reserved_public_ip>.nip.io/api/dex/callback`
    - `https://argocd.<reserved_public_ip>.nip.io/auth/callback`
  - Scroll down to **Client ip address** and select **Anywhere**
  - **Token issuance policy** select **All**.
  - Click on **Submit**.
- Click on **Actions** on top right corner to activate your application.
- Click on **Users** or **Groups** to select which users or groups can authenticate on ArgoCD using this Application. Add a group that you are part of.

## Task 2: Collect your Application information for the Deployment.

- Client ID and Client secret
  - On your Application page, select **OAuth configuration**.
  - Under **General Information**
    - Note down **Client ID**
    - Under **Client secret** click on **Show secret** and note it down.
- OCI Domain URL
  - Go to [Oracle Identity Domains](https://cloud.oracle.com/identity/domains) click on your current domain.
  - Under **Domain Information** you will find **Domain URL**. Note it down.

You may now proceed to the next lab.

### Acknowledgements

**Author**

- **Gabriel Feodorov**, Principal Cloud Architect.
