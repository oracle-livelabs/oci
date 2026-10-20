# Finish and Clean Up

## Introduction

Finish using your environment when you no longer need the lab resources. Follow only the section that applies to your sandbox reservation or own tenancy.

**Estimated Time:** 5–10 minutes, excluding waits for resource deletion.

### Objectives

- Retain any reports you want to keep.
- Identify the correct owner and order for removing lab resources.

### Prerequisites

- Finish Lab 1 and any optional exercises you want to complete.
- Have your resource sheet and the resource owner's approval before deleting resources in your own tenancy.

## Sandbox reservations

Save any reports you want to keep before your reservation ends. Follow the end-reservation instructions in LiveLabs. Do not destroy a stack, delete the foundation, or change IAM yourself. Use **Need Help?** in the workshop menu if you need assistance with your reservation.

## Your own tenancy

Coordinate cleanup with the resource owner. Use your resource sheet to identify
exact targets and retain anything you need before deleting it. Deletion can be
irreversible. Never delete a shared compartment or another learner's resources.

1. Disable and delete only your lab's Events rule so no new invocations start.
2. Wait for outstanding function executions to finish.
3. Delete your lab function and its application invocation log, then delete the
   empty Functions application. Confirm that no unrelated functions share it.
4. Download any reports you want to retain. Delete the lab objects in both buckets,
   then delete the two empty lab buckets. Versioning/retention, if enabled against
   the lab instructions, requires additional owner review.
5. The administrator can now run **Destroy** on the foundation's Resource Manager
   stack. Review its plan: only that stack's network, log group, and optionally
   managed runtime IAM should be removed. Network cleanup can wait on service
   VNIC release after application deletion; inspect failures rather than forcing
   deletion of other resources.
6. Confirm Destroy succeeded before deleting the stack record. Terraform state
   is needed to manage any resources left by a failed destroy.
7. The existing compartment and separately administered learner/runtime IAM were
   not created by the stack and are not removed by Destroy. Have their owner
   review them separately; retain shared identities and policies.

**Important:** Destroy does not discover or remove manually created buckets,
applications, functions, logs, or Events rules. Remove those dependencies first.
No automated destructive cleanup is included in this workshop.

## Acknowledgements

- **Author** - Graham Shroyer
- **Last Updated By/Date** - Graham Shroyer, September 2026
