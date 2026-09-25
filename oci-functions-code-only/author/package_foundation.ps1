# Build a source-only Resource Manager ZIP; never include state or credentials.
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression.FileSystem
$workshopRoot = Split-Path $PSScriptRoot -Parent
$foundationRoot = Join-Path $workshopRoot 'foundation'
$destinationDirectory = Join-Path $workshopRoot 'get-started/files'
$destination = Join-Path $destinationDirectory 'functions-foundation.zip'
$allowedFiles = @('versions.tf','variables.tf','main.tf','outputs.tf','schema.yaml','README.md','.terraform.lock.hcl')
foreach ($fileName in $allowedFiles) {
    if (-not (Test-Path -LiteralPath (Join-Path $foundationRoot $fileName) -PathType Leaf)) {
        throw "Missing foundation source: $fileName. Run local Terraform init/validation first."
    }
}
New-Item -ItemType Directory -Force -Path $destinationDirectory | Out-Null
$stream = [IO.File]::Open($destination, [IO.FileMode]::Create, [IO.FileAccess]::ReadWrite)
$archive = [IO.Compression.ZipArchive]::new($stream, [IO.Compression.ZipArchiveMode]::Create)
try {
    foreach ($fileName in $allowedFiles) {
        $entry = $archive.CreateEntry($fileName, [IO.Compression.CompressionLevel]::Optimal)
        $entry.LastWriteTime = [DateTimeOffset]::new(2026, 9, 25, 0, 0, 0, [TimeSpan]::Zero)
        $entryStream = $entry.Open()
        $inputStream = [IO.File]::OpenRead((Join-Path $foundationRoot $fileName))
        try { $inputStream.CopyTo($entryStream) }
        finally {
            $inputStream.Dispose()
            $entryStream.Dispose()
        }
    }
} finally {
    $archive.Dispose()
    $stream.Dispose()
}
Write-Output "Built $destination (seven allowlisted source files; no state, tfvars, tests, or provider binaries)."
Get-FileHash -LiteralPath $destination -Algorithm SHA256
