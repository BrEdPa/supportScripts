<#
bpage 6_20_22
modified script for remediating MS security vulnerability CVE-2013-3900; creates allowance for accessing MiPACS servers
#>
$registryPath = "HKLM:\Software\Microsoft\.NETFramework\v4.0.30319"

$registryPath1 = "HKLM:\Software\Wow6432Node\Microsoft\.NETFramework\v4.0.30319"

$name = "SchUseStrongCrypto"

$value = "1"

If(!(Test-Path $registryPath)) {

New-Item -path $registryPath -Force | Out-Null

New-ItemProperty -path $registryPath -name $name -value $value -propertytype String

}

else {

remove-item -path $registryPath -Force | Out-Null

New-Item -path $registryPath -Force | out-null

New-ItemProperty -path $registryPath -name $name -value $value -propertytype String -force | Out-Null

}

If(!(Test-Path $registryPath1)) {

New-Item -path $registryPath1 -Force | Out-Null

New-ItemProperty -path $registryPath1 -name $name -value $value -propertytype String

}

else {

remove-item -path $registryPath1 -Force | Out-Null

New-Item -path $registryPath1 -Force | out-null

New-ItemProperty -path $registryPath1 -name $name -value $value -propertytype String -force | Out-Null

}