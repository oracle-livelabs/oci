# Security

<!-- rem ## Path 1: Assign AI Privileges -->
## **Assign AI Privileges**

### **Introduction**

  Welcome to Oracle’s Cloud Adventure for Security Administration.  This is a fresh and unique way to offer you a chance for hands-on experience of highly differentiated and specifically curated content of numerous vignettes that are typically encountered in accounting and finance. We hope you will enjoy today’s adventure exploring a complete and unified solution for the office of the CIO.

### **Objectives**

  During this adventure, you will perform a time sensitive task of granting permissions to a user.

  Estimated Time: 15 minutes

  Do not forget to answer the Adventure Check Point questions at the end of the exercise!

### **Begin Exercise**

1. During this adventure, you will perform a time sensitive task of granting permissions to a user.  These are the steps you will perform:

    ![Security Objectives](../01-security-ai/images/secaiimage001.jpg)


    > At this point, you should be logged into your environment with a username **CIO.xx** where **xx** is the two number code of your login ID.


2. To enable the ability to use AI to discover new suppliers, you will access the security console. This is the Springboard where you’ll access all features.

     > (1) Select the **Tools** tab menu. <br>
     > (2) Select **Security Console**.

    ![Home Screen](../01-security-ai/images/secaiimage002.jpg)


3. While examining roles, begin by searching for the role we seeded for this adventure

    > (1) In the search field provided at the top, type **Adventure**. <br>

    > (2) Then click on the first entry as shown.

    ![Roles Screen](../01-security-ai/images/secaiimage003.jpg)

4.	Using the pull-down demo to copy the role as described below.  Modifications should always be done to copies.

    > (1) Click on the Pull-Down Menu. <br>

    > (2) Select **Copy Role**.

    ![Roles Screen](../01-security-ai/images/secaiimage004.jpg)


5. Continue with copying the role

    > (1) Select **Copy top role**. <br>

    > (2) Press the **Copy Role** button.

    ![Roles Screen](../01-security-ai/images/secaiimage005.jpg)

6.	Notice that you are provided with a list of ordered steps at the top.  For this example, we will only use steps 1, 2 and 7.

    > (1) Add **your initials and xx Code** to the beginning of the **Role Name** <br>
    > (2) Add **your initials and xx Code** to the beginning of the **Role Code** as shown. <br>
    > (3) Press the **Next** button.

    ![Copy Roles Screen](../01-security-ai/images/secaiimage006.jpg)

7.	Using Function Security Policy, you will add the privilege the user needs

    > (1) Press the **+ Add Function Security Policy** button.

    ![Function Security Policy](../01-security-ai/images/secaiimage007.jpg)

8.	You will now search for the required policy and add it.

    > (1) Type **Create Supplier Negotiation** in the search field
    > (2) Select the **Create Supplier Negotiation** privilege from the resulting dropdown as shown.

    ![Function Security Policy](../01-security-ai/images/secaiimage008.jpg)

9.	Continue adding

    > (1) Press the **Add Privilege to Role** button.

    ![Function Security Policy](../01-security-ai/images/secaiimage009.jpg)

10.	Complete adding roles

    > (1) Press the **Cancel** button to continue.

    ![Function Security Policy](../01-security-ai/images/secaiimage010.jpg)

11.	While there are other steps we can perform, we going to skip to Step 7 to add users to this role.
    > (1) Press the Step **7** **Users** from the list of steps at the top of the screen

    ![Function Security Policy](../01-security-ai/images/secaiimage011.jpg)

12.	You should now assign a user to this new role and its associated privileges.

    > (1) Press the **+ Add User** button.

    ![Users](../01-security-ai/images/secaiimage012.jpg)

13.	Searching for a user

    > (1) Type “Pat.ProcurementManager” in the search form then Select then name from the resulting dropdown list. <br>

    > **Note:** Be sure to include the ‘.’ between the first and last name.

    ![Add Users](../01-security-ai/images/secaiimage013.jpg)

14.	Continue

    > (1) Press the **Add User to Role** button.

    ![Add Users](../01-security-ai/images/secaiimage014.jpg)

15.	Again, the search box remains in case you want to add additional users.

    > (1) Press the **Cancel** button.

    ![Add Users](../01-security-ai/images/secaiimage015.jpg)

16.	Pat.ProcurementManager has been added to this new role

    > (1) Press the **Next** button.

    ![Add Users](../01-security-ai/images/secaiimage016.jpg)

17.	Note confirmation that we have added a Security Policy and user.

    > (1) Press the **Submit and Close** button.

    ![Add Users](../01-security-ai/images/secaiimage017.jpg)

18.	Using the compare roles feature, you can quickly identify changes you’ve made compared to the out of the box roles provided by Oracle or other custom roles.  This section uses your newly created role to do exactly this.

    > (1) From the Security Console, press the **Compare Roles button** button.

    ![Roles](../01-security-ai/images/secaiimage018.jpg)

19.	Begin search for the original role

    > (1) Press the **Search** icon for the First Role.

    ![Compare Roles](../01-security-ai/images/secaiimage019.jpg)

20.	Search for seeded role

    > (1) In the search field type **Adventure**.<br>

    > (2) **Select** the first entry.

    ![Compare Roles](../01-security-ai/images/secaiimage020.jpg)

21.	Continue

    > (1) Press the **Ok** button.

    ![Compare Roles](../01-security-ai/images/secaiimage021.jpg)

22.	Begin search for the custom role

    > (1) Press the **Search** icon for the Second Role.

    ![Compare Roles](../01-security-ai/images/secaiimage022.jpg)

23.	Search for custom role

    > (1) Type in your **three initials and XX Code** which you used to name your custom role . <br>

    > (2) **Select** your custom role.

    ![Compare Roles](../01-security-ai/images/secaiimage023.jpg)

24.	Continue

    > (1) Press the **Ok** button.

    ![Compare Roles](../01-security-ai/images/secaiimage024.jpg)

25.	Begin compare task

    > (1) Press the **Compare** button.

    ![Compare Roles](../01-security-ai/images/secaiimage025.jpg)

26.	Immediately you see that two roles have been added to the first role and does not exist in the second role.

    > (1) Press the **Only in second role** toggle.

    ![Compare Roles](../01-security-ai/images/secaiimage026.jpg)

27.	This view shows the two polices added you added to your custom role.

    > (1) Press the **Home** button.

    ![Compare Roles](../01-security-ai/images/secaiimage027.jpg)

28. Adventure awaits, click on the image, show what you know and rise to the top of the leader board!!!

    [![Cloud Adventure](../01-security-ai/images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:LOGIN_TEAM:::::CC:CIOADVENTURE)

<!--  ## Path 2: Request Access with Risk Management -->

### Summary

Security Console is used to quickly manage user access to the entire Fusion applications suite.

**You have successfully completed the Activity!**


### Learn More

* [Oracle Supply Chain & Manufacturing - Secure](https://docs.oracle.com/en/cloud/saas/supply-chain-and-manufacturing/24d/secure.html)
* [Oracle Human Resources - Secure](https://docs.oracle.com/en/cloud/saas/human-resources/24b/secure.html)
* [Oracle Documentation](http://docs.oracle.com)


## Acknowledgements
* **Author** - Nate Weinsaft, Cloud Technologist, Advanced Technology Services
* **Contributors** -
* **Last Updated By/Date** - Nate Weinsaft, October 2025
