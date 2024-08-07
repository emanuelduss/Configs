#
# PowerShell Options ($PROFILE)
#

Set-PSReadlineOption -EditMode vi
Set-PSReadlineOption -BellStyle None
Set-PSReadlineKeyHandler -Key Tab -Function Complete # Command completion like in bash
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward # Type command and search history using arrow keys
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

#
# Colors
#

Set-PSReadLineOption -Colors @{
  Command            = 'Magenta'
  Number             = 'DarkGray'
  Member             = 'DarkGray'
  Operator           = 'DarkGray'
  Type               = 'DarkGray'
  Variable           = 'DarkGreen'
  Parameter          = 'DarkGreen'
  ContinuationPrompt = 'DarkGray'
  Default            = 'DarkGray'
}

Set-PSReadLineOption -Colors @{
 # Use a ConsoleColor enum
 "Error" = [ConsoleColor]::DarkRed

 # 24 bit color escape sequence
 "String" = "$([char]0x1b)[38;5;100m"

 # RGB value
 "Command" = "#8181f7"
}

#
# Prompt
#

function prompt
{
  $branch = $(git branch --show-current)
  Write-Host "PS " -nonewline -ForegroundColor DarkYellow
  Write-Host "$env:USERNAME@$env:COMPUTERNAME " -ForegroundColor Green -NoNewLine
  Write-Host "$PWD " -ForegroundColor Blue -NoNewLine
  if ($branch){
    Write-Host "($branch) " -ForegroundColor Magenta -NoNewLine
  }
  Write-Host "$(Get-Date -Format '[yyyy-MM-dd HH:MM]')" -ForegroundColor DarkYellow
  Write-Host "PS >" -nonewline -ForegroundColor DarkYellow

  return " "
}

#
# Aliases
#

Set-Alias vi vim

#
# Functions
#

# Update Git Repositories (buggy)

function Update-GitRepositories {
  Get-ChildItem -Directory | ForEach-Object {
    if (Join-Path $_.FullName ".git" | Test-Path -PathType Container){
      Write-Host -ForegroundColor Green  "[*] Updating $_..."
      git -C $_.FullName pull --ff-only
      Write-Host
    }
  }
}
