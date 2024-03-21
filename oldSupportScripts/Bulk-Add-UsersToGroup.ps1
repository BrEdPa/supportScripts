[CmdletBinding()]
param (
    [Parameter(
      Mandatory = $true,
      HelpMessage = "Group name"
    )]
    [string] $groupName = "",

    [Parameter(
      Mandatory = $true,
      HelpMessage = "Path to CSV file"
    )]
    [string] $path = "",

    [Parameter(
      Mandatory = $false,
      HelpMessage = "CSV file delimiter"
    )]
    [string] $delimiter = ",",

    [Parameter(
      Mandatory = $false,
      HelpMessage = "Find users on DisplayName, Email or UserPrincipalName"
    )]
    [ValidateSet("DisplayName", "Email", "UserPrincipalName")]
    [string] $filter = "DisplayName"
)

Function Add-UsersToGroup {
    <#
    .SYNOPSIS
      Get users from the requested DN
    #>
    process{
        # Import the CSV File
        $users = (Import-Csv -Path $path -Delimiter $delimiter -header "name").name

        # Find the users in the Active Directory
        $users | ForEach {
            $user =  Get-ADUser -filter "$filter -eq '$_'" | Select ObjectGUID 

            if ($user) {
                Add-ADGroupMember -Identity $groupName -Members $user
                Write-Host "$_ added to the group"
            }else {
                Write-Warning "$_ not found in the Active Directory"
            }
        }
    }
}

# Load the Active Directory Module
Import-Module -Name ActiveDirectory

# Add user from CSV to given Group
Add-UsersToGroup