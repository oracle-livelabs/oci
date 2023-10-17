
# Group sharing Common Resources

Groups allow to create "Common Resources" that you will share between several applications.
It can be:
- the Network (VCN/Subnet)
- a Kubernetes cluster (OKE)
- (optional) a database or a container database
- a bastion
- ...


But when you enable the *Advanced* option, you have 3 choices for Group: *None / New / Existing*

- An application is by default standalone. Using no group: *None*
- a new group with a first application: *New*
- or a new application to use with an existing group: *Existing*

## Architecture

### Compute

Here is the architecture of a group of applications sharing common resources with Compute

![Group Compute](images/architecture_common_compute.png =80%x*)

### Kubernetes

Here is the architecture of a group of applications sharing common resources with  Kubernetes

![Group Kubernetes](images/architecture_common_kubernetes.png =80%x*)

### Container-Instance

Here is the architecture of a group of applications sharing common resources with  Container Instance

![Group Container-instance](images/architecture_common_container_instance.png =80%x*)

### Function

Here is the architecture of a group of applications sharing common resources with Function

![Group Function](images/architecture_common_function.png =80%x*)

## Task 1: Group sharing Kubernetes and Database for several Micro-Services

### Group Common Resources and First application

- Go to https://www.ocistarter.com/
- Click on *Advanced*
- Choose Group *New* 
    - You may click on the "..." to get more explanation
- Keep the *Group Name* "dev",    
- Choose Deployment *Kubernetes*
- Click *Cloud Shell*

![Group App1](images/starter-group-app1.png =80%x*)

- Copy the command 

```
curl "https://www.ocistarter.com/app/zip?prefix=starter&group_name=dev&group_common=atp,oke&deploy=kubernetes&ui=html&language=java&database=atp" --output dev.zip
unzip dev.zip
cd dev
cat README.md
```

Notice that you have 2 directories:
- group\_common for the common resources of the group (OKE, ATP)
- starter for the application

Configure the script:
- In Cloud Shell Or Cloud Editor, edit the file *group\_common/env.sh*
- It is the exact same steps than for Kubernetes. You need to enter the TF\_VAR\_auth\_token (OCI Auth Token). Please refer lab 2 Kubernetes steps.

![Group App1 Env](images/starter-group-app1-env.png =80%x*)

- Run 

```
./build_group.sh
```

The *build\_group.sh* will first build the directory *group\_common* and then the directory *starter*.

When done, check if the application works:

```
http://123.123.123.123/starter/
```

It is also interesting to look at the created file: group\_common\_env.sh. It contains all the settings of the group.
It is reused by all applications.

## Task 2: Create a second application 

This second application will reuse the components of group: Network, Kubernetes, database.
In this case, this means that it will just create new PODS in Kubernetes.

- Change the prefix to *starter2*
- Click on *Advanced*
- Choose Group *Existing* 
- Choose *Existing Database* 
- Choose Deployment *Kubernetes*
- This time, let's choose Node as language
- Click *Cloud Shell*

![Group App2](images/starter-group-app2.png =80%x*)

```
cd dev 
curl "https://www.ocistarter.com/app/zip?prefix=starter2&deploy=compute&ui=html&language=java&database=atp" --output starter2.zip
unzip starter2.zip
cd starter2
cat README.md
```

Run the build. Itt will take the environment variables from the group\_common\_env.sh created above.

```
./build.sh
```

Test if it works. Notice, the first app is using Java, the second one NodeJS.

```
http://123.123.123.123/starter/
http://123.123.123.123/starter2/
```

Congratulation, if you reached this point, you created a group of 2 microservices using the same common resources !!

## More info

To clean up, run 
```
<copy>
./destroy_group.sh
</copy>
```

## Acknowledgements 
- **Author**
    - Marc Gueury
    - Ewan Slater 

- **History** - Creation - 30 nov 2022