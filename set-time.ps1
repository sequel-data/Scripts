## Setting time on many ESXi hosts through PowerCLI
Get-Cluster DRS-Exch-Teague-1 |Get-VMHost | Where-Object {
$t = Get-Date
$dst = $_ | %{ Get-View $_.ExtensionData.ConfigManager.DateTimeSystem }
$dst.UpdateDateTime((Get-Date($t.ToUniversalTime()) -format u))
}