$Path = "HKLM:\SOFTWARE\JavaSoft\Java Runtime Environment"
$Name = "BrowserJavaVersion"
$value = "11.391.2"

$Registry = Get-ItemProperty -Path $Path -Name $Name -ErrorAction Stop | Select-Object -ExpandProperty $Name

    If ($Registry -eq $Value)
        {
            Write-Output "Compliant version of Java found"
        } 
    else 
        {
            Get-Package -Name "Java 8*"  | Uninstall-Package -Force
            Write-Output "Outdated Java version found, uninstalling"
        }