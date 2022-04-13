# Set keyboard layout to Swiss German (DE-CH)
Set-WinUserLanguageList -LanguageList DE-CH

# Show hidden files, file extensions and system files
$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
Set-ItemProperty $key Hidden 1
Set-ItemProperty $key HideFileExt 0
Set-ItemProperty $key ShowSuperHidden 1
Stop-Process -processname explorer
