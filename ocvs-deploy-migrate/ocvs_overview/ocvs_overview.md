# Oracle Cloud VMware Solution Overview

Oracle Cloud VMware Solution (OCVS) effortlessly integrates VMware's familiar cloud environment with Oracle Cloud Infrastructure allowing you to build, run and manage VMware Software Defined Data-Center (SDDC) in your existing OCI tenancy. The solution is customer managed with complete control over VMware resources allowing you to use your existing operational tools that you already know.

Leverage OCVS to efforlessly migrate or extend you VMware-based workloads to the cloud without application re-architecting, operational changes or new product investments.

## Service Overview

- **Global Availability** OCVS is available as a cloud service across all OCI regions ensuring support for global business application needs. You can choose to deploy OCVS in any OCI region of your choice based on your specific requirements.
- **Highly Available** By default, physical servers hosting OCVS components are spread across three fault domains in an availability domain, ensuring high availability. Multi-AD deployment is also a supported option for OCI Regions with multiple availability domains.
- **Scalable** With OCVS, you can start with a single 3 node cluster and create up to 15 Clusters in an SDDC with upto 64 nodes per cluster with Dense Shapes and 32 nodes per cluster with Standard Shapes. You can scale-out or scale-in existing OCVS cluster based on you application requirements, with the flexibility of scaling compute and storage independently.
- **Flexible Compute** OCVS supports a wide range of bare metal compute shapes with Intel and AMD processors. NVIDIA A10 GPU is also available for workloads with vGPU requirements.
- **Scalable Storage** OCVS offers multiple options for application storage requirements. DenseIO Bare Metal instances support vSAN as the primary storage with OCI Block and File Storage serving as secondary storage. Standard Bare Metal shapes support OCI Block as the primary as well as secondary storage.
- **High Performance Networking** OCVS is deployed in your existing VCN with close proximity to native OCI Services, providing best in class performance by avoiding complex routing and reducing network hops. OCVS is also the only cloud VMware solution with native support for VLANs for applications that need layer 2 networking in the cloud.
- **Flexible Billing Commitments** OCVS supports hourly, monthly, 1-Year and 3-Year commitment options to support different use cases ranging from seasonal workload demands, capacity expansions, Disaster Recovery to long-term steady workloads.

## VMware Components

Oracle Cloud VMware Solution (OCVS) bundles VMware components namely ESXi, vCenter, NSX-T, vSAN and HCX to support building a fully functional Software Defined Data Center (SDDC).

- **ESXi** is the VMware's flagship hypervisor that builds the foundation for the virtualization platform.
- **vCenter** is the centralized management component to manage all hypervisor and VM operations.
- **NSX-T** provides virtual networking and security capabilities.
- **vSAN** allows the ESXi hosts to share local disks from every participating host and create a shared datastore to host virtual machines.
- **HCX** HCX is an application mobility platform which abstracts the underlying infrastructure complexisties and enables seamless workload migration between SDDCs.

## Billing Options

