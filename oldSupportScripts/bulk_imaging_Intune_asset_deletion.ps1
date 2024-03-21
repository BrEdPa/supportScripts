##script created by BPage; removes objects from AzureAD based on friendly name
#Connect to AzureAD
connect-AzureAD
Import-Module AzureAD

#Set the path to the CSV file containing the list of computers to delete
$csvPath = "C:\TEMP\Image_List\to_be_imaged.csv"

#Import the CSV file
$computers = Import-Csv $csvPath

#Loop through each computer in the CSV file
foreach ($computer in $computers) {

  #Get the AzureAD device object for the computer
  $device = Get-AzureADDevice -Filter "Name eq '$($computer.Name)'"

  #If the device object exists, delete it; if not, warn tech
  if ($device) {
    Remove-AzureADDevice -ObjectId $device.ObjectId -Confirm:$false
    Write-Host "Computer $($computer.Name) deleted from AzureAD"
  }
  else {
    Write-Warning "Computer $($computer.Name) not found in AzureAD"
  }
}
#Loop through each computer in the CSV file again
foreach ($comptuer in $computers) {
  
   #Get the computer object from Active Directory
  $adComputer = Get-ADComputer -Filter "Name -eq '$($computer.Name)'"

  #If the computer object exists, delete it
  if ($adComputer) {
    Remove-ADComputer -Identity $adComputer -Confirm:$false
    Write-Host "Computer $($computer.Name) deleted from Active Directory"
  }
  else {
    Write-Warning "Computer $($computer.Name) not found in Active Directory"
  }
}
