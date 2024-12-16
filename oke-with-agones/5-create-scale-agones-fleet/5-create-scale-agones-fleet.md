# Deploy an Agones Fleet and Autoscale OKE Nodes

You will deploy an Agones fleet and observe your configured OKE Autoscaler create more nodes to meet the demand of the Fleet.

## Introduction

In this lab you will leverage the OKE cluster you created in previous labs and deploy an Agones Fleet of dedicated game servers using YAML and kubectl.  Once this Fleet is deployed, you will then scale the Fleet and observe OKE nodes auto scale to meet the scheduling demand of a large amount of pods that make up the fleet.  Once completed, you will scale down the fleet and observe the autoscaling OKE node pool scale down as well.

Estimated Time: 25 minutes

Objectives
In this lab, you will:
 - Deploy an Agones Fleet of Agones GameServers
 - Scale up the Fleet
 - Watch and troubleshoot scaling pods and nodes

Prerequisites
 - Completed the previous lab which deployed the Agones system pods

## **Task 1**: Create an Agones Fleet

You will deploy an Agones Fleet of dedicated game servers.

1. SSH to your Operater using the output from `terraform output`, example below.

    ```bash
    ssh -J opc@<bastion public IP> opc@<operator private ip>
    ```

2. Create a file called `fleet.yaml` with the contents from `files/fleet.yaml`.  This was sourced from [Agones v1.45.0](https://raw.githubusercontent.com/googleforgames/agones/release-1.45.0/install/yaml/install.yaml). The changes made here ensure that game servers get deployed to the matching label on our node as defined in your `module.tf` file.

    ```bash
    # using vim or nano
    vim fleet.yaml

    # paste from files/fleet.json into this new file and save
    ```

3. Apply the fleet

    ```bash
    kubectl apply -f fleet.yaml
    ```

4. Verify the game servers are running, you should see pods with public IP addresses with each having their own port.

    ```bash
    kubectl get gameserver
    ```

5. To actually use these game servers in production, the typical use case would be to have your match making server return to game clients the IP and port to connect to and leverage the Agones Allocator to create new on demand game servers.

## **Task 2**: Scale the Fleet and Node Pool

You will now scale the Agones Fleet and watch the node pool auto scale.

1. Scale the fleet to 300, this will trigger node autoscaling as the required resources to run 300 game servers cant be achieved with the current size of the worker node pool.

    ```bash
    kubectl scale fleet simple-game-server --replicas=300
    ```

2. After a few moments, get the `gameserver`'s and nodes, you should see a lot of `gameserver`'s in Starting or Pending state, and a new node starting up automatically for us.  Initially you will see the node pool in the console updating as well and new compute instances being added to the node pool before they start to show in `kubectl get nodes` results.

    ```bash
    # grep for pods that have 0 containers running
    kubectl get pods |grep 0/2

    # similarly, view the gameserver ip's and status
    kubectl get gameserver
    ```

3. To troubleshoot, get the status of a given pod that is NOT running, ideally you should see an Event that says "pod triggered scale-up" and you can skip the next numbered step here.  If you don't see that event the next step should be looked at.

    ```bash
    kubectl describe pod <pod name>
    ```

4. You may have issues with the pod not triggering autoscaling.  If so, make sure your addon was installed and configured to watch the correct node pool OCID (see previous lab) and that your `fleet.yaml` has the correct affinity settings (see steps above)

5. After some time you should see new nodes listed with a much younger value for age.

    ```bash
    kubectl get nodes
    ```

6. Once the new nodes are fully running, we should see zero pods listed when we run our list and grep command again.

    ```bash
    # grep for pods that have 0 containers running
    kubectl get pods |grep 0/2
    ```

7. Now scale down.

    ```bash
    kubectl scale fleet simple-game-server --replicas=3
    ```

   We should now see `gameserver`'s automatically start to be removed and put into Shutdown status.  Nodes wont scale down unless minimums are met, one minimum is that the node must have been running for 10 minutes, also if you have other workloads deployed they must not prevent themselves from eviction (Agones game servers by default will not be evicted unless you scale down the fleet first).

7. After some time, we should see the nodes start to disappear according to the [scale down rules of the autoscaler](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#how-does-scale-down-work).

    ```bash
    kubectl get nodes
    ```

8. Lastly, it's important to keep in mind the custom work that is needed to coordinate user demand of your game servers, the type of game servers you will run and the scaling of the fleet.  We manually scaled the fleet via the CLI, but, you should integrate that with on demand or predictable game server allocation.  When doing that the scaling of the nodes itself will be automatic.

## **Summary**

You deployed and Agones fleet with affinity for a node pool that is dedicated to running dedicated game servers.  You then scaled the fleet and watched as new pods were being scheduled.  While waiting on scheduling to complete you saw new nodes added to the node pool to serve the scheduled demand of the scaled up Fleet.

## Learn More - *Useful Links*

- [Agones](https://agones.dev/site/docs/)
- [Kubernetes](https://kubernetes.io/)
- [OKE Autoscaler FAQ](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md)

## **Acknowledgements**

 - **Author** - Marcellus Miles, Master Cloud Architect
 - **Last Updated By/Date** - Marcellus Miles, Dec 2024