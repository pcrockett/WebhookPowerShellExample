[CmdletBinding()]
param(
    [Parameter()]
    # Optionally allow the user to play with different API keys
    [string]$ApiKey
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version 5.0

if ($ApiKey) {
    $env:WEBHOOK_APIKEY = $ApiKey
} else {
    # If you're running this in a production environment, PLEASE don't hard-
    # code your API key and commit it to version control...
    $env:WEBHOOK_APIKEY = "9074aa54d80404921881b2dd382c5f3124234a020cfb63ed26678dc082926339"
}

# We have some relative file paths in our config. Make sure they resolve correctly.
Push-Location $PSScriptRoot

try {
    # Docs on webhook parameters: https://github.com/adnanh/webhook/blob/master/docs/Webhook-Parameters.md
    .\webhook.exe -hooks .\hooks.json -verbose -template
} finally {
    Pop-Location
}
