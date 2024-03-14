<#
.SYNOPSIS
console app for moving a group of computer objects into a specified security group.
BrEdPa 2024

.DESCRIPTION
Console application that was designed to stagger the rollout of an application to a hybrid cloud environment.
A .csv file can be made manually or otherwise exported to include a 'stage' of computers, which are then added to the ADDS group.
The group is then added to the intune app; this staggers the rollout based on parameters set by the IT dept. so support resouces can be properly allocated.
Can be modified to accomodate users as well, or even a slight change in the Add cmdlt to move objects between containers/OUs

.PARAMETER csvPath
full path for CSV, which needs the header "endpoints" for default. Advise using an unbroken string

.EXAMPLE
Export all computer objects in a desired site's OU, format as necessary; modify script to include target group. Run console app, specifying sec group. HJ model should give ~30 min lead time, allowing Support to be in place for installs.

.NOTES
I need to add some extra parameters to make the group a variable. I'd also like to build the logic in for if we're moving OUs or just adding user/computer objects to a group.
#>

# Function to add endpoints present in AD to a specific SEC group
function addEndpointsToGroup {
    param (
        [string]$csvPath,
        [string]$targetGroup
    )
    # Read .csv & create an array to store valid rows
    $csvData = Import-CSV -Path $csvPath
    $targetEndpoints = @()

# forEach row, add to an array if it's present in AD
    forEach ($row in $csvData) {
        $endpoint = $row.endpoints
        # confirm endpoint's presence in AD
        IF (Get-ADComputer -Filter { Name -eq $endpoint }) {
            $targetEndpoints += $endpoint
            } 
        ELSE {
                Write-Output "Endpoint $endpoint not present in ADDS or not in the specified OU"
            }
    }
# forEach item in the array, add to group ##for the vpn rollout we only have one group, and therefore it's static
$executeFunction = Read-Host "Do you want to add" $targetEndpoints.count "objects to the desired group? (Y/N)"
    IF ($executeFunction -eq "Y" -or $executeFunction -eq "y") {
        forEach ($endpoint in $targetEndpoints) {
            $obj = Get-ADComputer $endpoint
            Add-ADGroupMember -ID $targetGroup -Members $obj
        }
    }
    ELSE {
        Write-Output "Operation cancelled; that was a close one!"
    }
}

# Get variable file
$csvPath = Read-Host "Enter the full path for your .CSV file."
# Get variable group
$targetGroup = Read-Host "Enter the group you are adding these objects to."
# Call Function
addEndpointsToGroup -csvPath $csvPath -targetGroup $targetGroup