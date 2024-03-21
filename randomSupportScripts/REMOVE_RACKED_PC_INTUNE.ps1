$devices = Get-Content -Path C:\Temp\Image_List\imaging_rack.csv
foreach ($device in $devices)
{
	remove-intunemanageddevice -filter "deviceName eq '$device'"
}