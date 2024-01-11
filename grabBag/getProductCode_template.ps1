Get-WmiObject -Class Win32_Product -Filter "Name = '%appName%'" | Format-Table IdentifyingNumber, Name
