$target = Get-WmiObject -Class win32_product | where-Object{$_.Name -eq "MeadCo ScriptX (v8.2.1.2 (x86))"}
$target.Uninstall()