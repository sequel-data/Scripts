#Connect-VIServer vcenter.tamu.edu
 

$report = @()
#Sets path to where the report will be sent to...this will go to your desktop
 
 
$path = $HOME + '\desktop\VM_Disk_Detail.csv'
#gets all the VMs in the vCenter servers
 
 
$vmx = Get-VM | sort name
foreach
($vm in $vmx)
{
 
#Pull in the HDs associated with the VM 
#If you just want to see Thin disks, REM line one, unREM line two
vmhds = $vm | Get-HardDisk
#vmhds = $vm | Get-HardDisk | where {$_.StorageFormat -eq 'Thin'}
 
foreach ($vmhd in $vmhds)
{
 
$diskStyle = $null
 
#Boolean field to see if disk is thin provisioned or not
thinPro = $vmhd.extensiondata.backing.thinprovisioned
 
#Indicates where the disk is thick or thin
$format = $vmhd.StorageFormat
 
#This will be null for thin disks and thick lazy-zero disks, should be true for thick eager-zero
eager = $vmhd.extensiondata.backing.Eagerlyscrub
 
#This will determine what the true format is. If it can't decide, disk type is unknown or 'UNK'
 
if ($eager -eq $null -and $format -eq 'Thick'){$diskStyle = 'ThickLazyZero'}
 
elseif ($eager -eq 'True' -and $format -eq 'Thick'){$diskStyle = 'ThickEagerZero'}
 
elseif ($format -eq 'Thin'){$diskStyle = 'ThinProv'}
 
else {$diskStyle = "UNK"}
 
$list = '' | select vmName,vmCluster,vmHDname,diskMode,eagerScrub,diskFormat,TP_TF,style,filename
 
$list.vmname = $vm.Name
 
$list.vmCluster = $vm.VMHost.Parent
 
$list.vmHDname = $vmhd.name
 
$list.diskMode = $vmhd.Persistence
 
$list.eagerScrub = $eager
 
$list.diskformat = $vmhd.StorageFormat
 
$list.TP_TF = $thinPro
 
$list.style = $diskStyle
 
$list.filename = $vmhd.filename
 
$report += $list
}
}
$report | Export-Csv -NoTypeInformation -Path $path