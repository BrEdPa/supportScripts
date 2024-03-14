#this is the actual forEach loop that works; my other attempts got bogged down in making the function work.
$laptops = Import-CSV -Path "C:\TEMP\csv\vpnRollour_lma.csv" 

foreach ($laptop in $laptops.endpoints) {
    $obj = Get-ADComputer $laptop
    Add-ADGroupMember -ID sec-endpoint-app-SecureClient_rollout -Members $obj
}