#uninstalls a software package by name, will need to run Get-Package standalone to find details for your specific app
#template: Get-Package -Name "<app name>" -RequiredVersion <app version> | Uninstall-Package -Force
Get-Package -Name "Java 8 Update 391 (64-bit)" -RequiredVersion 8.0.3910.13 | Uninstall-Package -Force