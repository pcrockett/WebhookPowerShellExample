[CmdletBinding()]
param()

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

    if (!$env:HOOK_apikey) {
        throw "Did not find ""HOOK_apikey"" environment variable."
    }

    $a = [Text.Encoding]::ASCII.GetBytes($ExpectedApiKey.ToLowerInvariant())
    $b = [Text.Encoding]::ASCII.GetBytes($env:HOOK_apikey.ToLowerInvariant())

    [UInt32]$diff = $a.Length -bxor $b.Length
    if ($diff -ne 0) {
        return $false
    }

    for ($i = 0; $i -lt $a.Length; $i++) {
        [UInt32]$charDiff = $a[$i] -bxor $b[$i]
        $diff = $diff -bor $charDiff
    }

    return $diff -eq 0
}

if (-not (isApiKeyCorrect)) {
    throw "Invalid API key"
}

$name = $env:HOOK_name
if (!$name) {
    $name = "World"
}

Write-Host "Hello $name, this is a test hook."
