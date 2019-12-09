[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"
Set-StrictMode -Version 5.0

# Initialize an empty array that will eventually hold our cryptographically-sound API key
[byte[]]$keyBinary = 0..31 # 32 bytes => 256-bit key

$rng = [Security.Cryptography.RandomNumberGenerator]::Create()
try {
    $rng.GetBytes($keyBinary) # Populate the key array with random bytes
} finally {
    $rng.Dispose()
}

# Convert the key bytes to a hexadecimal string
$keyString = ""
$keyBinary | ForEach-Object { $keyString += $_.ToString("x2") }
$keyString
