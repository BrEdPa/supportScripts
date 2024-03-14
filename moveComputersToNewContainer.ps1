#seed for moving computers into new OUs as part of my larger console app
#create function
function moveComputersToNewContainer {
    param (
        [string]$csvPath,
        [string]$TargetOU
    )
    #read the file, make an array out of contents
    $csvData = Import-Csv -path $csvPath
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
            Get-ADComputer $endpoint | Move-ADObject -TargetPath $TargetOU
        }
    }
    ELSE {
        Write-Output "Operation cancelled; that was a close one!"
    }
}

# Get variable file
$csvPath = Read-Host "Enter the full path for your .CSV file."
# Get variable group
$targetOU = Read-Host "Enter the container you are adding these objects to."
# Call Function
moveComputersToNewContainer -csvPath $csvPath -targetGroup $targetOU