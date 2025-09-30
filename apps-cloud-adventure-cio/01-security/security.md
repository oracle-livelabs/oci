# Security

## Introduction

Welcome to Oracle’s Cloud Adventure.  This is a fresh and unique way to offer you a chance for hands-on experience of highly differentiated and specifically curated content of numerous vignettes that are typically encountered in accounting and finance. We hope you will enjoy today’s adventure exploring a complete and unified solution for the office of the CIO.

### Objectives

During this adventure, you will perform a time sensitive task of granting permissions to a user.  

Estimated Time: 15 minutes

Do not forget to answer the Adventure Check Point questions at the end of the exercise!

## ERP & SCM: Extending Privileges to a User

1. During this adventure, you will perform a time sensitive task of granting permissions to a user.  These are the steps you will perform:

  ![Security Objectives](images/image100objs.png)

At this point, you should be logged into your environment with a username CIO.xx where xx is a two number code assigned to your laptop.



2. Oracle Cloud Applications are delivered with a complete set of roles which control access to application functions and data.

  To add a new privilege  to a user, you will need to first copy an existing role.

   > This is the Springboard where you’ll access all features.

   ![Application Springboard](images/image001.png)


3. Accessing Security Console

  > Select the **Tools** tab menu. <br>

  > Select the **Tools** Select **Security Console**.

  ![Tools Security Console](images/image002.png)


4. You’ll be working from this single console for most of the examples today.  By default, you are viewing the Roles tab of the console.

  > Security Console - Roles.

  ![Console Top Empty](images/image003.png)

5. Notice how the search is dynamic and offers available options as you type.

  > In the search field provided at the top, type: **Adventure**. <br>

  > Then **click** on the **Adventure Accounts Payable Manager** job role.

  ![Adventure Role Search](images/image004.png)

6. You can now see a list of the roles which are granted to a user when they are provided with the Accounts Payable Manager.

  > Notice that the table may be exported to Microsoft Excel using the button provided at the top right. <br>

  > (Nothing to perform here)

  ![Adventure Role roles](images/image005.png)

7. Always make changes to a copied role to ensure that your custom configurations are preserved on updates.

  > Tasks associated with the role are available from this pull-down menu.  Select **Copy Role**.

  ![Copy Adventure Role a](images/image006.png)

  > Select **Copy top role**. <br>

  > Press the **Copy Role** button.

  ![Copy Adventure Role b](images/image007.png)

8. Notice that you are provided with a list of ordered steps at the top.  For this example, we will only provide answers to steps 1, 2 and 7.

  We start by giving our copied role a unique name.

  > Add **your initials and xx Code** to the name of the **role name** and **role code** as shown. <br>

  > This will keep your version separate from the other participants, and it will help you find the new role later in this Cloud Journey. <br>

  > Press the **Next** button.

  ![Copy Role a](images/image008.png)

9. Using Function Security  Policy, you will add the privileges Brian Bell needs

  > Press the **Add + Function Security  Policy** button.

  ![Copy Role 2a](images/image009.png)

10. You will now find the required policy using the search form.

  > Type **Cancel Supplier Negotiation** in the search field and select the policy.

  ![Copy Role 2b](images/image010.png)

  > Press the **Add Privilege to Role** button

  ![Copy Role 2c](images/image011.png)

11. Note that the search window did not automatically dismiss.  This is done so you can continue to add more policies in this process.

  > Press the **Cancel** button to continue.

 ![Copy Role 2d](images/image012.png)


12. Note that the new policy has been added.

  You will skip the next three tasks until you arrive at ‘Users (7)’ in the Copy Role process.

  > **Press the 7 (Users) task at the top of the screen**.

 ![Copy Role 2e](images/image013.png)

13. Using a similar search tool, you will now search for Brian Bell and provide him with this new role and its associated privileges.

  > Press the **Add User** button.

 ![Copy Role 7a](images/image014.png)

  > Type **Brian.Bell** in the search form then **Select** his name when found. <br>

  > Be sure to include the ‘.’ between the first and last name.

 ![Copy Role 7b](images/image015.png)

  > Press the **Add User to Role** button.

 ![Copy Role 7c](images/image016.png)


14. Again, the search box remains in case you want to add additional users.

  > Press the **Cancel** button.

 ![Copy Role 7d](images/image017.png)

15. Brian Bell has been added to this new role

  > Press the **Next** button.

 ![Copy Role 7e](images/image018.png)

16. Note confirmation that we have added one Security Policy and one user

  > Press the **Submit and Close** button.

 ![Copy Role 7f](images/image019.png)

17. Last screen confirms new role is added

  Success!

  > Press the **OK** button.

 ![Copy Role 7g](images/image020.png)

18. Using the compare roles feature, you can quickly identify changes you’ve made compared to the out of the box roles provided by Oracle or other custom roles.

  This section uses your newly created role to do exactly this.

  > From the Security Console, press the **Compare Roles button**.

 ![Compare Roles Launch](images/image021.png)

19. You will need to enter the name of your new role

  > Press the **Search** ![Search Icon](images/icon01_search.png) icon for the First Role

 ![Compare Roles 1](images/image022.png)

  > Type in your **three initials and XX Code** which you used to name your custom role.

 ![Compare Roles a](images/image023.png)

  > **Select** your custom role

 ![Compare Roles b](images/image024.png)

  > Press the **OK** button.

 ![Compare Roles c](images/image025.png)

 20. Now you will repeat these steps for the original role

  > Press the **Search** icon for the Second Role

 ![Compare Roles d](images/image026.png)

  > In the search field type **Adventure**. <br>

  > **Select** the first entry.

 ![Compare Roles E](images/image027.png)

  > Press the **OK** button.

 ![Compare Roles F](images/image028.png)

  > Press the **Compare** button.

 ![Compare Roles F](images/image029.png)

21. Immediately you see that Cancel Supplier Negotiation has been added to the first role and does not exist in the second role.

 ![Compare Roles 6](images/image030.png)



22. Adventure awaits, click on the image, show what you know and rise to the top of the leader board!!!

    [![Cloud Adventure](images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:LOGIN_TEAM:::::CC:CIOADVENTURE)


## Summary

Security Console is used to quickly manage user access to the entire Fusion applications suite.

**You have successfully completed the Activity!**


## Learn More

* [Oracle Supply Chain & Manufacturing - Secure](https://docs.oracle.com/en/cloud/saas/supply-chain-and-manufacturing/24d/secure.html)
* [Oracle Human Resources - Secure](https://docs.oracle.com/en/cloud/saas/human-resources/24b/secure.html)
* [Oracle Documentation](http://docs.oracle.com)


## Acknowledgements
* **Author** - Nate Weinsaft, Cloud Technologist, Advanced Technology Services
* **Contributors** -
* **Last Updated By/Date** - Nate Weinsaft, April 2025
