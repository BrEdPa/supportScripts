$machinename = "DTX10537"
$pw = "!!Legacy-2023"
new-aduser $machinename -AccountPassword (ConvertTo-SecureString $pw -AsPlainText -force) -PasswordNeverExpires $true -path "OU=DTX-Useraccounts,DC=legacy,DC=local" -enabled $true  
Add-ADGroupMember -identity "denied_users" -members $machinename 
Add-ADGroupMember -identity "dtx-users" -members $machinename