$vcenterserver = "vcenter.tamu.edu"
Add-PSSnapin VMware.VimAutomation.Core # Add PowerCLI commandlets.

Connect-VIServer -server $vcenterserver

. C:\Users\rsadmin\Desktop\Scripts\Get-VIsession.ps1

. C:\Users\rsadmin\Desktop\Scripts\Disconnect-ViSession.ps1

Get-VISession | Where { $_.IdleMinutes -gt 180} | Disconnect-ViSession

Disconnect-VIServer -Server $vcenterserver -Confirm:$false
exit