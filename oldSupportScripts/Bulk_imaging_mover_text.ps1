$computers = Get-Content C:\TEMP\Image_List\completed_images.csv

$TargetOU   = "OU=HybridJoin,OU=Equipment,OU=OU LMA,OU=LEGACY,DC=legacy,DC=local"

ForEach($computer in $computers){

Get-ADComputer $computer |Move-ADObject -TargetPath $TargetOU

}