[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"
Set-StrictMode -Version 5.0

$webhookExe = Join-Path $PSScriptRoot "webhook.exe"
$hookConfig = Join-Path $PSScriptRoot "hooks.json"

& $webhookExe -hooks $hookConfig -verbose
