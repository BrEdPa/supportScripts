# BrEdPa 2024 | Script for adding a selection of computers to a specific sec group from a CSV | determinant is site OU
##base of this comes from my bulk imaging mover script for when we need to dump stuff out of NewComputers while imaging
##need to make this dynamic, as well as make the objects members of a group versus moving them to a new OU
##the principal should work, then we loop through all the objects and bob's your uncle
##also built this list from all HybridJoined devices - we have plenty more only in Entra/Intune but I want to target clearly defined places first.
## ---

# Import AD module
Import-Module ActiveDirectory

# Function for adding endpoints to a specific sec group
function addEndpointsToGroup {
    param (
        [string]$csvPath,
        [string]$groupName,
        [string]$targetSite
    )
    # Read .csv
    $csvData = Import-Csv -Path $csvPath
    # Create array for storing target endpoints
    $targetEndpoints = @()

    # loop through .csv
    foreach ($row in $csvData) {
        $endpoint = $row.endpoint
        $siteID = $row.siteID

        # confirm endpoint's presence in AD
        IF ($siteID -eq $targetSite) {
            if (Get-ADComputer -Filter { Name -eq $endpoint }) {
            $targetEndpoints += $endpoint
            } else {
                Write-Output "Endpoint $endpoint not present in ADDS or not in the specified OU"
            }
        }
    }
    # Print list of target devices - not working
    #Write-Output "Endpoints to be added to $groupName :"
    #$targetEndpoints | ForEach-Object {
    #    Write-Host $_
    #}

    # Prompt confirmation
    $confirmation = Read-Host "Do you want to add these endpoints to the group $groupName? (Y/N)"
    if($confirmation -eq "Y" -or $confirmation -eq "y") {
        foreach ($endpoint in $targetEndpoints) {
            Add-ADGroupMember -Identity $groupName -Members (Get-ADComputer $endpoint)
            Write-Output "Endpoint $endpoint added to sec-grp $groupName."
        }
    } else {
    Write-Output "Operation Canceled."
    } 
}

# ask for .csv
$csvPath = Read-Host "Enter the path to the CSV File"
# ask for target site - vpn rollout = c:\TEMP\aaaaaaaaa\onPremLaptopsBySiteOU.csv
$targetSite = Read-Host "Enter the target site as "OU XXX""
# ask for target sec grp - vpn rollout = sec-endpoint-app-SecureClient_rollout
$groupName = Read-Host "Enter the name of the target security group."
#call function
addEndpointsToGroup -csvPath $csvPath -groupName $groupName -targetSite $targetSite