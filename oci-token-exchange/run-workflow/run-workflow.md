# Run the Github Action workflow 

## Introduction

In this chapter you will run the Github Action workflow. As a result a simple VCN will be created in your Tenancy

Estimated Time: 10 minutes

### **Objectives**

Hands-on experience with:

- set a Github Variable  
- run a Github Action with gh client
- review the Github Action logs

### **Prerequisites**

* completion of previous Labs.
* Github CLI installed and authenticated with your Github account

## Task 1 — Run the Github Action workflow

1. In a shell terminal
    - run the command below

     ```
     <copy>
     gh workflow list
     </copy>
     ```

    - you will see something like below. Note the _ID_ as you will need it in next command
     ```text
     NAME                               STATE   ID
     Run Terraform with token exchange  active  228733475
     ```

2. Launch the workflow from command line

     - run the command but replace the ID with your own:
      ```
      <copy>
      gh workflow run 228733475
      </copy>
      ```

    - the output should be like :

     ```text
     ✓ Created workflow_dispatch event for run-terraform.yaml at main
     To see runs for this workflow, try: gh run list --workflow="run-terraform.yaml"
     ```
    - run the command to see the progrress

     ```
     <copy>
     gh run list --workflow="run-terraform.yaml
     </copy>
     ```

    - when it will finishes you should see:
    
      ![workflow status](images/workflow_status.png)

    - at this point you have the simple VCN created by the workflow in your tenancy.
    - this can be seen in the workflow log

3. Review the workflow logs in Github UI

    - go to your repo in Github
    - under Actions Menu you should find all the runs
    - click on whatever run you want to see details 

![workflow logs](images/workflow_logs.png)

4. Update the TF_ACTION Variables to __destroy__ and run the workflow again
    - this action will destroy the created VCN
    - run the command below to update the variable
     ```
      <copy>
     gh variable set TF_ACTION --body "destroy"
     </copy>
     ```
    - run again the steps 1) and 2) to launch the same workflow
    - when it finished the VCN is destroyed

You may now **proceed to the next lab**.

## Acknowledgements

**Authors**

* **Francisc Vass**, Principal Cloud Architect, NACIE
* Last Updated - Francisc Vass, Jan 2026
