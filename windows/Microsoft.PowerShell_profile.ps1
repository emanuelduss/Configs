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
  Default            = 'White'
  Command            = 'Yellow'
  ContinuationPrompt = 'DarkYellow'
  Parameter          = 'Green'
  Variable           = 'Green'
  Number             = 'DarkCyan'
  String             = 'DarkCyan'
  Member             = 'DarkYellow'
  Operator           = 'DarkYellow'
  Type               = 'DarkYellow'
  Emphasis           = 'Yellow'
  Error              = 'Red'
}

#
# Prompt
#

function prompt
{
  $branch = $(git branch --show-current)
  Write-Host "PS " -nonewline -ForegroundColor DarkYellow
  Write-Host "$([environment]::username)@$([environment]::MachineName) " -ForegroundColor Green -NoNewLine
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
Set-Alias grep Select-String
Set-Alias dig Resolve-DnsName

#
# Functions
#

function Print-ConsoleColors {
  foreach ($color in [System.Enum]::getvalues([System.ConsoleColor])){
    Write-Host -NoNewline "${color} "
    Write-Host -NoNewline -ForegroundColor $color "$color "
    Write-Host -BackgroundColor $color " $color "
  }
}

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

function Convert-PowerPointToPDF {
  # Adapted from http://stackoverflow.com/questions/16534292/basic-powershell-batch-convert-word-docx-to-pdf
  $curr_path = (Get-Item -Path ".\").FullName
  $ppt_app = New-Object -ComObject PowerPoint.Application
  Get-ChildItem -Path $curr_path -Recurse -Filter *.ppt? | ForEach-Object {
    Write-Host "Processing" $_.FullName "..."
    $document = $ppt_app.Presentations.Open($_.FullName)
    $pdf_filename = "$($curr_path)\$($_.BaseName).pdf" # Or use $_.DirectoryName to save them besides the original file
    $opt= [Microsoft.Office.Interop.PowerPoint.PpSaveAsFileType]::ppSaveAsPDF
    $document.SaveAs($pdf_filename, $opt)
    $document.Close()
  }
  $ppt_app.Quit()
  [System.Runtime.Interopservices.Marshal]::ReleaseComObject($ppt_app)
}
