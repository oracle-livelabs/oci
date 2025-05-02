# Stress Test the Systems

## Introduction

In this lab we will work with the existing chatbot to see how the underlying system reacts to additional stress.  
If you are on a non-GPU system, this lab will not produce output using nvidia-smi. 

Estimated Time: 10 minutes


### Objectives
In this lab, you will:
- Monitor System Performance

## Task 1: Setup a Monitoring Session

1. From your local workstation, open a new tab or window in your terminal application. Then, just as we did earlier, open a new ssh session to your host. 

    ```
    cd ~/path_to_saved_ssh_directory
    
    ```

    ```
    ssh -i <private_sshkeyname> opc@<PUBLIC_IP_OF_COMPUTE>
    ```

 If needed, reference the **```PUBLIC_IP_OF_COMPUTE```** from OCI web console.  
Open **instances** from the top left corner and click on instance created in Lab 1 to copy the **public ip address**.

You should now have two ssh sessions to your host. The interactive session should still be running on the initial session.  
If it is not, please restart it using the last instructions in Lab 3. 

2.  Begin Monitoring the System  
With the interactive session still running, but not actively processing anything, we can see the toll it takes on the system.  
**In the 2nd SSH session**, run the following command:
            ```
            <copy>watch -n 1 nvidia-smi</copy>
            ```
The watch command is looking for changes in nvidia-smi every 1 second now so it looks real-time.  
Note the difference in the output from when you first ran this command in lab 1.  

- What Process is running?
- How utilized is the GPU(s)?  

If you are on a non-GPU system, you could use the top command to see CPU utilization. 

## Task 2: Adding load

1.    Now let’s increase utilization so you can see the CPU offload happen in real-time and the GPU takes the load.  
    In your 1st SSH window, hit ctrl+c to end the running llama-cli session.  
    Then, to keep the model busy for a minute, run the following command:  

    ```
    <copy>~/llama.cpp/build/bin/llama-cli -m models/mistral-7b-instruct-v0.1.Q4_K_M.gguf   --n-gpu-layers 100   -p "<s>[INST] Write an epic 3000-word sci-fi story about a robot uprising in a future Martian colony. Include suspense, betrayal, and a twist ending. [/INST]"   --n-predict 2700</copy>
    ```

    Return to the 2nd ssh session and observe the changes as they happen. 
    - How high is GPU utilization going now?  
    Feel free to repeat the command in the first ssh session to see it happen again.  

T minus 1!!  

*Congratulations! You have successfully completed the lab.*<br/>
You may now **proceed to the next lab**.


## Acknowledgements
* **Author** - Jeff Allen, Distinguished Cloud Architect, AI Accounts
* **Contributors** -  Animesh Sahay, Enterprise Cloud Engineering
* **Last Updated:** - May 2025

