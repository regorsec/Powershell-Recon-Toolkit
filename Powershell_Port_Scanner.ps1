# Powershell Single Host - Multi Port Scan

# Define required arguments
param (
    [Parameter(Mandatory=$true)]
    [string]$target,
    [Parameter(Mandatory=$true)]
    [string]$portRange,
    [switch]$v
)

function Test-Port {
    $portRange -split ',' | Foreach-Object -Process {

        # Parse Ports provided by command line argument
        $ports = $_ -split '-'
        $startPort = [int]$ports[0]
        $endPort = if ($ports.Length -eq 2) { [int]$ports[1] } else { $startPort }

        # Push the port range into a Foreach loop
        $startPort..$endPort | Foreach-Object -Process { 

            $tcpClient = New-Object System.Net.Sockets.TcpClient

            $result = $tcpClient.BeginConnect($target, $_, $null, $null)
        

            #Define an approprite timeout (Impacts performance and result quality)
            Start-Sleep -Milliseconds 100 # Wait for connection to complete

            # If Port was found Open
            if ($tcpClient.Connected) {
                Write-Host -ForegroundColor Green "Port $_ on host $target is open"
                $tcpClient.Close()
            }

            # Else Port was found Closed
            else {

                # If Verbose command line argument was provided > be verbose
                if ($v) {
                    Write-Host -ForegroundColor DarkMagenta "Port $_ on host $target is closed"
                }
            }
        }
    }
}

Test-Port
