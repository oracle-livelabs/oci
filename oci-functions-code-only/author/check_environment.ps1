$ErrorActionPreference = 'Stop'
$env:SUPPRESS_LABEL_WARNING = 'True'
$env:OCI_CLI_SUPPRESS_FILE_PERMISSIONS_WARNING = 'True'
$state = Get-Content -Raw -LiteralPath (Join-Path $PSScriptRoot 'state/resources.json') | ConvertFrom-Json
$checks = [System.Collections.Generic.List[object]]::new()
function Read-Oci {
    param([string[]]$Arguments)
    $region = if ($Arguments[0] -eq 'iam') { 'us-ashburn-1' } else { $state.region }
    $result = & oci @Arguments --region $region --output json
    if ($LASTEXITCODE -ne 0) { throw "Read failed: $($Arguments -join ' ')" }
    return ($result -join "`n" | ConvertFrom-Json).data
}
function Check {
    param([string]$Name, [bool]$Passed)
    $checks.Add(@{name=$Name;passed=$Passed})
    Write-Output "$(if ($Passed) {'PASS'} else {'FAIL'}) $Name"
}
$vcn = Read-Oci @('network','vcn','get','--vcn-id',$state.vcn_id)
$subnet = Read-Oci @('network','subnet','get','--subnet-id',$state.subnet_id)
$route = Read-Oci @('network','route-table','get','--rt-id',$state.route_table_id)
$security = Read-Oci @('network','security-list','get','--security-list-id',$state.security_list_id)
$gateway = Read-Oci @('network','service-gateway','get','--service-gateway-id',$state.service_gateway_id)
Check 'Private subnet is available and belongs to the lab VCN' ($subnet.'lifecycle-state' -eq 'AVAILABLE' -and $subnet.'vcn-id' -eq $vcn.id -and $subnet.'prohibit-public-ip-on-vnic')
Check 'Subnet uses the expected route table and security list' ($subnet.'route-table-id' -eq $route.id -and $subnet.'security-list-ids' -contains $security.id)
Check 'Oracle Services Network route uses the available service gateway' ($route.'route-rules'.Count -eq 1 -and $route.'route-rules'[0].'network-entity-id' -eq $gateway.id -and $route.'route-rules'[0].'destination-type' -eq 'SERVICE_CIDR_BLOCK' -and $gateway.'lifecycle-state' -eq 'AVAILABLE' -and -not $gateway.'block-traffic')
Check 'No ingress; only HTTPS egress to the Oracle Services Network' ($security.'ingress-security-rules'.Count -eq 0 -and $security.'egress-security-rules'.Count -eq 1 -and $security.'egress-security-rules'[0].protocol -eq '6' -and $security.'egress-security-rules'[0].'destination-type' -eq 'SERVICE_CIDR_BLOCK' -and $security.'egress-security-rules'[0].'tcp-options'.'destination-port-range'.min -eq 443 -and $security.'egress-security-rules'[0].'tcp-options'.'destination-port-range'.max -eq 443)
foreach ($purpose in @('incoming','output')) {
    $bucket = Read-Oci @('os','bucket','get','--namespace-name',$state.namespace,'--bucket-name',$state."${purpose}_bucket")
    Check "$purpose bucket is private, in LiveLab, with correct event setting" ($bucket.'compartment-id' -eq $state.compartment_id -and $bucket.'public-access-type' -eq 'NoPublicAccess' -and $bucket.'object-events-enabled' -eq ($purpose -eq 'incoming'))
}
$group = Read-Oci @('iam','dynamic-group','get','--dynamic-group-id',$state.dynamic_group_id)
$expectedMatch = "ALL {resource.type = 'fnfunc', resource.compartment.id = '$($state.compartment_id)'}"
Check 'Dynamic group matches only functions in LiveLab' ($group.'matching-rule' -eq $expectedMatch)
$policy = Read-Oci @('iam','policy','get','--policy-id',$state.policy_id)
$expectedStatements = @(
    "Allow dynamic-group LiveLabInventoryFunctions to read objects in compartment id $($state.compartment_id) where target.bucket.name = 'livelab-inventory-incoming'",
    "Allow dynamic-group LiveLabInventoryFunctions to manage objects in compartment id $($state.compartment_id) where all {target.bucket.name = 'livelab-inventory-output', any {request.permission = 'OBJECT_CREATE', request.permission = 'OBJECT_OVERWRITE'}}",
    "Allow service faas to use virtual-network-family in compartment id $($state.compartment_id)",
    "Allow service faas to read objects in compartment id $($state.compartment_id) where all {target.bucket.name = 'livelab-inventory-incoming', target.object.name = 'deployment/inventory-reporter.zip'}"
)
Check 'Lab policy contains exactly the four approved scoped statements' (@(Compare-Object $expectedStatements $policy.statements).Count -eq 0)
$app = Read-Oci @('fn','application','get','--application-id',$state.application_id)
Check 'Application is Active, x86, and uses the lab subnet' ($app.'lifecycle-state' -eq 'ACTIVE' -and $app.shape -eq 'GENERIC_X86' -and $app.'subnet-ids'.Count -eq 1 -and $app.'subnet-ids'[0] -eq $state.subnet_id)
Check 'Application configuration points to lab buckets and threshold 10' ($app.config.INPUT_BUCKET -eq $state.incoming_bucket -and $app.config.OUTPUT_BUCKET -eq $state.output_bucket -and $app.config.OBJECT_STORAGE_NAMESPACE -eq $state.namespace -and $app.config.LOW_STOCK_THRESHOLD -eq '10')
$log = Read-Oci @('logging','log','get','--log-group-id',$state.log_group_id,'--log-id',$state.log_id)
Check 'Application invocation logging is enabled' ($log.'is-enabled' -and $log.configuration.source.resource -eq $state.application_id -and $log.configuration.source.category -eq 'invoke')
$report = @{checked_at=[DateTime]::UtcNow.ToString('o');region=$state.region;checks=@($checks.ToArray());scope='Configuration read-back only; execution and IAM effectiveness require cloud tests.'}
$report | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath (Join-Path $PSScriptRoot 'state/environment-checks.json') -Encoding utf8
if (@($checks | Where-Object {-not $_.passed}).Count) { throw 'One or more environment checks failed.' }
