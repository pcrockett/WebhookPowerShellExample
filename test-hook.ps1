[CmdletBinding()]
param(
    [Parameter()]
    [string]$Name = "World"
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version 5.0

Write-Host "Hello $Name, this is a test hook."
