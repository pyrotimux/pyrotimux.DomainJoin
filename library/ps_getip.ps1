#!powershell
# WANT_JSON
# POWERSHELL_COMMON
$result = New-Object psobject

# $ipV4 = Test-Connection -ComputerName (hostname) -Count 1  | Select -ExpandProperty IPV4Address
# $ipV4.IPAddressToString

$ip_info = ipconfig
$ipv4 = $ip_info[8] -replace "   IPv4 Address. . . . . . . . . . . : ",""
[IPAddress] $subnet =  $ip_info[9] -replace "   Subnet Mask . . . . . . . . . . . : ",""
$gateway =  $ip_info[10] -replace "   Default Gateway . . . . . . . . . : ",""

$prefixlen = 0
$octets = $subnet.IPAddressToString.Split('.');
foreach($octet in $octets)
{
  while(0 -ne $octet)
  {
    $octet = ($octet -shl 1) -band [byte]::MaxValue
    $prefixlen++;
  }
}

Set-Attr $result "changed" $true
Set-Attr $result "ipv4" $ipv4
Set-Attr $result "subnet" $prefixlen
Set-Attr $result "gateway" $gateway
Exit-Json $result
