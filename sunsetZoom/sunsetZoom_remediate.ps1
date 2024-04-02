##BrEdPa 2024 | uninstall script for Zoom, which has been sunset

#define Zoom install media
$Path = "C:\Program Files\Zoom\bin"
$presenceCheck = Test-path -path $path

#Function to log messages
function LogMessage {
    param(
        [string]$message,
        [string]$logFile
    )

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "$timestamp - $message"
    Add-Content -Path $logFile -Value $logEntry
}

#double check for Zoom
if ($presenceCheck -eq $true) {
    get-package -name "Zoom*" | uninstall-package -force
}
else {
    write-output "Zoom is not installed, device is compliant."
}