<#
bpage 6_20_22
creates a registry entry for certificate padding, remediating MS security vulnerability CVE-2013-3900
#>
$registryPath = "HKLM:\Software\Microsoft\Cryptography\Wintrust\Config"

$registryPath1 = "HKLM:\Software\Wow6432Node\Microsoft\Cryptography\Wintrust\Config"

$name = "EnableCertPaddingCheck"

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