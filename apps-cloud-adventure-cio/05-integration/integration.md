# Integration

## Introduction

We're delighted to take you on a journey that will uncover the incredible capabilities of Fusion Cloud's REST API integration tools for auditing supplier address changes. This adventure is designed to offer a holistic understanding of how these integration tools can facilitate your Oracle Fusion Cloud integration requirements and access to business object data via REST APIs.

In the office of the Chief Information Officer (CIO), supply chain management is a complex web of interconnected processes. Our goal is to navigate this complexity and equip you with the skills to audit supplier address changes effectively. You'll learn how to leverage the power of Fusion Cloud's REST APIs, a game-changing solution that will revolutionize your operations.

We've designed this journey to be interactive and engaging. Make sure to answer the Adventure Check Point questions along the way, ensuring you capture the full potential of this experience. These check points are your path to becoming a master auditor, so pay close attention!

With your adventure hat on and a curious mind, prepare for an exhilarating exploration of Fusion Cloud's REST API integration features. Let's embark on this thrilling journey together!

As you follow along, do not forget to ask questions if you get stuck and answer the Adventure Check Point questions! 


Estimated Time: 15 minutes


### **Objectives**

In this activity you will learn the power and ease of integrating Fusion SaaS application with upstream and downstream systems

![Integration Objectives](images/Integration_objs2.png)


## **Task 1: Use REST API to pull Fusion SaaS Application audit data for use in any external system**




1. Let’s navigate to the Suppliers work area to modify a supplier’s address information

    > Click the **Procurement** tab

    ![Application Homepage](images/image002.png)


    > Click the **Manage Suppliers** button

    ![Show More View](images/image004.png)


2. Next, we’re going to search for the Supplier you’ve been assigned, e.g. “01…”

    > Click in the **Keywords** search bar

    ![Manage Suppliers View](images/image005.png)  

    > (1) **Search** for a supplier using the user id number (e.g. 01, 02).  <br>

    > (2) Click the **Search** button

    ![Keywords search bar](images/image006.png)  

    > Click the **Edit** ![Edit Icon](images/icon011_edit.png)  button in the ‘Search Results’ area

    ![Search Results](images/image007.png)  


3. We’re going to navigate to the Supplier’s addresses tab.
   
    > Click the **Addresses** tab

    ![Suppliers View](images/image008.png)  

    > Click the **Edit** ![Edit Icon](images/icon011_edit.png) icon to edit the Supplier’s address

    ![Edit Suppliers View](images/image009.png)  


4.   **Note:** We’ll only edit the Supplier’s second line of address information, i.e. ‘Address Line 2’ text entry field. 

    We’re going to add a Suite (e.g. 123) to the Supplier’s address information that was missing before.

    > Click in the **Address Line 2** text entry field 

    ![Edit Suppliers View](images/image010.png)

    > Type new address information into **Address Line 2**, e.g. ‘Suite 123’

    ![Edit Suppliers View](images/image011.png)

    > Click **Save and Close** 

    ![Edit Suppliers View](images/image012.png)

    > Click **Submit** 

    ![Edit Suppliers View](images/image013.png)

5.  **Note:** We’ve modified our demo environment’s approval workflow for internal supplier profile changes to be automatically approved for            demonstration purposes, however this can be configured based on each customer’s business requirements

    > Click **OK** on the resulting confirmation box. 

    ![Suppliers View](images/image014.png)

    > Click **Done**

    ![Suppliers View](images/image015.png)



6. Let’s navigate back to the Oracle Fusion Cloud home screen.

    > Click the **Home** ![Home Icon](images/icon012_home.png) button

    ![Suppliers View](images/image016.png)



7. Now, we’re going to discover how we can audit several pieces of information that’s relevant to our cloud adventure today: user access (sign in / sign out) as well as supplier address information changes via REST API integrations.

    > At the home screen, Navigate to **Integration** tab

    ![Home](images/image017.png)

    > Click on **Audit Report REST Endpoints**

    ![Integrations View](images/image018.png)
    


    **This is an example of a configuration. This tile links out to an external website.**

    **Take note of the detailed documentation. API endpoints, parameters, code examples, use cases, Oracle’s documentation is public and designed to be very useful.**


8. Let’s review the REST API endpoints that we can use to review Auditable data that can be extracted from Fusion Cloud.

    ![Audit Report REST Endpoints](images/image019.png)

    > Click on **Get an audit report** under **Audit Report**

    ![Audit Report REST Endpoints](images/image020.png)    

    > **Click** the drop-down menu icon [drop dowb icon](images/icon014_downarrow.png) **‘Jump to’** and select the **‘Examples’** menu option

    ![Get an audit report](images/image021.png)   

    > Scroll down the page, review the first **Example Request Payload** and **Example of Response Body**

    ![API Examples](images/image022.png)   



	

14. Adventure awaits, click on the image, show what you know and rise to the top of the leader board!!!
    
    [![Cloud Adventure](images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:LOGIN_TEAM:::::CC:CIOADVENTURE) 


## Summary

Throughout the Cloud Adventure for the office of the CIO, Integration activity guide, students are immersed in an interactive and engaging 
journey into the world of Fusion Cloud's REST API integration features. The primary goal of this instructional adventure was to empower 
students with the skills and knowledge necessary to effectively audit both user sign on activity as well as supplier address changes in Fusion 
Cloud Supply Chain Management (SCM). Throughout this exploration, they uncovered the potential of Fusion Cloud's integration tools, 
enhancing their understanding of supply chain security management integration and auditing processes.

Within the activity, students embarked on a hands-on exploration, beginning with a login to the Fusion Cloud SCM system. They navigated with 
purpose to the Suppliers work area, where they were tasked with modifying a supplier's address information. This interactive modification set 
the stage for the upcoming auditing activities. Cloud adventurers then delved into the Integration tab, a powerhouse of auditing capabilities 
within the Fusion Cloud platform. Here, they uncovered the 'Audit Report REST Endpoints,' a revelation of the potential to extract valuable 
auditable data. With growing curiosity, they scrutinized example request payloads and response bodies, gaining insights into the structure and 
content of auditing information.

The journey of Fusion Cloud integration exploration continued as students applied their newfound knowledge. They returned to the familiar 
grounds of the Fusion Cloud and audited the supplier address change they had made earlier. This practical application of REST API integration 
theory added a layer of depth to their practical understanding. As the adventure continued, the students ventured into the captivating world of 
Oracle APEX application integration, which simulated a 3rd party auditing application for the purposes of this cloud adventure. They skillfully 
authenticated their integration APEX application, utilizing the provided cloud adventure environment instance and password.

With the connection established, adventurers delved deeper, exploring the ‘Sign-on’ Audit area, where they uncovered a treasure trove of user 
access details. They reviewed the corresponding REST API, gaining insights into the security and transparency of user access history. The journey 
then led them to the 'Audit History' section, a comprehensive record of supplier address changes. Here, they extracted historical data, 
witnessing firsthand the power of Fusion Cloud to meticulously track and record business object data modifications. By scrutinizing the demo 
flow and API details, students developed a profound understanding of the platform's capabilities and their newfound auditing skills.

Throughout this immersive adventure, students not only acquired technical proficiency but also cultivated a deep appreciation for the potential 
of Fusion Cloud's REST API integration. They learned to navigate the intricate web of supply chain management integration, including how to 
audit user sign in activity, supplier address changes, and how to extract critical auditable information. With each step, they transformed from 
curious cloud adventurers to seasoned Fusion Cloud auditors, equipped with the knowledge and confidence to continue their Fusion Cloud

**You have successfully completed the Activity!**

## Acknowledgements
* **Author** - Jamil Orfali, Senior Sales Consultant, Advanced Technology Services, Kris Holmgren, Senior Sales Consultant, Advanced Technology Services
* **Contributors** -  
* **Last Updated By/Date** - Jamil Orfali, September 2024
