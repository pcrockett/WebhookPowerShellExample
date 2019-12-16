[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"
Set-StrictMode -Version 5.0

$name = $env:HOOK_name
if (!$name) {
    $name = "World"
}

Write-Host "Hello $name, this is a test hook."
