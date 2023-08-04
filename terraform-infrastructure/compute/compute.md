# Setting up Highly Available and Secure Infrastructure with Terraform

## Introduction

This lab walks you through how to set up Terraform to create a comoute instance in OCI. 

Estimated Time: 20 minutes

### About Compute Service
Oracle Cloud Infrastructure Compute lets you provision and manage compute hosts, known as instances. You can create instances as needed to meet your compute and application requirements.

### Objectives

In this lab, you will:
* Learn how to use/setup Terraform
* Learn how to provision OCI resources through Terraform

This lab assumes you have:
* An Oracle Cloud account
* Familiarity with Networking is desirable, but not required
* Some understanding of cloud, networking, Terraform terms is helpful
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

After entering your Image OCID, you should have something similar to this. 

![image-ocid-tf](images/image-ocid-tf.png)

## Task 2: Understanding the Bastion Variables

**1. Create Bastion**

  A Bastion is a way to provide secure and monitored access for authorised users while preventing unauthorised users access. It acts as a single point of entry to reduce attack surface and provide security.

  We will use this bastion we create to access our webservers. 

  In terraform.tfvars, we are going to edit the Bastion Host Specification. 
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
  Copy and paste the following in to your .tfvars file. 
  

**2. Edit Bastion Host Specifications**

  We will be replacing the variables needed to create a compute instance. 

  ```
  <copy>
  display_name         = "bastion"
  shape                = "VM.Standard2.1"
  version              = "us-phoenix-oel7"
  ad                   = 1
  fault_domain         = 1
  boot_volume_size     = 50
  preserve_boot_volume = false
  assign_public_ip     = true
  </copy>
  ```

  After editing you should have something similar to this.

  ![Image alt text](images/bastion.png)

## Task 3: Understanding the Webserver Variables

**1. Create Webservers**

In this section we will be editing the webservers. As we created our Bastion before we will create our webserver in similar fashion. However, we are **not** going to assign a public ip to our webservers. Hence we have the bastion to help us access them in a secure manner. 

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

Copy and paste this on each webserver under the Webserver specifications.

**2. Edit Webserver Specifications**

We will replace the variables needed to create our webservers. 

```
<copy>
display_name         = "webserver01"                      
shape                = "VM.Standard2.1"               
version              = "us-phoenix-oel7"                     
ad                   = 1                             
fault_domain         = 1                              
boot_volume_size     = 50                             
preserve_boot_volume = false                          
assign_public_ip     = false                            
</copy>
```

After editing all three servers, you should have the following

**Webserver01**
![webservers](images/webservers.png)

**Webserver02**
![webservers02](images/webservers02.png)

**Webserver03**
![webservers03](images/webservers03.png)

## Learn More



* [Compute Service](https://docs.oracle.com/en-us/iaas/Content/Compute/Concepts/computeoverview.htm)
* [Oracle + Terraform](https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-compute/01-summary.htm)
* [Oracle Linux Image OCIDs](https://docs.oracle.com/en-us/iaas/images/image/266adc03-7428-41fc-b17d-2f88ea56dff0/)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Month Year>
