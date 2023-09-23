# PowerShell History
## 1. View PowerShell Command History
```powershell
Get-History
```

## 2. Find Aliases to "Get-History" command
```ps1
Get-Alias | findstr "Get-History"
```

## 3. Locate the History file
```ps1
(Get-PSReadlineOption).HistorySavePath
```

### 3.1. View the content of the History file
```ps1
Get-Content (Get-PSReadlineOption).HistorySavePath
cat (Get-PSReadlineOption).HistorySavePath
notepad (Get-PSReadlineOption).HistorySavePath
code (Get-PSReadlineOption).HistorySavePath
```

### 3.2. Copy the content to clipboard or to a file
```ps1
Get-Content (Get-PSReadlineOption).HistorySavePath | clip
Get-Content (Get-PSReadlineOption).HistorySavePath >> file.txt
```
