Param(
    $filter="not port 22",
    $interface="eth0",
    $hostname="",
    $username="root",
    $key=""
)

If ( "" -eq $key ) {
    $key=Read-Host -Prompt "SSH key"
}

If ( "" -eq $hostname ) {
    $hostname=Read-Host -Prompt "Hostname"
}

#Set-Alias -Name "Wireshark" -Value "C:\Program Files\Wireshark\Wireshark.exe"
#Set-Alias -Name "plink" -Value "plink.exe"

# Start tcpdump on remote host and pipe to Wireshark
$command = "@echo off
SET PATH=%PATH%;C:\Program Files\Wireshark\
plink.exe -ssh -i $key $username@$hostname `"tcpdump -ni $interface -s 0 -w - $filter`" | Wireshark.exe -k -i -"

$command|Out-File -Encoding "utf8"-FilePath Trace-Node.bat
# We use this batch file workaround because we can't get the stdout pipe working in powershell
.\Trace-Node.bat