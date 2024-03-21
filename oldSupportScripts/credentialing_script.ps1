# Created by BPage, adapted from SOF for MiPACS credentialing

Import-Module CredentialManager

# Get the credential from the user with a windows credentials prompt:
$SessionCredential = Get-Credential -Message 'Please enter your server credentials'

# Save the credential object directly without unwrapping it:
New-StoredCredential -Credentials $SessionCredential -Target ServerCredentials -Persist Enterprise `
  -Comment "Server Credentials for $($SessionCredential.UserName)" > $null

# Open the credential later
$SavedCred = Get-StoredCredential -Target ServerCredentials

# Delete if needed
Remove-StoredCredential -Target ServerCredentials