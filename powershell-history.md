# PowerShell History
## 1. View PowerShell Command History
```powershell
Get-History
```
### 1.1. List more details on the commands
```ps1
Get-History | Format-List -Property *
Get-History | Select-Object -Property *
```
### 1.2. Run previously executed command by ID
```ps1
Invoke-History <ID>
Invoke-History -Id <ID>
```
---

## 2. Find Aliases to "Get-History" command
```ps1
Get-Alias | findstr "Get-History"
```
---

## 3. Locate the History file
```ps1
(Get-PSReadlineOption).HistorySavePath
Get-PSReadLineOption | select -ExpandProperty HistorySavePath
```
### 3.1. View the content of the History file
```ps1
Get-Content (Get-PSReadlineOption).HistorySavePath
cat (Get-PSReadlineOption).HistorySavePath
notepad (Get-PSReadlineOption).HistorySavePath
code (Get-PSReadlineOption).HistorySavePath
```
### 3.2. Copy the content to the clipboard or a file
```ps1
Get-Content (Get-PSReadlineOption).HistorySavePath | clip
Get-Content (Get-PSReadlineOption).HistorySavePath >> PS-History.txt
Get-History | Export-CSV -Path 'PS-History.csv'
```
---

## 4. Search for previously executed commands
### 4.1. Backward Search
```ps1
CTRL+R
```
### 4.1. Forward Search
```ps1
CTRL+S
```
---

## 5. Clear the History
```ps1
Clear-History
Clear-History -CommandLine *Help*, *Syntax
```
### 5.1. Delete the History file
```ps1
$HistoryFilePath = (Get-PSReadLineOption).HistorySavePath
Remove-Item -Path $HistoryFilePath -Verbose
```
---

