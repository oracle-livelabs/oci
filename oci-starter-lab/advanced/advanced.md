
# Advanced Topics

## Introduction

When you enable the *Advanced* option, you can do additional things:
![Advanced](images/starter-advanced.png =100%x*)

## Task 1 - Resource Manager

Instead of using the command line Terraform, you can use Resource Manager (a Terraform Managed Service on OCI) to create the infrastructure

1. Check the documentation: [docs.oracle.com > Concept > Resource Manager](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Concepts/resourcemanager.htm)
2. If you prefer Resource Manager, you can set it here:
    ![Advanced Resource Manager](images/starter-advanced-resource-manager.png =30%x*)

## Task 2 - Existing Resources

You can use resources that are already existing in your OCI Tenant (Database, OKE, Network)
- Network VCN, Subnet
- Database
- OKE

Please do this:
1. Enable the Advanced topic
2. Choose the checkbox to use the corresponding type of resource
3. The zip will not contain Terraform scripts to create the resources, but ask you to fill the OCID of the existing resources before to build the application

![Advanced Existing](images/starter-advanced-existing.png =30%x*)

## Task 3 - Java VM - JDK / GraalVM JIT / GraalVM Native

You can choose other Java VM to run your program:

1. To change the Java VM. It is in the advanced screen too
   ![Advanced Java](images/starter-advanced-javavm.png =50%x*)

2. There are 3 choices: (All in version 21)
    - JDK 
        - Standard Java JDK 
    - (Default) GraalVM EE JIT has the the following advantages:
        - Faster (20-30%)
        - Java Native Compilation
        - Polyglot  
        - Fully compatible with the Standard Java JDK
        - [More info: see https://wwww.graalvm.org](https://www.graalvm.org)
    - GraalVM EE Native compiles the Java program in binary format or Native executable. With the following advantages:
        - Very fast startup (in few milliseconds)
        - Low memory consumption
        - These advantage come also with a long time to compile. So, it is better to first start first with JIT (JDK or GraalVM). Then to compile with GraalVM Native
        - [More info: see https://www.graalvm.org/22.0/reference-manual/native-image/](https://www.graalvm.org/22.0/reference-manual/native-image/)

## Task 3 - Security 

To enable login using OAuth / OpenID using your application, choose the Security / OpenID flag.

It will add needed resources in your application to configure it:
- an OCI Identity Domain Confidential App,
- and login configuration for that Confidential App inside API Gateway.

## Task 4 - HTTPS = DNS + TLS

It is nicer to have a website with a HTTPS protocol. Like https://www.ocistarter.com.

Before to start, you need 2 common attributes:
1. A DNS Zone in OCI. There is no such thing than SSL without a DNS domain.
    - Follow this doc: https://docs.oracle.com/en-us/iaas/Content/DNS/Concepts/gettingstarted_topic-Creating_a_Zone.htm
    - Note the name of the zone. 
    - In env.sh, define TF\_VAR\_dns\_zone\_name (ex: mydomain.com)
2. A DNS name for you website
    - In env.sh, define TF\_VAR\_dns\_name (ex: www.mydomain.com)

There are 4 ways to have a TLS certificate:
1. Existing Certificate.
    - You have already a existing TLS (SSL) certificate 
    - Or your administrator manage centrally all TLS certificates from OCI Certificate. 
    - Depending where is your TLS Certificate:
        - in OCI Certificate
            - In env.sh, define TF\_VAR\_certificate\_ocid=OCID of certificate OCID
        - in a directory (files cert.pem, privkey.pem, chain.pem)
            - In env.sh, define TF\_VAR\_certificate\_dir=Directory where the 3 files resides
2. Let's Encrypt - DNS-01
    - Due that DNS is enabled, let's encrypt can create a TLS Certificate using DNS-01 protocol.
    - In env.sh, define TF\_VAR\_certificate\_email to the email that will receive certificate updates from Let's encrypt.
3. Let's Encrypt - HTTP-01 (Compute Only)
    - In a compute, it is possible to generate a certificate using the HTTP-01 protocol . 
    - In env.sh, define TF\_VAR\_certificate\_email to the email that will receive certificate updates from Let's encrypt.
4. Cert-Manager (Kubernetes Only)
    - In Kubernetes, you can generate certificates using the HTTP-01 protocol with a combination of 4 tools
        - Cert-manager
        - External DNS
        - Let's Encrypt (HTTP-01)
        - NgInx Ingress Controller 
    - In env.sh, define TF\_VAR\_certificate\_email to the email that will receive certificate updates from Let's encrypt.


| Method       | To define                     | Advantages                         |
| --------     | ---------                     | ----------                         | 
| Existing     | TF\_VAR\_certificate\_ocid or TF\_VAR\_certificate\_dir   | Certificate managed centrally (*)  |
|              |                               | Private key not exposed            |
| DNS-01       | TF\_VAR\_certificate\_email   | Works for all deployment types     |
| HTTP-01      | TF\_VAR\_certificate\_email   | Works for Compute only             |
|              |                               | No LoadBalancer or API GW needed   |
| Cert-Manager | TF\_VAR\_certificate\_email   | Works for Kubernetes only          |
|              |                               | Create Certificate few lines in a .yaml file |
{: title="Summary of the advantages"}

## Acknowledgements 

* Author - Marc Gueury
* Contributors - Ewan Slater 
* Last Updated - Jan, 20th 2025