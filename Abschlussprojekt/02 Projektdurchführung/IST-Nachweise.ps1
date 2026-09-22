# Auf CL01 und ADM01 in Windows PowerShell ausführen.
$ErrorActionPreference = 'Stop'
$runId = Get-Date -Format 'yyyyMMdd-HHmmss'
$proofPath = Join-Path ([Environment]::GetFolderPath('MyDocuments')) ("IST-$env:COMPUTERNAME-$runId")
New-Item -ItemType Directory -Path $proofPath -ErrorAction Stop | Out-Null
Start-Transcript -Path (Join-Path $proofPath 'Rohprotokoll.txt') -NoClobber | Out-Null
try {
    Write-Output ('Beginn: ' + [DateTimeOffset]::Now.ToString('o'))
    hostname
    whoami
    Get-TimeZone | Format-List
    & w32tm.exe /query /status
    Get-NetIPConfiguration | Format-List
    Get-NetIPAddress | Select-Object InterfaceAlias, AddressFamily, IPAddress, PrefixLength, PrefixOrigin | Format-Table -AutoSize
    Get-DnsClientServerAddress | Format-Table -AutoSize
    $dnsTests = @(
        @{ Id='D01'; Arguments=@('dc01.ad.projekt.test') },
        @{ Id='D02'; Arguments=@('dc01.ad.projekt.test','192.168.2.139') },
        @{ Id='D03'; Arguments=@('-type=SRV','_ldap._tcp.dc._msdcs.ad.projekt.test','192.168.2.139') }
    )
    foreach ($dnsTest in $dnsTests) {
        Write-Output ($dnsTest.Id + ' Start: ' + [DateTimeOffset]::Now.ToString('o'))
        $dnsArguments = $dnsTest.Arguments
        Write-Output ('nslookup ' + ($dnsArguments -join ' '))
        & nslookup.exe @dnsArguments
        Write-Output ($dnsTest.Id + ' Ende: ' + [DateTimeOffset]::Now.ToString('o'))
    }
    $results = foreach ($port in @(53,88,389,445,3389)) {
        $start = [DateTimeOffset]::Now.ToString('o')
        $connection = $null
        $failure = ''
        try {
            $connection = Test-NetConnection '192.168.2.139' -Port $port -InformationLevel Detailed -ErrorAction Stop
        } catch { $failure = $_.Exception.Message }
        [pscustomobject]@{
            TestId = "TCP-$port"
            Start = $start
            End = [DateTimeOffset]::Now.ToString('o')
            SourceComputer = $env:COMPUTERNAME
            SourceAddress = $(if ($connection) { [string]$connection.SourceAddress } else { '' })
            Destination = '192.168.2.139'
            Port = $port
            TcpTestSucceeded = $(if ($connection) { $connection.TcpTestSucceeded } else { $null })
            Error = $failure
        }
    }
    $results | Export-Csv -LiteralPath (Join-Path $proofPath 'TCP-Ergebnisse.csv') -Delimiter ';' -NoTypeInformation -Encoding UTF8
    $results | Format-Table -AutoSize
    Write-Output ('Ende: ' + [DateTimeOffset]::Now.ToString('o'))
} finally {
    Stop-Transcript | Out-Null
}
Write-Output "Nachweise gespeichert: $proofPath"
