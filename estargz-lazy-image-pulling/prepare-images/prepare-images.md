# Prepare benchmark images

## Introduction

In this lab, we will prepare the two container images required for the eStargz benchmark: a regular image and an eStargz image.

The infrastructure deployed in the previous lab created an Oracle Linux VM on OCI with `containerd`, `nerdctl`, and `stargz-snapshotter`. We will use that VM to pull a source image, push the regular image to OCIR, create the eStargz image, and push the eStargz image to OCIR.

Estimated Time: 30 minutes

### Objectives

In this lab, you will:

* Connect to the benchmark VM.
* Log in to OCIR from the VM.
* Select a source image for the benchmark.
* Push the regular image to OCIR.
* Create and push an eStargz image to OCIR.
* Record both image references for the benchmark lab.

### **Prerequisites**

This lab assumes you have:

* Completed Lab 1
* SSH access to the benchmark VM
* An OCIR repository or permission to create one
* Your tenancy namespace
* An OCI username with OCIR access
* An OCI auth token for the OCIR login password

If you already have both a regular image and a matching eStargz image in OCIR, you can skip the creation steps and record those two image references in Task 6.

## Task 1: Connect to the benchmark VM

1. From your local terminal, connect to the VM created in Lab 1:

    ```bash
    ssh -i ~/.ssh/id_rsa opc@<public_ip>
    ```

2. Confirm the image tooling is available:

    ```bash
    command -v /usr/local/bin/nerdctl
    command -v /usr/local/bin/ctr-remote
    sudo /usr/local/bin/nerdctl version
    ```

## Task 2: Define the image references

1. Review the generic image reference syntax.

    The benchmark uses one regular image and one eStargz image:

    ```text
    <registry>/<tenancy-namespace>/<repository-path>/<image-name>:<regular-tag>
    <registry>/<tenancy-namespace>/<repository-path>/<image-name>:<estargz-tag>
    ```

    Example:

    ```text
    fra.ocir.io/<tenancy-namespace>/estargz/testlp:pytorch-latest-regular
    fra.ocir.io/<tenancy-namespace>/estargz/testlp:pytorch-latest-esgz
    ```

2. Set the values that are specific to your tenancy.

    Replace only the values inside angle brackets:

    ```bash
    export REGISTRY="fra.ocir.io"
    export NAMESPACE="<tenancy-namespace>"
    export REPOSITORY="<repository-path>"
    ```

    For example:

    ```bash
    export REGISTRY="fra.ocir.io"
    export NAMESPACE="<tenancy-namespace>"
    export REPOSITORY="estargz"
    ```

3. Set the workshop image values.

    You can copy and run this block as-is:

    ```bash
    export IMAGE_NAME="testlp"
    export SOURCE_IMAGE="docker.io/pytorch/pytorch:latest"

    export REGULAR_IMAGE="${REGISTRY}/${NAMESPACE}/${REPOSITORY}/${IMAGE_NAME}:pytorch-latest-regular"
    export ESTARGZ_IMAGE="${REGISTRY}/${NAMESPACE}/${REPOSITORY}/${IMAGE_NAME}:pytorch-latest-esgz"
    ```

    This lab uses `docker.io/pytorch/pytorch:latest` because it is a large, generic public image. The image size helps make the startup difference visible in the benchmark.

4. Review the final image references:

    ```bash
    echo ${REGULAR_IMAGE}
    echo ${ESTARGZ_IMAGE}
    ```

Very small images, such as `busybox`, are useful for connectivity tests but usually do not demonstrate the eStargz benefit clearly.

## Task 3: Log in to OCIR

1. Log in to OCIR with `nerdctl`:

    ```bash
    sudo /usr/local/bin/nerdctl login ${REGISTRY}
    ```

    With the default workshop registry, this is:

    ```bash
    sudo /usr/local/bin/nerdctl login fra.ocir.io
    ```

2. When prompted, provide your OCIR username.

    For OCIR, the username is usually:

    ```text
    <tenancy-namespace>/<oci-username>
    ```

3. For the password, use an OCI auth token.

## Task 4: Push the regular image to OCIR

The regular image is the baseline image. It is stored in OCIR without eStargz optimization.

1. Pull the source image:

    ```bash
    sudo /usr/local/bin/nerdctl pull ${SOURCE_IMAGE}
    ```

    With the default workshop image, this is:

    ```bash
    sudo /usr/local/bin/nerdctl pull docker.io/pytorch/pytorch:latest
    ```

    This image is large, so the pull can take several minutes.

2. Tag it with the OCIR regular image reference:

    ```bash
    sudo /usr/local/bin/nerdctl tag ${SOURCE_IMAGE} ${REGULAR_IMAGE}
    ```

    If you used the workshop variables, the command above expands to a tag similar to:

    ```bash
    sudo /usr/local/bin/nerdctl tag docker.io/pytorch/pytorch:latest fra.ocir.io/<tenancy-namespace>/<repository-path>/testlp:pytorch-latest-regular
    ```

    You can check it with:

    ```bash
    sudo /usr/local/bin/nerdctl images
    ```

3. Push the regular image to OCIR:

    ```bash
    sudo /usr/local/bin/nerdctl push ${REGULAR_IMAGE}
    ```

    Generic syntax:

    ```bash
    sudo /usr/local/bin/nerdctl push fra.ocir.io/<tenancy-namespace>/<repository-path>/testlp:pytorch-latest-regular
    ```

4. Confirm the image is available locally:

    ```bash
    sudo /usr/local/bin/nerdctl images | grep ${IMAGE_NAME}
    ```

5. In the OCI Console, confirm that the image was pushed to the expected repository. If the repository does not appear in your selected compartment, check the root compartment. OCIR can automatically create a repository there when you push an image to a repository path that does not already exist.

## Task 5: Create and push the eStargz image

The eStargz image uses the same application content as the regular image, but the image layers are optimized for lazy startup.

1. Convert the regular image to eStargz format(the conversion can take a few minutes):

    ```bash
    sudo /usr/local/bin/nerdctl image convert --estargz --oci ${REGULAR_IMAGE} ${ESTARGZ_IMAGE}
    ```

    Generic syntax:

    ```bash
    sudo /usr/local/bin/nerdctl image convert --estargz --oci \
      fra.ocir.io/<tenancy-namespace>/<repository-path>/testlp:pytorch-latest-regular \
      fra.ocir.io/<tenancy-namespace>/<repository-path>/testlp:pytorch-latest-esgz
    ```

2. Push the eStargz image to OCIR:

    ```bash
    sudo /usr/local/bin/nerdctl push ${ESTARGZ_IMAGE}
    ```

    Generic syntax:

    ```bash
    sudo /usr/local/bin/nerdctl push fra.ocir.io/<tenancy-namespace>/<repository-path>/testlp:pytorch-latest-esgz
    ```

3. Confirm both image taestargz are present:

    ```bash
    sudo /usr/local/bin/nerdctl images | grep ${IMAGE_NAME}
    ```

## Task 6: Record the benchmark image references

1. Print the two image references:

    ```bash
    echo "REGULAR_IMAGE=${REGULAR_IMAGE}"
    echo "ESTARGZ_IMAGE=${ESTARGZ_IMAGE}"
    ```

2. Save these values for the next lab.

    The values should look similar to:

    ```text
    REGULAR_IMAGE=fra.ocir.io/<tenancy-namespace>/<repository-path>/testlp:pytorch-latest-regular
    ESTARGZ_IMAGE=fra.ocir.io/<tenancy-namespace>/<repository-path>/testlp:pytorch-latest-esgz
    ```

The benchmark lab uses these two image references to compare regular startup against eStargz lazy startup.

## What to remember

eStargz improves time to first container start. Avoid using image pull time as the benchmark result. The correct comparison is regular image startup versus eStargz image startup after the benchmark script resets the local container state.

## Learn More

* [OCI Container Registry Documentation](https://docs.oracle.com/en-us/iaas/Content/Registry/home.htm)
* [Pushing Images Using Docker CLI](https://docs.oracle.com/en-us/iaas/Content/Registry/Tasks/registrypushingimagesusingthedockercli.htm)
* [stargz-snapshotter Project](https://github.com/containerd/stargz-snapshotter)
* [nerdctl Command Reference](https://github.com/containerd/nerdctl/blob/main/docs/command-reference.md)

You may now proceed to the next lab.

## Acknowledgements

**Authors**

* **Adina Nicolescu**, Senior Cloud Engineer, NACIE
* **Last Updated By/Date** - Adina Nicolescu, June 2026
