# Define variables
$sourceFolderPath = "C:\TEMP\OrgInfo.json"
$destinationFolderPath = "C:\ProgramData\Cisco\Cisco Secure Client\Umbrella\"
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
if (Test-Path -Path $sourceFolderPath -PathType Leaf) {
    # Check if destination folder exists
    if (!(Test-Path -Path $destinationFolderPath -PathType Container)) {
        # Create destination folder if it doesn't exist
        New-Item -Path $destinationFolderPath -ItemType Directory | Out-Null
        LogMessage "Created destination folder: $destinationFolderPath" -logFile $logFilePath
    }

	#copy json to target folder
	Copy-Item -Path $sourceFolderPath -destination $destinationFolderPath -Force
	LogMessage "Copied file from $sourceFolderPath to $destinationFolderPath" -logFile $logFilePath
	
    # Check if folder already exists in destination
    if (Test-Path -Path "$destinationFolderPath\OrgInfo.json" -PathType Leaf) {
		LogMessage "File copied to $destinationFolderPath successfully!" -logFile $logFilePath
	}
	else {
		LogMessage "Could not copy file to $destinationFolderPath" -logFile $logFilePath
	}
     
}
else {
    LogMessage "Source folder not found: $sourceFolderPath" -logFile $logFilePath
}
