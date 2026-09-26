# Release Application to OCI Using GitHub Actions

## Introduction

### Objectives

* Verify that a Git push automatically triggers:

- Maven build of the Spring Boot application

- Docker image creation

- Push to OCI Container Registry (OCIR)

- Deployment to OCI Container Instances

- Load Balancer traffic cutover

- Zero-downtime replacement of the running version

### Prerequisites (Optional)

This lab assumes you have:
* An active GitHub account
* IntelliJ IDEA installed (Community or Ultimate edition)
* Basic familiarity with the command line

## Task 1: Make a Small Application Change

Edit any file in the Spring Boot project, for example:

```
   "variables": ["../../variables/variables.json",
                 "../../variables/variables-in-another-file.json"],
```

## Task 2

Specify the variables in the .json file like this:

*Example: variables.json*
```
{
    "var1": "Variable 1 value",
    "var2": "Variable 2 value",
    "random_name": "LiveLabs rocks!",
    "number_of_ocpu_paid": "24"
    "number_of_ocpu_always_free": "2"
 }
 ```

You can also add multiple files that specify variables (see the example in Task 1).

 *Example: variables_in_another_file.json*
```
{
    "var11": "Variable 1 value but yet different",
    "var22": "Variable 2 value is different",
    "random_name2": "LiveLabs rocks & rules!",``
    "name_of_database": "My-Database-Name-is-the-best",
    "magic": "What is 2*2?"
 }
 ```

## Task 3

Now, you can refer to those variables using the following syntax (**Please note that you can see the syntax only in markdown**):

[](var:var1)

or

[](var:magic)


### Examples

(Check the markdown to see the syntax - the bold text is the value of the variable)

- Do you know math? This is **[](var:magic)**

- How many OCPUs do I need to run this service in my paid tenancy? You need **[](var:number_of_ocpu_paid)**

- But what if am using 'Always free'? Then you need **[](var:number_of_ocpu_always_free)**

- What is the best name for my database? It is **[](var:name_of_database)**

- Here you can find more info: **[](var:doc_link)**
