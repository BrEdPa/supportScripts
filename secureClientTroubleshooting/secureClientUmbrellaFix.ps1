# Define variables
$sourceFolderPath = "\\legacyapps\apps\Cisco Secure Client\configFileCopy\OrgInfo.json"
$destinationFolderPath = "C:\ProgramData\Cisco\Cisco Secure Client\Umbrella\OrgInfo.json"
$logFilePath = "C:\TEMP\CopyScript.log"

# Function to log messages
function LogMessage {
    param(
        [string]$message,
        [string]$logFile
    )

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "$timestamp - $message"
    Add-Content -Path $logFile -Value $logEntry
}

# Check if source folder exists
if (Test-Path -Path $sourceFolderPath -PathType Container) {
    # Check if destination folder exists
    if (!(Test-Path -Path $destinationFolderPath -PathType Container)) {
        # Create destination folder if it doesn't exist
        New-Item -Path $destinationFolderPath -ItemType Directory | Out-Null
        LogMessage "Created destination folder: $destinationFolderPath" -logFile $logFilePath
    }

    # Check if folder already exists in destination
    if (!(Test-Path -Path "$destinationFolderPath\YourFolder" -PathType Container)) {
        # Copy folder to destination
        Copy-Item -Path $sourceFolderPath -Destination $destinationFolderPath -Recurse -Force
        LogMessage "Copied folder from $sourceFolderPath to $destinationFolderPath" -logFile $logFilePath
    } else {
        LogMessage "Folder already exists in destination: $destinationFolderPath" -logFile $logFilePath
    }
} else {
    LogMessage "Source folder not found: $sourceFolderPath" -logFile $logFilePath
}
