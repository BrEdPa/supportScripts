## Check for Zotero (File Detection Method)
$ZoteroExe = (Get-ChildItem -Path "C:\Program Files\Zotero\zotero.exe","C:\Program Files (x86)\Zotero\zotero.exe" -ErrorAction SilentlyContinue)
$ZoteroExe.FullName
$ZoteroPath = $($ZoteroExe.FullName).Replace("C:\Program Files\","").Replace("C:\Program Files (x86)\","")
$FileVersion = (Get-Item -Path "$($ZoteroExe.FullName)" -ErrorAction SilentlyContinue).VersionInfo.FileVersion

## Create Text File with Zotero File Detection Method
$FilePath = "C:\Windows\Temp\Zotero_Detection_Method.txt"
New-Item -Path "$FilePath" -Force
Set-Content -Path "$FilePath" -Value "If([String](Get-Item -Path `"`$Env:ProgramFiles\$ZoteroPath`",`"`${Env:ProgramFiles(x86)}\$ZoteroPath`" -ErrorAction SilentlyContinue).VersionInfo.FileVersion -ge `"$FileVersion`"){"
Add-Content -Path "$FilePath" -Value "Write-Host `"Installed`""
Add-Content -Path "$FilePath" -Value "Exit 0"
Add-Content -Path "$FilePath" -Value "}"
Add-Content -Path "$FilePath" -Value "else {"
Add-Content -Path "$FilePath" -Value "Exit 1"
Add-Content -Path "$FilePath" -Value "}"
Invoke-Item $FilePath