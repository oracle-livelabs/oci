# Jaeger on OCI Compute

This Terraform automation deploys CNCF Jaeger on a single Oracle Cloud Infrastructure Compute VM.

The deployment is intentionally VM-based rather than OKE-based so it stays fast, inexpensive, and easy to inspect. It creates the OCI networking, provisions one Oracle Linux instance, installs Docker, and runs Jaeger as an all-in-one container. It can also start the Jaeger HotROD demo application and generate sample traces automatically.

Jaeger 2.19 is the current latest documentation line as of June 2026. The official Jaeger getting started guide shows the all-in-one container exposing the UI on `16686`, OTLP on `4317` and `4318`, sampling on `5778`, and Zipkin compatibility on `9411`: https://www.jaegertracing.io/docs/latest/getting-started/

## Architecture

- VCN with one public subnet
- Internet gateway and public route table
- Security list allowing:
  - SSH: `22`
  - Jaeger UI: `16686`
  - OTLP gRPC: `4317`
  - OTLP HTTP: `4318`
  - HotROD demo: `8080`
- One Oracle Linux compute instance
- Docker and Docker Compose plugin installed by cloud-init
- Jaeger all-in-one container
- Optional HotROD demo container

## Files

- `main.tf` wires together the root modules.
- `variables.tf` defines OCI, network, compute, and Jaeger inputs.
- `terraform.tfvars` contains the editable sample deployment values.
- `outputs.tf` prints the Jaeger UI URL, OTLP endpoints, HotROD URL, SSH command, and post-deployment next steps.
- `modules/network` creates VCN, gateways, route tables, security lists, and subnets.
- `modules/instances` creates the VM and injects cloud-init.
- `userdata/cloudinit.sh.tftpl` installs Docker and starts Jaeger.

## Prerequisites

- Terraform installed locally.
- OCI API credentials configured in `provider.auto.tfvars`.
- A target compartment OCID in `provider.auto.tfvars`.
- An SSH key pair accessible from the machine running Terraform.

Example provider shape:

```hcl
provider_oci = {
  tenancy_ocid     = "ocid1.tenancy.oc1..example"
  user_ocid        = "ocid1.user.oc1..example"
  fingerprint      = "<api-key-fingerprint>"
  private_key_path = "/path/to/oci_api_key.pem"
  region           = "eu-frankfurt-1"
}

compartment_ids = {
  target = "ocid1.compartment.oc1..example"
}
```

## Populate Customer Values

Before applying, populate the placeholder values in these two files.

### `provider.auto.tfvars`

Set the OCI provider and compartment values:

- `provider_oci.tenancy_ocid`: tenancy OCID.
- `provider_oci.user_ocid`: user OCID for API key authentication.
- `provider_oci.fingerprint`: API key fingerprint.
- `provider_oci.private_key_path`: local path to the OCI API private key.
- `provider_oci.private_key_password`: private key password, or an empty string if the key has no password.
- `provider_oci.region`: target OCI region.
- `compartment_ids.target`: compartment OCID where the stack will be deployed.

### `terraform.tfvars`

Set the deployment values:

- `linux_images`: Oracle Linux image OCID for each OCI region you plan to use.
- `instance_params.jaeger_vm.ad`: availability domain number valid in the selected region.
- `instance_params.jaeger_vm.shape`: compute shape.
- `instance_params.jaeger_vm.ocpus`: OCPU count for flexible shapes.
- `instance_params.jaeger_vm.memory_in_gbs`: memory for flexible shapes.
- `instance_params.jaeger_vm.ssh_private_key`: local path to the SSH private key used by the output SSH command.
- `ssh_public_key`: local path to the SSH public key injected into the VM.
- `sl_params.jaeger_sl.ingress_rules[*].source`: replace `0.0.0.0/0` with trusted CIDR ranges for SSH, Jaeger UI, OTLP, and HotROD access.
- `jaeger_config`: Jaeger image, HotROD image, ports, and demo trace generation settings. The sample uses `cr.jaegertracing.io/jaegertracing/jaeger:2.19.0`.

The default compartment key is `target`. If you rename it in `provider.auto.tfvars`, update every matching `compartment_name` reference in `terraform.tfvars`.

## Deploy

Run the commands from this folder.

1. Initialize Terraform:

```powershell
terraform init
```

2. Check formatting and syntax:

```powershell
terraform fmt -check -recursive
terraform validate
```

3. Review the planned OCI resources:

```powershell
terraform plan
```

Check that the plan creates:

- one VCN
- one public subnet
- one internet gateway
- one route table
- one security list
- one compute instance

4. Apply the configuration:

```powershell
terraform apply
```

5. Save the outputs from the end of the apply:

- `jaeger_ui_urls`: open the Jaeger UI.
- `hotrod_urls`: open the demo app.
- `otlp_grpc_endpoints`: send traces over OTLP gRPC.
- `otlp_http_endpoints`: send traces over OTLP HTTP.
- `ssh_commands`: connect to the VM.
- `next_steps`: follow the generated demo and validation checklist.

Cloud-init can continue running for a few minutes after Terraform reports the VM as created. If the URLs do not respond immediately, wait 2-5 minutes and retry.

## Test The Demo

1. Open the Jaeger UI from the `jaeger_ui_urls` output.

The UI should load on port `16686`.

2. Open the HotROD demo from the `hotrod_urls` output.

The demo should load on port `8080`.

3. In HotROD, trigger a few requests by using the UI.

Each request simulates a ride-sharing workflow and emits traces to Jaeger.

4. Go back to the Jaeger UI.

In the search view:

- Select service `frontend`.
- Click `Find Traces`.
- Open one of the returned traces.

You should see a trace with multiple spans representing the HotROD request path.

## Test From SSH

On the VM:

```bash
jaeger-status
jaeger-generate-traces
```

`jaeger-status` shows the running Jaeger containers and checks the local UI.

`jaeger-generate-traces` sends requests to the HotROD demo. In the Jaeger UI, search for service `frontend` to see those traces.

Example flow:

```powershell
# Use the value from the ssh_commands Terraform output.
ssh -i /path/to/ssh_private_key opc@<public_ip>
```

Then on the VM:

```bash
jaeger-status
jaeger-generate-traces 20 1
```

The first argument is the number of HotROD requests. The second argument is the delay in seconds between requests.

## What To Check

In OCI:

- The compute instance is running.
- The instance has a public IP.
- The security list allows your client IP to reach ports `22`, `16686`, and `8080`.
- Ports `4317` and `4318` are open only if you plan to send OTLP traces from outside the VM.

On the VM:

```bash
docker ps
systemctl status jaeger.service --no-pager
journalctl -u jaeger.service --no-pager
cloud-init status --long
```

Expected containers:

- `jaeger`
- `jaeger-hotrod`, when `jaeger_config.enable_hotrod = true`

Expected local checks:

```bash
curl -I http://127.0.0.1:16686/
curl -I http://127.0.0.1:8080/
```

The HotROD check applies when `jaeger_config.enable_hotrod = true`.

## Troubleshooting

If the Jaeger UI is empty:

- Open HotROD and generate a few requests.
- SSH to the VM and run `jaeger-generate-traces 20 1`.
- In Jaeger, search for service `frontend`.
- Widen the lookback window in the Jaeger UI.

If the browser cannot reach Jaeger:

- Confirm the VM public IP from Terraform output or OCI Console.
- Confirm your source IP is allowed in `terraform.tfvars`.
- Confirm cloud-init completed with `cloud-init status --long`.
- Check Docker with `docker ps`.

If Terraform apply succeeds but containers are missing:

```bash
sudo tail -n 200 /var/log/cloud-init-output.log
sudo systemctl restart jaeger.service
sudo journalctl -u jaeger.service --no-pager
```

## Notes

The default Jaeger all-in-one mode uses in-memory trace storage. This is right for demos and learning automation, but it is not a durable production topology. For a production design, add an external backend such as OpenSearch, Elasticsearch, Cassandra, or another Jaeger-supported store, and restrict all ingress with private networking or a controlled load balancer.
