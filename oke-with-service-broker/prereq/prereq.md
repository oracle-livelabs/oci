# Install Prerequisites

## Introduction

You will install the software required to run the stack to deploy an Oracle Kubernetes Engine (OKE) cluster with Oracle Cloud Infrastructure (OCI) Service Broker.

Note that you must install `kubectl`, as well as Helm, to run the stack. This is because the OCI Service Broker depends on Service Catalog, as well as the key value store, `etcd`, all of which are deployed as Helm charts in Kubernetes. Furthermore, the OCI command-line interface (CLI) is used for some tasks and is required for `kubectl`.

Estimated Time: 10 minutes.

### Objectives

- Install the OCI CLI.
- Install `kubectl` 1.18 or later if not already present.
- install Helm 3.x.

## Task 1: Install the Oracle Cloud Infrastructure CLI

1. To install the Oracle Cloud Infrastructure (OCI) CLI on Linux or Mac OS X, run the following command:

    ```bash
    <copy>
    bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"
    </copy>
    ```

    Press **Enter** to use the defaults for all options.

2. Restart your shell.

    ```bash
    <copy>
    exec -l $SHELL
    </copy>
    ```

3. Configure the OCI CLI.

    ```bash
    <copy>
    oci setup config
    </copy>
    ```

    You will be prompted for:
    - Location of the config. Press **Enter**.
    - `user_ocid`: enter your user OCID.
    - `tenancy_ocid`: enter your tenancy OCID.
    - `region`: enter your region from the list provided.
    - Generate a RSA key pair: press **Enter** for Yes (default).
    - Directory for keys: press **Enter** for the default.
    - name for the key: press **Enter** for the default.
    - Passphrase: press **Enter** for no passphrase.


    You should see an output like:

    ```bash
    Private key written to: /home/oracle/.oci/oci_api_key.pem
    Fingerprint: 21:d4:f1:a0:55:a5:c2:ce:...
    Config written to ~/.oci/config
    ```


4. Upload the public key to your OCI account

    Before you can use the OCI CLI, you must upload the public key to your user account.

    Get the key content with:

    ```bash
    <copy>
    cat ~/.oci/oci_api_key_public.pem
    </copy>
    ```

    Alternatively, you can open the file with your preferred editor and copy the full printed output to the clipboard.

5. In the Oracle Cloud console, from navigation menu, select **Users** and then click **User Settings**, and then do the following:

    - Click **API Keys**.
    - Click **Add Public Key**.
    - Click **Paste Public Key**.
    - Paste the key copied above.
    - Click **Add**.

    You can verify that the fingerprint generated matches the fingerprint output of the configuration.

6. Test the OCI CLI:

    ```bash
    <copy>
    oci os ns get
    </copy>
    ```

    This command should output the namespace of your tenancy (usually the name of the tenancy or a randomized string).

    ```json
    {
        "data": "your-tenancy-namespace"
    }
    ```

7. Make a note of this name for later.

## Task 2: Install `kubectl`

**Note**: If you are using Docker Desktop on Mac OS X or Windows, `kubectl` should already be installed, and you can skip the install step.

1. To install `kubectl` run:

    ```bash
    <copy>
    PLATFORM=$(uname)
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/${PLATFORM,,}/amd64/kubectl"
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
    </copy>
    ```

    On Windows use:

    ```bash
    <copy>
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.20.0/bin/windows/amd64/kubectl.exe
    </copy>
    ```

    Add the binary to your PATH variable.

    For more detailed instructions, go to:
    [https://kubernetes.io/docs/tasks/tools/install-kubectl/](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

2. Use the following command to make sure you are using kubectl 1.18 or later:

    ```bash
    <copy>
    kubectl version --client
    </copy>
    ```

## Task 3: Install Helm

1. To install helm on Mac OS X and Linux, use:

    ```bash
    <copy>
    curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
    </copy>
    ```

    For more detailed instructions for your specific OS, go to:
    [https://helm.sh/docs/intro/install/](https://helm.sh/docs/intro/install/).

## Task 4: Check OpenSSL

1. Make sure you have OpenSSL installed with

    ```bash
    <copy>
    openssl version
    </copy>
    ```

    See if the command is found or fails.

    It should be present by default on your machine.

## Acknowledgements

 - **Author** - Emmanuel Leroy, January 2021
 - **Last Updated By/Date** - Emmanuel Leroy, January 2021
