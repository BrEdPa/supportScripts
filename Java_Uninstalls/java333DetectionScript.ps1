#BrEdPa, 2024 | active remediation for known vulnerable Java installs; tries to find Java's install path, returns appropriate code if present.

##define java install path, registry path of valid java version
$path = test-path -path "C:\Program Files\Java\jre-1.8\"
#$regPath = "Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel\NameSpace\{4299124F-F2C3-41b4-9C73-9236B2AD0E8F}"

##checks for java installation
#try{
    if ($path -eq $True) {
        Write-Output "Java installed"
        exit 1
        }
    else {
        Write-Output "Java not installed"
        exit 0
    }
#}
#Catch{
    #Write-Host "Checking Java Version"
        #try{
            #if ($regPath -eq $True){
                #Write-Output "Java version is up to date"
#                exit 0
              #  }
#            else{
#                exit 1
#            }
       # }
       # catch{
        #    Write-Warning "Java version non-compliant"
        #    exit 1
       # }
#}