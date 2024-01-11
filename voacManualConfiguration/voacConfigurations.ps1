#written by BP 2023
#Script installs VOAC & sets configurations needed for VOAC to record & transmit properly
#sets program folder permissions for users to "full control" and allows VOAC apps through Windows Defender Firewall

#install VOAC
msiexec 
#calls icalcs, executes in PS
icacls "C:\Program Files (x86)\CSI\Virtual Observer" --% /grant:r Users:(OI)(CI)F /T

#sets firewall allowances for all VOAC apps
New-NetFirewallRule -DisplayName "voacccf" -Direction Inbound -Program "C:\Program Files (x86)\CSI\Virtual Observer\voaccf.exe" -Action Allow
New-NetFirewallRule -DisplayName "voacld" -Direction Inbound -Program "C:\Program Files (x86)\CSI\Virtual Observer\voacld.exe" -Action Allow
New-NetFirewallRule -DisplayName "voacli" -Direction Inbound -Program "C:\Program Files (x86)\CSI\Virtual Observer\voacli.exe" -Action Allow
New-NetFirewallRule -DisplayName "voaclm" -Direction Inbound -Program "C:\Program Files (x86)\CSI\Virtual Observer\voaclm.exe" -Action Allow
New-NetFirewallRule -DisplayName "voacmt" -Direction Inbound -Program "C:\Program Files (x86)\CSI\Virtual Observer\voacmt.exe" -Action Allow
New-NetFirewallRule -DisplayName "voacsc" -Direction Inbound -Program "C:\Program Files (x86)\CSI\Virtual Observer\voacsc.exe" -Action Allow
New-NetFirewallRule -DisplayName "voacse" -Direction Inbound -Program "C:\Program Files (x86)\CSI\Virtual Observer\voacse.exe" -Action Allow
New-NetFirewallRule -DisplayName "voacwc" -Direction Inbound -Program "C:\Program Files (x86)\CSI\Virtual Observer\voacwc.exe" -Action Allow

#cmd = netsh advfirewall add rule name="Firefox" dir=in action=allow program="C:/Program Files/Mozilla Firefox/firefox.exe" enable=yes