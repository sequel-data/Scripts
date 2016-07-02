$TotalNumvCPUs = 0
Foreach ($Cluster in (Get-Cluster |Sort Name)){
$HostNumvCPUs = 0
Write-Host “Cluster: $($Cluster.name)“
Foreach ($ESXHost in ($Cluster |Get-VMHost |Sort Name)){
Write-Host “ Host: $($ESXHost.name)“
$RunningLimit = $null
$RunningLimit = ($ESXHost |Get-VMHostAdvancedConfiguration).get_Item(“Misc.RunningVCpuLimit“)
If ($RunningLimit -eq $null){
$RunningLimit = 128
}
Write-Host “ Misc.RunningVCpuLimit: $RunningLimit“
Foreach ($VM in ($ESXHost |Get-VM)){
$HostNumvCPUs += ($VM).NumCpu
}
Write-Host “ Number of vCPU on host: $($HostNumvCPUs)“
$TotalNumvCPUs += $HostNumvCPUs
$HostNumvCPUs = 0
}
Write-Host “———-“
Write-Host “Number of vCPU in $($Cluster.name): $TotalNumvCPUs“
Write-Host “———-“
Write-Host “”
$TotalNumvCPUs = 0
}