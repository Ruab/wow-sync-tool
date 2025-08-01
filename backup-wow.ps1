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
$basepath = "C:\Program Files (x86)\World of Warcraft\_retail_\" ## CHANGE THIS TO YOUR _RETAIL_ FULLY QUALIFIED PATH IF WOW IS NOT INSTALLED IN "C:\Program Files (x86)\"
$wowFolders = @(
    -join($basepath, "Cache"),
    -join($basepath, "Errors"),
    -join($basepath, "Fonts"),
    -join($basepath, "GPUCache"),
    -join($basepath, "Interface"),
    -join($basepath, "Logs"),
    -join($basepath, "Screenshots"),
    -join($basepath, "Utils"),
    -join($basepath, "WTF")
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
