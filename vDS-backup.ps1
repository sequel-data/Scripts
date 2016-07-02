Connect-VIServer vcenter.tamu.edu
Get-VDSwitch -Name dvS-TAMU | Get-VDPortgroup | Foreach {
Export-VDPortGroup -VDPortGroup $_ -Description “Backup of $($_.Name) PG” -Force -Destination “C:\Backups\$($_.Name).Zip”}