#defines origin OU
$ADComps= Get-ADComputer -Filter * -SearchBase "OU=NewComputers,OU=LEGACY,DC=legacy,DC=local"| Select-Object -Property Name |sort -Property name | Out-GridView -PassThru –title “Select Computers to Move”| Select -ExpandProperty Name

#captures all available OUs
$ADOUs= Get-ADOrganizationalUnit -Filter * | Select-Object -Property DistinguishedName | Out-GridView -PassThru –title “Select Target OU”| Select-Object -ExpandProperty DistinguishedName

Foreach($ou in $ADOUs){

Foreach($comp in $ADComps){

#move the object to the selected OU
get-adcomputer $comp |Move-ADObject -TargetPath "$ou" -Verbose }

}
