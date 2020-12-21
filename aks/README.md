# PowerShell installs

## Prereq needed: 
- PS 5.1+
- .Net Framework 4.7.2 +
- Latest version of PowerShellGet

## Install Azure Module

```
if ($PSVersionTable.PSEdition -eq 'Desktop' -and (Get-Module -Name AzureRM -ListAvailable)) {
    Write-Warning -Message ('Az module not installed. Having both the AzureRM and ' +
      'Az modules installed at the same time is not supported.')
} else {
    Install-Module -Name Az -AllowClobber -Scope CurrentUser
}
```

> More info under : https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-5.2.0