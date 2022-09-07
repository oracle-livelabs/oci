# Set Up Digital Twin Running Environment



## Introduction
In this session, we will configure OCI tenancy with required IAM resources (compartment, user/group, compartment), create OCI services like OKE, OCI Streaming, Object Storage, and OCI Notification service.

*Estimated Time*: 20 minutes

### Objectives
1. Create the OCI infrastracture need to run digital twin
2. Understand the OCI services
3. 


### Task 1 Create OCI Resource Manager

Resource Manager automates deployment and operations for all Oracle Cloud Infrastructure resources. Using the infrastructure-as-code (IaC) model, the service is based on Terraform, an open source industry standard that lets DevOps engineers develop and deploy their infrastructure anywhere

1. 
2. 

### Task 2 OCI Streaming Service

The Oracle Cloud Infrastructure Streaming service provides a fully managed, scalable, and durable solution for ingesting and consuming high-volume data streams in real-time. Use Streaming for any use case in which data is produced and processed continually and sequentially in a publish-subscribe messaging model.

### Task 2 OCI OKE

Oracle Cloud Infrastructure Container Engine for Kubernetes is a fully-managed, scalable, and highly available service that you can use to deploy your containerized applications to the cloud. Use Container Engine for Kubernetes when your development team wants to reliably build, deploy, and manage cloud-native applications. You specify the compute resources that your applications require, and Container Engine for Kubernetes provisions them on Oracle Cloud Infrastructure in an existing OCI tenancy.


### Task 3 Verify OCI Object Storage

Oracle Cloud Infrastructure Object Storage service is an Internet-scale, high-performance storage platform that offers reliable and cost-efficient data durability. The Object Storage service can store an unlimited amount of unstructured data of any content type, including analytic data and rich content, like images and videos.

With Object Storage, you can safely and securely store or retrieve data directly from the Internet or from within the cloud platform. Object Storage offers multiple management interfaces that let you easily manage storage at scale.

Object Storage is a regional service and is not tied to any specific compute instances. You can access data from anywhere inside or outside the context of Oracle Cloud Infrastructure.

1. Click the Navigation Menu in the upper left, navigate to **Storage**, and select **Buckets**.
![Buckets]()
2. Select the compartments
3. Open the bucket **ad_bucket**