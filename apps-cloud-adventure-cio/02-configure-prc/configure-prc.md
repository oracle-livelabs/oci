# Configure

## PRC: Update Suppliers (New) Listing Page

### Introduction

Oracle offers hundreds of prebuilt pages, workflows and forms “out of the box” as part of the Oracle Fusion Cloud.  Many of our customers want to configure these pages and workflows to meet their specific business needs.  You can unify your experience in our applications by using Redwood.

Oracle Redwood is Oracle Fusion’s new design system that enhances the user experience through a visually stimulating, easy-to-use interface. By uniting customer-inspired design philosophies with industry-leading technology solutions, Oracle Redwood helps companies reduce costs, foster efficiency, revitalize the customer journey, and evolve continuously toward the future.

### Objectives

In this lab, you will use Redwood to quickly and efficiently improve the user experience in Oracle Fusion Cloud.

Estimated Time: 15 minutes

Do not forget to answer the Adventure Check Point questions at the end of the exercise!

### Begin Exercise

1. You will use Redwood, Oracle’s next-generation design system, to quickly and efficiently update the Suppliers (New) listing page providing more visibility to Procurement Managers. Suppliers (New) is a dynamic listing page that allows you to create role-based layouts based on configurable criteria.

    ![Configuration Objectives](../02-configure-prc/images/configure-prc-image001.jpg)

2. You will first navigate to the Suppliers (New) Listing Page.

    > (1) Click the **>** to scroll the tabs until you see **Procurement** <br>
    > (2) Click on the **Procurement** tab.

    ![Application Home Page](../02-configure-prc/images/configure-prc-image002.jpg)

3. The page you're going to configure, Suppliers (New), is available in the Quick Actions section of the screen on the left.

    > (1) Click on **Suppliers (New)** under **Quick Actions**.

    ![Procurement Page](../02-configure-prc/images/configure-prc-image003.jpg)

4. Before you configure this screen, you'll query some Supplier data.

    > (1) Click on the **Supplier Type** to display the Filter. <br>
    > (2) Click into the Search box **Supplier Type**.<br>
    > (3) Click and select **Supplier (97)** to display list of suppliers.<br>
    > (4) Click anywhere in the page away from the search filter **Supplier (97)**

    ![Suppliers List Page](../02-configure-prc/images/configure-prc-image004.jpg)

5. Now you will enter the Suppliers (New) Page that displays lists of suppliers.

    > (1) Click on drop-down icon to expand a specific supplier row.

    ![Suppliers List Page](../02-configure-prc/images/configure-prc-image005.jpg)

6.  You can see the supplier information displayed is limited. We will update the page to display more fields for procurement managers. <br>Now you will leverage Visual Builder Studio to update the Suppliers (New) page.

    > (1) Click on the ![picture image](../gen-images/user_icon.png) **Image** in the top right corner of the screen.  <br>

    > (2) Then select **Edit Page in Visual Builder Studio** from the drop down options.

    ![Suppliers List Page](../02-configure-prc/images/configure-prc-image006.jpg)

7. Welcome to Oracle Visual Builder Studio (VB Studio), a robust application development platform that helps your team effectively plan and manage your work throughout all stages of the application development lifecycle: design, build, test, and deploy. <br> Now we will use VB Studio to make the required changes to the Suppliers (New) page.

    > (1) Click on **Configure Fields and Regions**. <br>

    ![Configure Fields and Regions](../02-configure-prc/images/configure-prc-image007.jpg)

8.  First we will create a new role-based form rule for Suppliers (New) page

    > (1) Click on the ![+ Icon](../gen-images/plusicon.jpg) **Icon** to add a new form rule.

    ![Fields and Regions](../02-configure-prc/images/configure-prc-image008.jpg)

9.  You can name your rule whatever you want.  For example:

    > (1) Enter **procurementManagerLayout** in label. <br>

    > (2) Click on **Create**.

    ![Fields and Regions](../02-configure-prc/images/configure-prc-image009.jpg)

10. Now you'll create a condition.

    > (1) Click on the **Edit** button.  ![Edit Button](../gen-images/edit_button.png)

    ![Fields and Regions, Conditions](../02-configure-prc/images/configure-prc-image010.jpg)

11. You can start entering your first condition based on the user role

    > (1) Enter **Roles** in the first field of the condition and.<br>

    > (2) Select **[] Roles** from the resulting drop-down.

    ![Fields and Regions, Conditions](../02-configure-prc/images/configure-prc-image011.jpg)

12. Next, you'll enter the comparison value for your first condition. You'll limit the use of this rule to users assigned the Procurement Manager role.

    > (1) Type **Procurement Manager** in the value field and select the first occurrence of **Procurement Manager** from the dropdown.

    ![Fields and Regions](../02-configure-prc/images/configure-prc-image012.jpg)

13. Now you'll determine which fields to show and/or hide for this rule.

    > (1) Click on the **arrow ![Fields and Regions](../gen-images/debugarrow.jpg) icon** to the left of **Supplier Details** to expand the section.<br>

    ![Fields and Regions](../02-configure-prc/images/configure-prc-image013.jpg)

14. First you want to the configure the page to display the **Creation Date**.

    > (1) Click in the Box in the **Hidden Column** for the **Creation Date** Field row.    <br>

    > (2) Then select **Visble** from the options that appear.<br>

    ![Fields and Regions](../02-configure-prc/images/configure-prc-image014.jpg)

15. Now repeat the above steps for fields CreationSource, ParentSupplierNumber and TaxPayerCountry to make them visible.

    > (1) Click the Box in the **Hidden Column** for **each of these** rows and select **Visible** from the options that appear.
    * **CreationSource**
    * **ParentSupplierNumber**
    * **TaxpayerCountry**
    <br>
    > (2) Click the ![x icon](../gen-images/icon011_x.png) to close this section.

   ![Fields and Regions](../02-configure-prc/images/configure-prc-image015.jpg)

16. Well done.  You're going to do one more configuration that will display an AI Agent to assist the user in determining the appropriate salary change by checking market compensation information.  You'll do this by leveraging the Guided Journey configuration feature.  Guided Journeys allow you to embed information, including documents, links, reports and more in standard application screens.  You'll use it to embed an AI Agent.

    > (1) Type **Supplier** in the **Set Guided Journeys Code at the Suppliers Page Level** field.<br>
    > (2) Select **Supplier Advisor Agent** from the resulting dropdown.

    ![Preview](../02-configure-prc/images/configure-prc-image016.jpg)

17. You can see the the Supplier Advisor Agent Task Agent banner appear on the page.  You're done with configurations and ready to Preview your changes.

    > (1) Click on the **Preview** ![Fields and Regions, Conditions](../gen-images/preview.png) icon in the upper right of the screen.  The Preview will appear in a new browser tab.

    ![Preview](../02-configure-prc/images/configure-prc-image017.jpg)

18. You have re-entered the Suppliers screen. Before querying any suppliers you'll use the Supplier Advisor Agent to familiarize yourself with supplier data confidentiality guidelines.

    > (1) Click on the **Ask Oracle** ![Ask Oracle Logo Button](../gen-images/ask-oracle-logo.jpg) button.

![Suppliers List Page](../02-configure-prc/images/configure-prc-image018.jpg)

19. The Supplier Advisor Agent allows you to ask questions about Supplier information and policies.

    > (1) In the **How can I help you?** dialog box in the agent window, click the **What is considered confidential information?** button.

![Suppliers List Page](../02-configure-prc/images/configure-prc-image019.jpg)

20. The Agent replies with detailed information about maintaining confidentiality of certain supplier information.  With this knowledge in hand, you'll close the agent and proceed with querying supplier information.

    > (1) Review the confidential information response and, when finished, click the the ![x icon](../gen-images/icon011_x.png) icon in the upper right.

![Suppliers List Page](../02-configure-prc/images/configure-prc-image020.jpg)

21. You can requery Suppliers as shown below.

    > (1) Click on the **Supplier Type** to display the Filter. <br>
    > (2) Click into the Search box **Supplier Type**.<br>
    > (3) Click and select **Supplier (97)** to display list of suppliers.<br>
    > (4) Click anywhere in the page away from the search filter **Supplier (97)**

![Suppliers List Page](../02-configure-prc/images/configure-prc-image021.jpg)

22.  You can expand the Preview region for one of the suppliers.

> (1) Click on drop-down icon ![Region down arrow](../gen-images/icon014_downarrow.png) to expand a specific supplier row.

![Suppliers List Page](../02-configure-prc/images/configure-prc-image022.jpg)

23.  You can now see the new fields that you've made visible via application configuration.

> (1) The new fields are now visible. The configurations are **automatically maintained during the release update process**.

![Supplier List Screen](../02-configure-prc/images/configure-prc-image023.jpg)

18. Adventure awaits, click on the image, show what you know and rise to the top of the leader board!!!

    [![Checkpoint](../gen-images/cloud-adventure-checkpoint-image.png)](https://apex.oracle.com/pls/apex/f?p=159406:LOGIN_TEAM:::::CC:CIOADVENTURE)

### Summary

Oracle Redwood is Oracle Fusion’s new design system that enhances the user experience through a visually stimulating, easy-to-use interface. By uniting customer-inspired design philosophies with industry-leading technology solutions, Oracle Redwood helps companies reduce costs, foster efficiency, revitalize the customer journey, and evolve continuously toward the future.

**You have successfully completed the Activity!**

### Learn More

* [Overview of Redwood Application Extension](https://docs.oracle.com/en/cloud/saas/human-resources/fauvb/overview-of-redwood-application-extensions.html)
* [Configuring and Extending Applications](https://docs.oracle.com/en/cloud/saas/applications-common/26a/oaext/overview-of-using-visual-builder-studio.html)
* [Oracle Documentation](http://docs.oracle.com)

## Acknowledgements
* **Author** - Charlie Moff, Distinguished Cloud Technologist; Casey Doody, Cloud Technologist; Sajid Saleem, Master Principal Cloud Technologist
* **Contributors** - The AI Adventure Team (Gus, Kris, Sajid, Casey, Stephen, Jamil, Sohel, Xavier, Nate, Charlie)
* **Last Updated By/Date** - Charlie Moff; Sajid Saleem, January 2026