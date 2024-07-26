# Cleanup

From the Oracle Cloud Console, clean up the resources provisioned for this workshop:

1. From **Storage >> Object Storage & Archive Storage >> Buckets**, delete the **Bucket**.

2. From **Resource Manager >> Stacks >> Stack Details** screen, first run **Destroy** to delete VCN and Compute instance. Next, delete the **Stack**.

<if type="tenancy">
3. From **Identity & Security >> Identity >> Policies**, delete the Instance Principals **Policy**.
</if>
