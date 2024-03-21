##create a CSV of the list of computers being imaged, name/save it like the below path
# Start transcript
#Start-Transcript -Path C:\Temp\dtx-imaging.log -Append

# Import AD Module
#Import-Module ActiveDirectory

# Import the data from CSV file and assign it to variable
$List = Import-Csv "C:\TEMP\csv\dtx_imaging.csv"
$pw = "!!Legacy-2023"
    foreach ($machineName in $list)
    {
        new-aduser $machineName -AccountPassword (ConvertTo-SecureString $pw -AsPlainText -force) -PasswordNeverExpires $true -path "OU=DTX-Useraccounts,DC=legacy,DC=local" -enabled $true
    }