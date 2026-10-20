$ErrorActionPreference = 'Stop'
$env:SUPPRESS_LABEL_WARNING = 'True'
$env:OCI_CLI_SUPPRESS_FILE_PERMISSIONS_WARNING = 'True'
$state = Get-Content -Raw -LiteralPath (Join-Path $PSScriptRoot 'state/resources.json') | ConvertFrom-Json
$result = & oci iam policy get --policy-id $state.policy_id --region us-ashburn-1 --output json
if ($LASTEXITCODE -ne 0) { throw 'Could not read the lab policy.' }
$current = $result -join "`n" | ConvertFrom-Json
if ($current.data.'freeform-tags'.ManagedBy -ne 'functions-livelab') { throw 'Policy is not owned by this lab.' }
$statement = "Allow service faas to read objects in compartment id $($state.compartment_id) where all {target.bucket.name = 'livelab-inventory-incoming', target.object.name = 'deployment/inventory-reporter.zip'}"
if ($current.data.statements -contains $statement) { Write-Output 'Archive-read statement already exists.'; exit 0 }
$versionDate = if ($null -eq $current.data.'version-date') { '' } else { $current.data.'version-date' }
$request = @{statements=@($current.data.statements) + @($statement); versionDate=$versionDate}
$requestPath = Join-Path $PSScriptRoot 'state/archive-policy-request.json'
$request | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $requestPath -Encoding utf8NoBOM
& oci iam policy update --policy-id $state.policy_id --region us-ashburn-1 --if-match $current.etag --from-json "file://$requestPath" --force
if ($LASTEXITCODE -ne 0) { throw 'Archive-read policy update failed.' }
