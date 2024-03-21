# Get a list of Intune managed devices
$devices = Get-IntuneManagedDevice

# Create a hash table that maps computer names to device IDs
$deviceHashTable = @{}
foreach ($device in $devices) {
    $deviceHashTable[$device.DeviceName] = $device.id
}

# Define an array of computer names
$computerNames = "ComputerName1", "ComputerName2", "ComputerName3"

# Look up the device IDs for each computer name
$deviceIds = foreach ($computerName in $computerNames) {
    $deviceHashTable[$computerName]
}

# Output the list of device IDs
$deviceIds