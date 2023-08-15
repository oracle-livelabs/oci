# Setting up Highly Available and Secure Infrastructure with Terraform

## Introduction

This lab walks you through how to set up Terraform to define a comoute instance in OCI. 

Estimated Time: 20 minutes

### About Compute Service
Oracle Cloud Infrastructure Compute lets you provision and manage compute hosts, known as instances. You can define instances as needed to meet your compute and application requirements.

### Objectives

In this lab, you will:
* Learn how to use/setup Terraform
* Learn how to provision OCI resources through Terraform

This lab assumes you have:
* An Oracle Cloud account
* Familiarity with Networking is desirable, but not required
* Some understanding of cloud, networking, Terraform
* Familiarity with Oracle Cloud Infrastructure (OCI) is helpful

## Task 1: SSH Keys and Image OCIDS

**1. SSH Keys**
  In terraform.tfvars, at the top of the file we have set the location of our SSH keys for us to access our instances. 

  ```
  <copy>
  ssh_public_key  = "<replace-public-sshkeypath-here>"
  ssh_private_key = "<replace-private-sshkeypath-here>"
  </copy>
  ```

  Copy and paste the following in the ssh_keys data structure. 

  Provide the path to your SSH keys.
  
  After editing, it would be similar to this. 

  ![ssh-path](images/ssh-path.png)

  **2. Image OCIDs**

  Next we will be providing our Image OCID. 

  An Image OCID is how Oracle Identifies a specific image to a specific region. 

  Dependent on where you are provisiong your resources you will identify the correct Image OCID. 

  For this example we will use the US Pheonix Region. 

```
<copy>
us-phoenix-oel7 = "replace-phoenix-oraclelinux7-image-ocid"
</copy>
```

For other regions
```
<copy>
country-region-oel7 = "replace-region-oraclelinux7-image-ocid"
</copy>
```
Copy and paste the following to the Image OCIDs section of the terraform.tfvars file.

In this [Documentation](https://docs.oracle.com/en-us/iaas/images/image/266adc03-7428-41fc-b17d-2f88ea56dff0/), you will be able to find Image OCIDs for Oracle Enterprise Linux 7. 

We will search for the Pheonix Region and find the Image OCID. 

![image-ocid](images/image-ocid.png)

We were able to find and implment our Image OCID needed to define out compute instances. Image OCIDs are software with configurations needed to launch our instances.

After entering your Image OCID, you should have something similar to this. 

![image-ocid-tf](images/image-ocid-tf.png)

## Task 2: Understanding The Bastion Variables

**1. Define the Bastion**

  A Bastion is a way to provide secure and monitored access for authorised users while preventing unauthorised users access. It acts as a single point of entry to reduce attack surface and provide security.

  We will use this bastion we define to access our webservers. 

  In terraform.tfvars, we are going to edit the Bastion Host Specifications. Copy this code block into the bastion data structure in terraform.tfvars file.
  ```
  <copy>
  compartment_data     = "comp-ocid"                     
  subnet_name          = "pub-subnet-oci-WebBastion-vcn" 
  ssh_public_key       = "ssh_public_key"                
  ssh_private_key      = "ssh_private_key"               
  display_name         = "replace-bastion-name-here"                      
  shape                = "replace-bastion-shape-here"               
  version              = "replace-bastion-version-here"                     
  ad                   = replace-ad-here                              
  fault_domain         = replace-fd-here                              
  boot_volume_size     = replace-bv-size-here                             
  preserve_boot_volume = replace-bv-perserve-true-or-false-here                         
  assign_public_ip     = replace-public-assign-true-or-false-here                            
  freeform_tags        = {}
  </copy>
  ```

**2. Edit The Bastion Host Specifications**

  We will be replacing the variables needed to define a compute instance. 

  Editing these varibales are the same as editing it the instance on the OCI console.

  When you define an instance on the OCI Console you start by giving it a name (refered as "display_name" in terraform code).

  ```
  display_name         = "bastion"
  ```

  Next we determine its shape.

  A shape of an instance is a predefined virtual machine (VM) configuration that has the number of CPUs, amount of memory, and other characteristics of the VM instance. In this case we will be using a Standard shape, which is suitable for our bastion host.

  Here is a list of different [Shapes](https://docs.oracle.com/en-us/iaas/Content/Compute/References/computeshapes.htm) in OCI.

  ```
  shape                = "VM.Standard2.1"
  ```

  The Operating System or OS (refered as "version" in our code) is the software that is going to be running the instance. In Task 1, we sought our image already and we determined that an Image OCID is required for a specific region. Since we are provisioning in the pheonix region we will use our **'us-pheonix-oel7'** oracle linux image OCID.

  Here is a list of different [Images](https://docs.oracle.com/en-us/iaas/images/).

  ```
  version              = "us-phoenix-oel7"
  ```
  
  Next we can decide which Availability Domain (AD) and Fault Domain (FD). 
  
  Availability Domains are Data centers within a region that are physically isolated from each other. These AD's have their own power, colling and networking. 
  A Fault Domain is is a grouping of hardware and infrastructure within an availability domain. Each availability domain contains three fault domains.

  All regions vary in how many Availability Domains they have to offer. For example the pheonix region has 3 Availiabilty Domains.<br>
  Here we have the option to place it in the 1st, 2nd, or 3rd AD. If it was in another region like Sydney, there would only be one AD.

  Here is a list of [Regions and Availability Domains](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm)

  ```
  ad                   = 1
  fault_domain         = 1
  ```

  **Note**

  If you set your ad to the 3rd Availability Domain and the region only supports 1. The instance will **NOT** be defined and Terraform will throw an error during execution. 

  ```
  ad = 3
  ```

  A Boot Volume contains the operating system and other files needed to boot the instance.

  Here is more info on [Boot Volumes](https://docs.oracle.com/en-us/iaas/Content/Block/Concepts/bootvolumes.htm)

  ```
  boot_volume_size     = 50
  ```

  The preserve status determines if the boot volume lives after the instance is terminated. If set to false it will deleted along with the instance. Else it will be retained which can be useful when keeping important data or configurations. 

  ```
  preserve_boot_volume = false
  ```
  
  Lastly we will determine if we assign the Bastion a public ip. In this case we will assign a public ip as we are going to be using the Bastion as a single point of entry to our webservers.
  
  ```
  assign_public_ip     = true
  ```

  After editing you should have something similar to this. 

  ![Image alt text](images/bastion.png)

## Task 3: Understanding The Webserver Variables

**1. Define The Webservers**

In this section we will be editing the webservers. As we defined our Bastion before. We will define our webserver in a similar fashion. However, we are **not** going to assign a public ip to our webservers. Hence we have the bastion to help us access them in a secure manner. 

In terraform.tfvars, we are going to edit the Webserver Specifications. Copy this code block into each webserver data structure in terraform.tfvars file.

```
<copy>
compartment_data     = "comp-ocid"                     
subnet_name          = "pub-subnet-oci-WebBastion-vcn" 
ssh_public_key       = "ssh_public_key"                
ssh_private_key      = "ssh_private_key"
webserver_data       = "webserver01"           
display_name         = "replace-webserver1-name-here"                      
shape                = "replace-webserver1-shape-here"               
version              = "replace-webserver1-version-here"                     
ad                   = replace-ad-here                             
fault_domain         = replace-fd-here                              
boot_volume_size     = replace-bv-size-here                             
preserve_boot_volume = replace-bv-perserve-true-or-false-here                          
assign_public_ip     = replace-public-assign-true-or-false-here                            
freeform_tags        = {}
</copy>
```

**2. Edit The Webserver Specifications**

Similarly how we defined our Bastion we will define our webservers

We will give it a ```display_name```. For example ```webserver01``` is simple and easy to track.

```
display_name         = "webserver01"                                       
```

we will determine the ```shape``` of the webserver. We will be using a ```VM.Standar2.1```.

```                
shape                = "VM.Standard2.1"                                       
```

Next is the ```version```. In this example we are provisioning in the Phoenix region, we will be using ```us-phoenix-oel7```.

```            
version              = "us-phoenix-oel7"                                              
```

For our Availability Domain and Fault Domain we will assign it to 1.

```                     
ad                   = 1                             
fault_domain         = 1                                                    
```

Boot Volume size is set to 50 and we will not be perserving it.

```                            
boot_volume_size     = 50                             
preserve_boot_volume = false                                                   
```

We will **not** be assinging our webservers a public ip.

```                       
assign_public_ip     = false                            
```

**Note**
* As we mentioned to make our webservers secure, we will be using the Bastion as a single point of entry to our webservers

After editing all three servers, you should have the following

**Webserver01**
![webservers](images/webservers.png)

**Webserver02**
![webservers02](images/webservers02.png)

**Webserver03**
![webservers03](images/webservers03.png)

## Understanding Modules

In Terraform, modules are a way to organize and encapsulate related resources and configurations into reusable and shareable components. They allow you to break down your infrastructure code into smaller, manageable units, promoting code reusability, maintainability, and collaboration.

A module in Terraform consists of a collection of Terraform configuration files grouped together in a directory. These configuration files define resources, variables, outputs, and other elements just like the main Terraform configuration files. However, modules are designed to represent a specific piece of functionality, such as a compute instance, a network setup, or an application deployment. We have used this concept to help promote reusability with our code.<br>
A module encapsulates a set of resources and variables within a defined namespace. 

In the terraform environment you have a folder called modules.

![modules](images/modules.png)

In the modules folder there are three modules being used to create resources on OCI. The network module creates all the networking resources such as the Virtual Cloud Network and the Load Balancer resources. Below is the list of resources created by the network module. While the bastion module creates resources needed to succefully create a Bastion instance that can access the Web servers being created through Terraform. Lastly, the webservers module creates compute instances and deploys Apache server for each instance.

<!--
The network module creates all the networking resources such as the Virtual Cloud Network and the Load Balancer resources. Below is the list of resources created by the network module.
* Virtual Cloud Network (VCN)
* Private and Public Subnets
* Private and Public Security lists
* Private and Public Route Tables
* Internet Gateway
* Nat Gateway
* Service Gateway
* Load Balancer

The bastion module creates resources needed to succefully create a Bastion instance that can access the Web servers being created through Terraform.  Below is the list of resources created by the bastion module. 

The webservers module creates compute instances and deploys Apache server for each instance. Below is the list of resources created by the webservers module.
-->
Every module contains a main.tf, output.tf, and variables.tf file.

* The main.tf file is where resources and configurations are created based on the definitions provided in the terraform.tfvars file.
* The variables.tf file is where input variables for the modules are defined.
* The output.tf file defines output values that are outputed once Terraform is deployed.

<!--
In the variables.tf file, we can see that it has a Data Structure with a Data Block mapping the parameters needed to provision a bastion.

![bastion-params](images/bastion-params.png)

In the main.tf file we see how to define the bastion instance using the defined bastion parameters. 

![define-bastion](images/define-bastion.png)
-->

Within each module there are a set of data structures that declare resources using the Oracle Cloud Infrastructure provider. Lets break down the declaration of a resource structure.

Navigate to the modules folder and open the main.tf folder located in the network module. In the main.tf folder navigate to the oci\_core\_virtual\_network resouce data structure. 

![datastruct](images/datastruct.png)

The following keywords are used to declare a resource within Terraform.

1. resource: This keyword signifies a resource declaration data structure in Terraform. Resources are entities that Terraform manages and provisions in OCI. They can represent various components, such as virtual machines, networks, storage, and more.

2. oci\_core\_virtual\_network: This keyword signifies the resource type in Terraform based the provider being used by the Terraform environment. The exact resource type corresponds to the OCI service and resource you want to manage using Terraform. In this case, the resource type is a OCI Virtual Cloud Network.

3. vcn: This keyword signifies the local name or identifier assigned to the resource block. It's a reference that is used within the Terraform configuration to interact with or refer to this specific resource. This identifier helps distinguish multiple resources of the same resource type within the Terraform configuration.

Putting it all together, the code line resource "oci\_core\_virtual\_network" "vcn" means that you're declaring a Terraform resource block to manage an OCI Virtual Cloud Network. 

Within the curly brackets there are arguments for this virtual cloud network that are used to create the resource. The arguments are values that are provided to resources to configure and customize their behavior. Arguments allow Terrafrom to tailor the settings of each component to your specific requirements, making your infrastructure code more flexible, reusable, and maintainable.

In the OCI VCN resource data structure there are four arguments that are defined based on the vaules provided in the pervious labs within the terraform.tfvars file.  

![datastruct](images/combo.png)

Throughout our code we make use of **each.value** and **for_each**. These are constructs that work together inside a resource, module and provider.

The first construct, ```for_each``` is an argument used within a resource block to itereate over elements in a map or set. 
We will use ```for_each``` to create multiple instances of a reasource, each with a unique configuartion we defined in terraform.tfvars file. Terraform will generate one instance of the resource for each key-value pair in the map or each element in the set. 

The second construct, ```each.value``` is a reference used within a resource block to represent the value associated with the current iteration of ```for_each```. It's used to dynamically set attributes of resources or modules based on the vaules from the map or set. 

In the picture below we are defining an OIC Compute Instance resource. In the resource block we see ```for_each``` being used. This will iterate over the var.```webservers_params``` map. Since we defined 3 webservers in terraform.tfvars under the ```webservers_params``` structure, it will only iterate through each webserver. 

We also see ```each.value``` being used within the resource block to reference the attributes within each webserver i.e. shape, display_name etc.

![for-each](images/for-each.png)

Next is the provisioner. A provisioner executes scripts or commands on a resource after it has been created but before it's marked fully operational. Provisioners allow you to to install software, configuration management, and data setup on a rsource.

Take note at the end of the main.tf file in the bastion module we are using the provisioner to do some actions after the resource was created. There are different provisioner types for different tasks, in this example we use the file provisioner to copy a file on to the instance. We will be copying our SSH private key onto to the Bastion. This will allow us to access our webservers.

![provisioner](images/provisioner.png)

Following this we use the remote-execution type of provisioner. The remote-execution type lets us run scripts to run commands on a remote source. Here run some commands to modify the permissions onto the file for ease of use.

![remote-execute](images/remote-execute.png)

## Learn More

* [Compute Service](https://docs.oracle.com/en-us/iaas/Content/Compute/Concepts/computeoverview.htm)
* [Oracle + Terraform](https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-compute/01-summary.htm)
* [Oracle Linux Image OCIDs](https://docs.oracle.com/en-us/iaas/images/image/266adc03-7428-41fc-b17d-2f88ea56dff0/)
* [Physical Architecture Concepts](https://docs.oracle.com/en-us/iaas/Content/GSG/Concepts/concepts-physical.htm)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Month Year>
