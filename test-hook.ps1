[CmdletBinding()]
param(
    [Parameter(Mandatory=$True)]
    [string]$ApiKey,

    [Parameter()]
    [string]$Name = "World"
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version 5.0

$ExpectedApiKey = "9074aa54d80404921881b2dd382c5f3124234a020cfb63ed26678dc082926339"

function isApiKeyCorrect() {
    # We don't want to use String.Equals(), -eq,  or any other traditional
    # equals comparison method, because they are vulnerable to timing attacks.
    # For more info see:
    #
    #    https://bryanavery.co.uk/cryptography-net-avoiding-timing-attack/
    #
    # This is an implementation of a constant-time string comparison. No matter
    # what API key the user (or attacker) gives us, the comparison will take
    # the same amount of time.

    $a = [Text.Encoding]::ASCII.GetBytes($ExpectedApiKey.ToLowerInvariant())
    $b = [Text.Encoding]::ASCII.GetBytes($ApiKey.ToLowerInvariant())

    [UInt32]$diff = $a.Length -bxor $b.Length
    if ($diff -ne 0) {
        return $false
    }

    for ($i = 0; $i -lt $a.Length; $i++) {
        $charDiff = [UInt32]($a[$i] -bxor $b[$i])
        $diff = $diff -bor $charDiff
    }

    return $diff -eq 0
}

if (-not (isApiKeyCorrect)) {
    throw "Invalid API key"
}

Write-Host "Hello $Name, this is a test hook."
