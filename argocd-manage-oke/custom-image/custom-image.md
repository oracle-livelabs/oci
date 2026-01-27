# Create ArgoCD custom image

## Introduction

In this Lab we will create the ArgoCD custom image with oci cli installed and available in path.
The ArgoCD version used at the moment of this LiveLab is v3.1.1.

Estimated Lab Time: 10 minutes

### Objectives

- Create custom image
- Push image to OCIR

### Prerequisites

This lab assumes you have:

- An Oracle Cloud account
- Docker or Podman installed
- Auth token for your OCI user (from the OCI Console, go to your user profile and click **Auth tokens**), it can take up to 5 mins to activate.
- Permission for your OCI user to create repos in OCI Container Registry.

## Task 1: Create OCIR repository

- Go to OCI Console > Developer Services > Containers & Artifacts > Container Registry > Create repository.
- Set the name **repository_name**/**image_name**
- For the purpose of this Lab, the repository will be public.
  ![Create repository](images/create_repository.png)

## Task 2: Create and push the custom image

1. Download the [Dockerfile](files/Dockerfile).

2. Run the following command inside the folder containing the 'Dockerfile' to build the image.

   ```
   podman build --platform linux/amd64 -t argocd-oci:v3.1.1 .
   ```

   > **Note:** The **dot (.)** at the end of the command is for current directory, where the Dockerfile is located.

3. Run the following command to tag the image.

   ```
   podman tag argocd-oci:v3.1.1 ocir.your_region.oci.oraclecloud.com/your_tenancy_namespace/your_repository_name/argocd-oci:v3.1.1
   ```

4. Login to OCIR.
   ```
   podman login ocir.your_region.oci.oraclecloud.com
   ```

- User is :
- If identity domain is used: **your_tenancy_namespace**/**identity_domain_name**/**your_email**
- If default domain is used: **your_tenancy_namespace**/**your_email**
- Password is your OCI Auth token

5. Push the image to OCIR.
   ```
   podman push ocir.your_region.oci.oraclecloud.com/your_tenancy_namespace**/your_repository_name/argocd-oci:v3.1.1
   ```
   default\*\*.

You may now proceed to the next lab.

## Acknowledgements

**Author**

- **Gabriel Feodorov**, Principal Cloud Architect.
