# List All installed Powershell Modules
``` powershell
Get-InstalledModule
```
---
# Verify the availablility of a specific Powershell Module
``` powershell
Get-Module <module-name> -ListAvailable
```
### Example
``` powershell
Get-Module AzureAD -ListAvailable
```
---
# Search for a Powershell Module in the repository
``` powershell
Find-module -Name <module-name>
Find-module -Name <module-name> -Repository <repo-name>
```
### Example
``` powershell
Find-module -Name AzureAD
Find-module -Name AzureAD -Repository psgallery
```
---
# Install/Uninstall/Update a Powershell Module
``` powershell
Install-Module -Name <module-name>
Uninstall-Module -Name <module-name>
Update-Module -Name <module-name>
```
### Example
``` powershell
Install-Module -Name AzureAD
Uninstall-Module -Name AzureAD
Update-Module -Name AzureAD
```
---
# Import a Powershell Module to the current session
``` powershell
Import-Module -Name <module-name>
```
### Example
``` powershell
Import-Module -Name AzureAD
```
---
# View available commands of a Powershell Module
``` powershell
Get-Command -Module <module-name>
``` 
### Example
``` powershell
Get-Command -Module AzureAD
```
