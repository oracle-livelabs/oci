# Introduction

Get hands-on learning with training labs about Oracle cloud solutions. The workshops featured cover various solutions, skill levels, and categories based on Oracle Cloud Infrastructure (OCI).

Estimated time: 60 minutes

## Enterprise Scale Baseline Landing Zone

The enterprise scale landing zone provides the baseline architectural framework for your organization to deploy new projects and workloads on OCI. The landing zone consists of Terraform modules, the architectural documentation, and an implementation guide. The landing zone helps you quickly and securely create a foundation for your cloud deployment based on Oracle recommendations, customer experience, and industry-standard best practices.

The landing zone creates infrastructure that consists of compartments, networking resources, and security at the infrastructure layer. Migrating or developing workloads is not in scope for the CAF landing zone. However, setting up the right infrastructure is often the first step to migrating workloads to the cloud or developing cloud-native workloads successfully.


## Architecture

The CAF landing zone creates an architectural framework that's ready for you to launch new projects and workloads on OCI.

- Compartments: Use compartments to organize and isolate your resources to make it easier to manage and secure access to them.
    ![compartments](./../intro/images/caf-lz-compartments.svg " ")

- Tags: Use tags to organize and list resources based on your business needs.

- Budgets and alerts: Use budgets to set soft limits on your OCI spending, and use alerts to let you know when you might exceed your budget.

- Oracle Cloud Infrastructure Identity and Access Management (IAM): Use IAM to control access to your cloud resources on OCI.

- Networking and connectivity: Create a virtual cloud network (VCN), subnets, and other networking and connectivity resources that are required to run your workloads and connect to the internet or your on-premises network.
    ![vcn](./../intro/images/caf-lz-vcn.svg " ")

- Security: Enable a strong security posture by enabling OCI security services such as Oracle Cloud Guard, Oracle Vulnerability Scanning Service, and Oracle Cloud Infrastructure Bastion.
    ![security](./../intro/images/caf-lz-security-compartment.svg " ")



## Additional Recommended Resources

1. [OCI Training](https://cloud.oracle.com/en_US/iaas/training)
2. [Familiarity with OCI console](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/console.htm)
3. [Overview of Networking](https://docs.us-phoenix-1.oraclecloud.com/Content/Network/Concepts/overview.htm)
4. [Familiarity with Compartments](https://docs.us-phoenix-1.oraclecloud.com/Content/GSG/Concepts/concepts.htm)

*Please proceed to the next lab*

<!-- ## Acknowledgements

- **Author** - Kay Malcolm, Director, Product Management
- **Adapted by** -  Yaisah Granillo, Cloud Solution Engineer, NA Cloud
- **Contributors** - LiveLabs QA Team (Arabella Yao, Product Manager Intern | Isa Kessinger, QA Intern)
- **Last Updated By/Date** - Kay Malcolm, October 2020 -->

