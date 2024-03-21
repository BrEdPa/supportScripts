If([String](Get-Item -Path "$Env:ProgramFiles\Zotero\zotero.exe","${Env:ProgramFiles(x86)}\Zotero\zotero.exe" -ErrorAction SilentlyContinue).VersionInfo.FileVersion -ge "6.0.26"){
Write-Host "Installed"
Exit 0
}
else {
Exit 1
}
