# go to microsoft store and find powershell 7 and download that
## Now Install the Azure Az PowerShell module

### Prerequisit
- PowerShell script execution policy must be set to remote signed or less restrictive. Get-ExecutionPolicy -List can be used to determine the current execution policy. For more information

```
 Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Installation
- Using the Install-Module cmdlet is the preferred installation method for the Az PowerShell module. Install the Az module for the current user only. This is the recommended installation scope. This method works the same on Windows, Linux, and macOS platforms. Run the following command from a PowerShell session:

```
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force
```
