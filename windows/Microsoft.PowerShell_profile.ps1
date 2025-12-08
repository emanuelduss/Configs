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
  Write-Host "$(Get-Date -Format '[yyyy-MM-dd HH:mm]')" -ForegroundColor DarkYellow
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

function Get-DailyFirstAndLastSystemLogTimestamp {
  param (
    [int]$Days = 7
  )

  $today = (Get-Date).Date
  $startDate = $today.AddDays(-$Days)

  $results = @()

  for ($i = 0; $i -le $Days; $i++) {  # <= to include today
    $dayStart = $startDate.AddDays($i)
    $dayEnd = $dayStart.AddDays(1).AddSeconds(-1)

    $logs = Get-WinEvent -FilterHashtable @{
      LogName = 'System'
      StartTime = $dayStart
      EndTime = $dayEnd
    } -ErrorAction SilentlyContinue | Sort-Object TimeCreated

    if ($logs -and $logs.Count -gt 0) {
      $firstTime = $logs[0].TimeCreated
      $lastTime  = $logs[-1].TimeCreated

      $results += [PSCustomObject]@{
        Date     = $dayStart.ToString("yyyy-MM-dd")
        FirstEntry = $firstTime.ToString("HH:mm:ss")
        LastEntry  = $lastTime.ToString("HH:mm:ss")
      }
    }
    else {
      $results += [PSCustomObject]@{
        Date     = $dayStart.ToString("yyyy-MM-dd")
        FirstEntry = 'N/A'
        LastEntry  = 'N/A'
      }
    }
  }

  $results | Format-Table -AutoSize
}

function Probe-Port {
  param(
    [Parameter(Mandatory=$true)]
    [string]$Hostname,

    [Parameter(Mandatory=$true)]
    [int]$Port
  )

  $c = New-Object Net.Sockets.TcpClient
  try {
    $c.BeginConnect($Hostname,$Port,$null,$null).AsyncWaitHandle.WaitOne(1000)
  }
  finally {
    $c.Close()
  }
}

function Get-Uptime {
  [TimeSpan]::FromMilliseconds([Environment]::TickCount) | Select-Object Days,Hours,Minutes,Seconds
}
