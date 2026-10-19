param([ValidateSet('Core','Extensions')][string]$Suite='Core', [string]$SourceSuffix='')
$ErrorActionPreference = 'Stop'
$env:SUPPRESS_LABEL_WARNING = 'True'
$env:OCI_CLI_SUPPRESS_FILE_PERMISSIONS_WARNING = 'True'
$state = Get-Content -Raw -LiteralPath (Join-Path $PSScriptRoot 'state/resources.json') | ConvertFrom-Json
if (-not $state.event_rule_id -or -not $state.function_id) { throw 'Connect the event rule first.' }
$files = Join-Path $PSScriptRoot '../deploy-function/files'
$evidence = Join-Path $PSScriptRoot "state/cloud-$($Suite.ToLower())"
New-Item -ItemType Directory -Path $evidence -Force | Out-Null
$results = [System.Collections.Generic.List[object]]::new()
function Run-Oci {
    param([string[]]$Arguments)
    $response = & oci @Arguments --region $state.region --output json
    if ($LASTEXITCODE -ne 0) { throw "OCI command failed: $($Arguments -join ' ')" }
    if ($response) { return ($response -join "`n" | ConvertFrom-Json) }
}
function Set-Threshold {
    param([string]$Value)
    $uri = "https://functions.$($state.region).oci.oraclecloud.com/20260325/functions/$($state.function_id)"
    $current = Run-Oci @('raw-request','--http-method','GET','--target-uri',$uri)
    if ($current.status -notmatch '^2' -or $current.data.lifecycleState -ne 'ACTIVE') { throw 'Expected an Active function before config update.' }
    $config = @{}
    foreach ($property in $current.data.config.psobject.Properties) { $config[$property.Name] = $property.Value }
    $config.LOW_STOCK_THRESHOLD = $Value
    $requestPath = Join-Path $evidence 'config-request.json'
    @{config=$config} | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $requestPath -Encoding utf8NoBOM
    $update = Run-Oci @('raw-request','--http-method','PUT','--target-uri',$uri,'--request-body',"file://$requestPath")
    if ($update.status -notmatch '^2') { throw ($update | ConvertTo-Json -Depth 10) }
    $workId = $update.headers.'opc-work-request-id'
    for ($attempt=0; $attempt -lt 30; $attempt++) {
        $work = Run-Oci @('raw-request','--http-method','GET','--target-uri',"https://functions.$($state.region).oci.oraclecloud.com/20260325/workRequests/$workId")
        if ($work.data.status -eq 'SUCCEEDED') { Write-Output "Threshold set to $Value"; return }
        if ($work.data.status -in @('FAILED','CANCELED')) { throw "Config work request $($work.data.status)" }
        Start-Sleep -Seconds 5
    }
    throw 'Timed out updating threshold.'
}
function Test-Upload {
    param([string]$Stem,[int]$Threshold,[int]$Restock,[int]$Rejected)
    $sourceStem = "$Stem$SourceSuffix"
    $source = "$sourceStem.csv"
    $existing = Run-Oci @('os','object','list','--namespace-name',$state.namespace,'--bucket-name',$state.incoming_bucket,'--prefix',$source,'--all')
    if (@($existing.data | Where-Object {$_.name -eq $source}).Count) { throw "$source already exists; do not accidentally test an update instead of an object-create event." }
    Run-Oci @('os','object','put','--namespace-name',$state.namespace,'--bucket-name',$state.incoming_bucket,'--name',$source,'--file',(Join-Path $files "$Stem.csv"),'--no-overwrite') | Out-Null
    Write-Output "Uploaded $source; waiting for event-driven reports."
    $found = $false
    for ($attempt=0; $attempt -lt 18; $attempt++) {
        $listing = Run-Oci @('os','object','list','--namespace-name',$state.namespace,'--bucket-name',$state.output_bucket,'--prefix',"$sourceStem/",'--all')
        $names = @($listing.data | ForEach-Object {$_.name})
        if ($names -contains "$sourceStem/restock-report.csv" -and $names -contains "$sourceStem/rejected-records.csv") { $found=$true; break }
        Start-Sleep -Seconds 10
    }
    if (-not $found) { throw "No complete output for $source; inspect invocation logs and the Events rule." }
    $destination = Join-Path $evidence $sourceStem
    New-Item -ItemType Directory -Path $destination -Force | Out-Null
    foreach ($report in @('restock-report.csv','rejected-records.csv')) {
        $actualPath = Join-Path $destination $report
        Run-Oci @('os','object','get','--namespace-name',$state.namespace,'--bucket-name',$state.output_bucket,'--name',"$sourceStem/$report",'--file',$actualPath) | Out-Null
        $expectedPath = Join-Path $files "expected/$Stem/$report"
        if ((Get-FileHash -LiteralPath $actualPath).Hash -ne (Get-FileHash -LiteralPath $expectedPath).Hash) { throw "$Stem/$report does not exactly match the expected output." }
    }
    $actualRestock = @(Import-Csv -LiteralPath (Join-Path $destination 'restock-report.csv')).Count
    $actualRejected = @(Import-Csv -LiteralPath (Join-Path $destination 'rejected-records.csv')).Count
    if ($actualRestock -ne $Restock -or $actualRejected -ne $Rejected) { throw 'Unexpected row counts.' }
    $results.Add(@{source=$source;threshold=$Threshold;restock=$actualRestock;rejected=$actualRejected;exact_file_match=$true;manual_invocation=$false})
    Write-Output "PASS $source : $actualRestock restock, $actualRejected rejected; exact expected file match."
}
try {
    if ($Suite -eq 'Core') {
        Test-Upload 'inventory-run1' 10 5 0
    } else {
        Set-Threshold '20'
        Test-Upload 'inventory-run2' 20 11 0
        Test-Upload 'inventory-bad' 20 10 1
        Test-Upload 'inventory-fixed' 20 11 0
    }
} finally {
    if ($Suite -eq 'Extensions') { Set-Threshold '10' }
    @{checked_at=[DateTime]::UtcNow.ToString('o');suite=$Suite;results=@($results.ToArray())} | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath (Join-Path $evidence 'results.json') -Encoding utf8
}
