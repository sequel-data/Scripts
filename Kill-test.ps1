
$vcenterserver = "vcenter.tamu.edu" #Enter the FQDN or IP of your vCenter server

Connect-VIServer -server $vcenterserver


Get-VISession | Where { $_.IdleMinutes -gt 30 } | Disconnect-ViSession