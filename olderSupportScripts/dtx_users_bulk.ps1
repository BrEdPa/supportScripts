#borrowed this from Adam
$machines = import-csv C:\TEMP\csv\DTX_imaging.csv
foreach ($machine in $machines) {
$machinename = $machine.computername
#$machinename
try {
    $didwefindthenuser = get-aduser $machinename -erroraction stop | select samaccountname
    Write-Host "User $machinename exists"
    $writetofile = "User $didwefindthenuser exists"
    }
catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException] {
    #return $false
    write-host "user $machinename does not exist, creating new"
    $pw = "!!Legacy-2023"
    new-aduser -name $machinename -SamAccountName $machinename -UserPrincipalName ($machinename + '@legacycommunityhealth.org') -AccountPassword (ConvertTo-SecureString $pw -AsPlainText -force) -PasswordNeverExpires $true -path "OU=DTX-Useraccounts,DC=legacy,DC=local" -DisplayName $machinename -enabled $true
    set-aduser $machinename -LogonWorkstations $machinename
    set-aduser $machinename -CannotChangePassword $true -PasswordNeverExpires $true
    Add-ADGroupMember -identity "denied_users" -members $machinename
    Add-ADGroupMember -identity "dtx-users" -members $machinename
    $writetofile = "User $machinename did not exist, created new"
    }
$writetofile | Out-File C:\TEMP\logs\DTX-user-results.txt -Append
} 
