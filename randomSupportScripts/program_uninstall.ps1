#script for deleting malware from a device after infection
#use the following command to find the package on an infected device, then modify the script accordingly
#Get-WmiObject -Class Win32_Product | slect-object -property Name

$Target = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq "target"}
$Target.Uninstall()