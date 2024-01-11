##BrEdPa, 2023
##MiPACS dental software requires some registry changes in the environment to work correctly, this script makes those changes.

#Set the variables
$RegistryPath1 = 'HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319'
$RegistryPath2 = 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319'
$Name = 'SchUseStrongCrypto'
$Value = '1'

#create the registry entries
New-ItemProperty -Path $RegistryPath1 -Name $Name -Value $Value -PropertyType DWORD -Force
New-ItemProperty -Path $RegistryPath2 -Name $Name -Value $Value -PropertyType DWORD -Force


