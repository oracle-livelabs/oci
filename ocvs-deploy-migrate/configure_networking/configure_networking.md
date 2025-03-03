## Task 1 - Create VCN

To Create a VCN on Oracle Cloud Infrastructure:

1. On the Oracle Cloud Infrastrucutre Console homepage, on the top left you will find the hamburger menu.

    ![hamburger menu](images/hambuger.png)

2. Select **Networking**, and then **Virtual cloud networks**.

    ![Networking](images/networking.png)

    Here!!!

3. Select the **compartment** next to the **Applied filters**. Ensure you are in the correct compartment to deploy your VCN.

    ![Compartment](images/compartment.png)

4. Select the **Actions**, and then **Start VCN Wizard**. Select **Create VCN with Internet Connectivity** and **Start VCN Wizard**.

    ![VCNwizard](images/vcnwizard.png)

5. The VCN Wizard will help provision, a VCN, a Public and Private Subnet, an Internet Gateway, NAT Gateway, and a Service Gateway. We will start by giving the VCN a name,

    ```
    <copy>
    ocvs-livelab
    </copy>
    ```

    next, you will provide the **IPv4 CIDR Blocks**,

    ```
    <copy>
    172.16.0.0/16
    </copy>
    ```

    ![vcnname](images/vcnname.png)

6. Add the **IPv4 CIDR Blocks** for the Public and Private subnets,

    ```
    <copy>
    172.16.0.0/24
    </copy>
    ```

    ```
    <copy>
    172.16.1.0/24
    </copy>
    ```

    click next to review and create.

    ![VCN](images/subnets.png)

## Task 2 - Configure Security Rules and Routing

1. After provisioning your VCN. Click **View VCN**.

![provisioned](images/provisioned.png)

2. Click on **Security** on the VCN details page and click on **security list for private subnet-ocvs-livelab**. Here will configure the Security Rules.

    ![securitylist](images/securitylist.png)

3. Click on **Security rules** and then **Add Ingress rules**.

    ![ingressrule](images/ingressrule.png)

    Here we will add the **Source CIDR** and **Port** to allow access through TCP for the jump server.

    ```
    <copy>
    172.16.0.0/16
    </copy>
    ```

    ```
    <copy>
    3389
    </copy>
    ```

    ![port3389](images/port3389.png)

4. Next we'll verify that our routing rules are correct. Click on the **Routing** and then on **route table for private private subnet-ocvs-livelab**.

    ![routing](images/routing.png)

    Verify the rules for the NAT and Service Gateways. The NAT Gateway will gives cloud resources without public IP addresses access to the internet without exposing those resources to incoming internet connections. A service gateway lets resources in your VCN privately access specific Oracle services, without exposing the data to an internet gateway or NAT.

    ![gateways](images/gateways.png)

5. Finally, verify the rules for the Internet Gateway. Click on the **Routing** and then on **default route table for ocvs-livelab**

    ![internetgateway](images/internetgateway.png)

    An internet gateway is an optional gateway you can add to your VCN to enable direct connectivity to the internet.

    ![internetrules](images/internetrules.png)

## Task 3 - Deploy Bastion and Jump Server Instance

1. We will be deploying a Bastion first, a Bastion instance allows you to access to the private subnet we created in the last task. Lets start by going to the hamburger menu on the top left, click on **compute** and then **instances**.

    ![instance](images/instance.png)

2. Click on **Create Instance**. Fill in the **name** for the bastion host and ensure that your in the correct **compartment**.

    ![bastioninfo](images/bastioninfo.png)

3. Click on **change image**, select Oracle Linux

    ![changeimage](images/changeimage.png)

    select **Oracle Linux**,

    ![linux](images/linux.png)

    select the Oracle linux 8 image and click **Select image**.

    ![linuximage](images/linuximage.png)

4. Next, we will be selecting the shape for our bastion. Click on **Change shape**. 

    ![changeshape](images/changeshape.png)

    Select the following; 

    **Instance type**

    ```
    Virtual machine
    ```

    **Shape series**

    ```
    AMD
    ```

    **Shape name**

    ```
    VM.Standard.E4.Flex
    ```

    and click on **Select shape** when finished.

    ![linuxshape](images/linuxshape.png)

5. Click **Next** to get to task 3 to set up networking for the bastion host. For the Primary networking we will be using the existing VCN we created in task 1. Ensure that you using the correct **compartment** were you created the VCN. We will also be using the existing public subnet we created in task 1.

    ![bastionsubnet](images/bastionsubnet.png)

6. Next we will upload our SSH public key file, select **Upload public key file (.pub)**, drop your key inside the box and select **Next** to move on to storage, which we leave at default.

    ![bastionssh](images/bastionssh.png)

7. Review your compute instance and click **Create** after reviewing.

    ![bastionreview](images/bastionreview.png)

    After creation please take note of the **Public IP address** in the details page of the bastion host instance.

    ![bastionip](images/bastionip.png)

8. We will repeat the process for the jump server, however the difference is we will be using the **Windows Server 2022 Standard Core Image**,

    ![windows](images/windows.png)

    and placing it in our **private subnet** we created.

    ![windowssubnet](images/windowssubnet.png)

# Congratulations!
# You may procede to the next lab!

## Learn More



## Acknowledgments

* **Author:** Vijay Kumar
, Cloud Engineering OCVS
* **Contributors:** 
    - Chris Wegenek, Cloud Engineering
    - Karthik Meenakshi Sundaram, Cloud Engineering
    - Germain Vargas, Cloud Engineering

* **Last Updated By/Date:** Germain Vargas, Cloud Engineering, February 2025