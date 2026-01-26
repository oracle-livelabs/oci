# Cleanup

## Introduction

From the Oracle Cloud Console, clean up the resources provisioned for this workshop.

Estimated Workshop Time: 05 minutes

### Objectives

In this lab, you will:

* Delete the ADB instance
* Delete the three Secrets
* Delete the Master Encryption Key
* Delete the Vault
* Destroy Stack
* Delete the Stack
* Delete the Instance Principals Policy

## Task 1: Cleanup

From the Oracle Cloud Console, clean up the resources provisioned for this workshop:

1. From **Oracle Database** >> **Autonomous Database**, click **Terminate** to delete the ADB instance.

2. From **Identity & Security** >> **Key Management & Secret Management** >> **Vault** >> **Secrets**, use **Delete Secret** to delete all three secrets.

3. From **Identity & Security** >> **Key Management & Secret Management** >> **Vault** >> **Master Encryption Keys**, use **Delete Key** to delete the master encryption key.

4. From **Identity & Security** >> **Key Management & Secret Management** >> **Vault**, use **Delete Vault** to delete the vault.

5. From **Resource Manager >> Stacks >> Stack Details** screen, run **Destroy** to delete the VCN and the Compute instance.

6. From **Resource Manager >> Stacks >> Stack Details** screen, **Delete** the stack.

7. From **Identity & Security >> Identity >> Policies**, delete the Instance Principals policy.

Congratulations! You've successfully completed this lab.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - [](var:author)
* **Contributors** - [](var:contributors)
* **Last Updated By/Date** - [](var:last_updated)