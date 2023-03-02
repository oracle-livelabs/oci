# Lab 2: Configure Variables for Basic Deployment

You should be on the __Configure Variables__ page as defined by the left side-menu. What this page does is allow us to define variables that would otherwise be defined in the [quickstart-input.tfvars](https://github.com/oracle-quickstart/oci-cis-landingzone-quickstart/blob/main/config/quickstart-input.tfvars) file in the main project. Resource Manager is translating the fields from the config file into a more friendly GUI for usability.

## Sections

### Environment

This section sets general environmental configurations for the Landing Zone. Inputs from this section will control fundamental parts of the Landing Zone. For this lab, we will only work with a few of these options, which will be explained below.

1. The first field to check is the __Region__. Most likely, your current region is entered here automatically. If you want to deploy into another region, just select the appropriate value from the drop-down menu. You must be [subscribed to the region](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/managingregions.htm#uconsole) prior to deployment.
2. The second field is __Service Label__. This service label will be prepended to everything created by the Landing Zone. As such, we need to choose a succinct value to enter. The requirements for service labels are 2-8 characters, the first being a letter, and last 2-8 characters being either a letter or number. If you violate these rules, the field will let you know.
3. The third field is __CIS Level__. There are two levels of CIS compliance to choose from. These levels correspond to requirements found in the [CIS OCI Foundations Benchmark v1.2](https://www.cisecurity.org/benchmark/oracle_cloud/). To see a full list of changes between CIS Levels 1 & 2, please refer to the benchmark. The high level summary is that CIS Level 2 requires more strict encryption necessitating the creation of an [OCI Vault](https://docs.oracle.com/en-us/iaas/Content/KeyManagement/Concepts/keyoverview.htm) and encryption keys. __We will use CIS Level 1 for this lab__.

![The Environment Menu Options](images/environment_menu.png "Environment Menu")_Note that the invalid service label is triggering an error message_

One optional setting that we recommend in enterprise tenancies is the _Enclosing Compartment_ selection. Selecting a compartment from the drop down menu will create the Landing Zone inside the selected compartment. This allows for multiple Landing Zones to be used in a tenancy. This is useful for creating separate Dev/Test/Production environments in a single OCI tenant. Each Landing Zone will be able to support independent group memberships and permission structures via this mechanism.

_Using an Enclosing Compartment is optional in this lab, but useful for following best practices._
![An Enclosing Compartment is Selected](images/enclosing_compartment.png "Enclosing Compartment")

### Networking - Generic VCNs

This section controls the creation of generic Virtual Cloud Network (VCN) resources. The Landing Zone by default will deploy a 3-tier network containing Web, App, and Database subnets. VCNs support IP CIDR ranges of /16 to /30.

__The default value of 10.0.0.0/20 will work__, and is large enough to fit most use cases. For this lab, only change this value if you know what you are doing.

Check the __Advanced Options__ checkbox to view further configurations. Give your VCN a custom name under __VCNs Custom Names__.

![Generic VCN Configurations](images/generic_vcn.png "Generic VCN")

### Networking - Exadata Cloud Service VCNs to Networking - Connectivity to On-Premises

We will not be covering these sections yet. Leave them as-is.

### Events and Notifications

There are two required notification contacts as required by CIS Controls. An email address for a network admin and a security admin. Once created, these addresses will receive a confirmation email letting the person on the other end know that they are signed up for these notifications. Upon validating that they want to continue receiving the notifications, they will be sent messages when a network or security (IAM) object is created, modified, or destroyed. There can be multiple endpoints for each service to allow for redundancy if specifying the addresses of individuals. More often than not, these notifications go to shared inboxes for their respective teams.

There are further endpoints defined for admins of other services, but these are not mandatory under the CIS benchmark. For this lab, we will not need them.

__Enter your email in the _Network Admin Email Endpoints_ and _Security Admin Email Endpoints_.__

![Events and Notifications Options](images/events_notifications.png "Admin Endpoints")

### Object Storage

Leaving the _Enable Object Storage bucket_ checkbox selected will create an Object Storage Bucket in the AppDev compartment of the Landing Zone. This is largely as a demonstration of where generic application data should reside in the Landing Zone compartment structure.

Leave the box checked for this lab.

![Object Storage Option](images/object_storage.png "Object Storage Bucket Checkbox")

### Cloud Guard

Leave the _Enable Cloud Guard Service?_ button unchecked. Cloud Guard is a Cloud Security Posture Management tool that is free to use for paid accounts. If Cloud Guard already has targets set, checking this box will cause the deployment to fail. If you are using a free tier account, Cloud Guard is not included and the deployment will fail.

We recommend using Cloud Guard if eligible. For the purposes of this lab, we are not going to use it with the Landing Zone.

### Security Zones, Logging Consolidation, Vulnerability Scanning, and Cost Management

All are useful tools, but for the sake of starting simple will not be a part of the labs.

### Finishing Up

Click __Next__ to continue to the review page. Quickly double check the variables entered.

__Leave the _Run apply_ button unchecked__.

![Apply Button](images/apply_button.png "Leave it unchecked")

Click the __Save Changes__ button when finished.

## Next Step

Create, review, and apply a deployment plan.
