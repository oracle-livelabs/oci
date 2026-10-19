param(
    [Parameter(Mandatory = $true)]
    [string]$CompartmentId,
    [string]$Region = 'us-chicago-1',
    [string]$HomeRegion = 'us-ashburn-1'
)
$ErrorActionPreference = 'Stop'
$env:SUPPRESS_LABEL_WARNING = 'True'
$env:OCI_CLI_SUPPRESS_FILE_PERMISSIONS_WARNING = 'True'
$stateDirectory = Join-Path $PSScriptRoot 'state'
New-Item -ItemType Directory -Force -Path $stateDirectory | Out-Null
$cliPath = (Get-Command oci).Source
$tags = @{ Workshop = 'from-code-to-cloud'; ManagedBy = 'functions-livelab' }
$state = [ordered]@{ region = $Region; compartment_id = $CompartmentId }
$existingStatePath = Join-Path $stateDirectory 'resources.json'
if (Test-Path -LiteralPath $existingStatePath) {
    $existingState = Get-Content -Raw -LiteralPath $existingStatePath | ConvertFrom-Json
    if ($existingState.region -ne $Region -or $existingState.compartment_id -ne $CompartmentId) {
        throw 'Existing state belongs to a different lab scope. Use a separate authoring directory.'
    }
    foreach ($property in $existingState.psobject.Properties) { $state[$property.Name] = $property.Value }
}

function Save-State {
    $state | ConvertTo-Json -Depth 30 | Set-Content -LiteralPath (Join-Path $stateDirectory 'resources.json') -Encoding utf8
}
function Invoke-Oci {
    param([string[]]$Arguments, [hashtable]$InputData)
    $requestRegion = if ($Arguments[0] -eq 'iam') { $HomeRegion } else { $Region }
    $cliArguments = @($Arguments) + @('--region', $requestRegion, '--output', 'json')
    if ($InputData) {
        $inputPath = Join-Path $stateDirectory 'request.json'
        $InputData | ConvertTo-Json -Depth 30 | Set-Content -LiteralPath $inputPath -Encoding utf8NoBOM
        $cliArguments += @('--from-json', "file://$inputPath")
    }
    $output = & $cliPath @cliArguments
    if ($LASTEXITCODE -ne 0) { throw "OCI command failed: $($Arguments -join ' ')" }
    if ($output) { return ($output -join "`n" | ConvertFrom-Json) }
    return $null
}
function Select-LabResource {
    param($Items, [string]$Name, [string]$NameProperty = 'display-name')
    $matches = @($Items | Where-Object { $_.$NameProperty -eq $Name -and $_.'lifecycle-state' -notin @('DELETED','DELETING','TERMINATED','TERMINATING') })
    if ($matches.Count -gt 1) { throw "Multiple resources named $Name; select one manually." }
    if ($matches.Count -eq 1) {
        if ($matches[0].'freeform-tags'.ManagedBy -ne 'functions-livelab') {
            throw "Existing $Name is not marked as managed by this lab. No changes made to it."
        }
        return $matches[0]
    }
    return $null
}

$compartment = (Invoke-Oci -Arguments @('iam','compartment','get','--compartment-id',$CompartmentId)).data
if ($compartment.name -ne 'LiveLab' -or $compartment.'lifecycle-state' -ne 'ACTIVE') { throw 'Expected the active LiveLab compartment.' }
$tenancyId = $compartment.'compartment-id'
$namespace = (Invoke-Oci -Arguments @('os','ns','get')).data
$state.namespace = $namespace
Save-State

$services = (Invoke-Oci -Arguments @('network','service','list')).data
$service = @($services | Where-Object { $_.name -like 'All * Services In Oracle Services Network' })
if ($service.Count -ne 1) { throw 'Could not identify the regional Oracle Services Network service.' }
$service = $service[0]

$vcn = Select-LabResource (Invoke-Oci -Arguments @('network','vcn','list','--compartment-id',$CompartmentId,'--all')).data 'livelab-functions-vcn'
if (-not $vcn) {
    Write-Host 'Creating private Functions network...'
    $vcn = (Invoke-Oci -Arguments @('network','vcn','create','--wait-for-state','AVAILABLE','--wait-interval-seconds','2') -InputData @{
        compartmentId=$CompartmentId; displayName='livelab-functions-vcn'; cidrBlock='10.42.0.0/16'; dnsLabel='livelab'; freeformTags=$tags
    }).data
}
$state.vcn_id = $vcn.id
Save-State

$gateway = Select-LabResource (Invoke-Oci -Arguments @('network','service-gateway','list','--compartment-id',$CompartmentId,'--vcn-id',$vcn.id,'--all')).data 'livelab-service-gateway'
if (-not $gateway) {
    $gateway = (Invoke-Oci -Arguments @('network','service-gateway','create','--wait-for-state','AVAILABLE','--wait-interval-seconds','2') -InputData @{
        compartmentId=$CompartmentId; displayName='livelab-service-gateway'; vcnId=$vcn.id; services=@(@{serviceId=$service.id}); freeformTags=$tags
    }).data
}
$state.service_gateway_id = $gateway.id
Save-State

$route = Select-LabResource (Invoke-Oci -Arguments @('network','route-table','list','--compartment-id',$CompartmentId,'--vcn-id',$vcn.id,'--all')).data 'livelab-functions-routes'
if (-not $route) {
    $route = (Invoke-Oci -Arguments @('network','route-table','create') -InputData @{
        compartmentId=$CompartmentId; displayName='livelab-functions-routes'; vcnId=$vcn.id; freeformTags=$tags
        routeRules=@(@{destination=$service.'cidr-block'; destinationType='SERVICE_CIDR_BLOCK'; networkEntityId=$gateway.id})
    }).data
}
$state.route_table_id = $route.id
Save-State

$security = Select-LabResource (Invoke-Oci -Arguments @('network','security-list','list','--compartment-id',$CompartmentId,'--vcn-id',$vcn.id,'--all')).data 'livelab-functions-security'
if (-not $security) {
    $security = (Invoke-Oci -Arguments @('network','security-list','create') -InputData @{
        compartmentId=$CompartmentId; displayName='livelab-functions-security'; vcnId=$vcn.id; freeformTags=$tags
        ingressSecurityRules=@()
        egressSecurityRules=@(@{destination=$service.'cidr-block'; destinationType='SERVICE_CIDR_BLOCK'; protocol='6'; isStateless=$false; tcpOptions=@{destinationPortRange=@{min=443;max=443}}})
    }).data
}
$state.security_list_id = $security.id
Save-State

$subnet = Select-LabResource (Invoke-Oci -Arguments @('network','subnet','list','--compartment-id',$CompartmentId,'--vcn-id',$vcn.id,'--all')).data 'livelab-functions-subnet'
if (-not $subnet) {
    $subnet = (Invoke-Oci -Arguments @('network','subnet','create','--wait-for-state','AVAILABLE','--wait-interval-seconds','2') -InputData @{
        compartmentId=$CompartmentId; displayName='livelab-functions-subnet'; vcnId=$vcn.id; cidrBlock='10.42.1.0/24'; dnsLabel='functions'
        routeTableId=$route.id; securityListIds=@($security.id); prohibitPublicIpOnVnic=$true; freeformTags=$tags
    }).data
}
$state.subnet_id = $subnet.id
Save-State

$buckets = (Invoke-Oci -Arguments @('os','bucket','list','--compartment-id',$CompartmentId,'--namespace-name',$namespace,'--fields','tags','--all')).data
foreach ($purpose in @('incoming','output')) {
    $bucketName = "livelab-inventory-$purpose"
    $bucket = Select-LabResource $buckets $bucketName 'name'
    if (-not $bucket) {
        Write-Host "Creating $bucketName..."
        $bucket = (Invoke-Oci -Arguments @('os','bucket','create') -InputData @{
            compartmentId=$CompartmentId; namespaceName=$namespace; name=$bucketName; publicAccessType='NoPublicAccess'
            objectEventsEnabled=($purpose -eq 'incoming'); storageTier='Standard'; freeformTags=$tags
        }).data
    }
    $state["${purpose}_bucket"] = $bucket.name
    Save-State
}

$groups = (Invoke-Oci -Arguments @('iam','dynamic-group','list','--compartment-id',$tenancyId,'--all')).data
$group = Select-LabResource $groups 'LiveLabInventoryFunctions' 'name'
if (-not $group) {
    $group = (Invoke-Oci -Arguments @('iam','dynamic-group','create') -InputData @{
        compartmentId=$tenancyId; name='LiveLabInventoryFunctions'; description='Only Functions resources in the LiveLab compartment.'
        matchingRule="ALL {resource.type = 'fnfunc', resource.compartment.id = '$CompartmentId'}"; freeformTags=$tags
    }).data
}
$state.dynamic_group_id = $group.id
Save-State

$policy = Select-LabResource (Invoke-Oci -Arguments @('iam','policy','list','--compartment-id',$CompartmentId,'--all')).data 'LiveLabInventoryAccess' 'name'
if (-not $policy) {
    $policy = (Invoke-Oci -Arguments @('iam','policy','create') -InputData @{
        compartmentId=$CompartmentId; name='LiveLabInventoryAccess'; description='Lab function reads input objects and creates or overwrites its output reports.'; freeformTags=$tags
        statements=@(
            "Allow dynamic-group LiveLabInventoryFunctions to read objects in compartment id $CompartmentId where target.bucket.name = 'livelab-inventory-incoming'",
            "Allow dynamic-group LiveLabInventoryFunctions to manage objects in compartment id $CompartmentId where all {target.bucket.name = 'livelab-inventory-output', any {request.permission = 'OBJECT_CREATE', request.permission = 'OBJECT_OVERWRITE'}}",
            "Allow service faas to use virtual-network-family in compartment id $CompartmentId"
        )
    }).data
}
$state.policy_id = $policy.id
Save-State

$application = Select-LabResource (Invoke-Oci -Arguments @('fn','application','list','--compartment-id',$CompartmentId,'--all')).data 'livelab-inventory-app'
if (-not $application) {
    Write-Host 'Creating Functions application...'
    $application = (Invoke-Oci -Arguments @('fn','application','create','--wait-for-state','ACTIVE','--wait-interval-seconds','2') -InputData @{
        compartmentId=$CompartmentId; displayName='livelab-inventory-app'; subnetIds=@($subnet.id); shape='GENERIC_X86'; freeformTags=$tags
        config=@{ INPUT_BUCKET=$state.incoming_bucket; OUTPUT_BUCKET=$state.output_bucket; OBJECT_STORAGE_NAMESPACE=$namespace; LOW_STOCK_THRESHOLD='10' }
    }).data
}
$state.application_id = $application.id
$state.application_name = $application.'display-name'
Save-State

$logGroup = Select-LabResource (Invoke-Oci -Arguments @('logging','log-group','list','--compartment-id',$CompartmentId,'--all')).data 'livelab-functions-logs'
if (-not $logGroup) {
    $logGroup = (Invoke-Oci -Arguments @('logging','log-group','create','--wait-for-state','SUCCEEDED','--wait-interval-seconds','2') -InputData @{
        compartmentId=$CompartmentId; displayName='livelab-functions-logs'; description='Functions LiveLab invocation logs.'; freeformTags=$tags
    }).data
    $logGroup = Select-LabResource (Invoke-Oci -Arguments @('logging','log-group','list','--compartment-id',$CompartmentId,'--all')).data 'livelab-functions-logs'
}
$state.log_group_id = $logGroup.id
Save-State
$log = Select-LabResource (Invoke-Oci -Arguments @('logging','log','list','--log-group-id',$logGroup.id,'--all')).data 'inventory-invocations'
if (-not $log) {
    $log = (Invoke-Oci -Arguments @('logging','log','create','--wait-for-state','SUCCEEDED','--wait-interval-seconds','2') -InputData @{
        logGroupId=$logGroup.id; displayName='inventory-invocations'; logType='SERVICE'; isEnabled=$true; retentionDuration=30; freeformTags=$tags
        configuration=@{ compartmentId=$CompartmentId; source=@{sourceType='OCISERVICE';service='functions';resource=$application.id;category='invoke'} }
    }).data
    $log = Select-LabResource (Invoke-Oci -Arguments @('logging','log','list','--log-group-id',$logGroup.id,'--all')).data 'inventory-invocations'
}
$state.log_id = $log.id
if (-not $state.function_id) { $state.status = 'Infrastructure ready; function deployment and event wiring pending.' }
Save-State
Write-Host ($state | ConvertTo-Json -Depth 10)
