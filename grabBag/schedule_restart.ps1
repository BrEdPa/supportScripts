[datetime]$RestartTime = '9PM'
[datetime]$CurrentTime = Get-Date
[int]$WaitSeconds = ( $RestartTime - $CurrentTime ).TotalSeconds
shutdown -r -t $WaitSeconds -d p:5:1