# Get the Virtual Network Adapter
#
# Niklas Åkerlund / RTS
$VMs = Get-Cluster DRS-Teague-2 |Get-ResourcePool Util* | Get-VM  
$Data = @()
foreach ($VM in $VMs){
$NICs = Get-NetworkAdapter -VM
foreach ($NIC in $NICs) {
$into = New-Object PSObject
Add-Member -InputObject $into -MemberType NoteProperty -Name VMname $VM.Name
Add-Member -InputObject $into -MemberType NoteProperty -Name NICtype $NIC.Type
$Data += $into
}
}
$Data | Export-Csv -Path c:\users\rsadmin\Desktop\NIC.csv -NoTypeInformation
