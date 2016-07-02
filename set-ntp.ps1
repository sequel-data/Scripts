#Edit the $NTPServers variable to create a comma delimited list of the NTP Servers that your ESXi hosts should use
$NTPServers = "165.91.23.54", "165.91.22.66"
#Edit this Get-VMHost command to limit the scope of the script.  For example, "Get-VMHost *test*" will only target hosts with "test" in their name
$AllHosts = Get-Cluster DRS-Exch-Wehner-1 |Get-VMHost

#No need to edit anything below this line
#====================================
foreach ($ThisHost in $AllHosts){
    $AllNTP = get-vmhostntpserver -VMHost $ThisHost
    foreach ($ThisNTP in $AllNTP){
        echo "Removing $ThisNTP from $ThisHost"
        remove-vmhostntpserver -VMHost $ThisHost -ntpserver $ThisNTP -Confirm:$false
    }
    foreach ($ThisNTP in $NTPServers){
        echo "Adding $ThisNTP to $ThisHost"
        add-vmhostntpserver -VMHost $ThisHost -ntpserver $ThisNTP -Confirm:$false
    }
    Get-VMHostService -VMHost $ThisHost | where{$_.Key -eq "ntpd"} | restart-vmhostservice -Confirm:$false
    Get-VMHostService -VMHost $ThisHost | where{$_.Key -eq "ntpd"} | set-vmhostservice -policy "on" -Confirm:$false
}
