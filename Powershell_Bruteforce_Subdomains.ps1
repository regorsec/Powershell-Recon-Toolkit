# Bruteforce Sub-Domains

# Define required arguments and bind
[CmdletBinding()]
Param(
    [Parameter(Mandatory=$true)]
    [string]$Target,

    [Parameter(Mandatory=$true)]
    [string]$Wordlist
)

$Subdomains = Get-Content $Wordlist
$ResolvedSubdomains = @()

# Main
foreach ($sub in $Subdomains) {

    $hostname = "$sub.$Target"
    $resolved = $null

    try {
        $resolved = Resolve-DnsName -Name $hostname -ErrorAction Stop | Where-Object {$_.Type -eq "A"}
    }
    catch {
        # Ignore any errors and move on
        continue
    }

    if ($resolved) {
        $ResolvedSubdomains += $hostname
        Write-Output $hostname
    }
}

# If no subdomains were found
if ($ResolvedSubdomains.Count -eq 0) {
    Write-Output "No subdomains found"
}
