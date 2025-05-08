# NovaSystems Launch!

## Introduction
Great news! The manned mission launch to Mars was a success, but no time to celebrate now. The crew is well on their way to the Red Planet and are now far enough from earth that messages take between 12 to 25 minutes each way — making real-time communication impractical for urgent safety and technical questions.  

To assist the crew, you fine-tuned a custom language model using PyTorch, trained on spaceflight operations, human safety measures, EVA protocols, and engineering procedures. It has read 10,000 pages of NASA safety protocol guides. You then converted this model into GGUF format to run efficiently on local GPUs using llama.cpp.  

The result? A local AI assistant named **NovaAssist**, designed to provide instant, expert advice and guidance to the crew — even when millions of miles from home.  

Estimated Time: 10 minutes


### Objectives
In this lab, you will:
- Test all of your work

## Task 1:  Hello NovaAssist!

1. As the lead AI expert at NovaSystems, you prepped the model and used a lot of trial and error to construct the most efficient prompt for the expert to respond correctly to questions from the crew. Let's try it out now and see how the crew can use it! Run this command in your first ssh window.
    ```
    <copy>cd ~/llama.cpp
    ~/llama.cpp/build/bin/llama-cli   -m models/mistral-7b-instruct-v0.1.Q4_K_M.gguf   --n-gpu-layers 100   --interactive   --color   -p "<s>[INST] You are NovaAssist, a local AI expert on space systems. Provide technical and precise answers to astronauts without humor or speculation. Stay focused on mission-critical knowledge. Await user input before responding. [/INST]\n"</copy>
    ```
 Below are some questions the crew has asked. Try some of these or come up with some of your own!  
 Protip: Triple click these lines below to highlight them.
 
 •  What might explain a sudden rise in CO₂ absorption in hydroponic bay 4?  
 •  We’re seeing intermittent power drops in the habitat module. What diagnostics should we run first?  
 •  How should I recalibrate the oxygen sensor in the primary life support loop?  
 •  What is the maximum safe radiation exposure for EVA crew on sol 17 of this mission?  
 •  There’s a strange vibration in the centrifuge module. What are likely causes and mitigation steps?  
 •  If nitrogen levels fall below 15%, what symptoms should we expect in the crew?  
 •  How do we patch a micrometeoroid puncture in an inner habitat wall?  
 •  The water reclamation system is returning less than 85% yield. What subsystems should we inspect?  
 •  We’ve isolated a leak in coolant loop B. What’s the priority protocol for containment and rerouting?  
 •  How do we safely repack a deployable solar panel that hasn’t fully extended?  
 

*Congratulations! You have successfully completed the lab.*<br/>

## Acknowledgements
* **Author** - Jeff Allen, Distinguished Cloud Architect, AI Accounts
* **Contributors** -  Animesh Sahay, Enterprise Cloud Engineering
* **Last Updated:** - May 2025