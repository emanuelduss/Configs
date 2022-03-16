#
# PowerShell Options ($PROFILE)
#

Set-PSReadlineOption -EditMode vi
Set-PSReadlineOption -BellStyle None

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
  Write-Host "PS " -nonewline -ForegroundColor "DarkYellow"
  Write-Host "$env:USERNAME@$env:COMPUTERNAME " -ForegroundColor "Green" -NoNewLine
  Write-Host "$PWD" -ForegroundColor "Blue"
  Write-Host "PS >" -nonewline -ForegroundColor "DarkYellow"

  return " "
}

#
# Aliases
#

Set-Alias vi vim

#
# Functions
#
