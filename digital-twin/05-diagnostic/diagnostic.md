# Anomaly Diagnosis

## Introduction
In this lab session, we will explore the process of matching and transforming an ideal digital model to a digital twin, specifically with the goal of gaining physical insight into the (presumed) real-world model represented.

When a physics-driven digital model/virtual prototype is first created, it represents the ideal or expected behaviour of the designed system. 
Initial discrepancies in manufacturing as well as system degradation and failure can all cause a specific instance of the real world machine to behave differently than the original digital model. 
 
The process of matching the digital model to a specific real-world asset transforms the generic model into a digital twin. This twin, and the process of creating it, can be used to gain physical insight into the behaviours observed in the real-world model.  As well, they provide a safe and efficient testbed to test controller changes that can improve machine performance.
 
The simplest way perform this tuning  is to manually update the physical parameters of the model until the performance of the virtual model match the performance of the real world model for a given set of operations.    For this session we will drive the FMU from the previous sessions through a known task.  The performance of the model will be compared to sample operation data that (for simplicity) we’ve embedded in the model).  Users will be able to update parameters of the digital model to manually match the sample operational data.


*Estimated Time*: 10 minutes

### Objectives
- Demonstrate a simple way to match the behaviour of a digital model with the behaviour of a real-world model (represented by operational data)
- Understand physical insight about an observed anomaly can be obtained by tuning a digital model.

### Prerequisites
- The operational data of the anomaly is available
- The digital model is available
- The anomaly that is occurring can be represented in the digital model (i.e. it includes the pieces necessary to represent the failure)
- The operational data is rich enough to uniquely identify the parameters that need to be tuned in the digital model.


## Task 1



## Task 2




## Task 3