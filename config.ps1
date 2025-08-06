function Get-Config{
    Write-Host "Getting wow install directory"
    do
    {
        $oftSelect = New-Object System.Windows.Forms.OpenFileDialog
        $oftSelect.ShowHelp = $true
        $oftSelect.Filter = "wow.exe (*.exe)|*.exe"
        $oftSelect.FilterIndex = 1
        $oftDialog = $oftSelect.ShowDialog()

        $retailpath = Split-Path -Path $oftSelect.FileName -Parent
        $filecheck = $retailpath.Split("\")
        if($filecheck[-1] -eq "_retail_")
        {
            $validpath = $true
        }
        else
        {
            $validpath = $false
            Add-Type -AssemblyName System.Windows.Forms | Out-Null
            [System.Windows.Forms.MessageBox]::Show("This is not a valid retail wow install, please reselect the install folder of wow.exe")
        }
    } while ($validpath -ne $true)
    Write-Verbose "Valid path found, creating config file"
    $filepath = Split-Path -Path $PSCommandPath -Parent
    $filepath = -join($filepath, "\config.json")
    $param = @{
        Path = $retailpath
        }
    $param | ConvertTo-Json | Out-File -FilePath $filepath -Force
}

function Create-Task
{
    $pathtoscript = Split-Path -Path $PSCommandPath -Parent
    $pathtoscript = -join($pathtoscript, "\backup-wow.ps1")
    $args = -join('-ExecutionPolicy Bypass -File "', $pathtoscript, '"')
    $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument $args

    $sett = New-ScheduledTaskSettingsSet -RestartCount 3 -RestartInterval (New-TimeSpan -Minutes 60) -RunOnlyIfNetworkAvailable -DontStopIfGoingOnBatteries -StartWhenAvailable

    $FromObj = "How often would you like to back up your files? (D)aily or (W)eekly"
    $dotask = { (Read-Host $FromObj) -as [char] }
    $FromInput = & $dotask
    $validchoices = ("D", "W")
    while($FromInput -notin $validchoices) {
        Write-Output "Your input has to be D for Daily or W for Weekly"
        $FromInput = & $dotask
    }


    if($FromInput  -eq "D")
    {
        $trigger = New-ScheduledTaskTrigger -Daily -At "8:00AM"
    }
    else
    {
        $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday -At "8:00AM"
    }

    Register-ScheduledTask "backup-wow" -Action $action -Trigger $trigger -Settings $sett

}

## Get file path stuff
$FromObj = "Is your wow install at 'C:\Program Files (x86)\World of Warcraft'? (Y/N)"
$dotask = { (Read-Host $FromObj) -as [char] }
$FromInput = & $dotask
$validchoices = ("Y", "N")
while($FromInput -notin $validchoices) {
    Write-Output "Your input has to be Y or N"
    $FromInput = & $dotask
}

if($FromInput -eq "Y")
{
    Write-Verbose "Default wow install selected creating config file with default path"
    $param = @{
    Path = "C:\Program Files (x86)\World of Warcraft\_retail_\"
    }
    $filepath = Split-Path -Path $PSCommandPath -Parent
    $filepath = -join("\config.json")
    $param | ConvertTo-Json | Out-File -FilePath $filepath -Force
}
else
{
    Write-Verbose "Non standard wow install selected"
    Get-Config
}




## Get scheduled task stuff
$FromObj = "Would you like to create a scheduled task to run this backup script? (Y/N)"
$dotask = { (Read-Host $FromObj) -as [char] }
$FromInput = & $dotask
$validchoices = ("Y", "N")
while($FromInput -notin $validchoices) {
    Write-Output "Your input has to be Y or N"
    $FromInput = & $dotask
}

if($FromInput -eq "N")
{
    Write-Verbose "Not creating a scheduled task"
    break
}
else
{
    Create-Task
}

Write-Verbose "Fin"
