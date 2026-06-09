# Run the benchmark

## Introduction

In this lab, we will run the eStargz benchmark on the Oracle Linux VM created in Lab 1.

The benchmark compares startup time for:

* an eStargz image using the `stargz` snapshotter
* a regular image using the `overlayfs` snapshotter

The benchmark measures time to first container start. This is the important metric for eStargz because lazy pulling lets the container start before the full image is downloaded.

Estimated Time: 30 minutes

### **Objectives**

In this lab, you will:

* Connect to the benchmark VM.
* Log in to OCIR from the VM.
* Configure the regular and eStargz image references.
* Run the benchmark helper script.
* Review the benchmark summary and raw log.
* Interpret the results.

### **Prerequisites**

This lab assumes you have:

* Completed Lab 1
* Completed Lab 2
* SSH access to the benchmark VM
* The regular image reference from Lab 2
* The eStargz image reference from Lab 2
* An OCI auth token for OCIR login

## Task 1: Connect to the benchmark VM

1. From your local terminal, connect to the VM created in Lab 1:

    ```bash
    ssh -i ~/.ssh/id_rsa opc@<public_ip>
    ```

2. Confirm the benchmark helper scripts are available:

    ```bash
    sudo /usr/local/bin/estargz-status.sh
    ```

3. Confirm that `containerd` and `stargz-snapshotter` are active in the output.

## Task 2: Log in to OCIR

1. Log in to OCIR with `nerdctl`:

    ```bash
    sudo /usr/local/bin/nerdctl login fra.ocir.io
    ```

    If you used a different OCIR region, replace `fra.ocir.io` with your registry.

2. When prompted, provide your OCIR username.

    For OCIR, the username is usually:

    ```text
    <tenancy-namespace>/<oci-username>
    ```

3. For the password, use an OCI auth token.

## Task 3: Configure the benchmark image references

1. Set the two image references from Lab 2.

    Replace the placeholder values with your own OCIR references:

    ```bash
    export REGULAR_IMAGE="fra.ocir.io/<tenancy-namespace>/<repository-path>/testlp:pytorch-latest-regular"
    export ESTARGZ_IMAGE="fra.ocir.io/<tenancy-namespace>/<repository-path>/testlp:pytorch-latest-esgz"
    ```

2. Write the benchmark configuration file:

    ```bash
    sudo tee /etc/estargz-benchmark.env >/dev/null <<EOF
    REGISTRY="fra.ocir.io"
    ESTARGZ_IMAGE="${ESTARGZ_IMAGE}"
    REGULAR_IMAGE="${REGULAR_IMAGE}"
    CONTAINER_CMD="true"
    LOG_FILE="/var/log/estargz-benchmark.log"
    SUMMARY_FILE="/var/log/estargz-summary.txt"
    EOF
    ```

    If you used a different OCIR region, update the `REGISTRY` value.

3. Confirm the configuration:

    ```bash
    sudo cat /etc/estargz-benchmark.env
    ```

## Task 4: Run the benchmark

1. Start the benchmark:

    ```bash
    sudo /usr/local/bin/test-estargz.sh
    ```

2. Wait for both benchmark cases to complete.

    The script performs these steps:

    * resets containerd and stargz-snapshotter state
    * runs the eStargz image with the `stargz` snapshotter
    * resets state again
    * runs the regular image with the `overlayfs` snapshotter
    * writes a raw log
    * writes a clean summary

The regular image can take several minutes because it must download and prepare the full image before the container starts.

## Task 5: Review the benchmark results

1. View the summary:

    ```bash
    sudo cat /var/log/estargz-summary.txt
    ```

2. View the raw benchmark log:

    ```bash
    sudo cat /var/log/estargz-benchmark.log
    ```

3. Optional: inspect image and snapshot state after the run:

    ```bash
    sudo /usr/local/bin/nerdctl images
    sudo /usr/local/bin/nerdctl ps -a
    sudo /usr/local/bin/ctr images ls
    sudo /usr/local/bin/ctr snapshots ls
    sudo du -sh /var/lib/containerd
    sudo du -sh /var/lib/containerd-stargz-grpc
    ```

The benchmark uses `nerdctl run --rm`, so completed containers are removed automatically. It is normal for `nerdctl ps -a` to be empty.

## Task 6: Interpret the summary

1. Locate the eStargz result.

    In the summary, this result is labeled:

    ```text
    estargz lazy pull
    ```

    It uses:

    ```text
    snapshotter: stargz
    ```

2. Locate the regular image result.

    In the summary, this result is labeled:

    ```text
    regular baseline
    ```

    It uses:

    ```text
    snapshotter: overlayfs
    ```

3. Compare the `real_seconds` values.

    Lower `real_seconds` means faster time to first container start.

4. Review `downloaded_initially`.

    For eStargz, the initial download is usually much smaller because the filesystem data is fetched lazily. For the regular image, the initial download is usually much larger because the full image must be available before startup.

5. Review the improvement line.

    When both cases complete, the summary prints the improvement percentage for the eStargz startup time compared with the regular baseline.

## What to remember

eStargz optimizes time to first container start. Do not use image pull time as the main benchmark result.

The correct comparison is:

```text
eStargz image + stargz snapshotter
regular image + overlayfs snapshotter
```

The benchmark helper resets local container state before each case so the comparison focuses on startup behavior.

## Learn More

* [OCI Container Registry Documentation](https://docs.oracle.com/en-us/iaas/Content/Registry/home.htm)
* [containerd Documentation](https://containerd.io/docs/)
* [stargz-snapshotter Project](https://github.com/containerd/stargz-snapshotter)
* [nerdctl Command Reference](https://github.com/containerd/nerdctl/blob/main/docs/command-reference.md)

You may now proceed to the next lab.

## Acknowledgements

**Authors**

* **Adina Nicolescu**, Senior Cloud Engineer, NACIE
* **Last Updated By/Date** - Adina Nicolescu, June 2026
