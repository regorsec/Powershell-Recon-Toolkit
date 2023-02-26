#Bruteforce Web Directories

Write-Host "THIS SCRIPT IS BROKEN - NEED TO FIX - ON THE TO DO LIST" -ForegroundColor Red

# Define required arguments
Param(
    [Parameter(Mandatory=$true)]
    [string]$t,
    [Parameter(Mandatory=$true)]
    [string]$w
)

# Do not show errors
$ErrorActionPreference = "SilentlyContinue"

# Get the Wordlist
$wordlist = Get-Content $w

# Main
foreach ($path in $wordlist) {

    # Build the URL to query
    $url = "$t/$path"

    $response = Invoke-WebRequest $url -UseBasicParsin
    $statusCode = $response.StatusCode.value__

    # Output any URL's that give a 200 Type Code
    if ($statusCode -ge 200 -and $statusCode -lt 300) {
        Write-Host "Found: $url ($statusCode)" -ForegroundColor Green
    }
}
