# Create OCI Event Rule, Alarm and Notifications

## Introduction

Oracle Cloud Infrastructure services emit events, which are structured messages that indicate changes in resources. 

The Notifications service lets you know when something happens with your resources in Oracle Cloud Infrastructure. 

Using alarms and event rules, you can get human-readable messages through email and text messages (SMS).

Some examples of how you might use Events and notifications: 

- Send a notification to a DevOps team when a database backup completes.
- Convert files of one format to another when files are uploaded to an Object Storage bucket.

Estimated Lab Time: 30 minutes

### Objectives

The objectives of this lab are:

- Add OCI event rule, alarm and notifications in excel spreadsheet.
- Deploy event rule, alarm and notifcations.
- Use the Plan to Terraform Apply

## Task 1: Add OCI event rule, alarm and notifications in Excel Spreadsheet

1. Copy __CD3-CIS-ManagementServices-template.xlsx__ from /cd3user/oci_tools/cd3_automation_toolkit/example to localy on your system.

2. Open __CD3-CIS-ManagementServices-template.xlsx__ and update __Events, Alarms, Notifications__ tabs based on your requirements and save it. You could use CIS standard pre-filled data in spreadsheet.

_e.g._ ![Event Rule](images/Event_Rule.jpg)

![Notifications](images/notifications.jpg)

![Alarms](images/Alarms.jpg)

## Task 2: Deploy OCI Event rule, alarm and notifications

1. Place _CD3-CIS-ManagementServices-template.xlsx_ excel sheet at appropriate location in your container and provide the corresponding path in cd3file parmeter of: /cd3user/tenancies /<customer_name>/<customer_name>_setUpOCI.properties file.

_e.g._ cd3file=/cd3user/tenancies/usr1_livelab/CD3-CIS-ManagementServices-template.xlsx

2. Execute the setUpOCI Script:
python setUpOCI.py /cd3user/tenancies/<customer_name>/<customer_name>_setUpOCI.properties

_e.g._ python setUpOCI.py /cd3user/tenancies/usr1_livelab/usr1_livelab_setUpOCI.properties

3. Type __option 8__ for management services from Menu and __option 2__ from submenu for __add/modify/delete events__.

4. Once the execution is successful, <customer_name>_events.auto.tfvars file will be generated under the folder /cd3user/tenancies/<customer_name>/terraform_files/<region_dir>.

5. Navigate to the above path and execute the terraform commands:

```
terraform init
terraform plan
```

Wait for a bit until the plan succeeds and plan logs are available under _Logs_. Take a look to familiarize yourself with the log format. Scroll down until you see the line `Plan: X to add, 0 to change, 0 to destroy`.

6. Once satisfied by the plan logs, we put it into motion by starting the Apply process.

```
terraform apply
```

The apply process can take some time, so patience is required.

## Task 4: Inspect Created Objects

Go to __OCI console__ under compartment which was selected for deployment and take a few moments to explore the resources created. 

Ask yourself how these resources will make your environment more healthy. 

## Acknowledgements

- __Author__ - Dipesh Rathod
- __Contributors__ - Murali N V, Suruchi Singla, Lasya Vadavalli
- __Last Updated By/Date__ - Dipesh Rathod, May 2023
