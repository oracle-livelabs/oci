# Add Users


## Introduction
In this section, we will cover the steps necessary to add multiple users to your Oracle Tenancy.

For the purposes of this workshop, all users may be added to the `Administrators` group, which has permissions to manage all resources in the Tenancy.

Beyond this workshop experience, we recommend leveraging the security principle of least privilege available in Oracle Cloud Infrastructure (OCI), by assigning users to groups besides `Administrators`, to best suit the role structure of your organization from an Identity and Access Management (IAM) perspective. You can learn about managing groups [here](https://docs.oracle.com/en-us/iaas/Content/Identity/groups/managinggroups.htm).

1. Open the navigation menu and click `Identity & Security`. Under `Identity`, click `Domains`.
2. Select `Default`, which is the identity domain we want to work in, and click `Users`.
3. Click `Create user`.
4. In the `First name` and `Last name` fields of the `Create user` window, enter the user’s first and last name.
5. Leave the `Use the email address as the username` check box selected, and provide an email address in the `Email` field to create the user account.
6. Select the check box for the `Administrators` group to assign the user account to this group.
7. Click `Create`.
