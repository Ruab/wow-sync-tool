# Get timestamp
$timestamp = Get-Date -Format "yyyy-MM-dd_HHmmss"

# Define OneDrive base backup path
$oneDriveRoot = "$env:OneDrive"

# AppData backup destination
$appDataDest = Join-Path $oneDriveRoot "AppDataBackup\$timestamp"

# World of Warcraft backup destination
$wowDest = Join-Path $oneDriveRoot "WoWBackup\$timestamp"

# List of AppData folders to back up
$appDataFolders = @(
    "$env:APPDATA\weakauras-companion",
    "$env:APPDATA\WowUpCf"
)

# List of WoW folders to back up
$wowFolders = @(
    "C:\Program Files (x86)\World of Warcraft\_retail_\Cache",
    "C:\Program Files (x86)\World of Warcraft\_retail_\Errors",
    "C:\Program Files (x86)\World of Warcraft\_retail_\Fonts",
    "C:\Program Files (x86)\World of Warcraft\_retail_\GPUCache",
    "C:\Program Files (x86)\World of Warcraft\_retail_\Interface",
    "C:\Program Files (x86)\World of Warcraft\_retail_\Logs",
    "C:\Program Files (x86)\World of Warcraft\_retail_\Screenshots",
    "C:\Program Files (x86)\World of Warcraft\_retail_\Utils",
    "C:\Program Files (x86)\World of Warcraft\_retail_\WTF"
)

# Function to back up folders
function Backup-Folders {
    param (
        [string[]]$Folders,
        [string]$DestinationRoot
    )

    foreach ($folder in $Folders) {
        if (Test-Path $folder) {
            $folderName = Split-Path $folder -Leaf
            $destination = Join-Path $DestinationRoot $folderName
            robocopy $folder $destination /E /R:2 /W:5
        } else {
            Write-Warning "$folder not found, skipping."
        }
    }
}

# Run backups
Backup-Folders -Folders $appDataFolders -DestinationRoot $appDataDest
Backup-Folders -Folders $wowFolders -DestinationRoot $wowDest
