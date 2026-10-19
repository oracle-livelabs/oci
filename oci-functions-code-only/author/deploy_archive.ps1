param([switch]$RecreateFailed)
$ErrorActionPreference = 'Stop'
$env:SUPPRESS_LABEL_WARNING = 'True'
$env:OCI_CLI_SUPPRESS_FILE_PERMISSIONS_WARNING = 'True'
$statePath = Join-Path $PSScriptRoot 'state/resources.json'
$state = Get-Content -Raw -LiteralPath $statePath | ConvertFrom-Json -AsHashtable
$base = "https://functions.$($state.region).oci.oraclecloud.com/20260325"
function Call-Api {
    param([string]$Method,[string]$Path,[hashtable]$Body)
    $arguments = @('raw-request','--http-method',$Method,'--target-uri',"$base$Path")
    if ($Body) {
        $bodyPath = Join-Path $PSScriptRoot 'state/function-request.json'
        $Body | ConvertTo-Json -Depth 20 | Set-Content -LiteralPath $bodyPath -Encoding utf8NoBOM
        $arguments += @('--request-body',"file://$bodyPath")
    }
    $result = & oci @arguments
    if ($LASTEXITCODE -ne 0) { throw 'Signed API request failed.' }
    $response = $result -join "`n" | ConvertFrom-Json
    if ($response.status -notmatch '^2') { throw ($response | ConvertTo-Json -Depth 20) }
    return $response
}
function Wait-Operation {
    param([string]$WorkRequestId)
    for ($attempt=0; $attempt -lt 60; $attempt++) {
        $work = (Call-Api 'GET' "/workRequests/$WorkRequestId").data
        Write-Output "Work request: $($work.status) ($($work.percentComplete)%)"
        if ($work.status -eq 'SUCCEEDED') { return }
        if ($work.status -in @('FAILED','CANCELED')) {
            $errors = Call-Api 'GET' "/workRequests/$WorkRequestId/errors"
            throw ($errors.data | ConvertTo-Json -Depth 20)
        }
        Start-Sleep -Seconds 10
    }
    throw "Deployment still running; check work request $WorkRequestId"
}
if ($RecreateFailed) {
    $failedId = $state.failed_function_id
    if (-not $failedId) { throw 'No failed function ID is recorded in this local state.' }
    $failed = (Call-Api 'GET' "/functions/$failedId").data
    if ($failed.lifecycleState -ne 'FAILED' -or $failed.applicationId -ne $state.application_id -or $failed.displayName -ne 'inventory-reporter') { throw 'Refusing to remove anything except the verified failed lab function.' }
    $state.failed_function_id = $failedId
    $state | ConvertTo-Json -Depth 20 | Set-Content -LiteralPath $statePath -Encoding utf8
    $deletion = Call-Api 'DELETE' "/functions/$failedId"
    Wait-Operation $deletion.headers.'opc-work-request-id'
    Write-Output 'Removed the failed, never-active lab function; rebuilding from retained source.'
}
$functions = & oci fn function list --application-id $state.application_id --region $state.region --all --output json
if ($LASTEXITCODE -ne 0) { throw 'Could not check for existing functions.' }
$existing = @((($functions -join "`n" | ConvertFrom-Json).data) | Where-Object {$_.'display-name' -eq 'inventory-reporter' -and $_.'lifecycle-state' -ne 'DELETED'})
if ($existing.Count) { throw 'A matching function already exists; inspect it before creating another.' }
$archive = Join-Path $PSScriptRoot '../deploy-function/files/inventory-reporter.zip'
& oci os object put --region $state.region --namespace-name $state.namespace --bucket-name $state.incoming_bucket --name deployment/inventory-reporter.zip --file $archive --no-multipart --force
if ($LASTEXITCODE -ne 0) { throw 'Archive upload failed.' }
$source = @{
    sourceType='ARCHIVE'; handler='func.handler'
    archiveSourceDetails=@{archiveSourceType='OBJECT_STORAGE_ARCHIVE';bucketName=$state.incoming_bucket;namespace=$state.namespace;objectName='deployment/inventory-reporter.zip'}
    runtimeConfig=@{runtimeConfigType='FUNCTION_UPDATE';functionsRuntimeName='python312.ol9'}
}
$created = Call-Api 'POST' '/functions' @{
    applicationId=$state.application_id;displayName='inventory-reporter';memoryInMBs=256;timeoutInSeconds=60;sourceDetails=$source
    freeformTags=@{Workshop='from-code-to-cloud';ManagedBy='functions-livelab'}
}
$state.function_id = $created.data.id
$state.function_work_request_id = $created.headers.'opc-work-request-id'
$state.status = 'Code-only function deployment in progress.'
$state | ConvertTo-Json -Depth 20 | Set-Content -LiteralPath $statePath -Encoding utf8
Wait-Operation $state.function_work_request_id
$actual = (Call-Api 'GET' "/functions/$($state.function_id)").data
$actual | ConvertTo-Json -Depth 20 | Set-Content -LiteralPath (Join-Path $PSScriptRoot 'state/deployed-function.json') -Encoding utf8
if ($actual.lifecycleState -ne 'ACTIVE') { throw "Function state: $($actual.lifecycleState)" }
$state.status = 'Code-only function Active; event wiring and execution verification pending.'
$state | ConvertTo-Json -Depth 20 | Set-Content -LiteralPath $statePath -Encoding utf8
Write-Output "Active function: $($state.function_id)"
