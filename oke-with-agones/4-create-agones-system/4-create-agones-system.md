# Create the Agones System Pods with Helm

In this lab you will deploy Agones using Helm and test UDP connectivity to a dedicated Agones game server.

## Introduction

You will install the Agones components into your OKE cluster using Helm.  This will deploy pods for Agones itself such as its Allocator and other services.  You will also quickly deploy a single dedicated game server that you will use to test UDP connectivity to the public node pool that serves UDP.

Estimated Time: 15 minutes

Objectives
In this lab, you will:
 - Install Agones by using Helm
 - Install an Agones dedicated game server
 - Make a test connection to the game server

Prerequisites
 - Completed the previous labs

## **Task 1**: Install Agones Helm Chart

In this task you will create Agones components and create LoadBalancer services for the Allocator and Ping HTTP Service.  No games or game servers are deployed in this step. Note that Agones respects the node labels we set in `module.tf` so the end result is the agones system pods all run on a node pool separate from the worker node pool and separate from the autoscaler node pool.

1. SSH to your Operater using the output from `terraform output`, example below.

    ```bash
    ssh -J opc@<bastion public IP> opc@<operator private ip>
    ```

2. Deploy the Agones system using Helm

    ````shell
    <copy>
    helm repo add agones https://agones.dev/chart/stable
    helm repo update

    helm install my-release --namespace agones-system --create-namespace agones/agones

    helm test my-release -n agones-system
    </copy>
    ````

3. Get the status of all the agones pods, they should all be running (allocator, controller, extensions, ping)

    ````shell
    <copy>
    kubectl get pods --namespace agones-system
    </copy>
    ````

   Example output...

    ```bash
    [opc@o-xiteaz ~]$ kubectl get pods --namespace agones-system

    NAME                                 READY   STATUS    RESTARTS   AGE
    agones-allocator-79d8dbfcbb-r5k4j    1/1     Running   0          2m23s
    agones-allocator-79d8dbfcbb-sf6bt    1/1     Running   0          2m23s
    agones-allocator-79d8dbfcbb-xk4h5    1/1     Running   0          2m23s
    agones-controller-657c48fdfd-bfl67   1/1     Running   0          2m23s
    agones-controller-657c48fdfd-gvt2m   1/1     Running   0          2m23s
    agones-extensions-7bbbf98956-bcjkk   1/1     Running   0          2m23s
    agones-extensions-7bbbf98956-tbbrx   1/1     Running   0          2m23s
    agones-ping-6848778bd7-7z76r         1/1     Running   0          2m23s
    agones-ping-6848778bd7-dg5wp         1/1     Running   0          2m23s
    ```

## **Task 2**: Test Agones with A Game Server and Client

This step can be skipped, but its a good step to test simple connectivity from game clients without having to create an Agones Fleet and before we try autoscaling, this acts as a proof of concept dedicated game server.

The steps here follow the [guide built by Agones](https://agones.dev/site/docs/getting-started/create-gameserver/).

1. From the Operator after you SSH create the game server (by default this will go into the `default` namespace and that namespace is using the `node_pool_workers` node pool)

    ````shell
    <copy>
    kubectl create -f https://raw.githubusercontent.com/googleforgames/agones/release-1.45.0/examples/simple-game-server/gameserver.yaml
    </copy>
    ````

2. Get the IP of a `gameserver` for the next step

    ````shell
    <copy>
    kubectl get gameserver
    </copy>
    ````

3. Make a UDP connection and test.  You are testing this from the Operator, which is in the private subnet.  But, you should also test this in another shell that is on the internet and you should get the same results.

    ````shell
    <copy>
    nc -u <IP of gameserver> 7043
    </copy>
    ````

4. Now type the following line and hit enter, you will see a response of `ACK: HELLO WORLD!`

    ```bash
    HELLO WORLD!
    ```

5. Delete the `gameserver` when done

    ````shell
    <copy>
    kubectl get gameserver
    kubectl delete gameserver <name of gameserver>
    </copy>
    ````

## **Summary**

You installed the Agones system pods using Helm.  You then created a dedicated gameserver deployment which exposes a UDP port.  You successfully made a UDP connection to the dedicated gameserver's public IP.

## Learn More - *Useful Links*

- [Agones](https://agones.dev/site/docs/)
- [Kubernetes](https://kubernetes.io/)
- [Helm](https://helm.sh/)

## **Acknowledgements**

 - **Author** - Marcellus Miles, Master Cloud Architect
 - **Last Updated By/Date** - Marcellus Miles, Dec 2024