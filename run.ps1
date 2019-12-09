[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"
Set-StrictMode -Version 5.0

# We have some relative file paths in our config. Make sure they resolve correctly.
Push-Location $PSScriptRoot

try {
    .\webhook.exe -hooks .\hooks.json -verbose
} finally {
    Pop-Location
}
