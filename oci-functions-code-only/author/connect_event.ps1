$ErrorActionPreference = 'Stop'
$env:SUPPRESS_LABEL_WARNING = 'True'
$env:OCI_CLI_SUPPRESS_FILE_PERMISSIONS_WARNING = 'True'
$statePath = Join-Path $PSScriptRoot 'state/resources.json'
$state = Get-Content -Raw -LiteralPath $statePath | ConvertFrom-Json -AsHashtable
function Invoke-LabOci {
    param([string[]]$Arguments)
    $result = & oci @Arguments --region $state.region --output json
    if ($LASTEXITCODE -ne 0) { throw "OCI failed: $($Arguments -join ' ')" }
    if ($result) { return ($result -join "`n" | ConvertFrom-Json) }
}
$functions = (Invoke-LabOci @('fn','function','list','--application-id',$state.application_id,'--all')).data
$target = @($functions | Where-Object { $_.'display-name' -eq 'inventory-reporter' -and $_.'lifecycle-state' -eq 'ACTIVE' })
if ($target.Count -ne 1) { throw 'Expected exactly one active inventory-reporter function in the lab application.' }
$functionId = $target[0].id
$condition = @{
    eventType=@('com.oraclecloud.objectstorage.createobject')
    data=@{ additionalDetails=@{ bucketName=@($state.incoming_bucket) } }
}
$rules = (Invoke-LabOci @('events','rule','list','--compartment-id',$state.compartment_id,'--all')).data
$existing = @($rules | Where-Object { $_.'display-name' -eq 'livelab-inventory-upload' -and $_.'lifecycle-state' -eq 'ACTIVE' })
if ($existing.Count -gt 1) { throw 'Multiple matching rules exist; select manually.' }
if ($existing.Count -eq 1) {
    $rule = $existing[0]
    if ($rule.'freeform-tags'.ManagedBy -ne 'functions-livelab') { throw 'Existing rule is not managed by this lab.' }
    if ($rule.actions.actions[0].'function-id' -ne $functionId) { throw 'Existing rule has a different target.' }
} else {
    $request = @{
        compartmentId=$state.compartment_id; displayName='livelab-inventory-upload'
        description='Process new inventory CSV objects in the LiveLab incoming bucket.'
        condition=($condition | ConvertTo-Json -Depth 10 -Compress); isEnabled=$true
        actions=@{actions=@(@{actionType='FAAS';isEnabled=$true;functionId=$functionId})}
        freeformTags=@{Workshop='from-code-to-cloud';ManagedBy='functions-livelab'}
    }
    $requestPath = Join-Path $PSScriptRoot 'state/event-request.json'
    $request | ConvertTo-Json -Depth 20 | Set-Content -LiteralPath $requestPath -Encoding utf8NoBOM
    $rule = (Invoke-LabOci @('events','rule','create','--from-json',"file://$requestPath")).data
}
$state.function_id = $functionId
$state.event_rule_id = $rule.id
$state.status = 'Function and event rule created; end-to-end upload verification pending.'
$state | ConvertTo-Json -Depth 30 | Set-Content -LiteralPath $statePath -Encoding utf8
Write-Output "Connected livelab-inventory-upload to inventory-reporter. Rule: $($rule.id)"
