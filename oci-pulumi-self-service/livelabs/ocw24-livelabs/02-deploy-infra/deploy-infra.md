# Start your first Pulumi stack and deploy Backstage

## Introduction

In this lab you will create your first Pulumi stack from a pre-built YAML template. The stack will deploy the open source project Backstage on [OCI Container Instances](https://www.oracle.com/cloud/cloud-native/container-instances/).

Estimated time: 20 minutes

### Objectives

* Set up and run your first Pulumi stack
* Access the Backstage portal
* Create a new environment in Pulumi

## Task 1: Download the code and configure Pulumi

1. Within your lab environment (Compute instance or local machine), clone the source code repository.

    ```bash
    <copy>
    git clone https://github.com/enschilling/oci-pulumi-self-service.git
    cd oci-pulumi-self-service/00-backstage
    </copy>
    ```

2. Confirm Pulumi installed successfully.

    ```bash
    <copy>pulumi --help</copy>
    ```

    **Output should look something like...**

    ```bash
    Pulumi - Modern Infrastructure as Code

    To begin working with Pulumi, run the `pulumi new` command:

        $ pulumi new

    This will prompt you to create a new project for your cloud and language of choice.

    The most common commands from there are:

        - pulumi up       : Deploy code and/or resource changes
        - pulumi stack    : Manage instances of your project
        - pulumi config   : Alter your stack"'"s configuration or secrets
        - pulumi destroy  : Tear down your stack"'"s resources entirely

    For more information, please visit the project page: https://www.pulumi.com/docs/
    ```

## Create a Python virtual environment and install the Pulumi OCI provider

1. Create a new Python virtual environment with Python 3.10

    ```bash
    <copy>
    python3 -m venv venv
    source venv/bin/activate
    </copy>
    ```

    You should now see `(venv)` at the beginning of of your terminal prompt.

2. Install the Pulumi OCI provider

    ```
    pip install pulumi_oci
    ```

3. Create your first Pulumi stack.

    ```bash
    <copy>
    pulumi config
    </copy>
    ```

    Whem prompted to log in, paste your Pulumi Personal Access Token that you created in lab 1. You will then be prompted:

    ```bash
    (venv) ubuntu@instance:~/oci-pulumi-self-service/livelabs/ocw24-livelabs/99-resources/00-backstage$ pulumi config
    Manage your Pulumi stacks by logging in.
    Run `pulumi login --help` for alternative login options.
    Enter your access token from https://app.pulumi.com/account/tokens
        or hit <ENTER> to log in using your browser                   : *********************************


    Welcome to Pulumi!

    Pulumi helps you create, deploy, and manage infrastructure on any cloud using
    your favorite language. You can get started today with Pulumi at:

        https://www.pulumi.com/docs/get-started/

    Tip: Resources you create with Pulumi are given unique names (a randomly
    generated suffix) by default. To learn more about auto-naming or customizing resource
    names see https://www.pulumi.com/docs/intro/concepts/resources/#autonaming.


    Please choose a stack, or create a new one:  [Use arrows to move, type to filter]
    > <create a new stack>
    ```

4. Provide a name the stack (e.g. OCW-2024) and press enter.

## Task 2: Build out your Pulumi project

1. Now that you have a Pulumi stack, you'll need to provide some environment configuration details. Copy the commands below to a text file and replace the `<placeholder>` values with the data you gathered in lab 1.

    ```bash
    <copy>
    pulumi config set oci:region <chosen region>
    pulumi config set username <your usernam> # for the Oracle Container Registry
    pulumi config set auth-token <your auth token> --secret # for the Oracle Container Registry
    pulumi config set github-token <your github PAT> --secret 
    pulumi config set pulumi-pat <your Pulumi personal access token> --secret
    pulumi config set compartment_ocid <your compartment OCID>
    pulumi config set tenancy_ocid <your tenancy OCID>
    </copy>
    ```

2. Double check to ensure all the values were stored properly.

    ```bash
    <copy>pulumi config</copy>
    ```

    Output should look like this. Notice how the value of the secrets is not displayed:

    ```bash
    KEY               VALUE
    auth-token        [secret]
    pulumi-pat        [secret]
    github-token      [secret]
    compartment_ocid  ocid1.compartment.oc1..aa00000000000000000000000000000000000000000000006a
    tenancy_ocid      ocid1.tenancy.oc1.aa999999999999999999999999999999999999999999999b
    username          el123456g@domain.com
    oci:region        us-ashburn-1
    ```


3. Bring the Pulumi project online.

    ```bash
    <copy>pulumi up</copy>
    ```

4. Pulumi will evaluate the contents of the stack, show a preview, and prompt for confirmation before creating anything.

    ```bash
    Previewing update (pulumi-stack)

    View in Browser (Ctrl+O): https://app.pulumi.com/elischilling/00-backstage/pulumi-stack/previews/fd611c60-57a0-4ae8-a157-faddc811a8e7

        Type                                      Name                          Plan
    +   pulumi:pulumi:Stack                       00-backstage-pulumi-stack     create
    +   ├─ command:local:Command                  backstageBuild                create
    +   ├─ oci:Core:Vcn                           backstageVcn                  create
    +   ├─ oci:Artifacts:ContainerRepository      backstageContainerRepository  create
    +   ├─ oci:Core:InternetGateway               backstageInternetGateway      create
    +   ├─ oci:Core:SecurityList                  backstageSecurityList         create
    +   ├─ oci:Core:RouteTable                    backstageRouteTable           create
    +   ├─ oci:Core:Subnet                        backstageSubnet               create
    +   ├─ docker:index:Image                     backstageImage                create
    +   └─ oci:ContainerEngine:ContainerInstance  backstageContainerInstance    create

    Outputs:
        backstageUrl: output<string>
        image       : output<string>

    Resources:
        + 10 to create

    Do you want to perform this update? 
    ```

5. Use the up arrow on your keyboard to select `Yes` and press enter. The resources will be provisioned. When it has finished, you should see a `backstageUrl` in the **Outputs:** section. Copy and paste that into your browser.

    ![View the Backstage dashboard](images/backstage-dashboard.png)

## Task 3: Create a new Pulumi Environment
Pulumi environments, secrets, and configuration - or ESC for short - enables teams to centralize secrets and configuration data in a central repository. ESC is intended to provide frictionless security, improve developer efficiency, enhance compliance, and mitigate sprawl. On top of that, ESC easiliy integrates with a variety of platforms, making it a cinch to add to your IaC efforts.

1. Return to the app.pulumi.com portal, making sure you're logged in, and click **Environments** on the left navigation menu.

2. Click **`[Create Environment]`** and supply a name for the environment: `oci-pulumi-self-service`.

    >Note: If you enter a different name for the Environment, lab 3 will not work properly.

3. You will now see a new environment definition with some sample information. You can go ahead and delete everything you see there.

    ![Sample environment definition](images/esc-new-environment-01.png)

4. Copy and paste the following into the Environment Definition.

    ```bash
    <copy>
    # values is a required top-level key
    values:
      oracle:
        default:
          userOcid: <you user OCID here>>
            fingerprint: <your API key fingerprint here>>
            tenancyOcid: <your tenancy OCID here>
            region: <your selected region here>
            privateKey:
              fn::secret: "<paste API private key contents here>"
      # Configuration nested under the "pulumiConfig" key will be available to Pulumi stacks that
      # reference this Environment during `pulumi up/preview/refresh/destroy`
      pulumiConfig:
        oci:userOcid: ${oracle.default.userOcid}
        oci:fingerprint: ${oracle.default.fingerprint}
        oci:tenancyOcid: ${oracle.default.tenancyOcid}
        oci:region: ${oracle.default.region}
        oci:privateKey: ${oracle.default.privateKey}
    </copy>
    ```

    >Note: Your pasted values should look something like this:

    ```bash
    # values is a required top-level key
    values:
      oracle:
        default:
          userOcid: ocid1.user.oc1..aaaaasldkjfasdfasdfasdfasdfa56kypvlma
          fingerprint: 2b:2b:99:00:11:22:b2:2b:2b:88:2b:88:2n:ab:2b:99
          tenancyOcid: ocid1.tenancy.oc1..aaaaaaaaasdfasfdasdfasdfasdfasdfasfdadsfasda
          region: us-ashburn-1
          privateKey:
            fn::secret: "-----BEGIN PRIVATE KEY-----
            blah blah blah
            blah blah blah
            -----END PRIVATE KEY-----"
      # Configuration nested under the "pulumiConfig" key will be available to Pulumi stacks that
      # reference this Environment during `pulumi up/preview/refresh/destroy`
      pulumiConfig:
        oci:userOcid: ${oracle.default.userOcid}
        oci:fingerprint: ${oracle.default.fingerprint}
        oci:tenancyOcid: ${oracle.default.tenancyOcid}
        oci:region: ${oracle.default.region}
        oci:privateKey: ${oracle.default.privateKey}
    ```

5. Click the **`[Save]`** button to store your environment details.  You'll notice that the contents of your private key are replaced with `cipherText:` and a hash, as the value of your secret is encrypted, then stored.

6. Go ahead and return to the Backstage dashboard.

You may now **proceed to the next lab**.

## Learn More

* [Backstage open source project](https://backstage.io/)
* [Pulumi ESC](https://www.pulumi.com/product/esc/)

## Acknowledgements

* **Author** - Eli Schilling - Technical Architect
* **Contributors** -
* **Last Updated By/Date** - August, 2024