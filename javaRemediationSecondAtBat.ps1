$Path = "C:\Program Files\Java"

    If (!(Test-Path $path))
        {
            Get-Package -Name "Java 8*"  | Uninstall-Package -Force
        } 
    else 
        {
            write-output "No Java install detected."
        }