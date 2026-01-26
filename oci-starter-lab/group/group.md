
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

### Public Virtual Machine

Here is the architecture of a group of applications sharing common resources with Public Virtual Machine

![Group Public Compute](images/architecture_common_public_compute.png =80%x*)

### Private Virtual Machine

Here is the architecture of a group of applications sharing common resources with Private Virtual Machine

![Group Private Compute](images/architecture_common_public_compute.png =80%x*)

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

Let's create a group and a first application (micro-service).

1. Go to https://www.ocistarter.com/
2. Click on *Advanced*
3. Choose Group *New* 
    - You may click on the "..." to get more explanation
4. Keep the *Group Name* "dev",    
5. Choose Deployment *Kubernetes*
6. Click *Cloud Shell*
   ![Group App1](images/starter-group-app1.png =80%x*)
7. Copy the command 
    ```
    <copy>
    curl "https://www.ocistarter.com/app/zip?prefix=starter&group_name=dev&group_common=atp,oke&deploy=kubernetes&ui=html&language=java&database=atp" --output dev.zip
    unzip dev.zip
    cd dev
    cat README.md
    </copy>
    ```
8. Notice that you have 2 directories:
    - group\_common for the common resources of the group (OKE, ATP)
    - starter for the application
9. Configure the script:
    - In Cloud Shell Or Cloud Editor, edit the file *group\_common/env.sh*
    - It is the exact same steps than for Kubernetes. Please refer to the lab "Kubernetes".
    ![Group App1 Env](images/starter-group-app1-env.png =80%x*)
10. Run 
    ```
    <copy>
    ./build_group.sh
    </copy>
    ```
    The *build\_group.sh* will first build the directory *group\_common* and then the directory *starter*.
11. When done, check if the application works:
    ```
    <copy>
    http://123.123.123.123/starter/
    </copy>
    ```
    It is also interesting to look at the created file: group\_common\_env.sh. It contains all the settings of the group.
    It is reused by all applications.

## Task 2: Create a second application 

This second application will reuse the components of group: Network, Kubernetes, database.
In this case, this means that it will just create new PODS in Kubernetes.

1. Change the prefix to *starter2*
2. Click on *Advanced*
3. Choose Group *Existing* 
4. Choose *Existing Database* 
5. Choose Deployment *Kubernetes*
6. This time, let's choose Node as language
7. Click *Cloud Shell*
    ![Group App2](images/starter-group-app2.png =80%x*)
    ```
    <copy>
    cd dev 
    curl "https://www.ocistarter.com/app/zip?prefix=starter2&deploy=compute&ui=html&language=java&database=atp" --output starter2.zip
    unzip starter2.zip
    cd starter2
    cat README.md
    </copy>
    ```
8. Run the build. It will take the environment variables from the group\_common\_env.sh created above.
    ```
    <copy>
    ./starter.sh build
    </copy>
    ```
9. Test if it works. Notice, the first app is using Java, the second one NodeJS.
    ```
    <copy>
    http://123.123.123.123/starter/
    http://123.123.123.123/starter2/
    </copy>
    ```

Congratulation, if you reached this point, you created a group of 2 microservices using the same common resources !!

## More info

1. To clean up, run 
    ```
    <copy>
    ./destroy_group.sh
    </copy>
    ```

## Acknowledgements 

* Author - Marc Gueury
* Contributors - Ewan Slater 
* Last Updated - Jan, 20th 2025