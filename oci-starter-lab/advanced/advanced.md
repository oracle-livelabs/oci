
# Advanced Topics

When you enable the *Advanced* option, you can do additional things:
![Advanced](images/starter-advanced.png =100%x*)

## Resource Manager

Instead of using the command line Terraform, you can use Resource Manager (a Terraform Managed Service on OCI) to create the infrastructure

[More info: see docs.oracle.com > Concept > Resource Manager](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Concepts/resourcemanager.htm)

![Advanced](images/starter-advanced-resource-manager.png =30%x*)

## Existing Resources

To use resources that are already existing in your OCI Tenant (Database, OKE, Network)
- Network VCN, Subnet
- Database
- OKE

Please do this:
1. Enable the Advanced topic
2. Choose the checkbox to use the corresponding type of resource
3. The zip will not contain Terraform scripts to create the resources, but ask you to fill the OCID of the existing resources before to build the application

![Advanced](images/starter-advanced-existing.png =30%x*)

## Java VM - JDK / GraalVM JIT / GraalVM Native

You can choose other Java VM to run your program:

![Advanced](images/starter-advanced-javavm.png =50%x*)

- GraalVM EE JIT has the the following advantages:
    - Faster (20-30%)
    - Java Native Compilation
    - Polyglot  
    - [More info: see https://wwww.graalvm.org](https://www.graalvm.org)
- GraalVM EE Native compiles the Java program in binary format or Native executable. With the following advantages:
    - Very fast startup (in few milliseconds)
    - Low memory consumption
    - These advantage come also with a long time to compile. So, it is better to first start first with JIT (JDK or GraalVM). Then to compile with GraalVM Native
    - [More info: see https://www.graalvm.org/22.0/reference-manual/native-image/](https://www.graalvm.org/22.0/reference-manual/native-image/)

## Acknowledgements 
- **Author**
    - Marc Gueury
    - Ewan Slater 

- **History** - Creation - 30 nov 2022