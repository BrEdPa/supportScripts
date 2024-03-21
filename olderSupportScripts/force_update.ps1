#Script created by BPage, installs the PSWindowsUpdate module and forces an autoupdate
#intended for creating a flat playing field for all updates for a given group of machines, originally intended for Epic Training [aug.2023]
#comment out the first line if the module has already been installed

Install-Module PSWindowsUpdate -force
Get-WindowsUpdate -AcceptAll -Install -AutoReboot