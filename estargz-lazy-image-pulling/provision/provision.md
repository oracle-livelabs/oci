# Deploy infrastructure

## Introduction

In this lab, you will deploy the OCI resources required for the eStargz benchmark. The automation creates a small OCI environment and configures one Oracle Linux VM with `containerd`, `nerdctl`, and `stargz-snapshotter`.

The VM is the benchmark host used later to compare startup time for a regular container image and its eStargz version.

Estimated Time: 30 minutes

### **Objectives**

By the end of this lab, you will:

* Configure the Terraform provider values for your OCI tenancy.
* Deploy the eStargz benchmark VM and supporting network resources.
* Confirm cloud-init completed successfully.
* Verify that `containerd`, `nerdctl`, and `stargz-snapshotter` are available on the VM.

### **Prerequisites**

This lab assumes you have:

* An Oracle Cloud account
* Access to an OCI tenancy and compartment
* Terraform installed locally
* OCI API key credentials configured for Terraform
* A local SSH key pair for connecting to the VM
* Permission to create networking and compute resources in the target compartment

## Task 1: Review the automation

Download [estargz.zip](files/estargz.zip) from the lab files. Create an `estargz` folder and unzip the file into it:

```bash
mkdir estargz
unzip estargz.zip -d estargz
```

The `estargz` folder is the Terraform automation folder used in this lab.

It provisions:

* one VCN
* one public subnet and one private subnet
* Internet Gateway and NAT Gateway
* route tables and security list
* one Oracle Linux 9 compute VM with a 200 GB boot volume

Cloud-init configures the VM with:

* root filesystem expansion
* `containerd`
* `stargz-snapshotter`
* `nerdctl`
* CNI plugins
* benchmark helper scripts

Open a terminal where you unzipped the file and move to the automation folder:

```bash
cd estargz
```

## Task 2: Configure OCI provider values

Copy the provider example file:

```bash
cp provider.auto.tfvars.example provider.auto.tfvars
```

Edit `provider.auto.tfvars` and provide your OCI provider values:

```hcl
provider_oci = {
  tenancy_ocid     = "ocid1.tenancy.oc1..<CHANGE_ME>"
  user_ocid        = "ocid1.user.oc1..<CHANGE_ME>"
  fingerprint      = "<CHANGE_ME>"
  private_key_path = "~/.oci/oci_api_key.pem"
  region           = "eu-frankfurt-1"
}

compartment_ids = {
  sandbox = "ocid1.compartment.oc1..<CHANGE_ME>"
}
```

## Task 3: Review benchmark inputs

Open `terraform.tfvars` and review the customer/demo values.

At minimum, confirm the SSH public key and OCIR registry region:

```hcl
ssh_public_key = "~/.ssh/id_rsa.pub"
registry       = "fra.ocir.io"
```

The packaged `terraform.tfvars` file includes placeholder image references. You can leave these placeholders during infrastructure deployment:

```hcl
estargz_image  = "fra.ocir.io/<namespace>/<repo>/<image>:<estargz-tag>"
regular_image  = "fra.ocir.io/<namespace>/<repo>/<image>:<regular-tag>"
run_validation = false
```

Keep `run_validation = false` for private OCIR images. You will replace the placeholder image references, log in to OCIR from the VM, and run the benchmark manually in the next labs.

## Task 4: Deploy the infrastructure

Initialize Terraform:

```bash
terraform init
```

Validate the configuration:

```bash
terraform validate
```

Review the execution plan:

```bash
terraform plan
```

Apply the configuration:

```bash
terraform apply
```

When prompted, type `yes`.

The deployment may take several minutes while OCI creates the network, VM, and boot volume.

## Task 5: Connect to the VM

After Terraform completes, get the VM connection details:

```bash
terraform output linux_instances
```

Copy the public IP address from the output and connect to the VM:

```bash
ssh -i ~/.ssh/id_rsa opc@public_ip
```

Wait for cloud-init to complete:

```bash
tail -f /var/log/cloud-init-output.log
sudo cloud-init status --wait --long
```

On a successful deployment, cloud-init finishes without errors.

## Task 6: Verify the benchmark host

Run the status helper:

```bash
sudo /usr/local/bin/estargz-status.sh
```

Confirm the important expected signals:

* `/` shows the enlarged boot volume
* `containerd` is active
* `stargz-snapshotter` is active
* the `overlayfs` snapshotter is available
* the `stargz` snapshotter is available

You can also run these manual checks:

```bash
df -h /
sudo systemctl status containerd --no-pager
sudo systemctl status stargz-snapshotter --no-pager
sudo /usr/local/bin/ctr plugins ls | grep -E 'stargz|overlayfs|snapshot'
sudo /usr/local/bin/nerdctl version
sudo cat /etc/estargz-benchmark.env
```

If you need to inspect bootstrap logs, use:

```bash
sudo cat /var/log/estargz-cloudinit.log
sudo cat /var/log/cloud-init-output.log
```

## Task 7: Run a basic public image test

Before using private OCIR images, confirm the VM can run containers with both snapshotters:

```bash
sudo /usr/local/bin/nerdctl --snapshotter overlayfs run --rm docker.io/library/busybox:latest true
sudo /usr/local/bin/nerdctl --snapshotter stargz run --rm docker.io/library/busybox:latest true
OR
sudo /usr/local/bin/nerdctl --snapshotter stargz run --rm docker.io/library/busybox:latest echo stargz-ok
```

If the commands complete successfully, the infrastructure is ready for the image creation and benchmark lab.

## Learn More

* [Oracle Cloud Infrastructure Documentation](https://docs.oracle.com/en-us/iaas/Content/home.htm)
* [OCI Container Registry Documentation](https://docs.oracle.com/en-us/iaas/Content/Registry/home.htm)
* [Terraform OCI Provider Documentation](https://registry.terraform.io/providers/oracle/oci/latest/docs)
* [containerd Documentation](https://containerd.io/docs/)
* [stargz-snapshotter Project](https://github.com/containerd/stargz-snapshotter)

You may now proceed to the next lab.

## Acknowledgements

**Authors**

* **Adina Nicolescu**, Senior Cloud Engineer, NACIE
* **Last Updated By/Date** - Adina Nicolescu, June 2026
