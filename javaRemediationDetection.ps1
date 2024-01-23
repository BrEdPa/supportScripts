#BrEdPa, 2024 | active remediation for known vulnerable Java installs; tries to find Java's install path, returns appropriate code if present.

##define java install path,
$path = test-path -path "C:\Program Files\Java\jre-1.8\"

##checks for java installation
    if ($path -eq $True) {
        Write-Output "Java installed"
        exit 1
        }
    else {
        Write-Output "Java not installed"
        exit 0
    }