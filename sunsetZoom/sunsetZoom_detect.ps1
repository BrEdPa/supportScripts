##BrEdPa 2024 | detection script for Zoom uninstall, which has been sunset

#define variables for Zoom install files
$Path = "C:\Program Files\Zoom\bin"
$presenceCheck = Test-path -path $path

Try {
        if ($presenceCheck -eq $true){
        Write-Warning "Zoom is present, device noncompliant."
        exit 1
        }
        else {
            Write-Output "Zoom is not present, device compliant."
            Exit 0
        }
    }
Catch {
        Write-Warning "Zoom is installed, proceed to uninstall."
        Exit 1
}